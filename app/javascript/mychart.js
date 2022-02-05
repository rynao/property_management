import { BubbleChart } from "chartkick";

window.addEventListener('load', function(){
    const ctx = document.getElementById('myChart');
    const myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: gon.chart_labels,
            datasets: [{
                label: '家賃推移',
                data: gon.chart_data,
                backgroundColor: 'RGB(68,114,196)',
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
});