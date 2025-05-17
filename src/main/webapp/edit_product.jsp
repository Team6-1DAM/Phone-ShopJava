<%--
  Created by IntelliJ IDEA.
  User: S1-PC58
  Date: 16/05/2025
  Time: 19:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.ProductsDao" %>
<%@ page import="com.svalero.phoneshop.dao.ProductsDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.Products" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.exception.ProductNotFoundException" %>
<%@ page import="com.svalero.phoneshop.dao.SupplierDao" %>
<%@ page import="com.svalero.phoneshop.dao.SupplierDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.Supplier" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>


<%
  if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
    response.sendRedirect("/phone_shop/login.jsp");
  }

  String action;
  Products products = null;
  Supplier supplier = null;
  String productId = request.getParameter("product_id");

  if (productId != null) {
    action = "Modificar";
    Database database = new Database();
    try {
      database.connect();
    } catch (ClassNotFoundException | SQLException e) {
      throw new RuntimeException(e);
    }
    ProductsDao productsDao = new ProductsDaoImpl(database.getConnection());
    try {
      products = productsDao.get(Integer.parseInt(productId));
    } catch (SQLException | ProductNotFoundException e) {
      throw new RuntimeException(e);
    }

  } else {
    action = "Registrar";
  }

  String productImage;
  if (products == null) {
    productImage = "no_image.jpg";
  } else {
    productImage = products.getImage();
  }

%>

<script type="text/javascript">
  $(document).ready(function() {
    $("form").on("submit", function(event) {
      event.preventDefault();
      const form = $("#product-form")[0];
      const formValue = new FormData(form);
      console.log(formValue);
      $.ajax({
        url: "edit_products",
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
    return confirm("Are you sure you sure you want to modify this product?");
  }
</script>
<div class="container d-flex justify-content-center">
  <div class="card" style="width: 50rem;">
    <img class="img-thumbnail" src="/phoneshop_images/<%=productImage%>" style="width: 100%; height: auto;">
    <form class="row g-2 p-5" id="product-form" method="post" enctype="multipart/form-data">
      <h1 class="h3 mb-3 fw-normal"><%=action%> a product</h1>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="id_supplier" class="form-control" placeholder="Supplier ID"
               value="<%=products != null ? products.getId_supplier() : ""%>">
        <label for="floatingTextarea">Supplier Id</label>
      </div>
      <div class="form-floating col-md-6">

        <input type="text" id="floatingTextarea" name="product_name" class="form-control" placeholder="Name"

               value="<%=products != null ? products.getProduct_name() : ""%>">
        <label for="floatingTextarea">Name</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="description" class="form-control" placeholder="Description"
               value="<%=products != null ? products.getDescription() : ""%>">
        <label for="floatingTextarea">Description</label>
      </div>
      <div class="form-floating col-md-6">

        <input type="text" id="floatingTextarea" name="sale_price" class="form-control" placeholder="genero"

               value="<%=products != null ? products.getSale_price() : ""%>">
        <label for="floatingTextarea">Sale Price</label>
      </div>
      <div class="form-floating col-md-6">
        <input type="date" id="floatingTextarea" name="release_date" class="form-control" placeholder="Release Date"
               value="<%=products != null ? products.getRelease_date() : ""%>">
        <label for="floatingTextarea">Release Date</label>
      </div>
      <%
        if (action.equals("Registrar")) {
      %>
      <div class="form-floating col-md-6">
        <input type="file" id="floatingTextarea" name="image" class="form-control" placeholder="Imagen">
        <label for="floatingTextarea">Image</label>
      </div>
      <%
        }
      %>
      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="stocks_units" class="form-control" placeholder="Stock"
               value="<%=products != null ? products.isStocks_units() : ""%>">
        <label for="floatingTextarea">Is there stock?</label>
      </div>


      <div class="form-floating col-md-6">
        <input type="text" id="floatingTextarea" name="product_status" class="form-control" placeholder="Status"
               value="<%=products != null ? products.getProduct_status() : ""%>">
        <label for="floatingTextarea">Status</label>
      </div>

      <div class="input-group mb-3">
        <input onclick="return confirmModify()" class="btn btn-primary" type="submit" value="Guardar">
      </div>

      <input type="hidden" name="action" value="<%=action%>">
      <div id="result"></div>
      <table class="table table-striped table-bordered mt-4">
        <thead class="table-dark">
        <tr>
          <th scope="col">Supplier Id</th>
          <th scope="col">Supplier Name</th>
          <th scope="col">Country</th>
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
          SupplierDao supplierDao = new SupplierDaoImpl(db.getConnection());
          List<Supplier> supplierList = supplierDao.getAll();
          for (Supplier supplierL : supplierList) {
        %>
        <tr>
          <td><%= supplierL.getId() %></td>
          <td><%= supplierL.getSupplier_name() %></td>
          <td><%= supplierL.getCountry() %></td>
        </tr>
        <% } %>
        </tbody>
      </table>
      <%
        if (action.equals("Modificar")) {
      %>
      <input type="hidden" name="id" value="<%=Integer.parseInt(productId)%>">
      <%
        }
      %>


    </form>
  </div>
</div>

<%@include file="includes/footer.jsp"%>
