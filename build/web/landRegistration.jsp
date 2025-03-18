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
    <div class="form-element-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-element-list">
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
                        <div class="basic-tb-hd">
                            <h2>Land registration</h2>
                           </div>
                        
                        <div class="row">
                            <form action="landRegistration.jsp" method="POST">
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
                                        <input type="text" class="form-control" name="landupi" placeholder="Enter land UPI">
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
    <!-- Form Element area End-->
    <!-- Start Footer area-->
    <jsp:include page="footer.jsp"/>
    <%   
   if(request.getParameter("regLand")!=null && request.getParameter("regLand")!="")
   {
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
String code="";
 SimpleDateFormat dte;
 dte=new SimpleDateFormat("dd");
 Date dt=new Date();
rs=st.executeQuery("select * from landstb order by id desc limit 1");
    if(rs.first())
    {
code=(Integer.valueOf(rs.getString("id"))+1)+"-LND-"+dte.format(dt);
         dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);
    }
    else
    {
code="1-LND-"+dte.format(dt);
dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);  
    }
rs.close();
rs=st.executeQuery("select * from farmerstb where nationalid='"+request.getParameter("landownerid")+"'");
rs.last();
if(rs.getRow()==1)
{
PreparedStatement pt=con.prepareStatement("INSERT INTO `landstb`(`id`, `landid`, `upi`, `farmerid`, `size`,`location`, `date`)"
        + "VALUES (?,?,?,?,?,?,?)");

pt.setString(1,null);
pt.setString(2, code);
pt.setString(3,request.getParameter("landupi"));
pt.setString(4, rs.getString("farmerid"));
pt.setString(5, request.getParameter("landheight")+"X"+request.getParameter("landwidth"));
pt.setString(6, request.getParameter("landprov")+"/"+request.getParameter("landdis"));
dte=new SimpleDateFormat("dd-MM-yyyy");
pt.setString(7, dte.format(dt));
pt.execute();
msg="<font color='blue'>Land registered successfully</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='landManage.jsp';</script>");
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