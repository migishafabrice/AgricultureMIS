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
                            <h2>Farmer edit</h2>
                             </div>
              <%
    Properties properties = new Properties();
    String msg;
    try
       {
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
int n;
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select * from farmerstb where farmerid='"+session.getAttribute("userCode")+"'");
    rs.last();
    n=rs.getRow();
    if(n==1)
    {
 %>
 <form action="farmerManage.jsp" method="POST" enctype="multipart/form-data">
                        <div class="row">
                             <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                            <img src="<%= rs.getString("profilepic") %>" width="200" height="200"/>
                            </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Name</label>
                                        <input type="text" class="form-control" value="<%= rs.getString("name")%>" name="fname">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Surname</label>
                                        <input type="text" class="form-control" value="<%= rs.getString("surname")%>" name="fsurname">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select gender</label>
                                        <select class="form-control" name="fgender" >
                                            <option>Select gender</option><option value="Male" <% 
                                                if(rs.getString("sex").equals("Male"))
                                                        {
                                                       %>
                                                       selected=""
                                                       <%
                                                    }%> 
                                                    >Male</option>
                                            <option value="Female"
                                                    <% 
                                                if(rs.getString("sex").equals("Female"))
                                                        {
                                                       %>
                                                       selected=""
                                                       <%
                                                    }%> >Female</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>National ID</label>
                                        <input type="text" class="form-control" value="<%= rs.getString("nationalid")%>" name="fid"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Telephone</label>
                                        <input type="text" class="form-control" value="<%= rs.getString("telephone")%>" name="ftel">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Email</label>
                                        <input type="text" class="form-control" value="<%= rs.getString("email")%>" name="fmail">
                                    </div>
                                </div>
                            </div>
                           
                            
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Change profile picture</label>
                                        
                                        <input type="file" class="form-control" name="fpic">
                                    </div>
                                </div>
                            </div>
                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="editFarmer" value="edit">Save changes</button>
                                </div>
                    </div>
                        </form>
 <%
      
    } 
       }
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("farmerEdit.jsp");
       }
    
                  %>
                        
                </div>
            </div>
            
        </div>
    </div>
    <!-- Form Element area End-->
    <!-- Start Footer area-->
    <jsp:include page="footer.jsp"/>