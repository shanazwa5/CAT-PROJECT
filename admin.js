// Get modal elements
const modal = document.getElementById("productModal");
const btnAdd = document.getElementById("btnAddProduct");
const spanClose = document.querySelector(".close");
const form = document.getElementById("addProductForm");
const tableBody = document.querySelector(".admin-table tbody");

// Open modal
btnAdd.onclick = () => {
  modal.style.display = "block";
};

// Close modal
spanClose.onclick = () => {
  modal.style.display = "none";
};

// Close modal when click outside content
window.onclick = (e) => {
  if (e.target == modal) {
    modal.style.display = "none";
  }
};

// Handle form submit
form.addEventListener("submit", (e) => {
  e.preventDefault(); // stop reload

  // Get input values
  const name = document.getElementById("productName").value;
  const category = document.getElementById("productCategory").value;
  const price = document.getElementById("productPrice").value;
  const image = document.getElementById("productImage").value;

  // Create new table row
  const newRow = document.createElement("tr");
  newRow.innerHTML = `
    <td><img src="${image}" alt="${name}" width="60"></td>
    <td>${name}</td>
    <td>${category}</td>
    <td>${price}</td>
    <td>
      <button class="edit">Edit</button>
      <button class="delete">Delete</button>
    </td>
  `;

  // Append row to table
  tableBody.appendChild(newRow);

  // Clear form
  form.reset();

  // Close modal
  modal.style.display = "none";
});
