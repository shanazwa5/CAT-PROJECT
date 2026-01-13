<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="/sweetbite/css/style.css">
</head>

<body>
<div class="wrapper">

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

        <div class="nav-action">
            <a href="cart.jsp" class="fas fa-shopping-cart"></a>
            <a href="admin_login.jsp" class="fas fa-user"></a>
        </div>
    </nav>
</header>

<main>

<section class="cart-section">
<div class="section-content">

<h1 class="cart-title">Your Cart</h1>

<table>
<tr>
    <th>No</th>
    <th>Product</th>
    <th>Details</th>
    <th>Quantity</th>
    <th>Subtotal</th>
    <th>Action</th>
</tr>

<%
    String sessionId = session.getId();

    double total = 0;
    int count = 1;
    boolean hasItem = false;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();

        String sql =
            "SELECT c.CART_ID, c.PRODUCT_SIZE, c.QUANTITY, c.UNIT_PRICE, " +
            "p.NAME, p.IMAGE_URL " +
            "FROM CART c " +
            "JOIN PRODUCTS p ON c.PRODUCT_ID = p.PRODUCT_ID " +
            "WHERE c.SESSION_ID = ?";

        ps = conn.prepareStatement(sql);
        ps.setString(1, sessionId);
        rs = ps.executeQuery();

        while (rs.next()) {
            hasItem = true;

            int cartId = rs.getInt("CART_ID");
            String size = rs.getString("PRODUCT_SIZE");
            String productName = rs.getString("NAME");
            String image = rs.getString("IMAGE_URL");
            int qty = rs.getInt("QUANTITY");
            double price = rs.getDouble("UNIT_PRICE");

            double subtotal = qty * price;
            total += subtotal;
%>

<tr>
    <td><%= count++ %></td>

    <td>
        <img src="/sweetbite/images/<%= image %>" alt="<%= productName %>" width="80">
        <br>
        <%= productName %>
    </td>

    <td>-</td>
    <td><%= qty %></td>

    <td>RM <%= String.format("%.2f", subtotal) %></td>

    <td>
        <form action="updateCart" method="post">
            <input type="hidden" name="cartid" value="<%= cartId %>">
            <input type="hidden" name="action" value="remove">
            <button type="submit">Remove</button>
        </form>
    </td>
</tr>

<%
        }

        if (!hasItem) {
%>
<tr>
    <td colspan="6" style="text-align:center;">Your cart is empty</td>
</tr>
<%
        }

    } catch (Exception e) {
%>
<tr>
    <td colspan="6">Error loading cart</td>
</tr>
<%
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

</table>

<h3>Total: RM <%= String.format("%.2f", total) %></h3>

<% if (hasItem) { %>
<form action="checkout.jsp" method="get">
    <button class="checkout" type="submit">Proceed to Checkout</button>
</form>
<% } %>

</div>
</section>

</main>

<footer class="footer-section">
    <p>&copy; 2024 SweetBite</p>

    <div class="social-link-list">
              <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-x-twitter"></i></a>
    </div>
</footer>

</div>
</body>
</html>
