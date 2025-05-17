<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.UserDao" %>
<%@ page import="com.svalero.phoneshop.dao.UserDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page import="com.svalero.phoneshop.exception.UserNotFoundException" %>
<%@ page import="com.svalero.phoneshop.util.DateUtils" %>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>

<div class="album py-5 bg-body-tertiary">
  <div class="container">
    <%
      String username = currentSession.getAttribute("username").toString();
      Database database = new Database();
      database.connect();
      UserDao userDao = new UserDaoImpl(database.getConnection());
      try {
        User user = userDao.get(username);
    %>
    <div class="container d-flex justify-content-center w-50">
      <div class="card" style="width: 50rem;">
        <div class="card-body">
          <h5 class="card-title fw-bold"><%= user.getUsername() %></h5>
          <p class="card-text fw-normal"><%= user.getCity() %> </p>
        </div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">Name: <%= user.getName() %></li>
          <li class="list-group-item">Email: <%= user.getEmail() %></li>
          <li class="list-group-item">Birthday: <%= DateUtils.format( user.getBirth_date()) %></li>
        </ul>
        <div class="card-body">
          <%
            if (role.equals("user")) {
          %>
          <a href="edit_user.jsp" type="button" class="btn btn-primary">Edit</a>
          <%
          } else if (role.equals("admin")) {
          %>
          <a href="edit_user.jsp" type="button" class="btn btn-primary">Edit</a>
          <%
          } else {
          %>
          <a href="login.jsp" type="button" class="btn btn-warning">Login</a>
          <%
            }
          %>

        </div>
      </div>
    </div>
  </div>
</div>

<%
} catch (UserNotFoundException dnfe) {
%>
<%@ include file="includes/product_not_found.jsp"%>
<%
  }
%>
<%@ include file="includes/footer.jsp"%>
