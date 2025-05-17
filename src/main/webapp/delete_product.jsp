<%--
  Created by IntelliJ IDEA.
  User: S1-PC58
  Date: 16/05/2025
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.ProductsDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.Products" %>
<%@ page import="com.svalero.phoneshop.exception.ProductNotFoundException" %>
<%@ page import="com.svalero.phoneshop.dao.ProductsDao" %>

<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar_users.jsp"%>

<script>
  function confirmDelete() {
    return confirm("Are you sure you want to delete this product?");
  }
</script>

<div class="album py-5 bg-body-tertiary">
  <div class="container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <%
        int productId = Integer.parseInt(request.getParameter("product_id"));
        Database database = new Database();
        database.connect();
        ProductsDao productsDao = new ProductsDaoImpl(database.getConnection());
        try {
          Products products = productsDao.get(productId);
      %>
      <div class="container d-flex justify-content-center">
        <div class="card" style="width: 50rem;">
          <img class="img-thumbnail" src="/phoneshop_images/<%= products.getImage() %>" style="width: 100%; height: auto">
          <div class="card-body">
            <h5 class="card-title"><%= products.getProduct_name() %></h5>
            <p class="card-text"><%= products.getDescription() %></p>
          </div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item">Price: <%= products.getSale_price() %></li>
            <li class="list-group-item">Status: <%= products.getProduct_status() %></li>
            <li class="list-group-item">Release date: <%= products.getRelease_date() %></li>
          </ul>
          <div class="card-body">
            <%
              if (role.equals("user")) {
            %>
            <a href="#" type="button" class="btn btn-primary">Buy!</a>
            <%
            } else if (role.equals("admin")) {
            %>
            <a href="edit_product.jsp?product_id=<%= products.getId() %>" class="btn btn-sm btn-warning">Edit</a>
            <a onclick="return confirmDelete()" href="delete_product.jsp?product_id=<%= products.getId() %>" class="btn btn-sm btn-danger">Delete</a>
            <%
            } else {
            %>
            <a href="login.jsp" type="button" class="btn btn-warning">Buy!</a>
            <%
              }
            %>

          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%
} catch (ProductNotFoundException pnfe) {
%>
<%@ include file="includes/product_not_found.jsp"%>
<%
  }
%>
<%@ include file="includes/footer.jsp"%>
