package com.svalero.phoneshop.servlet;

import com.svalero.phoneshop.dao.OrderDao;
import com.svalero.phoneshop.dao.OrderDaoImpl;
import com.svalero.phoneshop.database.Database;
import com.svalero.phoneshop.model.Orders;

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

@WebServlet("/edit_orders")
@MultipartConfig
public class EditOrdersServlet extends HttpServlet {

        private ArrayList<String> errors;

        @Override
        public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setCharacterEncoding("UTF-8");

            HttpSession currentSession = request.getSession();
            if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
                response.sendRedirect("login.jsp");
            }

            if (!validate(request)) {
                response.getWriter().println(errors.toString());
                return;
            }

            String action = request.getParameter("action");

            String productId = request.getParameter("id_product");
            String userId = request.getParameter("id_user");
            String order_date = request.getParameter("order_date");
            String totalPrice = request.getParameter("total_price");
            String username = request.getParameter("username");
            String notes  = request.getParameter("notes");

            try {
                Database database = new Database();
                database.connect();
                OrderDao orderDao = new OrderDaoImpl(database.getConnection());
                Orders orders = new Orders();
                orders.setId_product(Integer.parseInt(productId));
                orders.setId_user(Integer.parseInt(userId));
                orders.setOrder_date(Date.valueOf(order_date));
                orders.setTotal_price(Double.parseDouble(totalPrice));
                orders.setUsername(username);
                orders.setNotes(notes);

                // Procesa la imagen del producto
                if (action.equals("Modificar")) {
                    orders.setId(Integer.parseInt(request.getParameter("id")));
                }


                boolean done = false;
                if (action.equals("Registrar")) {
                    done = orderDao.add(orders);
                } else {
                    done = orderDao.modify(orders);
                }

                if (done) {
                    response.getWriter().print("ok");
                } else {
                    response.getWriter().print("No se ha podido guardar el producto");
                }
            } catch (SQLException sqle) {
                response.getWriter().println("No se ha podido conectar con la base de datos");
                sqle.printStackTrace();
            } catch (ClassNotFoundException cnfe) {
                response.getWriter().println("No se ha podido cargar el driver de la base de datos");
                cnfe.printStackTrace();
            } catch (IOException ioe) {
                response.getWriter().println("Error no esperado: " + ioe.getMessage());
                ioe.printStackTrace();
            } catch (Exception e) {
                response.getWriter().println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        }

        private boolean validate(HttpServletRequest request) {
            errors = new ArrayList<>();
            if (request.getParameter("id_product").isEmpty()) {
                errors.add("El ID del producto es un campo obligatorio");
            }
            if ((request.getParameter("id_user").isEmpty())) {
                errors.add("El ID del usuario es un campo obligatorio");
            }
            return errors.isEmpty();
        }
    }

