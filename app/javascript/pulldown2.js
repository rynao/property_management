window.addEventListener('load', function(){
  const roomId = document.getElementById('room_id');
  roomId.addEventListener('change', inputChangeContract);
    // const target = document.getElementById('room_id');
    // const config = {childList: true, characterData: true};

    // const callback = function(mutationsList, observer) {
    //   for(const mutation of mutationsList) {
    //     const params = `room_id=${currentTarget.value}`;
    //     const url = "/get_contracts?" + params
    //     console.log(params)
    //     console.log(url)
    //     const XHR = new XMLHttpRequest();
    //     XHR.open("GET", url, true);
    //     XHR.responseType = "json";
    //     XHR.send();
    //     XHR.onload = () => {
    //       const contractArea = document.getElementById("contract-area");
    //       contractArea.innerHTML = buildContractHTML(XHR);
    //     };
    //   };
    // };
    // const observer = new MutationObserver(callback);
    // observer.observe(target, config);
});

function inputChangeContract(event){
  const params = `room_id=${event.currentTarget.value}`;
  const url = "/get_contracts?" + params
  console.log(params)
  console.log(url)
  const XHR = new XMLHttpRequest();
  XHR.open("GET", url, true);
  XHR.responseType = "json";
  XHR.send();
  XHR.onload = () => {
    const contractArea = document.getElementById("contract-area");
    contractArea.innerHTML = buildContractHTML(XHR);
  };
};

function buildContractHTML(XHR) {
  const contracts = XHR.response.contracts;
  let items = [];
  contracts.forEach(contract => {
    item = `<option value=${contract.id}> ${contract.start_date}</option>`;
    items.push(item);
  });
  const html = `
    <label class='col-md-3 form-label'>契約</label>
    <div class='col-md-6'>
      <select name='contract_id', class='form-control'>
      ${items}
      </select>
    </div`;
  return html;
}

  