<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.dao.ProductsDao" %>
<%@ page import="com.svalero.phoneshop.dao.ProductsDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.Products" %>
<%@ page import="java.util.List" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>

<%
    String search = request.getParameter("search");
%>
<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this product?");
    }
</script>
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
                } catch (ClassNotFoundException e) {
                    throw new RuntimeException(e);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                ProductsDao productDao = new ProductsDaoImpl(database.getConnection());

                List<Products> productList = productDao.getAll(search);
                for (Products products : productList) {
                    String productImage;
                    if (products.getImage() == null){
                        productImage = "no_image.jpg";
                    } else {
                        productImage = products.getImage();
                    }
            %>
            <div class="col">
                <div class="card shadow-sm">
                    <img class="img-thumbnail" src="/phoneshop_images/<%= productImage %>" style="width: 100%; height: 225px; object-fit: cover;">
                    <div class="card-body">
                        <h4 class="card-text"><%= products.getProduct_name() %></h4>
                        <p class="card-text"><%= products.getDescription() %></p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <%
                                    if (role.equals("anonymous")) {
                                %>
                                <a href="login.jsp" class="btn btn-sm btn-secondary">Login to see the products</a>
                                <%
                                } else if (role.equals("user")) {
                                %>

                                <a href="view_product.jsp?product_id=<%= products.getId() %>" class="btn btn-sm btn-secondary">Details</a>
                                <%
                                } else if (role.equals("admin")) {
                                %>
                                <a href="view_product.jsp?product_id=<%= products.getId() %>" class="btn btn-sm btn-secondary">Details</a>
                                <a href="edit_product.jsp?product_id=<%= products.getId() %>" class="btn btn-sm btn-warning">Modify</a>
                                <a onclick="return confirmDelete()" href="delete_products?product_id=<%= products.getId() %>" class="btn btn-sm btn-danger">Delete</a>
                                <%
                                    }
                                %>
                            </div>
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