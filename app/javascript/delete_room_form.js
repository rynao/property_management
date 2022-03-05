const deleteRoomForm = () => {
  const addBtn = document.getElementById('add-form-btn');
  addBtn.addEventListener('click',function(){
    const deleteBtn = document.getElementsByClassName('delete-form-btn');
    for(let i = 0; i < deleteBtn.length; i++){
      deleteBtn[i].addEventListener('click',function(e){
        const targetNum = Number(this.dataset.name);
        const targetElement = document.getElementsByClassName('item')[targetNum];
        targetElement.remove();
      });
    };
  });
};


window.addEventListener('load', deleteRoomForm);
