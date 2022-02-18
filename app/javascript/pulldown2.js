window.addEventListener('load', function(){
  const roomSelect = document.getElementById('room-select');
  const observer = new MutationObserver(records => {
    const params = `room_id=${roomSelect.value}`;
    const url = "/get_contracts?" + params
    const XHR = new XMLHttpRequest();
    XHR.open("GET", url, true);
    XHR.responseType = "json";
    XHR.send();
    XHR.onload = () => {
      const contractSelect = document.getElementById("contract-select");
      contractSelect.innerHTML = buildContractHTML(XHR);
    };
  });

  observer.observe(roomSelect, {
    attributes: true,
    childList: true,
    characterData: true,
  });

  const roomSelect2 = document.getElementById('room-select');
  roomSelect2.addEventListener('change', inputChangeContract);

});


function buildContractHTML(XHR) {
  const contracts = XHR.response.contracts;
  let item = [];
  let items = [];
  contracts.forEach(contract => {
    item = `<option value=${contract.id}> ${contract.start_date}</option>`;
    items = items + item;
  });
  const html = items;
  return html;
};

function inputChangeContract(event){
  const params = `room_id=${event.currentTarget.value}`;
  const url = "/get_contracts?" + params
  const XHR = new XMLHttpRequest();
  XHR.open("GET", url, true);
  XHR.responseType = "json";
  XHR.send();
  XHR.onload = () => {
    const contractSelect = document.getElementById("contract-select");
    contractSelect.innerHTML = buildContractHTML(XHR);
  };
};