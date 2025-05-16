<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.phoneshop.database.Database" %>
<%--<%@ page import="com.svalero.phoneshop.dao.DogDaoImpl" %>--%>
<%@ page import="com.svalero.phoneshop.model.Products" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.phoneshop.dao.ProductsDao %>
<%@ page import="java.sql.SQLException" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/footer.jsp"%>

<%
    String search = request.getParameter("search");
%>
<script>
    function confirmDelete() {
        return confirm("¿Estás seguro de que quieres eliminar este telefono??");
    }
</script>
<div class="album py-5 bg-body-tertiary">
    <div class="container mb-5">
        <form method="get" action="<%= request.getRequestURI() %>">
            <input type="text" name="search" id="search" class="form-control" placeholder="Buscar" value="<%= search != null ? search : "" %>">
        </form>
    </div>

    <div class="container">

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <%

                Database database = new Database();
                try {
                    database.connect();
                } catch (ClassNotFoundException e) {
                    throw new RuntimeException(e);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                ProductsDao ProductDao = new ProductsDaoImpl(database.getConnection());

                List<Products> productsList = ProductsDao.getAll(search);
                for (Products products : productsList) {
            %>
            <div class="col">
                <div class="card shadow-sm">
                    <img class="img-thumbnail" src="/shelter_images/<%= products.getImage() %>" style="width: 100%; height: 225px; object-fit: cover;">
                    <div class="card-body">
                        <h4 class="card-text"><%= products.getProduct_name() %></h4>
                        <p class="card-text"><%= products.getDescription() %></p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <%
                                    if (role.equals("anonymous")) {
                                %>
                                <a href="login.jsp" class="btn btn-sm btn-secondary">Log In para ver</a>
                                <%
                                } else if (role.equals("user")) {
                                %>
                                <a href="view_dog.jsp?dog_id=<%= products.getId() %>" class="btn btn-sm btn-secondary">Detalles</a>
                                <%
                                } else if (role.equals("admin")) {
                                %>
                                <a href="view_product.jsp?dog_id=<%= products.getId() %>" class="btn btn-sm btn-secondary">Detalles</a>
                                <a href="edit_product.jsp?dog_id=<%= products.getId() %>" class="btn btn-sm btn-warning">Modificar</a>
                                <a onclick="return confirmDelete()" href="delete_product?dog_id=<%= products.getId() %>" class="btn btn-sm btn-danger">Eliminar</a>
                                <%
                                    }
                                %>
                            </div>
                            <small class="text-body-secondary"> <%= products.getSale_price() %> </small>
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
