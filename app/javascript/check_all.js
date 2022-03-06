const checkAll = () => {
  const checkAll = document.getElementById("check_all");
  checkAll.addEventListener('click', function(){
    const checks = document.getElementsByClassName("check");
    let count = 0;
    for (let i = 0; i< checks.length; i++){
      if (checks[i].checked === true) {
        count += 1;
      };
    };
    if (checks.length !== count) {
      for (let i = 0; i < checks.length; i++){
        checks[i].checked = true;
      };

    } else{
      for (let i = 0; i < checks.length; i++){
        checks[i].checked = false;
      };
    }
  })
};



window.addEventListener('load',checkAll);