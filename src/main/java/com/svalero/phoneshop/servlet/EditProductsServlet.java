package com.svalero.phoneshop.servlet;

import com.svalero.phoneshop.dao.ProductsDao;
import com.svalero.phoneshop.dao.ProductsDaoImpl;
import com.svalero.phoneshop.database.Database;
import com.svalero.phoneshop.model.Products;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.UUID;

@WebServlet("/edit_products")
@MultipartConfig
public class EditProductsServlet extends HttpServlet {

    private ArrayList<String> errors;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        HttpSession currentSession = request.getSession();
        if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (!validate(request)) {
            response.getWriter().println(errors.toString());
            return;
        }

        String action = request.getParameter("action");

        String supplierId = request.getParameter("id_supplier");
        String product_name = request.getParameter("product_name");
        String description = request.getParameter("description");
        String sale_price = request.getParameter("sale_price");
        String stocks_units = request.getParameter("stocks_units");
        String release_date = request.getParameter("release_date");
        String product_status = request.getParameter("product_status");
        Part image = request.getPart("image");


        try {
            Database database = new Database();
            database.connect();
            ProductsDao productsDao = new ProductsDaoImpl(database.getConnection());
            Products products = new Products();
            products.setId_supplier(Integer.parseInt(supplierId));
            products.setProduct_name(product_name);
            products.setDescription(description);
            products.setSale_price(Double.parseDouble(sale_price));
            products.setStocks_units(Boolean.parseBoolean(stocks_units));
            products.setRelease_date(Date.valueOf(release_date));
            products.setProduct_status(product_status);




            // Procesa la imagen del producto
            if (action.equals("Registrar")) {
                String filename = "no_image.jpg";
                String imagePath = "C:/Users/S2-PC00/Desktop/apache-tomcat-9.0.105/webapps/phoneshop_images/";
                if (image.getSize() != 0) {
                    filename = UUID.randomUUID() + ".jpg";

                    InputStream inputStream = image.getInputStream();
                    Files.copy(inputStream, Path.of(imagePath + File.separator + filename));
                }

                products.setImage(filename);
            } else {
                products.setId(Integer.parseInt(request.getParameter("id")));
            }


            boolean done = false;
            if (action.equals("Registrar")) {
                done = productsDao.add(products);
            } else {
                done = productsDao.modify(products);
            }

            if (done) {
                response.getWriter().print("ok");
            } else {
                response.getWriter().print("We couldn't save the product");
            }
        } catch (SQLException sqle) {
            response.getWriter().println("Cannot connect to the database");
            sqle.printStackTrace();
        } catch (ClassNotFoundException cnfe) {
            response.getWriter().println("Couldnt load the database driver");
            cnfe.printStackTrace();
        } catch (IOException ioe) {
            response.getWriter().println("Unknown error: " + ioe.getMessage());
            ioe.printStackTrace();
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private boolean validate(HttpServletRequest request) {
        errors = new ArrayList<>();
        if ((request.getParameter("sale_price").isEmpty()) || (!request.getParameter("sale_price").matches("^[0-9]+(\\.[0-9]{1,3})?$"))) {
            errors.add("Price is a required field");
        }

        if (request.getParameter("product_name").isEmpty()) {
            errors.add("Product name is a required field");
        }

        return errors.isEmpty();
    }
}

