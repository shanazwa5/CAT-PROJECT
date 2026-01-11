<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="style.css">
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

<h1 class="cart-title">Checkout</h1>
<p>Please review your order and complete checkout</p>

<%
    HttpSession session = request.getSession();
    String sessionId = session.getId();

    double total = 0;
    boolean hasItem = false;
%>

<form action="confirmOrder" method="post">

<!-- ================= ORDER SUMMARY ================= -->
<h3>Your Order Summary</h3>

<table>
<tr>
    <th>Product</th>
    <th>Details</th>
    <th>Qty</th>
    <th>Subtotal</th>
</tr>

<%
    try {
        Connection conn = DBConnection.getConnection();

        String sql =
            "SELECT p.NAME, c.SIZE, c.QUANTITY, c.UNIT_PRICE " +
            "FROM CART c " +
            "JOIN PRODUCTS p ON c.PRODUCT_ID = p.PRODUCT_ID " +
            "WHERE c.SESSION_ID = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, sessionId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            hasItem = true;

            String name = rs.getString("NAME");
            String size = rs.getString("SIZE");
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
        e.printStackTrace();
    }
%>

</table>

<% if (!hasItem) { %>
<p>Your cart is empty.</p>
<% } else { %>

<h3>Total: RM <%= String.format("%.2f", total) %></h3>

<hr>

<!-- ================= DELIVERY ================= -->
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

<!-- ================= PAYMENT ================= -->
<h3>Payment Method</h3>

<label>
    <input type="radio" name="paymentMethod" value="CASH" checked onclick="togglePayment()"> Cash
</label>
<div id="cashMethod">
    <p>Please pay at the counter.</p>
</div>

<label>
    <input type="radio" name="paymentMethod" value="CARD" onclick="togglePayment()"> Card
</label>
<div id="cardMethod" style="display:none;">
    <input type="text" name="fullName" placeholder="Full Name">
    <input type="text" name="cardNum" placeholder="Card Number">
    <input type="month" name="expMonth">
    <input type="number" name="cvvNum" placeholder="CVV">
</div>

<label>
    <input type="radio" name="paymentMethod" value="EWALLET" onclick="togglePayment()"> E-Wallet
</label>
<div id="ewalletMethod" style="display:none;">
    <p>Redirecting to e-wallet…</p>
</div>

<hr>

<!-- ================= NOTES ================= -->
<h3>Order Notes (optional)</h3>
<textarea name="notes" rows="4" placeholder="e.g. 5 candles"></textarea>

<br><br>
<button type="submit">Confirm Order</button>

<% } %>
</form>

</div>
</section>
</main>

<footer class="footer-section">
    <div class="section-content">
        <p>&copy; 2024 SweetBite</p>
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