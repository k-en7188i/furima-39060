window.addEventListener('load', () => {
  console.log("OK、頑張れクソやろー！");

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    console.log("イベント発火");
    const inputValue = priceInput.value;
    console.log(inputValue);

    // 販売手数料（10%）を計算
    const fee = Math.floor(inputValue * 0.1);
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = fee; // 計算した販売手数料を表示

    // 販売利益を計算
    const profit = inputValue - fee;
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = profit; // 計算した販売利益を表示
  });

});