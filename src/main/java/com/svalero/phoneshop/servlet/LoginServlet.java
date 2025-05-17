package com.svalero.phoneshop.servlet;

import com.svalero.phoneshop.dao.UserDao;
import com.svalero.phoneshop.dao.UserDaoImpl;
import com.svalero.phoneshop.database.Database;
import com.svalero.phoneshop.exception.UserNotFoundException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Database database = new Database();
            database.connect();
            UserDao userDao = new UserDaoImpl(database.getConnection());
            String role = userDao.loginUser(username, password);

            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);

            response.getWriter().print("ok");
        } catch (SQLException sqle) {
            try {
                response.getWriter().println("Error connecting to the database");
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } catch (UserNotFoundException unfe) {
            try {
                response.getWriter().println("Username or password is incorrect");
            } catch (IOException ioe) {
                ioe.printStackTrace();
            }
        }

    }

}
