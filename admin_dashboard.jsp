<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <!-- Linking Font Awesome for icons -->
    <link rel ="stylesheet" href ="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<header>
    <!-- Header -->
    <nav class="navbar">
        <a href="#" class="nav-logo">
            <h2 class="logo-text">🍰 SweetBite</h2>
        </a>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="admin_dashboard.jsp" class="nav-link">Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="admin_products.jsp" class="nav-link">Products</a>
            </li>
            <li class="nav-item">
                <a href="admin_order.jsp" class="nav-link">Orders</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">Logout</a>
            </li>
        </ul>
    </nav>
</header>

<!-- Main Content -->
<main class="admin-content">

<%
    int totalProducts = 0;
    int totalOrders = 0;
    int pendingOrders = 0;
    double revenue = 0;

    try {
        Connection conn = DBConnection.getConnection();

        // Total Products
        ResultSet rs = conn.prepareStatement ("SELECT COUNT(*) FROM PRODUCTS").executeQuery();
        if (rs.next()) totalProducts = rs.getInt(1);
        rs.close();

        //total Orders
        rs = conn.prepareStatement ("SELECT COUNT(*) FROM ORDERS").executeQuery();
        if (rs.next()) pendingOrders = rs.getInt(1);
        rs.close();

        //revenue
        rs = conn.prepareStatement ("SELECT NVL(SUM(TOTAL_AMOUNT), 0) FROM ORDERS WHERE ORDER_STATUS = 'COMPLETED'").executeQuery();
        if (rs.next()) revenue = rs.getDouble(1);
        rs.close();

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

    <h1>Dashboard</h1>

    <!-- Summary Cards -->
    <section class="dashboard-cards">
        <div class="card">
            <p>Total Products</p>
            <h2><%= totalProducts %></h2>
        </div>
        
        <div class="card">
            <p>Total Orders</p>
            <h2><%= totalOrders %></h2>
        </div>
        
        <div class="card">
            <p>Revenue</p>
            <h2>RM <%= String.format("%.2f", revenue) %></h2>
        </div>
        
        <div class="card">
            <p>Pending Orders</p>
            <h2><%= pendingOrders %></h2>
        </div>
    </section>

    <!-- Recent Orders -->
    <section class="recent-orders">
        <h2>Recent Orders</h2>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Total</th>
                <th>Status</th>
            </tr>

    <%
            try {
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT ORDER_ID, TOTAL_AMOUNT, ORDER_STATUS " +
                    "FROM ORDERS ORDER BY ORDER_DATE DESC FETCH FIRST 5 ROWS ONLY"
                );
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
    %>
                <tr>
                    <td>#<%= rs.getInt("ORDER_ID") %></td>
                    <td>RM <%= rs.getDouble("TOTAL_AMOUNT") %></td>
                    <td><%= rs.getString("ORDER_STATUS") %></td>
                </tr>
    <%            
                }
                rs.close();
                ps.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='3'>Error loading orders</td></tr>");
            }
    %>
        </table>

        <a href="admin_order.jsp" class="btn-view-all">View All Orders</a>
    </section>


</main>
</body>
</html>
