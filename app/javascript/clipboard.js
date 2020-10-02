window.addEventListener("load", (e) => {
  const copyBtn = document.getElementsByClassName("clipboard-btn");
  for (let i = 0; i < copyBtn.length; i++ ) {
    copyBtn[i].addEventListener("click", (e) => {
      const copyText = document.getElementsByClassName("en-address")[i].innerText;
      navigator.clipboard.writeText(copyText);
    });
  };
});