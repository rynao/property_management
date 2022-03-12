window.addEventListener('load', function(){
    const ctx = document.getElementById('monthChart');
    const monthChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: gon.month_labels,
            datasets: [{
                data: gon.month_data,
                backgroundColor: '#A7D9D5',
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks : {
                        callback: function(tick) {
                          return '¥' + tick.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        }
                      }
                }
            },
            plugins: {
                legend: false
            }
        }
    });

    const ctx2 = document.getElementById('allChart');
    window.allChart = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: gon.all_labels,
            datasets: [{
                data: gon.all_data,
                backgroundColor: '#24205E',
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks : {
                        callback: function(tick) {
                          return '¥' + tick.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        }
                      }
                }
            },
            plugins: {
                legend: false
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
                backgroundColor: ['#365596','rgba(0, 0, 0, 0)'],
                cutout:'70%',
            }]
        },
    });
});