<%@ page import="com.svalero.phoneshop.model.Orders" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.OrderDao" %>
<%@ page import="com.svalero.phoneshop.dao.OrderDaoImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>


<%
  if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
    response.sendRedirect("/phone_shop/login.jsp");
  }

  String action = null;
  Orders order = null;
  String orderId = request.getParameter("id");
  if (orderId != null) {
    action = "Delete";
    Database db = new Database();
    db.connect();
    OrderDao orderDao = new OrderDaoImpl(db.getConnection());
    order = orderDao.getById(Integer.parseInt(orderId));
  } else {
    action = "Registrar";
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
        url: "delete_orders",
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
