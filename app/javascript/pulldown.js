window.onload = function() {

  // 部屋の選択肢
  rom = document.getElementById("contract_room_id");

  // 物件の選択肢が変更された際の動作
  property = document.getElementById("contract_property_id");
  property.onchange = changeProperty;

}

// 物件の選択肢が変更された際の動作

function changeProperty() {

  // 変更後のカテゴリを取得

  var changedProperty = property.value;
  if (changedProperty == "0") {
    // カテゴリに和食が選択された場合
    setJFootds();
  } else if (changedProperty == "1") {
    // カテゴリにアジア料理が選択された場合
    setAsianFoods();
  } else {
    // カテゴリにヨーロッパ料理が選択された場合
    setEuropeFoods();
  }
}

// 和食の選択肢を設定する

function setJFootds() {

  // 好きな食べ物の選択肢を空にする
  food.textContent = null;

  // 和食の選択肢
  var jFoods = [
    {cd:"", label:"選択して下さい"},
    {cd:"0", label:"寿司"},
    {cd:"1", label:"おでん"},
    {cd:"2", label:"そば"}
  ];

  jFoods.forEach(function(value) {
    var op = document.createElement("option");
    op.value = value.cd;
    op.text = value.label;
    food.appendChild(op);
  });

}

// アジア料理の選択肢を設定する

function setAsianFoods() {

  // 好きな食べ物の選択肢を空にする

  food.textContent = null;

  // アジア料理の選択肢
  var asianFoods = [
    {cd:"", label:"選択して下さい"},
    {cd:"3", label:"インドネシア料理"},
    {cd:"4", label:"ベトナム料理"},
    {cd:"5", label:"インド料理"}
  ];

  asianFoods.forEach(function(value) {
    var op = document.createElement("option");
    op.value = value.cd;
    op.text = value.label;
    food.appendChild(op);
  });

}

// ヨーロッパ料理の選択肢を設定する

function setEuropeFoods() {

  // 好きな食べ物の選択肢を空にする
  food.textContent = null;

  // ヨーロッパ料理の選択肢
  var europeFoods = [
    {cd:"", label:"選択して下さい"},
    {cd:"6", label:"イタリア料理"},
    {cd:"7", label:"カリフォルニア料理"},
    {cd:"8", label:"モロッコ料理"}
  ];

  europeFoods.forEach(function(value) {
    var op = document.createElement("option");
    op.value = value.cd;
    op.text = value.label;
    food.appendChild(op);
  });
}