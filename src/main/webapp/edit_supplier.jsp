<%@ page import="com.svalero.phoneshop.database.Database" %>
<%@ page import="com.svalero.phoneshop.model.Supplier" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.phoneshop.exception.SupplierNotFoundException" %>
<%@ page import="com.svalero.phoneshop.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>
<%@include file="includes/navbar.jsp"%>

<%
    if ((currentSession.getAttribute("role") == null) || (!currentSession.getAttribute("role").equals("admin"))) {
        response.sendRedirect("/supplier/login.jsp");
    }

    String action;
    Supplier supplier = null;
    String supplierId = request.getParameter("supplier_id");
    System.out.println("Supplier id :" + supplierId);


    if (supplierId != null) {
        action = "Modificar";
        Database database = new Database();
        try {
            database.connect();
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        SupplierDao supplierDao = new SupplierDaoImpl(database.getConnection());
        try {
            supplier = supplierDao.get(Integer.parseInt(supplierId));
        } catch (SQLException | SupplierNotFoundException e) {
            throw new RuntimeException(e);
        }
    } else {
        action = "Registrar";
    }

%>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const form = $("#supplier-form")[0];
            const formValue = new FormData(form);
            console.log(formValue);
            $.ajax({
                url: "edit_supplier",
                type: "POST",
                enctype: "multipart/form-data",
                data: formValue,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 10000,
                statusCode: {
                    200: function(response) {
                        console.log(response);
                        if (response === "ok") {
                            // TODO Limpiar el formulario?
                            $("#result").html("<div class='alert alert-success' role='alert'>" + response + "</div>");
                        } else {
                            $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
                        }
                    },
                    404: function(response) {
                        $("#result").html("<div class='alert alert-danger' role='alert'>Error al enviar los datos</div>");
                    },
                    500: function(response) {
                        console.log(response);
                        $("#result").html("<div class='alert alert-danger' role='alert'>" + response.toString() + "</div>");
                    }
                }
            });
        });
    });

    function confirmModify() {
        return confirm("Are you sure to want to modify this supplier?");
    }

</script>
<div class="container d-flex justify-content-center">
    <div class="card" style="width: 50rem;">
        <form class="row g-2 p-5" id="supplier-form" method="post" enctype="multipart/form-data">
            <h1 class="h3 mb-3 fw-normal"><%=action%> Supplier</h1>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="supplier_name" class="form-control" placeholder="Name Supplier"
                       value="<%=supplier != null ? supplier.getSupplier_name() : ""%>">
                <label for="floatingTextarea">Name Supplier</label>
            </div>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="address" class="form-control" placeholder="Av Cesar augusto"
                       value="<%=supplier != null ? supplier.getAddress() : ""%>">
                <label for="floatingTextarea">Adreess</label>
            </div>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="city" class="form-control" placeholder="Zaragoza"
                       value="<%=supplier != null ? supplier.getCity() : ""%>">
                <label for="floatingTextarea">City</label>
            </div>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="tel" class="form-control" placeholder="+346675874856"
                       value="<%=supplier != null ? supplier.getTel() : ""%>">
                <label for="floatingTextarea">Tel</label>
            </div>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="zip_code" class="form-control" placeholder="50012"
                       value="<%=supplier != null ? supplier.getZip_code(): ""%>">
                <label for="floatingTextarea">Zip Code</label>
            </div>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="country" class="form-control" placeholder="Spain"
                       value="<%=supplier != null ? supplier.getCountry() : ""%>">
                <label for="floatingTextarea">Country</label>
            </div>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="email" class="form-control" placeholder="supplier@supplier.es"
                       value="<%=supplier != null ? supplier.getEmail(): ""%>">
                <label for="floatingTextarea">EMail</label>
            </div>
            <div class="form-floating col-md-6">
                <input type="text" id="floatingTextarea" name="website" class="form-control" placeholder="supplier.com"
                       value="<%=supplier != null ? supplier.getWebsite() : ""%>">
                <label for="floatingTextarea">Website</label>
            </div>



            <div class="input-group mb-3">
                <input onclick="return confirmModify()" class="btn btn-primary" type="submit" value="Save">
            </div>

            <input type="hidden" name="action" value="<%=action%>">

            <%
                if (action.equals("Modify")) {
            %>
            <input type="hidden" name="id" value="<%=Integer.parseInt(supplierId)%>">
            <%
                }
            %>

            <div id="result"></div>
        </form>
    </div>
</div>

<%@include file="includes/footer.jsp"%>
