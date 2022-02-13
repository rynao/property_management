const calcEndDate = () => {
  const btn = document.getElementById('submit-btn');
  btn.addEventListener('click',(e)=>{
    e.preventDefault();
    const start_date = document.getElementById('start-date');
    const date = new Date(start_date.value);
    const year = document.getElementById('contract-year');
    const form = document.getElementById('contract-form');

    date.setFullYear(date.getFullYear() + Number(year.value));
    date.setDate(date.getDate()-1)
    const end_date =`<input value=${date.toLocaleDateString()} name='end_date' type="hidden">`;
    form.insertAdjacentHTML("beforeend", end_date);
    document.getElementById('contract-form').submit();
  });
};

window.addEventListener('load', calcEndDate);