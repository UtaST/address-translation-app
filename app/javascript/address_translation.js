window.addEventListener("load", (e) => {
  const translate = document.getElementById("address_translate");
  translate.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("address_form"));
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/addresses/translate", true);
    xhr.responseType = "json";
    xhr.send(formData);
    xhr.onload = () => {
      if (xhr.status != 200) {
        alert(`Error ${xhr.status}: ${xhr.statusText}`);
        return null;
      }
      const address = xhr.response.address;
      // 出力する要素を取得
      const addressLine1 = document.getElementById("en_address_line1");
      const addressLine2 = document.getElementById("en_address_line2");
      const city = document.getElementById("en_city");
      const stateProvinceRegion = document.getElementById("en_state_province_region");
      const postalCode = document.getElementById("en_postal_code");
      const country = document.getElementById("en_country");
      // 出力する内容を変数に定義
      const addressCityAry = address.city.split(' ');
      const addressLine1Text = `${address.house_number} ${address.town_name} ${addressCityAry[1]}`;
      const addressLine2Text = `${address.room_number} ${address.building_name}`;
      const cityText = addressCityAry[0]
      const stateProvinceRegionText = address.prefecture;
      const postalCodeText = address.postal_code;
      const countryText = "Japan";
      // 要素にtextを挿入
      addressLine1.innerText = addressLine1Text;
      addressLine2.innerText = addressLine2Text;
      city.innerText = cityText;
      stateProvinceRegion.innerText = stateProvinceRegionText;
      postalCode.innerText = postalCodeText;
      country.innerText = countryText;
    };
  });
});