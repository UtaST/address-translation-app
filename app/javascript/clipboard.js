window.addEventListener("load", (e) => {
  const copyBtn = document.getElementsByClassName("clipboard-btn");
  for (let i = 0; i < copyBtn.length; i++ ) {
    copyBtn[i].addEventListener("click", (e) => {
      const copyText = document.getElementsByClassName("en-address")[i];
      // コピーメッセージをフェードイン・フェードアウトするための準備
      const copyMessage = document.getElementById("clip-message");
      copyText.select();
      document.execCommand("copy");
      copyMessage.style.display = "flex";
      copyMessage.animate([{opacity: '0'}, {opacity: '1'}], 500);
      setTimeout(function() {
        copyMessage.animate([{opacity: "1"}, {opacity: "0"}], 500);
        setTimeout(function() {
          copyMessage.style.display = "none";
        }, 500);
      }, 3000);
    });
  };
});