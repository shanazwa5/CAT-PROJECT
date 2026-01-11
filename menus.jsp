<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="style.css">
</head>

<body>

<!-- HEADER -->
<header>
    <nav class="navbar section-content">
        <a href="index.jsp" class="nav-logo">
            <h2 class="logo-text">🍰 SweetBite</h2>
        </a>

        <ul class="nav-menu">
            <li class="nav-item"><a href="index.jsp#home" class="nav-link">Home</a></li>
            <li class="nav-item"><a href="menus.jsp" class="nav-link">Menu</a></li>
        </ul>

        <div class="nav-action">
            <a href="cart.jsp" class="fas fa-shopping-cart"></a>
        </div>
    </nav>
</header>

<main class="menu-section">
<div class="section-content">

    <h2 class="menu-title">Our Menu</h2>
    <p style="text-align:center;">Search and filter cakes and pastries</p>

    <!-- SEARCH & FILTER -->
    <div class="nav-search-filter" style="justify-content:center; margin:20px 0;">
        <input type="text" id="search" placeholder="Search..." onkeyup="filterMenu()">

        <select id="filter" onchange="filterMenu()">
            <option value="all">All</option>
            <option value="cake">Cake</option>
            <option value="pastry">Pastry</option>
        </select>
    </div>

    <div class="menu-list">

<%
    Connection conn = DBConnection.getConnection();

    String productSql =
        "SELECT PRODUCT_ID, NAME, CATEGORY, DESCRIPTION, IMAGE_URL " +
        "FROM PRODUCTS ORDER BY CATEGORY, NAME";

    PreparedStatement psProduct = conn.prepareStatement(productSql);
    ResultSet rsProduct = psProduct.executeQuery();

    while (rsProduct.next()) {
        int productId = rsProduct.getInt("PRODUCT_ID");
        String name = rsProduct.getString("NAME");
        String category = rsProduct.getString("CATEGORY");
        String desc = rsProduct.getString("DESCRIPTION");
        String image = rsProduct.getString("IMAGE_URL");
%>

    <div class="menu-item" data-category="<%= category.toLowerCase() %>">

        <form action="addToCart" method="post">

            <img src="<%= image %>" class="menu-image" alt="<%= name %>">

            <h3 class="name"><%= name %></h3>
            <p class="text"><%= desc %></p>

            <input type="hidden" name="productId" value="<%= productId %>">

            <label>Size:</label>
            <select name="size" required>
                <%
                    String priceSql =
                        "SELECT PRODUCT_SIZE, PRICE FROM PRODUCT_PRICE WHERE PRODUCT_ID = ?";
                    PreparedStatement psPrice = conn.prepareStatement(priceSql);
                    psPrice.setInt(1, productId);
                    ResultSet rsPrice = psPrice.executeQuery();

                    while (rsPrice.next()) {
                %>
                    <option value="<%= rsPrice.getString("PRODUCT_SIZE") %>">
                        <%= rsPrice.getString("PRODUCT_SIZE") %>
                        (RM <%= String.format("%.2f", rsPrice.getDouble("PRICE")) %>)
                    </option>
                <%
                    }
                    rsPrice.close();
                    psPrice.close();
                %>
            </select>

            <label>Quantity:</label>
            <input type="number" name="quantity" min="1" value="1" required>

            <div class="product-actions">
                <button type="submit" class="btn">Add To Cart</button>
            </div>

        </form>
    </div>

<%
    }
    rsProduct.close();
    psProduct.close();
    conn.close();
%>

    </div>
</div>
</main>

<!-- FOOTER -->
<footer class="footer-section">
    <div class="section-content">
        <p class="copyright-text">
            &copy; 2024 SweetBite. All rights reserved.
        </p>
    </div>
</footer>

<!-- FILTER SCRIPT -->
<script>
function filterMenu() {
    const searchText = document.getElementById("search").value.toLowerCase();
    const selectedCategory = document.getElementById("filter").value;
    const menuItems = document.querySelectorAll(".menu-item");

    menuItems.forEach(item => {
        const itemName = item.querySelector(".name").innerText.toLowerCase();
        const itemCategory = item.getAttribute("data-category");

        const matchSearch = itemName.includes(searchText);
        const matchCategory =
            selectedCategory === "all" || itemCategory === selectedCategory;

        item.style.display =
            matchSearch && matchCategory ? "flex" : "none";
    });
}
</script>

</body>
</html>