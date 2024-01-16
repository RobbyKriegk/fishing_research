// app.js
document.addEventListener("DOMContentLoaded", function () {
    fetchData();
    getDatabaseData();
});

function fetchData() {
    fetch('/trigger-python')
        .then(response => response.json())
        .then(data => {
            document.getElementById('data-container').innerText = JSON.stringify(data, null, 2);
        })
        .catch(error => {
            console.error('Error fetching data:', error);
            document.getElementById('data-container').innerText = 'Error fetching data';
        });
}

function getDatabaseData() {
    fetch('/database-data', {
        method: 'GET',
    })

        .then(response => response.json())
        .then(data => {
            document.getElementById('data-container').innerText = JSON.stringify(data, null, 2);
        })
        .catch(error => {
            console.error('Error fetching data:', error);
            document.getElementById('data-container').innerText = 'Error fetching data';
        });
}