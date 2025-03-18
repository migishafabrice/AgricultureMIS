
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
   if(request.getParameter("editCriteria")!=null && request.getParameter("editCriteria")!="")
   {
    try
{
PreparedStatement pt=con.prepareStatement("update `criteriastb` set `title`=?,`description`=?, `location`=?, `priority`=?,`season`=?,`year`=?, `registrar`=? where `criteriaid`=?");
pt.setString(1,request.getParameter("ctitle") );
pt.setString(2, request.getParameter("cdescription"));
pt.setString(3, request.getParameter("cprov")+"/"+request.getParameter("cdis"));
pt.setString(4, request.getParameter("cpriority"));
pt.setString(5, request.getParameter("cseason"));
pt.setString(6, request.getParameter("cyear"));
pt.setString(7, session.getAttribute("userCode").toString());
pt.setString(8, request.getParameter("thiscritedit"));
pt.execute();
session.setAttribute("info", "<font color='blue'>Criteria edited successfully</font>");
out.println("<script>location.href='criteriaManage.jsp';</script>");
return;
}
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='criteriaManage.jsp';</script>");
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
                            <h2>Infrastructure history</h2>
                            <p>List of infrastructure requirement.</p>
                             <%
                      String info=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(info))
                      {
                          out.println("<p>"+info+"</p>");
                      }
                      session.removeAttribute("info");
                      if(session.getAttribute("userFunction").equals("District officer"))
                      {
              %>
                            <p> <a href="criteriaRegistration.jsp" data-ma-action="nk-login-switch" data-ma-block="#l-register"><i class="notika-icon notika-plus-symbol"></i> <span>New infrastructure</span></a></p>
                            <%}%>
                        </div>
                        <div class="table-responsive">
                            <table id="data-table-basic" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Date</th>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Location</th>
                                        <th>Priority</th>
                                        <th>Season</th>
                                        <th>Year</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <% 
                                        try
                                        {
                                    Statement stapp=con.createStatement();
                                    ResultSet  rsapp=stapp.executeQuery("select * from stafftb where staffid='"+session.getAttribute("userCode").toString()+"'");
                                    if(rsapp.first())
                                    {  n=0;
                                        Statement stcri=con.createStatement();
                                        ResultSet rscri=stcri.executeQuery("select * from criteriastb "
                                                    + "where location like'%"+rsapp.getString("assignedto")+"%' order by title,date,year desc");
                                        if(rscri.first())
                                        {
                                            rscri.beforeFirst();
                                            while(rscri.next())
                                            {
                                                n++;
                                          %>
                                    <tr>
                                        <td><%= n%></td>
                                        <td> <%= rscri.getString("date")%></td>
                                        <td><%= rscri.getString("title")%></td>
                                        <td><%= rscri.getString("description")%></td>
                                        <td><%= rscri.getString("location")%></td>
                                        <td><%= rscri.getString("priority")%></td>
                                        <td><%= rscri.getString("season")%></td>
                                        <td><%= rscri.getString("year")%></td>
                                        <td><form action="criteriaManage.jsp" method="POST">
<input type="hidden" value="<%= rscri.getString("criteriaid")%>" name="thiscrit"/><button type="submit" class="btn btn-primary notika-btn-primary" name="edit" value="edit">Edit</button>
                                            <button type="submit" class="btn btn-danger notika-btn-danger" name="delete" value="delete">Delete</button></form></td>
                                    </tr>
                                    <%}}}}
                                    catch(Exception e)
{
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='criteriaManage.jsp';</script>");
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
        if(session.getAttribute("userFunction").equals("District officer"))
        {
        Statement stcrit=con.createStatement();
        ResultSet rscrit=stcrit.executeQuery("select * from criteriastb where criteriaid='"+request.getParameter("thiscrit")+"'");
        if(rscrit.last() && rscrit.getRow()==1)
        {
        Statement stused=con.createStatement();
        ResultSet rsused=stused.executeQuery("select * from applicantstb where availablecriteria like'%"+rscrit.getString("criteriaid")+"%'");
        if(!rsused.first())
        {
%>

<div class="form-element-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-element-list">
                        <div class="basic-tb-hd">
                            <h2>Criteria edit</h2>
                             </div>
                        <form action="criteriaManage.jsp" method="POST">
                            <input type="hidden" value="<%= request.getParameter("thiscrit")%>" name="thiscritedit">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Title</label>
                                        <input type="text" class="form-control" value="<%= rscrit.getString("title")%>" name="ctitle">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Description</label>
                                        <textarea class="form-control"  name="cdescription"><%= rscrit.getString("description")%></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Priority</label>
                                        <select class="form-control" name="cpriority">
                                            <option>Select priority</option>
                                            <option <%
                                                if(rscrit.getString("priority").equals("A must"))
                                                {
                                                    out.println("selected=''");
                                                }
                                                %>value="A must">A must</option>
                                            <option
                                                
                                                <%
                                                if(rscrit.getString("priority").equals("Optional"))
                                                {
                                                    out.println("selected=''");
                                                }
                                                %>
                                                value="Optional">Optional</option>
                                            </select>
                                    </div>
                                </div>
                            </div>
                                                <%
                                                    
String [] location=session.getAttribute("userLocation").toString().split("/");
    
%>
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select province</label>
                                        <select class="form-control" id="country" name="cprov" onclick="populateStates(this.value);">                                             
<option selected=""><%=location[0] %></option>
                                      </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Select district</label>
                                        <select class="form-control" id="state" name="cdis">
<option selected=""><%=location[1] %></option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Applicable season</label>
                                        <select class="form-control" id="state" name="cseason">
                                            <option>Select season</option>
                                            <option 
                                                <%
                                                if(rscrit.getString("season").equals("Season A"))
                                                {
                                                    out.println("selected=''");
                                                }
                                                %>
                                                value="Season A">Season A</option>
                                            <option
                                                <%
                                                if(rscrit.getString("season").equals("Season B"))
                                                {
                                                    out.println("selected=''");
                                                }
                                                %>
                                                value="Season B">Season B</option>
                                            <option 
                                                <%
                                                if(rscrit.getString("season").equals("Season C"))
                                                {
                                                    out.println("selected=''");
                                                }
                                                %>
                                                value="Season C">Season C</option>
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
                                                    if(rscrit.getString("year").equals(String.valueOf(a)))
                                                    {
                                                  out.println("<option value='"+a+"' selected=''>"+a+"</option>");
                                                    }
                                                    else
                                                    {
                                                      out.println("<option value='"+a+"'>"+a+"</option>");  
                                                    }
                                                }
                                                %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                          
                        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="editCriteria" value="save">Save</button>
                                </div>
                    </div>
                        </form>
                </div>
            </div>
            
        </div>
    </div>
    </div>
<%
    }
else
{
session.setAttribute("info","<font color='red'>This criteria has been used in farmer application, you can't edit it.</font>");
out.println("<script>location.href='criteriaManage.jsp';</script>");
}
}

}
else
{
session.setAttribute("info","<font color='red'>You are not eligable to edit a criteria, please contact the district officer to do so.</font>");
out.println("<script>location.href='criteriaManage.jsp';</script>");
}
}
    %>
    
    <!-- Form Element area End-->
    <!-- Start Footer area-->
    <jsp:include page="footer.jsp"/>
   