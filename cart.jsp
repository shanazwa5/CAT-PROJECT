<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="wrapper">

<!-- HEADER -->
<header>
    <nav class="navbar section-content">
        <a href="#" class="nav-logo">
            <h2 class="logo-text">🍰 SweetBite</h2>
        </a>

        <ul class="nav-menu">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="menus.jsp">Menu</a></li>
        </ul>

        <div class="nav-action">
            <a href="cart.jsp" class="fas fa-shopping-cart"></a>
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
            "SELECT c.CART_ID, c.SIZE, c.QUANTITY, c.UNIT_PRICE, " +
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
            String productName = rs.getString("NAME");
            String image = rs.getString("IMAGE_URL");
            String size = rs.getString("SIZE");
            int qty = rs.getInt("QUANTITY");
            double price = rs.getDouble("UNIT_PRICE");

            double subtotal = qty * price;
            total += subtotal;
%>

<tr>
    <td><%= count++ %></td>

    <td>
        <img src="<%= image %>" alt="<%= productName %>" width="80">
        <br>
        <%= productName %>
    </td>

    <td>Size: <%= size %></td>
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
    <button type="submit">Proceed to Checkout</button>
</form>
<% } %>

</div>
</section>

</main>

<footer class="footer-section">
    <p>&copy; 2024 SweetBite</p>
</footer>

</div>
</body>
</html>
