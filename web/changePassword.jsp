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
                            
                            <h2>Change password</h2>
                             </div>
                        <form action="changePassword.jsp" method="POST">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Current password</label>
                                        <input type="password" class="form-control" placeholder="Enter current password" name="cpass">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>New password</label>
                                        <input type="password" class="form-control" placeholder="Enter new password" name="npass">
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Retype new password</label>
                                        <input type="password" class="form-control" placeholder="Re-type new password" name="rpass">
                                    </div>
                                </div>
                            </div>
                             <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="changePass" value="Change password">Change password</button>
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
        try
        {
        if(request.getParameter("changePass")!=null && request.getParameter("changePass")!=null)
        {
        if(!StringUtils.isNullOrEmpty(request.getParameter("npass")) && request.getParameter("npass").equals(request.getParameter("rpass")))  
        {
            if(session.getAttribute("userFunction").equals("Farmer"))
            {
            PreparedStatement pst=con.prepareStatement("update farmerstb set password=? where farmerid=?");
            pst.setString(1,request.getParameter("npass") );
            pst.setString(2,session.getAttribute("userCode").toString());
            pst.execute();
            Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select * from farmerstb where farmerid='"+session.getAttribute("userCode")+"'");
rs.last();
             String title="E-Agriculture MIS changed password";
String sms="Dear "+ rs.getString("name")+" "+ rs.getString("surname")+
        ";<br/> Your account password is:"+
        "<br/>Password:"+ rs.getString("password")+"<br/>"
        + "<br/>Regards;<br/><br/>E-Agriculture MIS automatic email.";
String result=sendMail(rs.getString("email"),title,sms);
msg="<font color='blue'>Password changed and is sent to your email,get it for access and "+result+"</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='changePassword.jsp';</script>");
return;
            }
            else
            {
             PreparedStatement pst=con.prepareStatement("update stafftb set password=? where staffid=?");
            pst.setString(1,request.getParameter("npass") );
            pst.setString(2,session.getAttribute("userCode").toString());  
            pst.execute();
            Statement st=con.createStatement();
ResultSet rs;
rs=st.executeQuery("select * from stafftb where staffid='"+session.getAttribute("userCode").toString()+"'");
rs.last();
             String title="E-Agriculture MIS changed password";
String sms="Dear "+ rs.getString("name")+" "+ rs.getString("surname")+
        ";<br/> Your account password is:"+
        "<br/>Password:"+ rs.getString("password")+"<br/>"
        + "<br/>Regards;<br/><br/>E-Agriculture MIS automatic email.";
String result=sendMail(rs.getString("email"),title,sms);
msg="<font color='blue'>Password changed and is sent to your email,get it for access and "+result+"</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='changePassword.jsp';</script>");
return;
            }
        }
        }
        }catch(Exception e)
        {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='changePassword.jsp';</script>");
return;
        }
        %>
  <%!
    //Creating a result for getting status that messsage is delivered or not!
public String sendMail(String receiver,String title,String sms)
{
    String result;
// Get recipient's email-ID, message & subject-line from index.html page

    final String to = receiver;
    final String subject = title;
    final String messg = sms;
   // Sender's email ID and password needs to be mentioned

    final String from = "eagriculturemis@gmail.com";

    final String pass = "ewndkzbyxaqbfgft";
  // Defining the gmail host

    String host = "smtp.gmail.com";
  // Creating Properties object

    Properties props = new Properties();
    // Defining properties

    props.put("mail.smtp.host", host);

    props.put("mail.transport.protocol", "smtp");

    props.put("mail.smtp.auth", "true");

    props.put("mail.smtp.starttls.enable", "true");

    props.put("mail.user", from);

    props.put("mail.password", pass);

    props.put("mail.port", "465");
   // Authorized the Session object.

    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {

        @Override

        protected PasswordAuthentication getPasswordAuthentication() {

            return new PasswordAuthentication(from, pass);

        }
    });
    try {

        // Create a default MimeMessage object.

        MimeMessage message = new MimeMessage(mailSession);

        // Set From: header field of the header.

        message.setFrom(new InternetAddress(from));

        // Set To: header field of the header.

        message.addRecipient(Message.RecipientType.TO,

                new InternetAddress(to));

        // Set Subject: header field

        message.setSubject(subject);

        // Now set the actual message

        message.setContent(messg,"text/html");

        // Send message

        Transport.send(message);

        result = "Email sent successfully";

    } catch (MessagingException mex) {

        mex.printStackTrace();

        result = "Email not sent";

    }
return result;
}
%>