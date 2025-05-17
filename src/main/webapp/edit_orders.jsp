<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.model.Orders" %>
<%@ page import="com.svalero.phoneshop.model.Products" %>
<%@ page import="com.svalero.phoneshop.exception.OrderNotFoundException" %>
<%@ page import="com.svalero.phoneshop.dao.*" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>

<!-- TODO Retringir acceso a los no administradores -->
<%
  if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
    response.sendRedirect("/phone_shop/login.jsp");
  }

  String action;
  Orders order = null;
  String orderId = request.getParameter("order_id");
  System.out.println("Order id :" + orderId);

  Products product = null;
  if (orderId != null) {
    action = "Modificar";
    Database database = new Database();
    try {
      database.connect();
    } catch (ClassNotFoundException | SQLException e) {
      throw new RuntimeException(e);
    }
    OrderDao orderDao = new OrderDaoImpl(database.getConnection());
    try {
      order = orderDao.getById(Integer.parseInt(orderId));
      ProductsDao productsDao = new ProductsDaoImpl(database.getConnection());
      product = productsDao.get(order.getId_product());
    } catch (SQLException | OrderNotFoundException e) {
      throw new RuntimeException(e);
    }
  } else {
    action = "Registrar";
  }

  String productImage;
  if (product == null) {
    productImage = "default.jpg";
  } else {
    productImage = product.getImage();
  }

%>

<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const form = $("#order-form")[0];
      const formValue = new FormData(form);
      console.log(formValue);
      $.ajax({
        url: "edit_orders",
        type: "POST",
        enctype: "multipart/form-data",
        data: formValue,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 10000,
        statusCode: {
          200: function(response) {
            console.log(response);
            if (response === "ok") {
              // TODO Limpiar el formulario?
              $("#result").html("<div class='alert alert-success' role='alert'>" + response + "</div>");
            } else {
              $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
            }
          },
          404: function(response) {
            $("#result").html("<div class='alert alert-danger' role='alert'>Error sending data</div>");
          },
          500: function(response) {
            console.log(response);
            $("#result").html("<div class='alert alert-danger' role='alert'>" + response.responseText + "</div>");
          }
        }
      });
    });
  });


  function confirmModify() {
    return confirm("Are you sure you want to modify this order?");
  }

</script>
<div class="container d-flex justify-content-center">
  <div class="card" style="width: 50rem;">
    <img class="img-thumbnail" src="/phoneshop_images/<%= productImage%>" style="width: 100%; height: auto;">
    <form class="row g-2 p-5" id="order-form" method="post" enctype="multipart/form-data">
      <h1 class="h3 mb-3 fw-normal"><%=action%> Order </h1>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="id_product" class="form-control" placeholder="Product Id"
               value="<%=order != null ? order.getId_product() : ""%>">
        <label for="floatingTextarea">Product ID</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="id_user" class="form-control" placeholder="User Id"
               value="<%=order != null ? order.getId_user() : ""%>">
        <label for="floatingTextarea">User ID</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="date" id="floatingTextarea" name="order_date" class="form-control" placeholder="Order Date"
               value="<%=order != null ? order.getOrder_date() : ""%>">
        <label for="floatingTextarea">Order date</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="notes" class="form-control" placeholder="Notes"
               value="<%=order != null ? order.getNotes() : ""%>">
        <label for="floatingTextarea">Notas</label>
      </div>


      <div class="input-group mb-3">
        <input onclick="return confirmModify()" class="btn btn-primary" type="submit" value="Save">
      </div>

      <input type="hidden" name="action" value="<%=action%>">
      <div id="result"></div>
      <table class="table table-striped table-bordered mt-4">
        <thead class="table-dark">
        <tr>
          <th scope="col">Product Id</th>
          <th scope="col">Product Name</th>
        </tr>
        </thead>
        <tbody>
        <%
          Database db = new Database();
          try {
            db.connect();
          } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
          }
          ProductsDao productDao = new ProductsDaoImpl(db.getConnection());
          UserDao userDao = new UserDaoImpl(db.getConnection());
          List<Products> productList = productDao.getNotOrdered();
          for (Products products : productList) {

        %>
        <tr>
          <td><%= products.getId() %></td>
          <td><%= products.getProduct_name() %></td>
        </tr>
        <% } %>
        </tbody>
      </table>
      <table class="table table-striped table-bordered mt-4">
        <thead class="table-dark">
        <tr>
          <th scope="col">User Id</th>
          <th scope="col">Username</th>
          <th scope="col">Name</th>
        </tr>
        </thead>
        <tbody>
        <%
          List<User> userList = userDao.getAll();
          for (User userL : userList) {

        %>
        <tr>
          <td><%= userL.getId() %></td>
          <td><%= userL.getUsername() %></td>
          <td><%= userL.getName() %></td>
        </tr>
        <% } %>
        </tbody>
      </table>
      <%
        if (action.equals("Modificar")) {
      %>
      <input type="hidden" name="id" value="<%=Integer.parseInt(orderId)%>">
      <%
        }
      %>


    </form>
  </div>
</div>

<%@include file="includes/footer.jsp"%>
