package com.svalero.phoneshop.servlet;

import com.svalero.phoneshop.dao.UserDao;
import com.svalero.phoneshop.dao.UserDaoImpl;
import com.svalero.phoneshop.database.Database;
import com.svalero.phoneshop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/edit_user")
@MultipartConfig
public class EditUserServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        HttpSession currentSession = request.getSession();

        if (currentSession.getAttribute("role") == null || (currentSession.getAttribute("role").equals("anonymous"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (!validate(request)) {
            response.getWriter().println(errors.toString());
            return;
        }

        String action = request.getParameter("action");
        System.out.println(action);

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");
        String birth_date = request.getParameter("birth_date");
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Database database = new Database();
            database.connect();
            UserDao userDao = new UserDaoImpl(database.getConnection());
            User user = new User();
            User userId = userDao.get(currentSession.getAttribute("username").toString());

            user.setId(userId.getId());
            user.setName(name);
            user.setEmail(email);
            user.setPhone(Integer.parseInt(phone));
            user.setCity(city);
            user.setBirth_date(Date.valueOf(birth_date));
            user.setRole(role);
            user.setUsername(username);
            user.setPassword(password);

            System.out.println(user);
            boolean done = userDao.modify(user);

            if (done) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("Impossible to save the user changes");
            }
        } catch (SQLException sqle) {
            response.getWriter().println("Error connecting to the database");
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            response.getWriter().println("Error charging the driver");
            cnfe.printStackTrace();
        } catch (IOException ioe) {
            response.getWriter().println("Unexpected error: " + ioe.getMessage());
            ioe.printStackTrace();
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private boolean validate(HttpServletRequest request) {
        errors = new ArrayList<>();
        if (request.getParameter("username").isEmpty()) {
            errors.add("Username is required");
        }
        if ((request.getParameter("password").isEmpty())) {
            errors.add("Password is required");
        }
        if ((!request.getParameter("password").equals(request.getParameter("passwordCheck")))) {
            errors.add("Username and password don't match");
        }

        return errors.isEmpty();
    }
}
