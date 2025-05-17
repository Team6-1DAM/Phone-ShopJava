<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.dao.UserDao" %>
<%@ page import="com.svalero.phoneshop.dao.UserDaoImpl" %>
<%@ page import="com.svalero.phoneshop.exception.UserNotFoundException" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>

<%
  if ((currentSession.getAttribute("role") == null)) {
    response.sendRedirect("/phone_shop/login.jsp");
  }

  String action;
  User user = null;
  String usernameId = currentSession.getAttribute("username").toString();
  System.out.println("AAAAAAAAAAAAA" + usernameId);
  if (usernameId != null) {
    action = "Modificar";
    Database database = new Database();
    try {
      database.connect();
    } catch (ClassNotFoundException | SQLException e) {
      throw new RuntimeException(e);
    }
    UserDao userDao = new UserDaoImpl(database.getConnection());

    try {
      user = userDao.get(usernameId);
      System.out.println(user);
    } catch (SQLException | UserNotFoundException e) {
      throw new RuntimeException(e);
    }
  } else {
    action = "Registrar";
  }
%>

<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const form = $("#user-form")[0];
      const formValue = new FormData(form);
      console.log(formValue);
      $.ajax({
        url: "edit_user",
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
            $("#result").html("<div class='alert alert-danger' role='alert'>" + response.toString() + "</div>");
          }
        }
      });
    });
  });

  function confirmModify() {
    return confirm("Are you sure you want to modify this user?");
  }
  function confirmDelete() {
    return confirm("Are you sure you want to delete this user?");
  }
</script>
<div class="album py-5 bg-body-tertiary">
  <div class="container d-flex justify-content-center ">
    <!-- TODO Validar formulario -->
    <form class=" row g-2 w-50" id="user-form" method="post" enctype="multipart/form-data">
      <h1 class="h3 mb-3 fw-normal"><%= action %> your profile</h1>
      <div class="form-floating col-md-6">

        <input type="text" id="floatingTextarea" name="name" class="form-control" placeholder="Name"
               value="<%= user != null ? user.getName() : "" %>">
        <label for="floatingTextarea">Name</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="email" class="form-control" placeholder="Email"
               value="<%= user != null ? user.getEmail() : "" %>">
        <label for="floatingTextarea">Email</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="phone" class="form-control" placeholder="Phone"
               value="<%= user != null ? user.getPhone() : ""%>">
        <label for="floatingTextarea">Phone</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="city" class="form-control" placeholder="City"
               value="<%= user != null ? user.getCity() : ""%>">
        <label for="floatingTextarea">City</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="date" id="floatingTextarea" name="birth_date" class="form-control" placeholder="Birthday"
               value="<%= user != null ? user.getBirth_date() : "" %>">
        <label for="floatingTextarea">Birthday</label>
      </div>

      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="username" class="form-control" placeholder="Username"
               value="<%= user != null ? user.getUsername() : "" %>">
        <label for="floatingTextarea">Username</label>
      </div>

      <div class="form-floating col-md-6">
        <input type="password" id="floatingTextarea" name="password" class="form-control" placeholder="password"
               value="<%= user != null ? user.getPassword() : "" %>">
        <label for="floatingTextarea">Password</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="password" id="floatingTextarea" name="passwordCheck" class="form-control" placeholder="password"
               value="<%= user != null ? user.getPassword() : "" %>">
        <label for="floatingTextarea">Confirm password</label>
      </div>
      <%
        if (user.getRole().equals("admin")) {
      %>
      <h1 class="h3 mb-3 fw-normal">Admin section</h1>

      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="role" class="form-control" placeholder="Role"
               value="<%= user != null ? user.getRole() : "" %>">
        <label for="floatingTextarea">Role</label>
      </div>
      <%
        }
      %>

      <div class="input-group mb-3 d-flex justify-content-between w-100">
        <input onclick="return confirmModify()" class="btn btn-primary" type="submit" value="Save">
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
