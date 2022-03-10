const changeTargetBuilding = () => {
  const targetBuilding = document.getElementById('select_building');
  targetBuilding.addEventListener('change', function (){
    const params = `property_id=${this.value}`;
    const url = "/get_building_rents?" + params
    const XHR = new XMLHttpRequest();
    XHR.open("GET", url, true);
    XHR.responseType = "json";
    XHR.send();
    XHR.onload = () => {
      const labels = XHR.response.labels;
      const data = XHR.response.data;
      changeChart(labels, data);
    };
  });
};

function changeChart(labels, data) {
    const ctx = document.getElementById('allChart');
    if (allChart) {
      allChart.destroy();
    };
    window.allChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: '#24205E',
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                legend: false
            }
        }
    });
};  

window.addEventListener('load',changeTargetBuilding);
