<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.model.Orders" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.phoneshop.model.Products" %>
<%@ page import="com.svalero.phoneshop.dao.*" %>
<%@ page import="com.svalero.phoneshop.model.User" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>

<script>
  function confirmDelete() {
    return confirm("Are you sure you want to delete this order?");
  }
</script>

<%
  String search = request.getParameter("search");
%>

<div class="album py-5 bg-body-tertiary">
  <div class="container mb-5">
    <form method="get" action="<%= request.getRequestURI() %>">
      <input type="text" name="search" id="search" class="form-control" placeholder="Search" value="<%= search != null ? search : "" %>">
    </form>
  </div>

  <div class="container">

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <%
        Database database = new Database();
        try {
          database.connect();
        } catch (ClassNotFoundException | SQLException e) {
          throw new RuntimeException(e);
        }
        OrderDao ordersDao = new OrderDaoImpl(database.getConnection());

        List<Orders> orderList = null;
        try {
          orderList = ordersDao.getAll(search);
        } catch (SQLException e) {
          throw new RuntimeException(e);
        }

        for (Orders orders : orderList) {
          ProductsDao productsDao = new ProductsDaoImpl(database.getConnection());
          Products products = productsDao.get(orders.getId_product());

          UserDao userDao = new UserDaoImpl(database.getConnection());
          User user = userDao.get(orders.getId_user());

          System.out.println(orders.getId_product());
          System.out.println(productsDao.get(orders.getId_product()));
      %>
      <div class="col">
        <div class="card shadow-sm">
          <img class="img-thumbnail" src="/phoneshop_images/<%= products.getImage() %>" style="width: 100%; height: 225px; object-fit: cover;">
          <div class="card-body">
            <h4 class="card-text"><%= orders.getOrder_date() %></h4>
            <p class="card-text">Phones: <%= products.getProduct_name() %></p>
            <p class="card-text">Bought by: <%= user.getName() %></p>
            <p class="card-text">Info: <%= orders.getNotes() %></p>
            <div class="d-flex justify-content-between align-items-center">
              <div class="btn-group">
                <%
                  if (role.equals("anonymous")) {
                %>
                <a href="login.jsp" class="btn btn-sm btn-secondary">Log In</a>
                <%
                } else if (role.equals("user")) {
                %>
                <a href="view_orders.jsp?order_id=<%= orders.getId() %>" class="btn btn-sm btn-secondary">More info</a>
                <%
                } else if (role.equals("admin")) {
                %><a href="view_orders.jsp?order_id=<%= orders.getId() %>" class="btn btn-sm btn-secondary">More info</a>
                <a href="edit_orders.jsp?order_id=<%= orders.getId()%>" class="btn btn-sm btn-warning">Modify</a>
                <a onclick="return confirmDelete()" href="/delete_orders?order_id=<%= orders.getId() %>" class="btn btn-sm btn-danger">Delete</a>
                <%
                  }
                %>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%
        }
      %>
    </div>
  </div>
</div>

<%@include file="includes/footer.jsp"%>
