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
Properties properties = new Properties();
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
    String msg;
if(request.getParameter("actStaff")!="" && request.getParameter("actStaff")!=null)
{
PreparedStatement pt=con.prepareStatement("update `stafftb` set `active`='YES' where `staffid`=?");
pt.setString(1, request.getParameter("staffid"));
pt.execute();
session.setAttribute("info","<font color='blue'>Staff activated successfully</font>");
//response.sendRedirect("staffManage.jsp");
}
if(request.getParameter("deactStaff")!="" && request.getParameter("deactStaff")!=null)
{
PreparedStatement pt=con.prepareStatement("update `stafftb` set `active`='NO' where `staffid`=?");
pt.setString(1, request.getParameter("staffid"));
pt.execute();
session.setAttribute("info","<font color='blue'>Staff deactivated successfully</font>");
//response.sendRedirect("staffManage.jsp");
}
    %>
<html class="no-js" lang="">
<jsp:include page="top-menu.jsp" />
   

    <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
    <!-- Start Header Top Area -->
    
    <!-- End Header Top Area -->
    <!-- Mobile Menu start -->
    
    <!-- Mobile Menu end -->
    <!-- Main Menu area start-->
    
    <!-- Main Menu area End-->
	<!-- Breadcomb area Start-->
	
	<!-- Breadcomb area End-->
    <!-- Data Table area Start-->
    <div class="data-table-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="data-table-list">
                        <div class="basic-tb-hd">
                            <h2>List of employee</h2>
                             <%
                      String info=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(info))
                      {
                          out.println("<p>"+info+"</p>");
                      }
                      session.removeAttribute("info");%>
                            <p> <a href="staffRegistration.jsp" data-ma-action="nk-login-switch" data-ma-block="#l-register"><i class="notika-icon notika-plus-symbol"></i> <span>New staff</span></a></p>
                        </div>
                        <div class="table-responsive">
                            <table id="data-table-basic" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Surname</th>
                                        <th>Gender</th>
                                        <th>Telephone</th>
                                        <th>Email</th>
                                        <th>Position</th>
                                        <th>Assigned to</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if(!session.getAttribute("userFunction").equals("Farmer"))
                                        {

    try
       {
           int n;
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select * from stafftb where position<>'Administrator' order by name,surname asc,position desc");
    rs.last();
    n=rs.getRow();
    if(n>=1)
    {
        n=1;
        rs.beforeFirst();
        while(rs.next())
        {
                                    %>
                                    <tr>
                                        <td><%=n%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("surname")%></td>
                                        <td><%=rs.getString("sex")%></td>
                                        <td><%=rs.getString("telephone")%></td>
                                        <td><%=rs.getString("email")%></td>
                                        <td><%=rs.getString("position")%></td>
                                        <td><%=rs.getString("assignedto")%></td>
                                        <td><%=rs.getString("active")%></td>
                                        <td>
                                            <form action="staffManage.jsp" method="POST">
                                                <input type="hidden" value="<%=rs.getString("staffid")%>" name="staffid"/>
                                            <button type="submit" class="btn btn-primary notika-btn-primary" value="edStaff" name="edStaff">Change</button>
                                            <% if(rs.getString("active").equals("NO"))
                                            {
                                            %>
                                            
                                            <button type="submit" class="btn btn-success notika-btn-success" value="actStaff" name="actStaff">Activate</button>
                                            <%}
                                            else
                                              {
                                              %>
                                            <button type="submit" class="btn btn-danger notika-btn-danger" value="deactStaff" name="deactStaff">Deactivate</button>
                                            <%}%>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                        n++;
                                        }
                                         } 
       }
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("farmerEdit.jsp");
       }
                                     }
                                    %>
                                 </tbody>
                                <tfoot>
                                    <tr>
                                        <th>#</th>
                                        <th>Name</th>
                                        <th>Surname</th>
                                        <th>Gender</th>
                                        <th>Telephone</th>
                                        <th>Email</th>
                                        <th>Position</th>
                                        <th>Assigned to</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
      <%
if(!StringUtils.isNullOrEmpty(request.getParameter("edStaff")))
  {

try
  {
int n;
Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select * from stafftb where staffid='"+request.getParameter("staffid").toString()+"'");
    rs.last();
    n=rs.getRow();
    if(n==1)
    {
        if(session.getAttribute("userFunction").equals("Administrator") 
       || (session.getAttribute("userFunction").equals("Province officer") && rs.getString("position").equals("District officer")))
        {
 %>
        %>
          
      <div class="form-element-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-element-list">
                        <div class="basic-tb-hd">
                           
                            <h2>Staff edit</h2>
                            </div>
                        <div class="row">
                            <form action="editStaff.jsp" method="POST" enctype="multipart/form-data">
                                <input type="hidden" value="<%=request.getParameter("staffid")%>" name="staffid"/>
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                <img src="<%=rs.getString("profilepic")%>" width="100"/>
                                    </div>
                                </div>
                                </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Name</label>
                                        <input type="text" class="form-control" value="<%=rs.getString("name")%>" name="sname">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Surname</label>
                                        <input type="text" class="form-control" value="<%=rs.getString("surname")%>" name="ssurname">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select gender</label>
                                        <select class="form-control" name="sgender">
                                            <option>Select gender</option><option value="Male" <% 
                                                if(rs.getString("sex").equals("Male"))
                                                        {
                                                       %>
                                                       selected=""
                                                       <%
                                                       }
                                                       %>>Male</option>
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
                                        <label>Telephone</label>
                                        <input type="text" class="form-control"value="<%=rs.getString("telephone")%>" name="stel">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Email</label>
                                        <input type="text" class="form-control" value="<%=rs.getString("email")%>" name="smail">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select function</label>
                                        <select class="form-control" name="sfunction">
                                           <option>Select function</option><option value="Province officer" <% 
                                                if(rs.getString("position").equals("Province officer"))
                                                        {
                                                       %>
                                                       selected=""
                                                       <%
                                                    }%>>Province officer</option>
                                            <option value="District officer"
                                                    <% 
                                                if(rs.getString("position").equals("District officer"))
                                                        {
                                                       %>
                                                       selected=""
                                                       <%
                                                    }%> >District officer</option>  
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
                            <button type="submit" class="btn btn-success notika-btn-success" name="staffed" value="edit">Save</button>
                                </div>
                            </form>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    </div>
<%   } 
else
{
session.setAttribute("info","<font color='red'>You are not eligible to edit this staff, contact your superior or administrator.</font>");
out.println("<script>location.href='staffManage.jsp'</script>");
return;
}
}
       }
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='staffManage.jsp'</script>");
       }}%>
    <!-- Data Table area End-->
    <!-- Start Footer area-->
     <jsp:include page="footer.jsp"/>
