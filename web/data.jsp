<%
/*if(session.getAttribute("userCode")==null)
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}*/
    %>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>    
<% 
    if(!StringUtils.isNullOrEmpty(request.getParameter("q")))
    {
       String name = ""; 
       String q = request.getParameter("q"); 
       Properties properties = new Properties();
       try { 
            properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
            Statement smt = con.createStatement(); //Create Statement to interact 
            ResultSet r = smt.executeQuery("select * from farmerstb where nationalid='" + q + "'"); 
            r.last();
            if(r.getRow()==1)
            {
         
        name="<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Name</label>"+
                                        "<input type='text' class='form-control' value='"+r.getString("name")+"' readonly=''>"+
                                    "</div>"+
                                "</div>"+
                            "</div>"+
                            "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Surname</label>"+
                                        "<input type='text' class='form-control' value='"+r.getString("surname")+"' readonly=''>"+
                                    "</div>"+
                                "</div>"+
                            "</div>";
            }
           } catch (Exception e) { 
            e.printStackTrace(); 
       } %>
       <%out.print(name);%> 
   <%  
}
    %> 
<% 
    if(!StringUtils.isNullOrEmpty(request.getParameter("f")))
    {
       String name = ""; 
       String f = request.getParameter("f"); 
       Properties properties = new Properties();
       try { 
            properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
            Statement smt = con.createStatement(); //Create Statement to interact 
            ResultSet r = smt.executeQuery("select * from farmerstb where nationalid='" + f + "'"); 
            r.last();
            if(r.getRow()==1)
            {
         
        name="<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Name</label>"+
                                        "<input type='text' class='form-control' value='"+r.getString("name")+"' readonly=''>"+
                                    "</div>"+
                                "</div>"+
                            "</div>"+
                            "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Surname</label>"+
                                        "<input type='text' class='form-control' value='"+r.getString("surname")+"' readonly=''>"+
                                    "</div>"+
                                "</div>"+
                            "</div>"
                + "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Land UPI</label>"+
                                        "<select class='form-control' name='landupi' id='landupi' onchange='getLocation(this.value);'>";
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from landstb where farmerid='"+r.getString("farmerid")+"'");
        rs.last();
        if(rs.getRow()>=1)
        {
            name+="<option>Select land UPI</option>";
                    rs.beforeFirst();
                    while(rs.next())
                    {
                name+="<option value='"+rs.getString("landid")+"'>"+rs.getString("upi")+"</option>";
                        }
        }
        name+=  "</select></div>"+
                                "</div>"+
                           " </div>";
            }
           } catch (Exception e) { 
            e.printStackTrace(); 
       } %>
       <%out.print(name);%> 
   <%  
}
    %> 
<% 
    if(!StringUtils.isNullOrEmpty(request.getParameter("loc")))
    {
       String name = ""; 
       String loc = request.getParameter("loc"); 
       Properties properties = new Properties();
       try { 
            properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
            Statement smt = con.createStatement(); //Create Statement to interact 
            ResultSet r = smt.executeQuery("select * from landstb where landid='" + loc + "'"); 
            r.last();
            if(r.getRow()==1)
            {
         String region[]=r.getString("location").split("/");
        name="<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Province</label>"+
                                        "<input type='text' class='form-control' value='"+region[0]+"' readonly=''>"+
                                    "</div>"+
                                "</div>"+
                            "</div>"+
                            "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>District</label>"+
                                        "<input type='text' class='form-control' value='"+region[1]+"' readonly=''>"+
                                    "</div>"+
                                "</div>"+
                            "</div>"
                + "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Check any requirement you dispose</label><br/>";
                                       
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from criteriastb where location='"+r.getString("location")+"'");
        rs.last();
        String season="";
        if(rs.getRow()>=1)
        {
            
                    rs.beforeFirst();
                    while(rs.next())
                    {
                name+="<p><input type='checkbox' name='criteria' class='i-checks' value='"+rs.getString("criteriaid")+"'>  "+rs.getString("title")+"</p>";
                if(!season.contains(rs.getString("season")))
                {
                season+="<option value='"+rs.getString("season")+"'>"+rs.getString("season")+"</option>";
                }
                        }
        }
        SimpleDateFormat dte;
 dte=new SimpleDateFormat("yyyy");
 Date dt=new Date();
        name+=  "</div>"+
                "</div>"+
                "</div>"+
                "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Year</label>"+
                                        "<input type='text' name='lyear' class='form-control' value='"+dte.format(dt)+"' readonly=''>"+
                                    "</div>"+
                                "</div>"+
                            "</div>"
                
                + "<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>"+
                                "<div class='form-group'>"+
                                    "<div class='nk-int-st'>"+
                                        "<label>Season</label>"+
                                        "<select class='form-control' name='lseason'><option value='Select season'>Select season</option>"
                + season+"</select>"+
                                    "</div>"+
                                "</div>"+
                            "</div>"
                + " <div class='col-lg-8 col-md-7 col-sm-7 col-xs-12'><button type='submit' class='btn btn-success notika-btn-success' name='regApplication'>Save</button></div>";
            }
           } catch (Exception e) { 
            e.printStackTrace(); 
       } %>
       <%out.print(name);%> 
   <%  
}
    %> 
         