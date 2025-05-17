package com.svalero.phoneshop.servlet;

import com.svalero.phoneshop.dao.SupplierDao;
import com.svalero.phoneshop.dao.SupplierDaoImpl;
import com.svalero.phoneshop.database.Database;
import com.svalero.phoneshop.model.Supplier;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/edit_supplier")
@MultipartConfig
public class EditSupplierServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
            response.sendRedirect("login.jsp");
        }

//        if (!validate(request)) {
//            response.getWriter().println(errors.toString());
//            return;
//        }

        String action = request.getParameter("action");

        String supplier_name = request.getParameter("supplier_name");
        String tel = request.getParameter("tel");
        String address = request.getParameter("address");
        String zip_code = request.getParameter("zip_code");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String website = request.getParameter("website");
        String email = request.getParameter("email");


        try {
            Database database = new Database();
            database.connect();
            SupplierDao supplierDao = new SupplierDaoImpl(database.getConnection());
            Supplier supplier = new Supplier();
            supplier.setSupplier_name(supplier_name);
            supplier.setTel(tel);
            supplier.setAddress(address);
            supplier.setZip_code(zip_code);
            supplier.setCity(city);
            supplier.setCountry(country);
            supplier.setWebsite(website);
            supplier.setEmail(email);

            if (action.equals("Modificar")) {
                supplier.setId(Integer.parseInt(request.getParameter("id")));
            }


            boolean done = false;
            if (action.equals("Registrar")) {
                done = supplierDao.add(supplier);
            } else {
                done = supplierDao.modify(supplier);
            }

            if (done) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("Impossible to save the product changes");
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
        if (request.getParameter("supplier_name").isEmpty()) {
            errors.add("Supplier name is a required field");
        }
        if (request.getParameter("city").isEmpty()) {
            errors.add("Supplier country is a required field");
        }
        // TODO más validaciones

        return errors.isEmpty();
    }
}

