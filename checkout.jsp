<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="/sweetbite/css/style.css">
</head>

<body>
<div class="wrapper">

<header>
    <nav class="navbar section-content">
        <a href="index.jsp" class="nav-logo">
            <h2 class="logo-text">🍰 SweetBite</h2>
        </a>
        <ul class="nav-menu">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="menus.jsp">Menu</a></li>
        </ul>
        <div class="nav-action">
            <li class="nav-item"><a href="index.jsp#home" class="nav-link">Home</a></li>
            <li class="nav-item"><a href="index.jsp#about" class="nav-link">About Us</a></li>
            <li class="nav-item"><a href="menus.jsp" class="nav-link">Menu</a></li>
            <li class="nav-item"><a href="index.jsp#testimonials" class="nav-link">Testimonials</a></li>
            <li class="nav-item"><a href="index.jsp#contact" class="nav-link">Contact</a></li>
        </div>
    </nav>
</header>

<main>
<section class="cart-section">
<div class="section-content">

<h1 class="cart-title">Checkout</h1>
<p>Please review your order and complete checkout</p>

<form action="<%= request.getContextPath() %>/confirmOrder" method="post">

<h3>Your Order Summary</h3>

<table>
<tr>
    <th>Product</th>
    <th>Details</th>
    <th>Qty</th>
    <th>Subtotal</th>
</tr>

<%
    double total = 0;
    boolean hasItem = false;

    try {
        Connection conn = DBConnection.getConnection();

        String sql =
            "SELECT p.NAME, c.PRODUCT_SIZE, c.QUANTITY, c.UNIT_PRICE " +
            "FROM CART c " +
            "JOIN PRODUCTS p ON c.PRODUCT_ID = p.PRODUCT_ID " +
            "WHERE c.SESSION_ID = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, session.getId());
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            hasItem = true;

            String name = rs.getString("NAME");
            String size = rs.getString("PRODUCT_SIZE");
            int qty = rs.getInt("QUANTITY");
            double price = rs.getDouble("UNIT_PRICE");

            double subtotal = qty * price;
            total += subtotal;
%>
<tr>
    <td><%= name %></td>
    <td>Size: <%= size %></td>
    <td><%= qty %></td>
    <td>RM <%= String.format("%.2f", subtotal) %></td>
</tr>
<%
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
%>
<tr>
    <td colspan="4">Error loading checkout</td>
</tr>
<%
    }
%>

</table>

<% if (!hasItem) { %>
<p>Your cart is empty.</p>
<% } else { %>

<h3>Total: RM <%= String.format("%.2f", total) %></h3>

<hr>

<!-- DELIVERY -->
<h3>Pickup or Delivery</h3>
<label>
    <input type="radio" name="deliveryMethod" value="PICKUP" checked onclick="toggleAddress()"> Pickup
</label><br>

<label>
    <input type="radio" name="deliveryMethod" value="DELIVERY" onclick="toggleAddress()"> Delivery
</label>

<div id="deliveryAddress" style="display:none;">
    <h4>Delivery Address</h4>
    <textarea name="address" rows="4"></textarea>
</div>

<hr>

<!-- PAYMENT -->
<h3>Payment Method</h3>

<label>
    <input type="radio" name="paymentMethod" value="CASH" checked onclick="togglePayment()"> Cash
</label>
<div id="cashMethod">
    <p>Pay at counter on pickup/delivery.</p>
</div>

<label>
    <input type="radio" name="paymentMethod" value="CARD" onclick="togglePayment()"> Card
</label>
<div id="cardMethod" style="display:none;">
    <input type="text" name="cardName" placeholder="Card Holder Name"><br>
    <input type="text" name="cardNumber" placeholder="Card Number"><br>
    <input type="month" name="expiry"><br>
    <input type="text" name="cvv" placeholder="CVV"><br>
</div>

<label>
    <input type="radio" name="paymentMethod" value="EWALLET" onclick="togglePayment()"> E-Wallet
</label>
<div id="ewalletMethod" style="display:none;">
    <p>E-wallet payment on delivery.</p>
</div>

<hr>

<!-- NOTES -->
<h3>Order Notes (optional)</h3>
<textarea name="notes" rows="4" placeholder="e.g. 5 candles"></textarea>

<br><br>
<button type="submit" class="checkout-btn">Confirm Order</button>

<% } %>

</form>

</div>
</section>
</main>

<footer class="footer-section">
    <div class="section-content">
        <p>&copy; 2024 SweetBite</p>
    </div>

    <div class="social-link-list">
              <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-x-twitter"></i></a>
    </div>
</footer>

</div>

<script>
function toggleAddress() {
    document.getElementById("deliveryAddress").style.display =
        document.querySelector('input[value="DELIVERY"]').checked ? "block" : "none";
}

function togglePayment() {
    document.getElementById("cashMethod").style.display =
        document.querySelector('input[value="CASH"]').checked ? "block" : "none";
    document.getElementById("cardMethod").style.display =
        document.querySelector('input[value="CARD"]').checked ? "block" : "none";
    document.getElementById("ewalletMethod").style.display =
        document.querySelector('input[value="EWALLET"]').checked ? "block" : "none";
}
</script>

</body>
</html>