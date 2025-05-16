<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.dao.UserDao" %>
<%@ page import="com.svalero.phoneshop.exception.UserNotFoundException" %>
<%@ page import="com.svalero.phoneshop.dao.UserDaoImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>

<!-- TODO Retringir acceso a los no administradores -->
<%
  if ((currentSession.getAttribute("role") == null)) {
    response.sendRedirect("/phone_shop/login.jsp");
  }

  String action;
  User user = null;
  int userId = Integer.parseInt(request.getParameter("user_id"));
  System.out.println("AAAAAAAAAAAAA" + userId);

  action = "Modificar";
  Database database = new Database();
  try {
    database.connect();
  } catch (ClassNotFoundException | SQLException e) {
    throw new RuntimeException(e);
  }
  UserDao userDao = new UserDaoImpl(database.getConnection());

  try {
    user = userDao.get(userId);
    System.out.println(user);
  } catch (SQLException | UserNotFoundException e) {
    throw new RuntimeException(e);
  }

%>

<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const form = $("#admin-user-form")[0];
      const formValue = new FormData(form);
      console.log(formValue);
      $.ajax({
        url: "edit_admin_user",
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
            $("#result").html("<div class='alert alert-danger' role='alert'>Error al enviar los datos</div>");
          },
          500: function(response) {
            console.log(response);
            $("#result").html("<div class='alert alert-danger' role='alert'>" + response.toString() + "</div>");
          }
        }
      });
    });
  });

  function confirmModify() {
    return confirm("Are you sure you want to edit this user?");
  }

</script>
<div class="album py-5 bg-body-tertiary">
  <div class="container d-flex justify-content-center ">
    <!-- TODO Validar formulario -->
    <form class=" row g-2 w-50" id="admin-user-form" method="post" enctype="multipart/form-data">
      <h1 class="h3 mb-3 fw-normal"><%= action %> Profile</h1>
      <div class="form-floating col-md-6">

        <input type="text" id="floatingTextarea" name="name" class="form-control" placeholder="Name"
               value="<%= user != null ? user.getName() : "" %>">
        <label for="floatingTextarea">Name</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="email" class="form-control" placeholder="Nombre"
               value="<%= user != null ? user.getEmail() : "" %>">
        <label for="floatingTextarea">Email</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="phone" class="form-control" placeholder="Phone"
               value="<%= user != null ? user.getPhone() : ""%>">
        <label for="floatingTextarea">Phone number</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="city" class="form-control" placeholder="City"
               value="<%= user != null ? user.getCity() : ""%>">
        <label for="floatingTextarea">City</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="date" id="floatingTextarea" name="birth_date" class="form-control" placeholder="Fecha de nacimiento"
               value="<%= user != null ? user.getBirth_date() : "" %>">
        <label for="floatingTextarea">Birthday</label>
      </div>

      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="username" class="form-control" placeholder="Nombre"
               value="<%= user != null ? user.getUsername() : "" %>">
        <label for="floatingTextarea">Username</label>
      </div>

      <div class="form-floating col-md-6">
        <input type="password" id="floatingTextarea" name="password" class="form-control" placeholder="password"
               value="<%= user != null ? user.getPassword() : "" %>">
        <label for="floatingTextarea">Password</label>
      </div>

      <h1 class="h3 mb-3 fw-normal">Admin section</h1>

      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="role" class="form-control" placeholder="Role"
               value="<%= user != null ? user.getRole() : "" %>">
        <label for="floatingTextarea">Role</label>
      </div>


      <div class="input-group mb-3 d-flex justify-content-between w-100">
        <input onclick="return confirmModify()" class="btn btn-primary" type="submit" value="Guardar">
        <p></p>
        <a onclick="return confirmDelete()" href="delete_user?user_id=<%= user.getId() %>" class="btn btn-danger">Delete</a>
      </div>

      <input type="hidden" name="action" value="<%= action %>">
      <input type="hidden" name="id" value="<%= user.getId() %>">

      <div id="result"></div>
    </form>
  </div>
</div>

<%@include file="includes/footer.jsp"%>
