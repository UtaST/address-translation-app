window.addEventListener("load", (e) => {
  const userPopBtn = document.getElementById("user_help_icon");
  const userPop = document.getElementById("user_pop");
  userPopBtn.addEventListener("mouseover", (e) => {
    userPop.style.display = "flex";
    userPop.animate([{opacity: '0'}, {opacity: '1'}], 200);
  });
  userPopBtn.addEventListener("mouseout", (e) => {
    userPop.style.display = "none";
  });
});