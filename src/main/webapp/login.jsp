<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>


<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const formValue = $(this).serialize();
      $.ajax("login", {
        type: "POST",
        data: formValue,
        statusCode: {
          200: function(response) {
            console.log(response);
            if (response === "ok") {
              window.location.href = "/phone_shop";
            } else {
              $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
            }
          }
        }
      });
    });
  });
</script>


<main class="py-5">
  <div class="container d-flex justify-content-center">

    <form>
      <h1 class="h3 mb-3 fw-normal">Log in</h1>
      <div class="input-group mb-3">
        <input type="text" name="username" class="form-control" placeholder="Username">
      </div>

      <div class="input-group mb-3">
        <input type="password" name="password" class="form-control" placeholder="Password">
      </div>

      <div class="input-group mb-3">
        <input class="btn btn-primary" type="submit" value="Login">
      </div>

      <div class="input-group mb-3">
        You don't have an user yet?  <a href="register.jsp"> Sign up here</a>
      </div>

      <div id="result"></div>
    </form>

  </div>

  <%@include file="includes/footer.jsp"%>
