<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.dao.UserDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.User" %>
<%@ page import="com.svalero.phoneshop.dao.OrderDao" %>
<%@ page import="com.svalero.phoneshop.dao.OrderDaoImpl" %>
<%@ page import="com.svalero.phoneshop.model.Orders" %>
<%@ page import="com.svalero.phoneshop.exception.UserNotFoundException" %>
<%@ page import="com.svalero.phoneshop.util.DateUtils" %>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar_users.jsp"%>

<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete?");
    }
</script>

<div class="album py-5 bg-body-tertiary">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
<%
    int userId = Integer.parseInt(request.getParameter("user_id"));
    Database database = new Database();
    database.connect();
    UserDaoImpl UserDaoImpl = new UserDaoImpl(database.getConnection());
    try {
        User user = UserDaoImpl.get(userId);
        OrderDao orderDao = new OrderDaoImpl(database.getConnection());
        int orderNumber = orderDao.getOrdersByUserId(userId);
        Orders order = null;


%>
<div class="container d-flex justify-content-center">
    <div class="card" style="width: 50rem;">
        <div class="card-body">
            <h5 class="card-title"><%=user.getUsername()%></h5>
            <p class="card-text"><%=user.getName()%></p>
        </div>
        <ul class="list-group list-group-flush">
            <li class="list-group-item">Email: <%=user.getEmail()%></li>
            <li class="list-group-item">City: <%=user.getCity()%></li>
            <li class="list-group-item">Birthday: <%=DateUtils.format(user.getBirth_date())%></li>
            <li class="list-group-item">Role: <%=user.getRole()%></li>
        </ul>
        <div class="card-body">
            <%
                if (role.equals("user")) {
            %>
            <a href="#" type="button" class="btn btn-primary">Buy</a>
            <%
            } else if (role.equals("admin")) {
            %>
            <a href="edit_user.jsp?user_id=<%=user.getId()%>" class="btn btn-sm btn-warning">Edit</a>
            <a onclick="return confirmDelete()" href="delete_user?user_id=<%=user.getId()%>" class="btn btn-sm btn-danger">Delete</a>
            <%
            } else {
            %>
            <a href="login.jsp" type="button" class="btn btn-secondary">Log in</a>
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
} catch (UserNotFoundException unfe) {
%>
<%@ include file="includes/user_not_found.jsp"%>
<%
    }
%>
<%@ include file="includes/footer.jsp"%>