const copyPaidDate = () => {
  const dateForm = document.getElementsByClassName('select_paid_date');
  dateForm[0].addEventListener('change', function() {
    const targetForms = document.getElementsByClassName('paid_dates')
    for(let i = 0; i < targetForms.length; i++){
      targetForms[i].value = `${dateForm[0].value}-${dateForm[1].value}-01`;
    };
  });
  dateForm[1].addEventListener('change', function() {
    const targetForms = document.getElementsByClassName('paid_dates')
    for(let i = 0; i < targetForms.length; i++){
      targetForms[i].value = `${dateForm[0].value}-${dateForm[1].value}-1`;
    };
  });
};



window.addEventListener('load',copyPaidDate);
