window.addEventListener('load', function(){ 
  const propertyId1 = document.getElementById('property_id_1');
  propertyId1.addEventListener('change', inputChangeRoom);
});

window.addEventListener('load', function(){
  const propertyId2 = document.getElementById('property_id_2');
  propertyId2.addEventListener('change', inputChangeRoom);
});

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
    item = `<option value=${room.id}> ${room.name}</option>`;
    items = items + item
  });
  const html = items;
  return html;
};