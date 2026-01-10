// --- Modal Open/Close ---
var modal = document.getElementById("productModal");
var btn = document.getElementById("btnAddProduct");
var span = document.getElementsByClassName("close")[0];

btn.onclick = function () {
  modal.style.display = "block";
};

span.onclick = function () {
  modal.style.display = "none";
};

window.onclick = function (event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
};

// --- Add Product to table ---
var form = document.getElementById("addProductForm");
var tableBody = document.querySelector(".admin-table tbody");

form.onsubmit = function (e) {
  e.preventDefault();

  var name = document.getElementById("productName").value;
  var category = document.getElementById("productCategory").value;
  var price = document.getElementById("productPrice").value;
  var image = document.getElementById("productImage").value;
  var description = "-"; // simple placeholder

  var row = tableBody.insertRow(); // add new row at end
  var cell1 = row.insertCell(0);
  var cell2 = row.insertCell(1);
  var cell3 = row.insertCell(2);
  var cell4 = row.insertCell(3);
  var cell5 = row.insertCell(4);
  var cell6 = row.insertCell(5);

  cell1.innerHTML = '<img src="' + image + '" width="60">';
  cell2.innerText = name;
  cell3.innerText = category;
  cell4.innerText = parseFloat(price).toFixed(2);
  cell5.innerText = description;
  cell6.innerHTML =
    '<button class="edit">Edit</button> <button class="delete">Delete</button>';

  // --- Edit button ---
  cell6.querySelector(".edit").onclick = function () {
    document.getElementById("productName").value = name;
    document.getElementById("productCategory").value = category;
    document.getElementById("productPrice").value = price;
    document.getElementById("productImage").value = image;
    modal.style.display = "block";

    // Remove row first, will re-add after submit
    tableBody.deleteRow(row.rowIndex - 1);
  };

  // --- Delete button ---
  cell6.querySelector(".delete").onclick = function () {
    if (confirm("Are you sure you want to delete this product?")) {
      tableBody.deleteRow(row.rowIndex - 1);
    }
  };

  form.reset();
  modal.style.display = "none";
};
