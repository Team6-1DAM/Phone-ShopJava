package com.svalero.phoneshop.servlet;

import com.svalero.phoneshop.database.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete_supplier")
public class DeleteSupplierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") == null) {
            response.sendRedirect("/phone_shop/login.jsp");
            return;
        }

        String supplierId = request.getParameter("id");

        try {
            Database db = new Database();
            db.connect();
            SupplierDao supplierDao = new SupplierDaoImpl(db.getConnection());
            supplierDao.delete(Integer.parseInt(supplierId));

            response.sendRedirect("/phone_shop");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
