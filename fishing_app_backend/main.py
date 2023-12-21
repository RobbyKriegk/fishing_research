from functions import connect_to_Maria, O2ptoO2c
import pandas as pd
import gsw
import matplotlib.pyplot as plt
import json

def returnCSV():
    engine, conn = connect_to_Maria()           # connect to Maria DB

    query_raw_values = 'SELECT deployment_id, sensor_id, logger_id, measuring_time, ST_AsText(measuring_location) as ' \
                    'measuring_location, value, pressure FROM RawValue WHERE logger_id = {} AND deployment_id = {}; '

    csv_Map = {
        'csv_List' : []
    }

    for i in range(152, 177):                   # the relevant deployments are with IDs 152-176
        raw_values = pd.read_sql_query(query_raw_values.format(5, i), con = engine)         # get values
        if raw_values.empty:
            print('empty deployment ' + str(i))
            continue
        print(raw_values)
        sensors = raw_values.sensor_id[0:3]
        data_new_frame = {'time': list(raw_values.measuring_time[raw_values.sensor_id == raw_values.sensor_id[0]]),
                        'location': list(raw_values.measuring_location[raw_values.sensor_id == raw_values.sensor_id[0]]),
                        'pressure': list(raw_values.pressure[raw_values.sensor_id == raw_values.sensor_id[0]])}
        for j in sensors:
            query_sensors = 'SELECT parameter FROM SensorType WHERE sensor_type_id = (SELECT sensor_type_id FROM Sensor ' \
                            'WHERE sensor_id = {}); '
            parameter = pd.read_sql_query(query_sensors.format(j), con=engine).parameter[0]
            data_new_frame[parameter + '_time'] = list(raw_values.measuring_time[raw_values.sensor_id == j])
            data_new_frame[parameter] = list(raw_values.value[raw_values.sensor_id == j])

        new_dataframe = pd.DataFrame(data=data_new_frame)
        new_dataframe['salinity_psu'] = new_dataframe.index.map(gsw.conversions.SP_from_C(new_dataframe.loc[:, 'conductivity'], new_dataframe.loc[:, 'temperature'], new_dataframe.loc[:, 'pressure']))
        new_dataframe['oxygen_mlL'] = new_dataframe.index.map(O2ptoO2c(new_dataframe.loc[:, 'oxygen'], new_dataframe.loc[:, 'temperature'], new_dataframe.loc[:, 'salinity_psu'], new_dataframe.loc[:, 'pressure']))
        new_dataframe['depth'] = new_dataframe.index.map((new_dataframe.pressure - 1013) / -100)

        csv_Map['csv_List'].append(new_dataframe.to_csv())

    json_csv_Map = json.dumps(csv_Map)

    return json_csv_Map
        # for parameter in ['oxygen_mlL', 'salinity_psu']:
        #     timestamp = str(new_dataframe['time'][0]).replace(' ', '_').replace(':', '-')
        #     plt.figure()
        #     plt.title(f'Deployment {i}, ' + parameter)
        #     plt.plot(new_dataframe[parameter], new_dataframe.depth)
        #     plt.xlabel(parameter)
        #     plt.ylabel('Depth')
        #     plt.grid()
            #plt.savefig(f'../../AP5_Validation/20230912_Charter_Kuestenfischer/Messungen/{timestamp}_Deployment_{i}_' + parameter + '.png')
        #plt.show()
        # break
