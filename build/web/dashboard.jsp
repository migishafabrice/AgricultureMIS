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
<jsp:include page="top-menu.jsp"/>
              <%
                      String info=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(info))
                      {
                          out.println("<p>"+info+"</p>");
                      }
                      session.removeAttribute("info");
                      Properties properties = new Properties();
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
    String msg;
try
  {
int n;
Statement st=con.createStatement();
ResultSet rs=null;
if(session.getAttribute("userFunction").equals("Administrator")) 
        {
rs=st.executeQuery("select * from stafftb order by name asc,surname asc,position desc,assignedto asc");
        }
if(session.getAttribute("userFunction").equals("Province officer"))
            {
rs=st.executeQuery("select * from stafftb order by name asc,surname asc,assignedto asc");               
            }
                
 %>
        
              
              <div class="normal-table-area">
        <div class="container">
            <% if(rs.first())
             {
            int dis=0,prov=0,adis=0,aprov=0,nadis=0,naprov=0;
            rs.beforeFirst();
            while(rs.next())
            {
                if(rs.getString("position").equals("District officer"))
                {
                    dis++;
                    if(rs.getString("active").equals("YES"))
                    {
                        adis++;
                    }
                    else
                    {
                     nadis++;   
                    }
                    
            }
                if(rs.getString("position").equals("Province officer"))
                {
                    prov++;
                    if(rs.getString("active").equals("YES"))
                    {
                        aprov++;
                    }
                    else
                    {
                     naprov++;   
                    }
            }
            }
            %>
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="normal-table-list">
                        <div class="basic-tb-hd">
                            <h2>Staff statistics</h2>
                            
                        </div>
                        <div class="bsc-tbl">
                            <table class="table table-sc-ex">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Activated</th>
                                        <th>Deactivated</th>
                                        <th>Total</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Province officer</td>
                                        <td><%= aprov%></td>
                                        <td><%= naprov%></td>
                                        <td><%= prov%></td>
                                        
                                    </tr>
                                    <tr>
                                        <td>District officer</td>
                                        <td><%= adis%></td>
                                        <td><%= nadis%></td>
                                        <td><%= dis%></td>
                                        
                                    </tr>
                                    
                                   </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <%}
            rs.close();
rs=st.executeQuery("select * from applicantstb");
if(rs.first())
{
rs.last();
int tot=rs.getRow();
rs.first();
int approv=0,sub=0,rev=0,rej=0;
while(rs.next())
{
if(rs.getString("decision").equals("Approved"))
{
approv++;
}
if(rs.getString("decision").equals("Submitted"))
{
sub++;
}
if(rs.getString("decision").equals("Review"))
{
rev++;
}
if(rs.getString("decision").equals("Rejected"))
{
rej++;
}
}
%>
 
<div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="normal-table-list">
                        <div class="basic-tb-hd">
                            <h2>Applications statistics</h2>
                            
                        </div>
                        <div class="bsc-tbl">
                            <table class="table table-sc-ex">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Submitted</th>
                                        <th>Approved</th>
                                        <th>Review</th>
                                        <th>Rejected</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Applications</td>
                                        <td><%= sub%></td>
                                        <td><%= approv%></td>
                                        <td><%= rev%></td>
                                        <td><%= rej%></td>
                                        <td><%= tot%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
<%
}
%>
</div>
</div>
<%}
catch(Exception e)
{
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("index.jsp");
}
%>
    <!-- Main Menu area End-->
    <!-- Start Status area -->
    
    <!-- End Status area-->
    
    <!-- End Sale Statistic area-->
    <!-- Start Email Statistic area-->
    
    <!-- End Email Statistic area-->
    <!-- Start Realtime sts area-->
    
    <!-- End Realtime sts area-->
    <!-- Start Footer area-->
    <jsp:include page="footer.jsp"/>