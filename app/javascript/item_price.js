window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");

  
  priceInput.addEventListener("input", () => {
    let inputValue = priceInput.value;
    inputValue = Math.floor(inputValue);

    

    // 販売手数料（10%）を計算
    const fee = Math.floor(inputValue * 0.1);

    // 小数点第二位まで表示
    // const fee = (inputValue * 0.1).toFixed(2);

    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = fee; // 計算した販売手数料を表示


    // 販売利益を計算
    const profit = inputValue - fee;
    
    // 小数点第二位まで表示
    // const profit = (inputValue - fee).toFixed(2);

    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = profit; // 計算した販売利益を表示
  });

});