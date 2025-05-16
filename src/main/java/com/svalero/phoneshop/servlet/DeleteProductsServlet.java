package com.svalero.phoneshop.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import com.svalero.phoneshop.dao.ProductsDao;
import com.svalero.phoneshop.dao.ProductsDaoImpl;
import com.svalero.phoneshop.database.Database;
@WebServlet("/delete_products")
public class DeleteProductsServlet extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setCharacterEncoding("UTF-8");

            HttpSession currentSession = request.getSession();
            if (currentSession.getAttribute("role") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String productsId = request.getParameter("product_id");

            try {
                Database db = new Database();
                db.connect();
                ProductsDao productsDao = new ProductsDaoImpl(db.getConnection());
                productsDao.delete(Integer.parseInt(productsId));

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
