<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <!-- Linking Font Awesome for icons -->
    <link rel ="stylesheet" href ="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"> 
    <link rel="stylesheet" href="admin.css"> 
  </head> 
  <body>
    <!--Header-->
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

    <!-- Order Cards 
      <section class="dashboard-cards">
        <div class="card">
          <p>Total Products</p>
          <h2>24</h2>
        </div>
        <div class="card">
          <p>Total Orders</p>
          <h2>120</h2>
        </div>
        <div class="card">
          <p>Revenue</p>
          <h2>RM 5,000</h2>
        </div>
        <div class="card">
          <p>Pending Orders</p>
          <h2>3</h2>
        </div>
      </section>-->

    <!-- Main Content -->
    <main class="admin-content">
      <div class="admin-header">
        <h1>Orders</h1>
      </div>

      <section class="admin-table">
        <table>
          <thead>
          <tr>
            <th>Order ID</th>
            <th>Customer Name</th>
            <th>Date</th>
            <th>Total Amount (RM)</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
          </thead>
          <tbody>
<%
    Connection conn = DBConnection.getConnection();
    String sql = 
            "SELECT ORDER_ID, ORDER_DATE, TOTAL_AMOUNT, ORDER_STATUS " +
            "FROM ORDERS " +
            "ORDER BY ORDER_DATE DESC";

    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
%>
<tr>
    <td>#<%= rs.getInt("ORDER_ID") %></td>
    <td>Guest</td>
    <td><%= rs.getTimestamp("ORDER_DATE") %></td>
    <td><%= rs.getDouble("TOTAL_AMOUNT") %></td>
    <td><%= rs.getString("ORDER_STATUS") %></td>
    <td>
        <form action="updateOrderStatus" method="post">
            <input type="hidden" name="orderId" value="<%= rs.getInt("ORDER_ID") %>">

          <select name="status">
            <option value="PENDING" <%= "PENDING".equals(rs.getString("ORDER_STATUS")) ? "selected" : "" %>>PENDING</option>
            <option value="PROCESSING" <%= "PROCESSING".equals(rs.getString("ORDER_STATUS")) ? "selected" : "" %>>PROCESSING</option>
            <option value="READY_FOR_PICKUP" <%= "READY_FOR_PICKUP".equals(rs.getString("ORDER_STATUS")) ? "selected" : "" %>>READY_FOR_PICKUP</option>
            <option value="OUT_FOR_DELIVERY" <%= "OUT_FOR_DELIVERY".equals(rs.getString("ORDER_STATUS")) ? "selected" : "" %>>OUT_FOR_DELIVERY</option>
            <option value="COMPLETED" <%= "COMPLETED".equals(rs.getString("ORDER_STATUS")) ? "selected" : "" %>>COMPLETED</option>
            <option value="CANCELLED" <%= "CANCELLED".equals(rs.getString("ORDER_STATUS")) ? "selected" : "" %>>CANCELLED</option>
          </select>


            <button type="submit">Update</button>
        </form>
    </td>
</tr>
<%
    }
    rs.close();
    ps.close();
    conn.close();
%>

  
          </tbody>
        </table>
      </section>

      <!-- Order View Modal -->
       <div id="orderModal" class="modal">
        <div class="modal-content">
          <span class="close">&times;</span>
          <h2>Order Details</h2>

          <div class="order-info">
            <p><strong>Order ID:</strong> <span id="modalOrderID"></span></p>
            <p><strong>Customer Name:</strong> <span id="modalCustomerName"></span></p>
            <p><strong>Date:</strong> <span id="modalOrderDate"></span></p>
            <p><strong>Total Amount:</strong> RM <span id="modalTotalAmount"></span></p>
            <p><strong>Status:</strong> <span id="modalOrderStatus"></span></p>
          </div>

          <button id="btnCloseOrderModal" class="btn-close">Close</button>
        </div>
       </div> 


      <!-- Order Update Status Modal -->
      <div id="updateOrderModal" class="modal"> 
      <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Update Order Status</h2>

        <form action="updateOrderStatus" method="post">
          <input type="hidden" name="orderId" id="updateModalOrderID">

          <label>Status:</label>
          <select name="status" required>
            <option value="PENDING">Pending</option>
            <option value="PROCESSING">Processing</option>
            <option value="READY_FOR_PICKUP">Ready for Pickup</option>
            <option value="OUT_FOR_DELIVERY">Out for Delivery</option>
            <option value="COMPLETED">Completed</option>
            <option value="CANCELLED">Cancelled</option>
          </select>

          <button type="submit" class="submit">Update Status</button>
        </form>
      </div>
     </div> 

      

       <!-- Linking Custom JS -->
      <script src="admin.js"></script>
     </main> 
    </body>
</html> 