<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu | SweetBite</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="/sweetbite/css/style.css">
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
            <li class="nav-item"><a href="index.jsp#about" class="nav-link">About Us</a></li>
            <li class="nav-item"><a href="menus.jsp" class="nav-link">Menu</a></li>
            <li class="nav-item"><a href="index.jsp#testimonials" class="nav-link">Testimonials</a></li>
            <li class="nav-item"><a href="index.jsp#contact" class="nav-link">Contact</a></li>
        </ul>

        <div class="nav-search-filter">
          <!-- Search Bar -->
          <input type="text" id="searchInput" placeholder="Search menu...">
    
          <!-- Filter Dropdown -->
          <select id="categoryFilter">
            <option value="all">All</option>
            <option value="cake">Cake</option>
            <option value="pastry">Pastry</option>
          </select>
        </div>

        <div class="nav-action">
            <a href="cart.jsp" class="fas fa-shopping-cart"></a>
            <a href="admin_login.jsp" class="fas fa-user"></a>
        </div>
    </nav>
</header>

<main class="menu-section">
    <div class="section-content">

        <h2 class="menu-title">Our Menu</h2>
        <p style="text-align:center;">Choose your favorite cakes & pastries</p>

        <div class="menu-list">

            <%
                Connection conn = null;
                PreparedStatement psProduct = null;
                ResultSet rsProduct = null;

                try {
                    conn = DBConnection.getConnection();

                    String productSql =
                            "SELECT PRODUCT_ID, NAME, CATEGORY, DESCRIPTION, IMAGE_URL " +
                                    "FROM PRODUCTS ORDER BY CATEGORY, NAME";

                    psProduct = conn.prepareStatement(productSql);
                    rsProduct = psProduct.executeQuery();

                    while (rsProduct.next()) {
                        int productId = rsProduct.getInt("PRODUCT_ID");
                        String name = rsProduct.getString("NAME");
                        String category = rsProduct.getString("CATEGORY");
                        String desc = rsProduct.getString("DESCRIPTION");
                        String image = rsProduct.getString("IMAGE_URL");
            %>

            <div class="menu-item" data-category="<%= category.toLowerCase() %>">

                <form action="addToCart" method="post">

                    <img src="/sweetbite/images/<%= image %>" class="menu-image" alt="<%= name %>">

                    <h3 class="name"><%= name %></h3>
                    <p class="text"><%= desc %></p>

                    <input type="hidden" name="productId" value="<%= productId %>">

                   <%
                    PreparedStatement psPrice = null;
                    ResultSet rsPrice = null;

                    String priceSql =
                            "SELECT PRODUCT_SIZE, PRICE FROM PRODUCT_PRICE WHERE PRODUCT_ID = ?";
                    psPrice = conn.prepareStatement(priceSql);
                    psPrice.setInt(1, productId);
                    rsPrice = psPrice.executeQuery();

                    if ("Pastry".equalsIgnoreCase(category)) {
                        if (rsPrice.next()) {
                    %>
                        <p><strong>Price:</strong>
                            RM <%= String.format("%.2f", rsPrice.getDouble("PRICE")) %>
                        </p>
                        <input type="hidden" name="size"
                                    value="<%= rsPrice.getString("PRODUCT_SIZE") %>">
                    <%
                        }
                    } else {
                    %>
                        <label>Size:</label>
                        <select name="size" required>
                    <%
                        while (rsPrice.next()) {
                    %>
                        <option value="<%= rsPrice.getString("PRODUCT_SIZE") %>">
                            <%= rsPrice.getString("PRODUCT_SIZE") %>
                            (RM <%= String.format("%.2f", rsPrice.getDouble("PRICE")) %>)
                        </option>
                    <%
                        }
                    %>
                        </select>
                    <%
                    }
                    rsPrice.close();
                    psPrice.close();
                    %>

                    <div class="form-group">
                    <label>Quantity:</label>
                    <input type="number" name="quantity" min="1" value="1" required>
                    </div>

                    <div class="product-actions">
                        <button type="submit" class="btn">Add To Cart</button>
                    </div>

                </form>
            </div>

            <%
                }
            } catch (Exception e) {
            %>
            <p style="color:red;">Error loading menu</p>
            <%
                    e.printStackTrace();
                } finally {
                    if (rsProduct != null) rsProduct.close();
                    if (psProduct != null) psProduct.close();
                    if (conn != null) conn.close();
                }
            %>

        </div>
    </div>
</main>

<!-- FOOTER -->
<footer class="footer-section">
    <div class="section-content">
        <p>&copy; 2024 SweetBite. All rights reserved.</p>
    </div>

    <div class="social-link-list">
              <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-x-twitter"></i></a>
    </div>
</footer>
<script src="/sweetbite/js/script.js"></script>
</body>
</html>