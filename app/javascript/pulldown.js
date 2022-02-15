window.addEventListener('load', function(){
  const propertyId = document.getElementById('property_id');
  propertyId.addEventListener('change', inputChangeRoom);
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