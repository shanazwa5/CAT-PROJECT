window.onload = function () {

    /* =========================
       PRODUCT MODAL (ADMIN PRODUCTS)
       ========================= */

    const productModal = document.getElementById("productModal");
    const btnAddProduct = document.getElementById("btnAddProduct");
    const closeProductModal = productModal
        ? productModal.querySelector(".close")
        : null;

    if (btnAddProduct && productModal) {
        btnAddProduct.onclick = () => {
            productModal.style.display = "block";
        };
    }

    if (closeProductModal) {
        closeProductModal.onclick = () => {
            productModal.style.display = "none";
        };
    }

    window.onclick = (e) => {
        if (e.target === productModal) {
            productModal.style.display = "none";
        }
    };


    /* =========================
       ORDER VIEW MODAL (ADMIN ORDER)
       ========================= */

    const orderModal = document.getElementById("orderModal");
    const closeOrderModal = orderModal
        ? orderModal.querySelector(".close")
        : null;
    const btnCloseOrderModal = document.getElementById("btnCloseOrderModal");

    const modalOrderID = document.getElementById("modalOrderID");
    const modalCustomerName = document.getElementById("modalCustomerName");
    const modalOrderDate = document.getElementById("modalOrderDate");
    const modalTotalAmount = document.getElementById("modalTotalAmount");
    const modalOrderStatus = document.getElementById("modalOrderStatus");

    document.querySelectorAll(".view-order").forEach(button => {
        button.addEventListener("click", () => {
            const row = button.closest("tr");

            modalOrderID.textContent = row.cells[0].innerText;
            modalCustomerName.textContent = row.cells[1].innerText;
            modalOrderDate.textContent = row.cells[2].innerText;
            modalTotalAmount.textContent = row.cells[3].innerText;
            modalOrderStatus.textContent = row.cells[4].innerText;

            orderModal.style.display = "block";
        });
    });

    if (closeOrderModal) {
        closeOrderModal.onclick = () => orderModal.style.display = "none";
    }

    if (btnCloseOrderModal) {
        btnCloseOrderModal.onclick = () => orderModal.style.display = "none";
    }


    /* =========================
       ORDER STATUS UPDATE MODAL
       ========================= */

    const updateModal = document.getElementById("updateOrderModal");
    const closeUpdateModal = updateModal
        ? updateModal.querySelector(".close")
        : null;
    const updateOrderIdInput = document.getElementById("updateModalOrderID");

    document.querySelectorAll(".update-order").forEach(button => {
        button.addEventListener("click", () => {
            const row = button.closest("tr");
            updateOrderIdInput.value = row.cells[0].innerText.replace("#", "");
            updateModal.style.display = "block";
        });
    });

    if (closeUpdateModal) {
        closeUpdateModal.onclick = () => updateModal.style.display = "none";
    }

    window.addEventListener("click", (e) => {
        if (e.target === updateModal) {
            updateModal.style.display = "none";
        }
    });
};