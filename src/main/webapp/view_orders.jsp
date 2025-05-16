<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.*" %>
<%@ page import="com.svalero.phoneshop.model.Orders" %>
<%@ page import="com.svalero.phoneshop.model.Products" %>
<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page import="com.svalero.phoneshop.exception.ProductNotFoundException" %>
<%@ page import="com.svalero.phoneshop.exception.OrderNotFoundException" %>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>
<div class="album py-5 bg-body-tertiary">
  <script>
    function confirmDelete() {
      return confirm("Are you sure you want to delete the order?");
    }

  </script>
  <%
    Database database = new Database();
    database.connect();
    OrderDao orderDao = new OrderDaoImpl(database.getConnection());
    ProductsDao productDao = new ProductsDaoImpl(database.getConnection());
    UserDao userDao = new UserDaoImpl(database.getConnection());

    int orderId = Integer.parseInt(request.getParameter("order_id"));

    try {
      Orders orders = orderDao.getById(orderId);
      Products products = productDao.get(orders.getId_product());
      User user = userDao.get(orders.getId_user());


  %>
  <div class="container d-flex justify-content-center">
    <div class="card" style="width: 50rem;">
      <img class="img-thumbnail" src="/phoneshop_images/<%= products.getImage() %>" style="width: 100%; height: auto">
      <div class="card-body">
        <h5 class="card-title fw-bold"><%= products.getProduct_name() %></h5>
        <p class="card-text fw-normal"><%= products.getDescription() %> <small class="fw-light fst-italic"></small></p>
      </div>
      <div class="card-body">
        <h5 class="card-title fw-bold"><%= user.getUsername() %></h5>
        <p class="card-text fw-normal"><%= user.getName() %> <small class="fw-light fst-italic"> <%= user.getCity()%></small></p>
      </div>
      <ul class="list-group list-group-flush">
        <li class="list-group-item">Comments: <%= orders.getNotes() %></li>
        <li class="list-group-item">Order date: <%= com.svalero.phone_shop.util.DateUtils.format(orders.getOrder_date()) %></li>
      </ul>
      <div class="card-body">
        <%
          if (role.equals("admin")) {
        %>
        <a href="edit_product.jsp?product_id=<%= products.getId() %>" class="btn btn-sm btn-warning">Edit product</a>
        <a href="edit_admin_user.jsp?user_id=<%= user.getId() %>" class="btn btn-sm btn-warning">Edit User</a>
        <a href="edit_orders.jsp?order_id=<%= orders.getId() %>" class="btn btn-sm btn-warning">Edit Order</a>
        <a onclick="return confirmDelete()" ="delete_product?product_id=<%= products.getId() %>" class="btn btn-sm btn-danger">Delete</a>
        <%
        } else {
        %>
        <a href="login.jsp" type="button" class="btn btn-warning">Log In</a>
        <%
          }
        %>

      </div>
    </div>
  </div>
</div>


<%
} catch (ProductNotFoundException pnfe) {
%>
<%@ include file="includes/product_not_found.jsp"%>
<%
} catch (OrderNotFoundException onfe) {
%>
<%@ include file="includes/order_not_found.jsp"%>
<%
  }
%>
<%@ include file="includes/footer.jsp"%>

