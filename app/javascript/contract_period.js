const calcEndDate = () => {
  const year = document.getElementById('contract-year');
  year.addEventListener('input',()=>{
    const start_date = document.getElementById('start-date');
    const date = new Date(start_date.value);
    const end_date = document.getElementById('end-date');

    date.setFullYear(date.getFullYear() + Number(year.value));
    date.setDate(date.getDate()-1)
    end_date.value = date.toISOString().split('T')[0];
  });
};

window.addEventListener('load', calcEndDate);