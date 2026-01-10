window.onload = function() {

    const modal = document.getElementById("productModal");
    const btnAdd = document.getElementById("btnAddProduct");
    const spanClose = document.querySelector(".close");
    const tableBody = document.querySelector(".admin-table tbody");
    const form = document.getElementById("addProductForm");

    let editingRow = null; // track row being edited

    // --- Modal open/close ---
    btnAdd.onclick = () => { 
        editingRow = null; 
        form.reset();
        modal.style.display = "block"; 
    };
    spanClose.onclick = () => modal.style.display = "none";
    window.onclick = (e) => { if(e.target == modal) modal.style.display = "none"; }

    // --- Add/Edit row function ---
    function addOrUpdateRow(product) {
        if(editingRow) {
            // Update existing row
            editingRow.cells[0].querySelector("img").src = product.imageURL;
            editingRow.cells[1].innerText = product.name;
            editingRow.cells[2].innerText = product.category;
            editingRow.cells[3].innerText = parseFloat(product.price).toFixed(2);
            editingRow.cells[4].innerText = product.description || "-";
        } else {
            // Add new row
            const row = tableBody.insertRow();
            row.innerHTML = `
                <td><img src="${product.imageURL}" width="60"></td>
                <td>${product.name}</td>
                <td>${product.category}</td>
                <td>${parseFloat(product.price).toFixed(2)}</td>
                <td>${product.description || "-"}</td>
                <td>
                    <button class="edit">Edit</button>
                    <button class="delete">Delete</button>
                </td>
            `;
        }
    }

    // --- Event delegation for Edit/Delete ---
    tableBody.addEventListener("click", function(e) {
        const target = e.target;
        const row = target.closest("tr");
        if(!row) return;

        if(target.classList.contains("edit")) {
            editingRow = row;
            document.getElementById("productName").value = row.cells[1].innerText;
            document.getElementById("productCategory").value = row.cells[2].innerText;
            document.getElementById("productPrice").value = row.cells[3].innerText;
            // image input skip
            modal.style.display = "block";
        }

        if(target.classList.contains("delete")) {
            if(confirm("Are you sure you want to delete this product?")) {
                tableBody.removeChild(row);
            }
        }
    });

    // --- Form submit ---
    form.onsubmit = function(e) {
        e.preventDefault();
        const name = document.getElementById("productName").value;
        const category = document.getElementById("productCategory").value;
        const price = document.getElementById("productPrice").value;
        const fileInput = document.getElementById("productImageFile");

        let imageURL = "";
        if(fileInput.files.length > 0) {
            imageURL = URL.createObjectURL(fileInput.files[0]);
        }

        const product = { name, category, price, description: "-", imageURL };
        addOrUpdateRow(product);

        form.reset();
        modal.style.display = "none";
    }

    // --- Load initial static products ---
    const initialProducts = [
        { name: "Chocolate Cake", category: "Cake", price: 25, description: "Rich and moist chocolate cake", imageURL: "images/chocolate-cake.jpg" },
        { name: "Red Velvet Cake", category: "Cake", price: 25, description: "Topped with cream cheese frosting", imageURL: "images/Red-Velvet.png" }
    ];
    initialProducts.forEach(p => addOrUpdateRow(p));
};

//============================================//
//------------ Order View Modal ---------------//
//============================================//

// Modal Elements
const orderModal = document.getElementById("orderModal");
const spanCloseOrder = orderModal.querySelector(".close");
const btnCloseOrderModal = document.getElementById("btnCloseOrderModal");

// Modal fields
const modalOrderID = document.getElementById("modalOrderID");
const modalCustomerName = document.getElementById("modalCustomerName");
const modalOrderDate = document.getElementById("modalOrderDate");
const modalTotalAmount = document.getElementById("modalTotalAmount");
const modalOrderStatus = document.getElementById("modalOrderStatus");

// Attach event to all View buttons
const viewButtons = document.querySelectorAll(".btn-view");

viewButtons.forEach(button => {
  button.addEventListener("click", (e) => {
    const row = e.target.closest("tr");
    modalOrderID.textContent = row.cells[0].textContent;
    modalCustomerName.textContent = row.cells[1].textContent;
    modalOrderDate.textContent = row.cells[2].textContent;
    modalTotalAmount.textContent = row.cells[3].textContent;
    modalOrderStatus.textContent = row.cells[4].textContent;

    orderModal.style.display = "block";
  });
});

// Close modal
spanCloseOrder.onclick = () => orderModal.style.display = "none";
btnCloseOrderModal.onclick = () => orderModal.style.display = "none";
window.addEventListener("click", (e) => {
  if (e.target === orderModal) orderModal.style.display = "none";
});


//============================================//
//------------ Order Update Modal -------------//
//============================================//

// Update Modal Elements
const updateModal = document.getElementById("updateOrderModal");
const updateForm = document.getElementById("updateOrderForm");
const updateSpanClose = updateModal.querySelector(".close");
const updateModalOrderID = document.getElementById("updateModalOrderID");
const orderStatusSelect = document.getElementById("orderStatusSelect");

// Attach event to all Update buttons
const updateButtons = document.querySelectorAll(".btn-update");

updateButtons.forEach(button => {
  button.addEventListener("click", (e) => {
    const row = e.target.closest("tr");
    updateModalOrderID.textContent = row.cells[0].textContent;
    orderStatusSelect.value = row.cells[4].textContent;

    // Store reference to row being updated
    updateForm.currentRow = row;

    updateModal.style.display = "block";
  });
});

// Close update modal
updateSpanClose.onclick = () => updateModal.style.display = "none";
window.addEventListener("click", (e) => {
  if (e.target === updateModal) updateModal.style.display = "none";
});

// Handle form submit
updateForm.addEventListener("submit", (e) => {
  e.preventDefault();
  const newStatus = orderStatusSelect.value;

  // Update status in the table row
  updateForm.currentRow.cells[4].textContent = newStatus;

  // Close modal
  updateModal.style.display = "none";

  // Optional alert
  alert(`✅ Order ${updateModalOrderID.textContent} status updated to ${newStatus}`);
});
