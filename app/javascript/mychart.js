window.addEventListener('load', function(){
    const ctx = document.getElementById('monthChart');
    const monthChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: gon.month_labels,
            datasets: [{
                label: '家賃推移',
                data: gon.month_data,
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

    const ctx2 = document.getElementById('allChart');
    const allChart = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: gon.all_labels,
            datasets: [{
                label: '家賃推移',
                data: gon.all_data,
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

    const ctx3 = document.getElementById('vacancyChart');
    const percentage = gon.occupancy_rate
    const vacancyChart = new Chart(ctx3, {
        type: 'doughnut',
        data: {
            datasets: [{
                label: '稼働状況',
                data: [percentage, 100 - percentage],
                backgroundColor: ['RGB(68,114,196)','rgba(0, 0, 0, 0)'],
                cutout:'70%',
            }]
        },
    });
});