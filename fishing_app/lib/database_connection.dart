import 'package:http/http.dart' as http;

void fetchData() async {
  try {
    final response = await http.get(
        Uri.parse('https://student:student0815@hyfive.info:3306/hyFiveDB'));

    if (response.statusCode == 200) {
      // Parse the response data (response.body) here
      print('Data: ${response.body}');
    } else {
      // Handle errors
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Error: $e');
  }
}
