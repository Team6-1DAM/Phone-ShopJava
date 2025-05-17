<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>


<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const formValue = $(this).serialize();
      $.ajax({
        url: "register",
        type: "POST",
        data: formValue,
        success: function(response) {
          if (response.trim() === "ok") {
            window.location.href = "/phone_shop"; // Adjust this path if needed
          } else {
            $("#result").html(
                    "<div class='alert alert-danger' role='alert'>" + response + "</div>"
            );
          }
        },
        error: function(xhr) {
          $("#result").html(
                  "<div class='alert alert-danger' role='alert'>Error: " + xhr.responseText + "</div>"
          );
        }
      });
    });
  });
</script>



<main class="py-5">
  <div class="container d-flex justify-content-center">


    <form class="mx-1 mx-md-4">
      <h1 class="h3 mb-3 fw-normal">Login</h1>


      <div class="input-group mb-2">
        <div class="form-outline flex-fill mb-0">
          <label class="form-label" for="username">Username</label>
          <input type="text" id="username" name="username" class="form-control" >
        </div>
      </div>


      <div class="input-group mb-2">
        <div class="form-outline flex-fill mb-0">
          <label class="form-label" for="email">Email</label>
          <input type="email" id="email" name="email" class="form-control" >
        </div>
      </div>

      <div class="input-group mb-2">
        <div class="form-outline flex-fill mb-0">
          <label class="form-label" for="password">Password</label>
          <input type="password" id="password" name="password" class="form-control" >
        </div>
      </div>

      <div class="input-group mb-2">
        <div class="form-outline flex-fill mb-0">
          <label class="form-label" for="passwordCheck">Confirm your password</label>
          <input type="password" id="passwordCheck" name="passwordCheck" class="form-control" >
        </div>
      </div>

      <div class="input-group mb-3">
        <input class="btn btn-primary" type="submit" value="Registrarse">
      </div>

      <div class="input-group mb-3">
        You have already a user? <a href="login.jsp"> Log in</a>
      </div>

      <div id="result"></div>
    </form>

  </div>

<%@include file="includes/footer.jsp"%>