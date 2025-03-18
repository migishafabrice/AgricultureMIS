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
      %>
      
      <%if(request.getParameter("changeme")!=null && request.getParameter("changeme")!="")
      {
        try
{
PreparedStatement pt=con.prepareStatement("update `applicantstb` set `decision`=?,`decidedby`=?, `decisiondate`=?, `comment`=? where `applicationid`=?");
pt.setString(1,request.getParameter("decision") );
pt.setString(2, session.getAttribute("userCode").toString());
SimpleDateFormat dte=new SimpleDateFormat("dd-MM-YYYY");
Date dt=new Date();
pt.setString(3, dte.format(dt));
pt.setString(4, request.getParameter("comment"));
pt.setString(5, request.getParameter("changethis"));
pt.execute();
session.setAttribute("info", "<font color='blue'>Application "+ request.getParameter("decision") +" successfully</font>");
out.println("<script>location.href='farmerApplicationManage.jsp';</script>");
return;
}
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='farmerApplicationManage.jsp';</script>");
return;
       }  
      }
          if(request.getParameter("viewme")==null || request.getParameter("viewme")=="") {%>
      <div class="data-table-area">
        <div style="width: 100%">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="data-table-list">
                        <div class="basic-tb-hd">
                             <% if(session.getAttribute("userFunction").equals("Farmer"))
                            {
                                %>
                            <h2>History application</h2>
                            <p>List of application you made.</p>
                              <%}
                                 else
{%>
<h2>Farmers application</h2>
<p>List of application made.</p>
<%}%>
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
                            <% if(session.getAttribute("userFunction").equals("Farmer"))
                            {
                                %>
                            
                            <p> <a href="farmerApplication.jsp" data-ma-action="nk-login-switch" data-ma-block="#l-register"><i class="notika-icon notika-plus-symbol"></i> <span>New application</span></a></p>
                            <%}%>
                        </div>
                        <div class="table-responsive">
                            <table id="data-table-basic" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Names</th>
                                        <th>Telephone</th>
                                        <th>Email</th>
                                        <th>Date</th>
                                        <th>Land UPI</th>
                                        <th>Season</th>
                                        <th>Year</th>
                                        <th>Required criteria</th>
                                        <th>Available criteria</th>
                                        <th>Location</th>
                                        <th>Status</th>
                                        <th>Comment</th>
                                         <th>Action</th>
                                    </tr>
                                </thead>
                                <%
                                %>
                                <tbody>
                                    <% 
                                    Statement stapp=con.createStatement();
                                    ResultSet  rsapp=null;
                                    if(session.getAttribute("userFunction").equals("Farmer"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb,applicantstb,farmerstb where farmerstb.farmerid=landstb.farmerid and farmerstb.farmerid=applicantstb.farmerid and applicantstb.farmerid='"+session.getAttribute("userCode").toString()+"'");
                                    }
                                     if(session.getAttribute("userFunction").equals("District officer") || session.getAttribute("userFunction").equals("Province officer"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb,applicantstb,farmerstb where farmerstb.farmerid=landstb.farmerid and applicantstb.landid=landstb.landid and landstb.location like'%"+session.getAttribute("userLocation").toString()+"%'");
                                    }
                                     if(session.getAttribute("userFunction").equals("Administrator"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb,applicantstb,farmerstb where farmerstb.farmerid=landstb.farmerid and applicantstb.landid=landstb.landid");
                                    }
                                    if(rsapp.first())
                                    {
                                        
                                       rsapp.beforeFirst();
                                        n=0;
                                        while(rsapp.next())
                                        {
                                        
                                        Statement stland=con.createStatement();
                                        ResultSet rsland=stland.executeQuery("select * from landstb where landid='"+rsapp.getString("applicantstb.landid")+"'");
                                        if(rsland.first())
                                        {
                                            String crit="";
                                            Statement stcri=con.createStatement();
                                            if(rsapp.getString("availablecriteria").contains(";"))
                                            {
                                             String []criteria=rsapp.getString("availablecriteria").split(";");  
                                             for(int i=0;i<criteria.length;i++)
                                            {
                                            ResultSet rscri=stcri.executeQuery("select * from criteriastb "
                                                    + "where criteriaid='"+criteria[i]+"' and location='"+rsland.getString("location")+"'");
                                            if(rscri.first())
                                            {
                                             crit+="*"+rscri.getString("title")+"<br/>";
                                            }
                                            }
                                            }
                                            else
                                            {
                                             ResultSet rscri=stcri.executeQuery("select * from criteriastb "
                                                    + "where criteriaid='"+rsapp.getString("availablecriteria")+"' and location='"+rsland.getString("location")+"'");
                                            if(rscri.first())
                                            {
                                             crit+="*"+rscri.getString("title");
                                            }
                                            }
                                            Statement stav=con.createStatement();
                                            ResultSet rsav=stav.executeQuery("select * from criteriastb where year='"+rsapp.getString("year")+"'order by title asc");
                                            if(rsav.first())
                                            {
                                                n++;
                                                String req="";
                                                rsav.beforeFirst();
                                            while(rsav.next())
                                            {
                                              req+="*"+rsav.getString("title")+"["+rsav.getString("priority")+"]<br/>";
                                            }
                                        %>
                                    <tr>
                                        <td><%= n%></td>
                                        <td><%= rsapp.getString("name")+" "+rsapp.getString("surname")%></td>
                                        <td><%= rsapp.getString("telephone")%></td>
                                        <td><%= rsapp.getString("email")%></td>
                                        <td><%= rsapp.getString("date")%></td>
                                        <td><%= rsland.getString("upi")%></td>
                                        <td><%= rsapp.getString("season")%></td>
                                        <td><%= rsapp.getString("year")%></td>
                                        <td><%= req%></td>
                                        <td><%= crit%></td>
                                        <td><%= rsapp.getString("location")%></td>
                                        <td><%= rsapp.getString("decision")%></td>
                                        <td><%= rsapp.getString("comment")%></td>
                                        <td><form action="viewProof.jsp" method="POST"><input type="hidden" value="<%= rsapp.getString("applicationid")%>" name="viewapp"/>
                                            <button type="submit" class="btn btn-success notika-btn-success"  name="viewme" value="viewme">Generate PDF</button></form><% if(session.getAttribute("userFunction").equals("District officer")) {%><form action="farmerApplicationManage.jsp" method="POST"><input type="hidden" value="<%= rsapp.getString("applicationid")%>" name="viewapp"/>
                                             <button type="submit" class="btn btn-success notika-btn-success"  name="viewme" value="viewme">View details</button></form><%}%></td>
                                    </tr>
                                    <%}}}}%>
                                </tbody>
                                
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div><%}
    else
{
%>
<% 
                                    Statement stapp=con.createStatement();
                                    ResultSet  rsapp=null;
                                    if(session.getAttribute("userFunction").equals("Farmer"))
                                    {
                                    rsapp=stapp.executeQuery("select * from applicantstb,farmerstb where farmerstb.farmerid=applicantstb.farmerid and applicantstb.farmerid='"+session.getAttribute("userCode").toString()+"'"
                                            + " and applicationid='"+request.getParameter("viewapp")+"'");
                                    }
                                     if(session.getAttribute("userFunction").equals("District officer") || session.getAttribute("userFunction").equals("Province officer"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb,applicantstb,farmerstb where farmerstb.farmerid=landstb.farmerid and applicantstb.landid=landstb.landid and landstb.location like'%"+session.getAttribute("userLocation").toString()+"%'");
                                    }
                                     if(session.getAttribute("userFunction").equals("Administrator"))
                                    {
                                    rsapp=stapp.executeQuery("select * from landstb,applicantstb,farmerstb where farmerstb.farmerid=landstb.farmerid and applicantstb.landid=landstb.landid");
                                    }
                                    if(rsapp.first())
                                    {
                                        
                                       rsapp.beforeFirst();
                                        n=0;
                                        while(rsapp.next())
                                        {
                                        
                                        Statement stland=con.createStatement();
                                        ResultSet rsland=stland.executeQuery("select * from landstb where landid='"+rsapp.getString("applicantstb.landid")+"'");
                                        if(rsland.first())
                                        {
                                            String crit="";
                                            Statement stcri=con.createStatement();
                                            if(rsapp.getString("availablecriteria").contains(";"))
                                            {
                                             String []criteria=rsapp.getString("availablecriteria").split(";");  
                                             for(int i=0;i<criteria.length;i++)
                                            {
                                            ResultSet rscri=stcri.executeQuery("select * from criteriastb "
                                                    + "where criteriaid='"+criteria[i]+"' and location='"+rsland.getString("location")+"'");
                                            if(rscri.first())
                                            {
                                             crit+="*"+rscri.getString("title")+"<br/>";
                                            }
                                            }
                                            }
                                            else
                                            {
                                             ResultSet rscri=stcri.executeQuery("select * from criteriastb "
                                                    + "where criteriaid='"+rsapp.getString("availablecriteria")+"' and location='"+rsland.getString("location")+"'");
                                            if(rscri.first())
                                            {
                                             crit+="*"+rscri.getString("title");
                                            }
                                            }
                                            Statement stav=con.createStatement();
                                            ResultSet rsav=stav.executeQuery("select * from criteriastb where year='"+rsapp.getString("year")+"'order by title asc");
                                            if(rsav.first())
                                            {
                                                n++;
                                                String req="";
                                                rsav.beforeFirst();
                                            while(rsav.next())
                                            {
                                              req+="*"+rsav.getString("title")+"["+rsav.getString("priority")+"]<br/>";
                                            }
                                        %>
<div class="form-element-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="form-element-list">
                        <div class="basic-tb-hd">
                            <h2>Application details</h2>
                           </div>
                        
                        <div class="row">
                            <form action="farmerApplicationManage.jsp" method="POST">
                                <input type="hidden" value="<%= request.getParameter("viewapp")%>" name="changethis"/>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Name</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("name")%>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Surname</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("surname")%>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Gender</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("sex") %>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Telephone</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("telephone") %>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Email</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("email") %>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>National ID</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("nationalID") %>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>UPI of land applied on</label>
                                        <input type="text" class="form-control" value="<%= rsland.getString("upi")%>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Location</label>
                                        <input type="text" class="form-control" value="<%= rsland.getString("location")%>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Infrastructure required</label><br/>
                                        <%= req %>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Available infrastructure</label><br/>
                                        <%= crit %>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Season</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("season")%>" readonly="">
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Year</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("year")%>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Date</label>
                                        <input type="text" class="form-control" value="<%= rsapp.getString("date")%>" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Comment</label>
                                        <textarea class="form-control" name="comment" ></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Decision</label>
                                        <select class="form-control" name="decision"><option>Select decision</option><option>Approved</option><option>Rejected</option></select>
                                    </div>
                                </div>
                                <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="changeme" value="changeme">Save</button>
                                </div>
                            </div>
                            
                            
                         </form>  
                        </div>                          
                </div>
            </div>
            
        </div>
        </div>
</div><%}}}}%>
<%
                                }%>
    
    <!-- Form Element area End-->
    <!-- Start Footer area-->
    <jsp:include page="footer.jsp"/>
   