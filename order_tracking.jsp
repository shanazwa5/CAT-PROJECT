<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Order</title>

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
            <li class="nav-item"><a href="index.jsp#menu" class="nav-link">Menu</a></li>
            <li class="nav-item"><a href="index.jsp#contact" class="nav-link">Contact</a></li>
        </ul>

        <div class="nav-action">
            <a href="cart.jsp" class="fas fa-shopping-cart"></a>
            <a href="admin_login.jsp" class="fas fa-user"></a>
        </div>
    </nav>
</header>

<main>
<section class="track-order-section">
<div class="section-content">

<h2>Track Your Order</h2>

<%
    String sessionId = session.getId();

    try {
        Connection conn = DBConnection.getConnection();

        String sql =
            "SELECT ORDER_ID, ORDER_STATUS, ORDER_DATE, ORDER_TYPE " +
            "FROM ORDERS " +
            "WHERE SESSION_ID = ? " +
            "ORDER BY ORDER_DATE DESC FETCH FIRST 1 ROWS ONLY";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, sessionId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>

<div class="order-summary">
    <h3>Order #<%= rs.getInt("ORDER_ID") %></h3>

    <p><strong>Date:</strong>
        <%= rs.getTimestamp("ORDER_DATE") %>
    </p>

    <p><strong>Order Type:</strong>
        <%= rs.getString("ORDER_TYPE") %>
    </p>

    <h4>Status</h4>
    <p class="order-status">
        <strong><%= rs.getString("ORDER_STATUS") %></strong>
    </p>
    <button onclick="window.location.href='index.jsp'" class="track-btn">Back to Home</button>
</div>

<%
        } else {
%>

<p>No order found.</p>

<%
        }

        rs.close();
        ps.close();
        conn.close();

    } catch (Exception e) {
%>

<p>Error loading order status.</p>

<%
    }
%>


</div>
</section>
</main>

<!-- FOOTER -->
<footer class="footer-section">
    <div class="section-content">
        <p class="copyright-text">
            &copy; 2024 SweetBite. All rights reserved.
        </p>
    </div>

    <div class="social-link-list">
              <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
              <a href="#" class="social-link"><i class="fa-brands fa-x-twitter"></i></a>
    </div>
</footer>

</body>
</html>
