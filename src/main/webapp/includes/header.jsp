<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 16/05/2025
  Time: 09:00

  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Phone</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<header data-bs-theme="dark">
  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container text-decoration-none">

      <a href="/shelter" class="navbar-brand d-flex align-items-center">
        <strong>Phone_shop</strong>
      </a>
      <%
        HttpSession currentSession = request.getSession();
        String role = "anonymous";
        if (currentSession.getAttribute("role") != null) {
          role = currentSession.getAttribute("role").toString();
        }

        if (role.equals("anonymous")) {
      %>
      <a href="/phone_shop/login.jsp" title="Log in"><img src="./images/user.png" height="50" width="50"></a>

      <%
      } else if (role.equals("user")){
      %>
      <div>

        <a class="text-decoration-none" href="/phone_shop/logout" title="Logout">Logout</a>
        <a class="text-decoration-none"  href="/phone_shop/myprofile.jsp" title="My Profile"><img src="./images/user.png" height="50" width="50"></a>

      </div>
      <%
        } else if (role.equals("admin")){
      %>
      <div>

        <a class="text-decoration-none" href="/phone_shop/logout" title="Logout">Logout</a>
        <a class="nav-item" href="/phone_shop/myprofile.jsp" title="My Profile"><img src="./images/user.png" height="50" width="50"></a>

      </div>
      <%
        }
      %>
    </div>
  </div>

</header>

