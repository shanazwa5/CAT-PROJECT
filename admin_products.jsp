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

    <!-- Main Content -->
    <main class="admin-content">

      <div class="admin-header">
        <h1>Products</h1>
        <button id="btnAddProduct" class="btn-add">+ Add Product</button>
      </div>

      <section class="admin-table">
        <table>
          <thead>
          <tr>
            <th>Image</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price (RM)</th>
            <th>Description</th>
            <th>Action</th>
          </tr>
          </thead>

          <tbody>
          <%
              Connection conn = null;
              PreparedStatement ps = null;
              ResultSet rs = null;

              try {
                  conn = DBConnection.getConnection();

                   String sql = 
                       "SELECT p.PRODUCT_ID, p.NAME, p.CATEGORY, p.DESCRIPTION, p.IMAGE_URL, pr.PRICE  " +
                        "FROM PRODUCTS p " +
                        "JOIN PRODUCT_PRICE pr ON p.PRODUCT_ID = pr.PRODUCT_ID " +
                        "WHERE pr.PRODUCT_SIZE = 'BASE'";
                  
                  ps = conn.prepareStatement(sql);
                  rs = ps.executeQuery();

                  while (rs.next()) {
          %>
          <tr>
            <td><img src="<%= rs.getString("IMAGE_URL") %>" width="80"></td>
            <td><%= rs.getString("NAME") %></td>
            <td><%= rs.getString("CATEGORY") %></td>
            <td><%= rs.getDouble("PRICE") %></td>
            <td><%= rs.getString("DESCRIPTION") %></td>
            <td>
              <form action="deleteProduct" method="post" style="display:inline;">
                <input type="hidden" name="productId" value="<%= rs.getInt("PRODUCT_ID") %>">
                <button class="delete">Delete</button>
              </form>

              <form action="updateProduct.jsp" method="get" style="display:inline;">
                <input type="hidden" name="productId" value="<%= rs.getInt("PRODUCT_ID") %>">
                <button class="edit">Edit</button>  
              </form>
            </td>
          </tr>
          <%
                  }
              } catch (Exception e) {
                  out.println("<tr><td colspan='6'>Error loading products</td></tr>");
                  e.printStackTrace();
              } finally {
                  if (rs != null) rs.close();
                  if (ps != null) ps.close();
                  if (conn != null) conn.close();
              }
          %>

        </tbody>
        </table>
        </section>

        <!-- Add Product Modal -->
      <div id="productModal" class="modal">
      <div class="modal-content">
          <span class="close">&times;</span>
          <h2>Add New Product</h2>
          <form action="addProduct" method="post">
            <label>Name</label>
            <input type="text" name="name" required>

            <label>Category</label>
            <select name="category" required>
              <option value="Cake">Cake</option>
              <option value="Pastry">Pastry</option>
            </select>

            <label>Price</label>
            <input type="number" step="0.01" name="price" required>

            <label>Description</label>
            <textarea name="description"></textarea>

            <label>Image URL</label>
            <input type="text" name="imageUrl">

            <button type="submit">Save</button>
          </form>

      </div>
      </div>

    </main>
    <!-- Linking Custom JS -->
    <script src="admin.js"></script>
</body>
</html>
