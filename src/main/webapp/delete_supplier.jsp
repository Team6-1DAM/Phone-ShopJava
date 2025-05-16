<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.UserDao" %>
<%@ page import="com.svalero.phoneshop.dao.UserDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>


<%
  if ((currentSession.getAttribute("role") == null)) {
    response.sendRedirect("/supplier/login.jsp");
  }

  String action = null;
  User user  = null;
  String supplierId = request.getParameter("supplier_id");
  if (supplierId != null) {
    action = "Delete";
    Database database = new Database();
    database.connect();
    UserDao userDao = new UserDaoImpl(database.getConnection());
    user = userDao.get(Integer.parseInt(supplierId));
  } else {
    action = "Registrar";
  }
%>

<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const form = $("#supplier-form")[0];
      const formValue = new FormData(form);
      console.log(formValue);
      $.ajax({
        url: "delete_supplier",
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
</script>

<div class="album py-5 bg-body-tertiary">
  <div class="container d-flex justify-content-center">


    <div id="result"></div>
    </form>
  </div>
</div>

<%@include file="includes/footer.jsp"%>
