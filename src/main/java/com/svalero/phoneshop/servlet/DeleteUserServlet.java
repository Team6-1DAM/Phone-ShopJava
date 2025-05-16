package com.svalero.phoneshop.servlet;

import com.svalero.phoneshop.dao.UserDao;
import com.svalero.phoneshop.dao.UserDaoImpl;
import com.svalero.phoneshop.database.Database;
import com.svalero.phoneshop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete_user")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = request.getParameter("user_id");

        try {
            Database database = new Database();
            database.connect();
            UserDao userDao = new UserDaoImpl(database.getConnection());
            User user = userDao.get(Integer.parseInt(userId));
            System.out.println(user);
            System.out.println(currentSession.getAttribute("username"));
            if (currentSession.getAttribute("username").equals(user.getUsername())) {
                userDao.delete(Integer.parseInt(userId));
                response.sendRedirect("/phone_shop");
                currentSession.invalidate();
            } else {
                userDao.delete(Integer.parseInt(userId));
                response.sendRedirect("users.jsp");
            }


        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
