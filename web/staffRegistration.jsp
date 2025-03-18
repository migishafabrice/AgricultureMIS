<!doctype html>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
if(session.getAttribute("userCode")==null || session.getAttribute("userCode")=="")
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
    return;
}
    %>
<html class="no-js" lang="">
    <jsp:include page="top-menu.jsp" />
    <!-- Main Menu area End-->
	<!-- Breadcomb area Start-->
	
	<!-- Breadcomb area End-->
    <!-- Form Element area Start-->
    <div class="form-element-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-element-list">
                        <div class="basic-tb-hd">
                            <p>
                                <%
                      String info=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(info))
                      {
                          out.println(info);
                      }
                      session.removeAttribute("info");
              %>
                            </p>
                            <h2>Staff registration</h2>
                            
                        </div>
                        <div class="row">
                            <form action="regStaff.jsp" method="POST" enctype="multipart/form-data">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Name</label>
                                        <input type="text" class="form-control" placeholder="Enter your name" name="sname">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Surname</label>
                                        <input type="text" class="form-control" placeholder="Enter your surname" name="ssurname">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select gender</label>
                                        <select class="form-control" name="sgender">
                                            <option>Select gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Telephone</label>
                                        <input type="text" class="form-control" placeholder="Enter your telephone" name="stel">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Email</label>
                                        <input type="text" class="form-control" placeholder="Enter your email" name="smail">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select function</label>
                                        <select class="form-control" name="sfunction">
                                            <option>Select function</option>
                                            <option>Province officer</option>
                                            <option>District officer</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                                <script src="js/countries.js"></script>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select province assigned to</label>
                                        <select class="form-control" id="country" name="sprov">
                                            
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select district assigned to</label>
                                        <select class="form-control" id="state" name="sdis">
                                        
                                        </select>
                                    </div>
                                </div>
                            </div>
<script language="javascript">
	populateCountries("country", "state"); // first parameter is id of country drop-down and second parameter is id of state drop-down
	populateCountries("country2");
</script> 
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Profile picture</label>
                                        <input type="file" class="form-control" name="spic">
                                    </div>
                                </div>
                            </div>
                        <div class="col-lg-8 col-md-7 col-sm-7 col-xs-12">
                                    <button class="btn btn-success notika-btn-success" name="reg">Register</button>
                                </div>
                            </form>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    <!-- Form Element area End-->
    <!-- Start Footer area-->
    <jsp:include page="footer.jsp"/>