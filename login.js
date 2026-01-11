document.getElementById("loginForm").addEventListener("submit", function(e){
  e.preventDefault(); // stop page reload

  const username = this.uname.value;
  const password = this.psw.value;

  if(username === "admin" && password === "1234") {
    alert("Login successful!");
    window.location.href = "admin_dashboard.jsp"; // redirect
  } else {
    alert("Invalid username or password");
  }
});