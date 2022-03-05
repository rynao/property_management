const addRoomForm = () => {
  const addBtn = document.getElementById('add-form-btn');
  addBtn.addEventListener('click',function(){
    let index = document.getElementsByClassName('item')
    const last = index[index.length - 1];
    let lastIndex = last.dataset.name;
    let indexNum = Number(lastIndex) + 1;
    const propertyId = document.getElementById('room_property_id');
    const userId = document.getElementById('room_user_id');
    const html = `
    <tr class="item", data-name="${indexNum}", id="item_${indexNum}">
      <td>
        <input class="form-control" placeholder="例：101" required="required" type="text" name="form_room_collection[rooms_attributes][${indexNum}][name]" id="form_room_collection_rooms_attributes_${indexNum}_name">
      </td>
      <td>
        <input class="form-control" placeholder="例：1K" type="text" name="form_room_collection[rooms_attributes][${indexNum}][layout]" id="form_room_collection_rooms_attributes_${indexNum}_layout">
      </td>
      <td>
        <input class="form-control" placeholder="例：23.3" type="text" name="form_room_collection[rooms_attributes][${indexNum}][room_size]" id="form_room_collection_rooms_attributes_${indexNum}_room_size">
      </td>
      <td>
        <input class="form-control" placeholder="例：南東" type="text" name="form_room_collection[rooms_attributes][${indexNum}][direction]" id="form_room_collection_rooms_attributes_${indexNum}_direction">
      </td>
      <td>
        <span class="delete-form-btn btn btn-outline-secondary", id="delete_btn_${indexNum}">削除</span>
      </td>
      <input value=${propertyId.value} type="hidden" name="form_room_collection[rooms_attributes][${indexNum}][property_id]" id="form_room_collection_rooms_attributes_${indexNum}_property_id">
      <input value=${userId.value} type="hidden" name="form_room_collection[rooms_attributes][${indexNum}][user_id]" id="form_room_collection_rooms_attributes_${indexNum}_user_id">
    </tr>`;
    last.insertAdjacentHTML('afterend', html);
    const targetBtn = document.getElementById(`delete_btn_${indexNum}`);
    console.log(targetBtn);
    targetBtn.addEventListener('click', function(){
      const targetElement = document.getElementById(`item_${indexNum}`);
      console.log(targetElement);
      targetElement.remove();
    });
  });
};


window.addEventListener('load', addRoomForm);