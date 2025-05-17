<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.dao.UserDao" %>
<%@ page import="com.svalero.phoneshop.dao.UserDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page import="java.util.List" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>
<script>
  function confirmDelete() {
    return confirm("Are you sure you want to delete this user?");
  }
</script>
<%
  if ((currentSession.getAttribute("role") == null || !currentSession.getAttribute("role").equals("admin"))) {
    response.sendRedirect("/phone_shop/login.jsp");
  }

  String search = request.getParameter("search");
%>

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
        } catch (ClassNotFoundException | SQLException e) {
          throw new RuntimeException(e);
        }
        UserDao userDao = new UserDaoImpl(database.getConnection());

        List<User> userList = null;
        try {
          userList = userDao.getAll(search);
        } catch (SQLException e) {
          throw new RuntimeException(e);
        }
        for (User user : userList) {
      %>

      <div class="card shadow-sm">
        <div class="card-body">
          <h4 class="card-text"><%= user.getName() %></h4>
          <p class="card-text"><%= user.getUsername() %></p>
          <div class="d-flex justify-content-between align-items-center">
            <div class="btn-group">
              <a href="view_user.jsp?user_id=<%= user.getId() %>" class="btn btn-sm btn-secondary">Info</a>
              <a href="edit_admin_user.jsp?user_id=<%= user.getId() %>" class="btn btn-sm btn-warning">Admin</a>
              <a onclick="return confirmDelete()" href="delete_user?user_id=<%= user.getId() %>" class="btn btn-sm btn-danger">Delete</a>
            </div>
            <small class="text-body-secondary"> <%= user.getRole() %> </small>
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
