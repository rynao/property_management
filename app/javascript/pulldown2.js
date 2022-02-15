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
      const contractArea = document.getElementById("contract-area");
      contractArea.innerHTML = buildContractHTML(XHR);
    };
  });

  observer.observe(roomSelect, {
    childList: true
  });
});

function buildContractHTML(XHR) {
  const contracts = XHR.response.contracts;
  let items = [];
  contracts.forEach(contract => {
    item = `<option value=${contract.id}> ${contract.start_date}</option>`;
    items.push(item);
  });
  const html = `
    <label class='col-md-3 form-label'>契約開始日</label>
    <div class='col-md-6'>
      <select name='contract_id', class='form-control'>
      ${items}
      </select>
    </div`;
  return html;
};

  