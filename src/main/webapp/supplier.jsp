<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.dao.SupplierDao" %>
<%@ page import="com.svalero.phoneshop.dao.SupplierDao" %>
<%@ page import="com.svalero.phoneshop.model.Supplier" %>
<%@ page import="com.svalero.phoneshop.dao.SupplierDaoImpl" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>

<script>
  function confirmDelete() {
    return confirm("Are you sure you want to delete this supplier?");
  }
</script>

<%
  String search = request.getParameter("search");
%>

<div class="album py-5 bg-body-tertiary">
  <div class="container mb-5">
    <form method="get" action="<%= request.getRequestURI() %>">
      <input type="text" name="search" id="search" class="form-control" placeholder="Search" value="<%= search != null ? search : "" %>">
    </form>
  </div>

  <div class="container">

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <%
        Database database = new Database();
        try {
          database.connect();
        } catch (ClassNotFoundException | SQLException e) {
          throw new RuntimeException(e);
        }
        SupplierDao shelterDao = new SupplierDaoImpl(database.getConnection());

        List<Supplier> supplierList = null;
        try {
          supplierList = shelterDao.getAll(search);
        } catch (SQLException e) {
          throw new RuntimeException(e);
        }

        for (Supplier supplier : supplierList) {

      %>
      <div class="col">
        <div class="card shadow-sm">

          <div class="card-body">
            <h4 class="card-text"><%= supplier.getSupplier_name() %></h4>
            <p class="card-text"><%= supplier.getCity() %></p>
            <p class="card-text"><%= supplier.getAddress() %></p>
            <div class="d-flex justify-content-between align-items-center">
              <div class="btn-group">
                <a href="view_supplier.jsp?supplier_id=<%= supplier.getId() %>" class="btn btn-sm btn-secondary">More info</a>
                <%
                 if (role.equals("admin")) {
                %>
                <a href="edit_supplier.jsp?supplier_id=<%= supplier.getId()  %>" class="btn btn-sm btn-warning">Modify</a>
                <a onclick="return confirmDelete()" href="delete_supplier?supplier_id=<%= supplier.getId()  %>" class="btn btn-sm btn-danger">Delete</a>
                <%
                  }
                %>
              </div>
              <small class="text-body-secondary"> <%= supplier.getWebsite() %> </small>
            </div>
          </div>
        </div>
      </div>
      <%
        }
      %>
    </div>
  </div>
</div>

<%@include file="includes/footer.jsp"%>
