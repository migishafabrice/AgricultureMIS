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
if(!session.getAttribute("userFunction").equals("District officer"))
{
 session.setAttribute("info","<font color='red'>You are not eligible to add an infrastructure, please contact the district officer to do so.</font>");
    response.sendRedirect("criteriaManage.jsp.jsp");
    return;   
}
    %>
<html class="no-js" lang="">
    <jsp:include page="top-menu.jsp" />
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
    
    <div class="form-element-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-element-list">
                        <div class="basic-tb-hd">
                            
                                <%
                      String info=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(info))
                      {
                          out.println("<p>"+info+"</p>");
                      }
                      session.removeAttribute("info");
              %>
                            
                            <h2>Infrastructure registration</h2>
                             </div>
                        <form action="criteriaRegistration.jsp" method="POST">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Title</label>
                                        <input type="text" class="form-control" placeholder="Enter criteria title" name="ctitle">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Description</label>
                                        <textarea class="form-control" placeholder="Criteria description" name="cdescription"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Priority</label>
                                        <select class="form-control" name="cpriority">
                                            <option>Select priority</option>
                                            <option value="A must">A must</option>
                                            <option value="Optional">Optional</option>
                                            </select>
                                    </div>
                                </div>
                            </div>
                            <script src="js/countries.js"></script>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Applicable province</label>
                                        <% 
                                            String locs=session.getAttribute("userLocation").toString();
                                            String[] loc=locs.split("/");
                                        %>
                                        <input class="form-control" name="cprov" value="<%= loc[0] %>" readonly="">
                                            
                                       
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Applicable district</label>
                                        <input class="form-control" value="<%= loc[1] %>" name="cdis" readonly="">
                                        
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Applicable season</label>
                                        <select class="form-control" id="state" name="cseason">
                                            <option>Select season</option>
                                            <option value="Season A">Season A</option>
                                            <option value="Season B">Season B</option>
                                           
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Applicable year</label>
                                        <select class="form-control" id="state" name="cyear">
                                            <option>Select year</option>
                                            <%
                                                SimpleDateFormat dy=new SimpleDateFormat("yyyy");
                                                Date dn=new Date();
                                                int year=Integer.valueOf(dy.format(dn));
                                                for(int a=year;a<=year+1;a++)
                                                {
                                                  out.println("<option value='"+a+"'>"+a+"</option>");
                                                }
                                                %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <script language="javascript">
	populateCountries("country", "state"); // first parameter is id of country drop-down and second parameter is id of state drop-down
	populateCountries("country2");
                         </script>
                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="regCriteria" value="save">Save</button>
                                </div>
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
    <%   
   if(request.getParameter("regCriteria")!=null && request.getParameter("regCriteria")!="")
   {
    try
       {
Statement st=con.createStatement();
ResultSet rs;
String code="",title="",des="",priority="",location="";
 SimpleDateFormat dte;

                dte=new SimpleDateFormat("dd");
                Date dt=new Date();
rs=st.executeQuery("select * from criteriastb order by id desc limit 1");
    if(rs.first())
    {
code=(Integer.valueOf(rs.getString("id"))+1)+"-CRT-"+dte.format(dt);
         dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);
    }
    else
    {
code="1-CRT-"+dte.format(dt);
dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);  
    }
PreparedStatement pt=con.prepareStatement("INSERT INTO `criteriastb`(`id`, `criteriaid`, `title`,`description`, `location`, `priority`,`season`,`year`, `registrar`, `date`)"
        + "VALUES (?,?,?,?,?,?,?,?,?,?)");
pt.setString(1,null);
pt.setString(2, code);
pt.setString(3,request.getParameter("ctitle") );
pt.setString(4, request.getParameter("cdescription"));
pt.setString(5, request.getParameter("cprov")+"/"+request.getParameter("cdis"));
pt.setString(6, request.getParameter("cpriority"));
pt.setString(7, request.getParameter("cseason"));
pt.setString(8, request.getParameter("cyear"));
pt.setString(9, "Administrator");
dte=new SimpleDateFormat("dd-MM-yyyy");
pt.setString(10, dte.format(dt));
pt.execute();
msg="<font color='blue'>Criteria registered successfully</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='criteriaManage.jsp';</script>");
}
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='criteriaManage.jsp';</script>");
return;
       }
}
%>