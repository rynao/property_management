const displayAmounts = () => {
  const contract = document.getElementById('contract-select');
  const observer = new MutationObserver(records => {
    const params = `contract_id=${contract.value}`;
    const url = "/get_amounts?" + params
    const XHR = new XMLHttpRequest();
    XHR.open("GET", url, true);
    XHR.responseType = "json";
    XHR.send();
    XHR.onload = () => {
      const amounts = document.getElementById('amounts');
      amounts.value = XHR.response.amounts;
    };
  });

  observer.observe(contract, {
    attributes: true,
    childList: true,
    characterData: true,
  });

  const contract2 = document.getElementById('contract-select')
  contract2.addEventListener('change',displayAmounts2)
};

window.addEventListener('load', displayAmounts);

function displayAmounts2(event){
  const params = `contract_id=${event.currentTarget.value}`;
  const url = "/get_amounts?" + params
  const XHR = new XMLHttpRequest();
  XHR.open("GET", url, true);
  XHR.responseType = "json";
  XHR.send();
  XHR.onload = () => {
    const amounts = document.getElementById('amounts');
    amounts.value = XHR.response.amounts;
  };
};