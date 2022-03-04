const deleteRoomForm = () => {
  const addBtn = document.getElementById('add-form-btn');
  addBtn.addEventListener('click',function(){
    const deleteBtn = document.getElementsByClassName('delete-form-btn');
    console.log(deleteBtn.length)
    for(let i = 0; i < deleteBtn.length; i++){
      deleteBtn[i].addEventListener('click',function(e){
        const targetNum = Number(this.dataset.name);
        console.log(targetNum)
        const targetElement = document.getElementsByClassName('item')[targetNum];
        console.log(targetElement);
        targetElement.remove();
      });
    };
  });
};


window.addEventListener('load', deleteRoomForm);
