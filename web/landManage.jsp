
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
    <script language="javascript" >
    function getNames(str)
    {
    if (str == "") {
        document.getElementById("ownerid").innerHTML = "";
        return;
    } else {
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("ownerid").innerHTML="";
                document.getElementById("ownerid").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("POST","data.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("q="+str);
    }
    }
      </script>
    <!-- Main Menu area End-->
	<!-- Breadcomb area Start-->
	<!-- Breadcomb area End-->
    <!-- Form Element area Start-->
    <%
Properties properties = new Properties();
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
int n;
String msg="";
      %>
        <%   
   if(request.getParameter("regLand")!=null && request.getParameter("regLand")!="")
   {
    
    try
       {
Statement st=con.createStatement();
ResultSet rs;
String code="";
 SimpleDateFormat dte;
 dte=new SimpleDateFormat("dd");
 Date dt=new Date();
rs=st.executeQuery("select * from farmerstb where nationalid='"+request.getParameter("landownerid")+"'");
rs.last();
if(rs.getRow()==1)
{
PreparedStatement pt=con.prepareStatement("update `landstb` set `upi`=?,`farmerid`=?,`size`=?,`location`=? where `farmerid`=?");
pt.setString(1,request.getParameter("landupi"));
pt.setString(2, rs.getString("farmerid"));
pt.setString(3, request.getParameter("landheight")+"X"+request.getParameter("landwidth"));
pt.setString(4, request.getParameter("landprov")+"/"+request.getParameter("landdis"));
pt.setString(5, rs.getString("farmerid"));
pt.execute();
msg="<font color='blue'>Land edited successfully</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='landManage.jsp';</script>");
return;
}
}
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='landRegistration.jsp';</script>");
return;
       }
}
%> 
    <div class="data-table-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="data-table-list">
                        <div class="basic-tb-hd">
                            <h2>Lands</h2>
                            <p>List of lands</p>
                             <%
                      String info=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(info))
                      {
                          out.println("<p>"+info+"</p>");
                      }
                      session.removeAttribute("info");
              %>
            <p> <a href="landRegistration.jsp" data-ma-action="nk-login-switch" data-ma-block="#l-register"><i class="notika-icon notika-plus-symbol"></i> <span>Record land</span></a></p>
                        </div>
                        <div class="table-responsive">
                            <table id="data-table-basic" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Date</th>
                                        <th>UPI</th>
                                        <th>Size</th>
                                        <th>Location</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <% 
                                        try
                                        {
                                    Statement stapp=con.createStatement();
                                    ResultSet rsapp=null;
                                    if(session.getAttribute("userFunction").equals("Administrator"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb order by location asc");
                                    }
                                    if(session.getAttribute("userFunction").equals("District officer")|| session.getAttribute("userFunction").equals("Province officer"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb where location like'%"+session.getAttribute("userLocation")+"%' order by location asc");
                                    }
                                    if(session.getAttribute("userFunction").equals("Farmer"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb where farmerid='"+session.getAttribute("userCode").toString()+"'");
                                    }
                                    if(rsapp.first())
                                    {  n=0;
                                       
                                            rsapp.beforeFirst();
                                            while(rsapp.next())
                                            {
                                                n++;
                                          %>
                                    <tr>
                                        <td><%= n%></td>
                                        <td> <%= rsapp.getString("date")%></td>
                                        <td><%= rsapp.getString("upi")%></td>
                                        <td><%= rsapp.getString("size")%></td>
                                        <td><%= rsapp.getString("location")%></td>
                                        
                                        <td><form action="landManage.jsp" method="POST">
<input type="hidden" value="<%= rsapp.getString("landid")%>" name="thisland"/><button type="submit" class="btn btn-primary notika-btn-primary" name="edit" value="edit">Edit</button></form></td>
                                    </tr>
                                    <%}}}
                                    catch(Exception e)
{
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='landManage.jsp';</script>");
}%>

                                </tbody>
                                
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%
    if(request.getParameter("edit")!=null && request.getParameter("edit")!="")
    {
        
        Statement stcrit=con.createStatement();
        ResultSet rscrit=stcrit.executeQuery("select * from landstb where landid='"+request.getParameter("thisland")+"'");
        if(rscrit.last() && rscrit.getRow()==1)
        {
        Statement stused=con.createStatement();
        ResultSet rsused=stused.executeQuery("select * from applicantstb where landid='"+rscrit.getString("landid")+"'");
        if(!rsused.first())
        {
%>

<div class="form-element-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-element-list">
                        <div class="basic-tb-hd">
                            <h2>Land registration</h2>
                           </div>
                        
                        <div class="row">
                            <form action="landManage.jsp" method="POST">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Owner national ID</label>
                                        <input type="text" class="form-control" name="landownerid" id="ownerlandid" placeholder="Enter owner national ID" onblur="getNames(this.value);">
                                    </div>
                                </div>
                            </div>
                            <div id="ownerid"></div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>UPI</label>
                                        <input type="text" class="form-control" name="landupi" value="<%= rscrit.getString("upi")%>">
                                    </div>
                                </div>
                            </div>
                            <script src="js/countries.js"></script>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select province</label>
                                        <select class="form-control" id="country" name="landprov">
                                            
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select district</label>
                                        <select class="form-control" id="state" name="landdis">
                                        
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
                                        <label>Height</label>
                                        <input type="text" class="form-control" name="landheight" placeholder="Enter land height in meters">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Width</label>
                                        <input type="text" class="form-control" name="landwidth"  placeholder="Enter land width in meters">
                                    </div>
                                </div>
                            </div>

                        <div class="col-lg-8 col-md-7 col-sm-7 col-xs-12">
                                    <button type="submit" class="btn btn-success notika-btn-success" name="regLand">Save</button>
                                </div>
                       
                        </form>  </div>                          
                </div>
            </div>
            
        </div>
    </div>
    </div>
<%
    }
else
{
session.setAttribute("info","<font color='red'>The land UPI has been used in application,you can not edit it.</font>");
out.println("<script>location.href='landManage.jsp';</script>");
}
}

}
    %>
    
    <!-- Form Element area End-->
    <!-- Start Footer area-->
    <jsp:include page="footer.jsp"/>
   