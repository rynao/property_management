window.addEventListener('load', function(){
<<<<<<< Updated upstream
  
  const propertyId = document.getElementById('property_id');
  propertyId.addEventListener('change', inputChangeRoom);

  const roomId = document.getElementById('room_id');
  roomId.addEventListener('change', inputChangeContract);
});
=======
  const propertyId1 = document.getElementById('property_id_1');
  propertyId1.addEventListener('change', inputChangeRoom);
});

window.addEventListener('load', function(){
  const propertyId2 = document.getElementById('property_id_2');
  propertyId2.addEventListener('change', inputChangeRoom);
});


>>>>>>> Stashed changes

function inputChangeRoom(event){
  const params = `property_id=${event.currentTarget.value}`;
  const url = "/get_rooms?" + params
  const XHR = new XMLHttpRequest();
  XHR.open("GET", url, true);
  XHR.responseType = "json";
  XHR.send();
  XHR.onload = () => {
    const roomSelect = document.getElementById("room-select");
    roomSelect.innerHTML = buildRoomHTML(XHR);
  };
};

function buildRoomHTML(XHR) {
  const rooms = XHR.response.rooms;
  let item = [];
  let items = [];
  rooms.forEach(room => {
<<<<<<< Updated upstream
    item = `<option value=${room.id}> ${room.room_name}</option>`;
    items.push(item);
  });
  const html = `
    <label class='form-label'>部屋</label>
    <select name='room_id', class='form-control'>
    ${items}
    </select>`;
=======
    item = `<option value=${room.id}> ${room.name}</option>`;
    items = items + item
  });
  const html = items;
>>>>>>> Stashed changes
  return html;
}

function inputChangeContract(event){
  const params = `room_id=${event.currentTarget.value}`;
  const url = "/get_contracts?" + params
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
    <label class='form-label'>契約</label>
    <select name='contract_id', class='form-control'>
    ${items}
    </select>`;
  return html;
}

