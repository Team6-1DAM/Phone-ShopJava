<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.SupplierDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.Supplier" %>
<%@ page import="com.svalero.phoneshop.exception.SupplierNotFoundException" %>
<%@ page import="com.svalero.phoneshop.dao.SupplierDao" %>
<%@ page import="java.sql.SQLException" %>

<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>

<script>
  function confirmDelete() {
    return confirm("Are you sure you want to remove this supplier?");
  }
</script>

<div class="album py-5 bg-body-tertiary">
  <div class="container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
<%
  int supplierId = Integer.parseInt(request.getParameter("supplier_id"));
  Database database = new Database();
    try {
        database.connect();
    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }
    SupplierDao supplierDao = new SupplierDaoImpl(database.getConnection());
  try {
      Supplier supplier = null;
      try {
          supplier = supplierDao.get(supplierId);
      } catch (SQLException e) {
          throw new RuntimeException(e);
      }
%>
<div class="container d-flex justify-content-center">
  <div class="card" style="width: 50rem;">
    <div class="card-body">
      <h5 class="card-title fw-bold"><%= supplier.getSupplier_name() %></h5>
      <p class="card-text fw-normal"><%= supplier.getCity() %> <small class="fw-light fst-italic"> <%= supplier.getCountry()%></small></p>
    </div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">City   : <%= supplier.getCity() %></li>
      <li class="list-group-item">Address: <%= supplier.getAddress() %></li>
      <li class="list-group-item">Website: <%= supplier.getWebsite() %></li>
    </ul>
    <div class="card-body">
      <%
        if (role.equals("user")) {
      %>
      <a href="#" type="button" class="btn btn-primary disabled">Contact</a>
      <%
      } else if (role.equals("admin")) {
      %>
      <div class="btn-group d-flex justify-content-between" role="group" aria-label="Basic example">
      <a href="edit_supplier.jsp?supplier_id=<%= supplier.getId() %>" class="btn btn-sm btn-warning">Edit</a>
      <a onclick="return confirmDelete()" href="delete_supplier?supplier_id=<%= supplier.getId() %>" class="btn btn-sm btn-danger">Delete</a>
      </div>
      <%
      } else {
      %>
      <a href="login.jsp" type="button" class="btn btn-warning">Contactar</a>
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
} catch (SupplierNotFoundException snfe) {
%>
<%@ include file="includes/supplier_not_found.jsp"%>
<%
  }
%>
<%@ include file="includes/footer.jsp"%>
