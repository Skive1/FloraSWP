<%-- 
    Document   : ManagerProduct
    Created on : Dec 28, 2020, 5:19:02 PM
    Author     : trinh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <!-- FavIcon -->
        <link rel="icon" href="img/flora-favicon.png"/>
        <style>
            img{
                width: 200px;
                height: 120px;                
            }

        </style>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title" style="background-color: orange"  >
                    <div class="row">
                        <div class="col-sm-6">
                            <h2 style="color: white">MANAGE ACCOUNT</h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="#addEmployeeModal"  class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                            <a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a>						
                        </div>
                    </div>
                </div>
                <c:set var="result" value="${requestScope.ACCOUNT_LIST}"/>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>
                                <span class="custom-checkbox">
                                    <input type="checkbox" id="selectAll">
                                    <label for="selectAll"></label>
                                </span>
                            </th>
                            <th>Username</th>
                            <th>Full name</th>
                            <th>Role</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Street</th>
                            <th>City</th>
                            <th>Sale_ID</th>
                        </tr>
                    </thead>
                    <c:if test="${not empty result}">
                        <tbody>
                            <c:forEach var="dto" items="${result}">
                                <tr>
                                    <td>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="checkbox1" name="options[]" value="1">
                                            <label for="checkbox1"></label>
                                        </span>
                                        <!--                                EDIT SẢN PHẨM TẠI ĐÂY-->
                                    </td>
                                    <td>
                                        ${dto.username}
                                    </td>
                                    <td>
                                        ${dto.fullName}
                                    </td>
                                    <td>
                                        <select name="txtGender">
                                            <option value="Admin"    
                                                    <c:if test="${dto.role == 'Admin'}">
                                                        selected="selected"
                                                    </c:if>>Admin</option>
                                            <option value="Seller" 
                                                    <c:if test="${dto.role == 'Seller'}">
                                                        selected="selected"
                                                    </c:if>>Seller</option>
                                            <option value="Delivery" 
                                                    <c:if test="${dto.role == 'Delivery'}">
                                                        selected="selected"
                                                    </c:if>>Delivery</option>
                                            <option value="Customer" 
                                                    <c:if test="${dto.role == 'Customer'}">
                                                        selected="selected"
                                                    </c:if>>Customer</option>
                                        </select>
                                    </td>
                                    <td>
                                        ${dto.gender}
                                    </td>
                                    <td>
                                        ${dto.email}
                                    </td>
                                    <td>
                                        ${dto.phone}
                                    </td>
                                    <td>
                                        ${dto.street}
                                    </td>
                                    <td>
                                        ${dto.city}
                                    </td>
                                    <td>
                                        ${dto.saleId}
                                    </td>
                                    <td>
                                        <a href="#editEmployeeModal"  class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                                        <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </c:if>
                </table>
                <div class="clearfix">
                    <div class="hint-text">Showing <b>5</b> out of <b>${requestScope.TOTAL_ACCOUNT}</b> entries</div>
                    <ul class="pagination">
                        <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <c:url var="prevUrl" value="manageAccount">
                                    <c:param name="page" value="${currentPage - 1}"/>
                                </c:url>
                                <li class="page-item"><a href="${prevUrl}" class="page-link">Previous</a></li>
                                </c:when>
                                <c:otherwise>
                                <li class="page-item disabled"><a href="#" class="page-link">Previous</a></li>
                                </c:otherwise>
                            </c:choose>

                        <c:forEach begin="1" end="${requestScope.END_PAGE}" var="i">
                            <c:url var="urlRewriting" value="manageAccount">
                                <c:param name="page" value="${i}"/>
                            </c:url>
                            <li class="page-item ${i == currentPage ? 'active' : ''}"><a href="${urlRewriting}" class="page-link">${i}</a></li>    
                            </c:forEach>

                        <c:choose>
                            <c:when test="${currentPage < requestScope.END_PAGE}">
                                <c:url var="nextUrl" value="manageAccount">
                                    <c:param name="page" value="${currentPage + 1}"/>
                                </c:url>
                                <li class="page-item"><a href="${nextUrl}" class="page-link">Next</a></li>
                                </c:when>
                                <c:otherwise>
                                <li class="page-item disabled"><a href="#" class="page-link">Next</a></li>
                                </c:otherwise>
                            </c:choose>
                    </ul>
                </div>
            </div>
            <a href="home"><button type="button" class="btn btn-primary">BACK TO HOME</button>

        </div>
        <!-- Edit Modal HTML -->
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="add" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Add Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Name</label>
                                <input name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Image</label>
                                <input name="image" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input name="price" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Title</label>
                                <textarea name="title" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea name="description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Category</label>
                                <select name="category" class="form-select" aria-label="Default select example">
                                    <c:forEach begin="1" end="3" var="o">
                                        <option value="1">Giày Adidas</option>
                                    </c:forEach>
                                </select>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Add">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">						
                            <h4 class="modal-title">Edit Employee</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" class="form-control" required>
                            </div>					
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Delete Modal HTML -->
        <div id="deleteEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">						
                            <h4 class="modal-title">Delete Product</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <p>Are you sure you want to delete these Records?</p>
                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-danger" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </a>
    <script src="js/manager.js" type="text/javascript"></script>
</body>
</html>