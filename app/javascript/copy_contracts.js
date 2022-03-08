const copyContracts = () => {
  const copyBtn = document.getElementById('copy_btn');
  copyBtn.addEventListener('click',function() {
    let contracts =[];
    const checks = document.getElementsByClassName('check')
    for (let i = 0; i < checks.length; i++){
      if(checks[i].checked) {
        contracts.push(checks[i].value);
      };
    };
    const params = `id=${contracts}`;
    const url = "/get_copy_contracts?" + params
    const XHR = new XMLHttpRequest();
    XHR.open("GET", url, true);
    XHR.responseType = "json";
    XHR.send();
    XHR.onload = () => {
    const copyContracts = XHR.response.partial;
    console.log(copyContracts);
    const dataForms = document.getElementById('copy_contracts_data')
    console.log(dataForms);
    dataForms.innerHTML = copyContracts;
    // let content = [];
    // let contents = [];

    // copyContracts.forEach(contract => {
    //   const propertyId = contract.property_id
    //   const roomId = contract.room_id
    //   const startContract = contract.start_date
    //   const rent = contract.rent
    //   item = `
    //     `
    //   console.log(rent);
    // });
    };
  });
};

window.addEventListener('load',copyContracts);
