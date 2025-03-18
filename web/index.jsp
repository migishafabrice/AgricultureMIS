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
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Login Register | E-Agribusiness</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- favicon
		============================================ -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <!-- Google Fonts
		============================================ -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,700,900" rel="stylesheet">
    <!-- Bootstrap CSS
		============================================ -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- font awesome CSS
		============================================ -->
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <!-- owl.carousel CSS
		============================================ -->
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link rel="stylesheet" href="css/owl.theme.css">
    <link rel="stylesheet" href="css/owl.transitions.css">
    <!-- animate CSS
		============================================ -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- normalize CSS
		============================================ -->
    <link rel="stylesheet" href="css/normalize.css">
    <!-- mCustomScrollbar CSS
		============================================ -->
    <link rel="stylesheet" href="css/scrollbar/jquery.mCustomScrollbar.min.css">
    <!-- wave CSS
		============================================ -->
    <link rel="stylesheet" href="css/wave/waves.min.css">
    <!-- Notika icon CSS
		============================================ -->
    <link rel="stylesheet" href="css/notika-custom-icon.css">
    <!-- main CSS
		============================================ -->
    <link rel="stylesheet" href="css/main.css">
    <!-- style CSS
		============================================ -->
    <link rel="stylesheet" href="style.css">
    <!-- responsive CSS
		============================================ -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- modernizr JS
		============================================ -->
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
</head>

<body>
    <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
    <!-- Login Register area Start-->
    <div class="login-content" style="background-image: url('img/logo/index.jpeg');">
        <!-- Login -->
        <div class="nk-block toggled" id="l-login">
            <div class="nk-form">
                <form action="index.jsp" method="post">
                    <p>
                                <%
                      String infos=(String) session.getAttribute("info");
                      if(!StringUtils.isNullOrEmpty(infos))
                      {
                          out.println(infos);
                      }
                      session.removeAttribute("info");
              %>
                            </p>
                <div class="input-group">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Username:</font></span>
                    <div class="nk-int-st">
                        <input type="text" class="form-control" placeholder="Username" name="fuser">
                    </div>
                </div>
                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Password:</font></span>
                    <div class="nk-int-st">
                        <input type="password" class="form-control" placeholder="Password" name="fpass">
                    </div>
                </div>
                <p></p>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="logFarmer" value="Register">Login</button>
                    </div></form>
                <a href="#l-register" data-ma-action="nk-login-switch" data-ma-block="#l-register" class="btn btn-login btn-success btn-float"><i class="notika-icon notika-right-arrow right-arrow-ant"></i></a>
            </div>

            <div class="nk-navigation nk-lg-ic">
                <a href="#" data-ma-action="nk-login-switch" data-ma-block="#l-register"><i class="notika-icon notika-plus-symbol"></i> <span>Register</span></a>
                <a href="#" data-ma-action="nk-login-switch" data-ma-block="#l-forget-password"><i>?</i> <span>Forgot Password</span></a>
            </div>
        </div>

        <!-- Register -->
        
        <div class="nk-block" id="l-register">
            <div class="nk-form">
                <form action="regfarmer.jsp" method="POST" enctype="multipart/form-data">
                    <h3>New farmer registration</h3>
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
                <div class="input-group">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Name:</font></span>
                    <div class="nk-int-st">
                    <input type="text" class="form-control" placeholder="Enter your name" name="fname">
                    </div>
                </div>

                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Surname:</font></span>
                    <div class="nk-int-st"> 
                        <input type="text" class="form-control" placeholder="Enter your surname" name="fsurname">
                    </div>
                </div>

                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Gender:</font></span>
                    <div class="nk-int-st">
                                       <select class="form-control" name="fgender" >
                                            <option>Select gender</option><option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                    </div>
                </div>
                    
                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">National ID:</font></span>
                    <div class="nk-int-st">
                       <input type="text" class="form-control" placeholder="Enter your national ID" name="fid"/>
                    </div>
                </div>
                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Telephone:</font></span>
                    <div class="nk-int-st">
                       <input type="text" class="form-control" placeholder="Enter your telephone" name="ftel">
                    </div>
                </div>
                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Email:</font></span>
                    <div class="nk-int-st">
                       
                       <input type="text" class="form-control" placeholder="Enter your email" name="fmail">
                    </div>
                </div>
                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Password:</font></span>
                    <div class="nk-int-st">
                       
                      <input type="password" class="form-control" placeholder="Enter your preferred password" name="fpass">
                    </div>
                </div>
                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Re-type password:</font></span>
                    <div class="nk-int-st">
                       
                       <input type="password" class="form-control" placeholder="Re-type the same password" name="frpass">
                    </div>
                </div>
                <div class="input-group mg-t-15">
                    <span class="input-group-addon nk-ic-st-pro"><font size="2.5">Upload profile picture:</font></span>
                    <div class="nk-int-st">
                      
                      <input type="file" class="form-control" name="fpic">
                    </div>
                </div><p></p>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="regFarmer" value="Register">Register</button>
                                </div>
                <a href="#l-login" data-ma-action="nk-login-switch" data-ma-block="#l-login" class="btn btn-login btn-success btn-float"><i class="notika-icon notika-right-arrow"></i></a>
            </form></div>

            <div class="nk-navigation rg-ic-stl">
                <a href="index.jsp" data-ma-action="nk-login-switch" data-ma-block="#l-login"><i class="notika-icon notika-right-arrow"></i> <span>Sign in</span></a>
                <a href="forgotPassword" data-ma-action="nk-login-switch" data-ma-block="#l-forget-password"><i>?</i> <span>Forgot Password</span></a>
            </div>
        </div>

        <!-- Forgot Password -->
        
        <div class="nk-block" id="l-forget-password">
            <div class="nk-form">
                <p class="text-left">Forget password?Fill the following information to get your password.</p>
<form action="index.jsp" method="POST">
                <div class="input-group">
                    <span class="input-group-addon nk-ic-st-pro"></span>
                    <div class="nk-int-st">
                        <input type="text" class="form-control" name="ftel" placeholder="Enter your telephone">
                        <input type="text" class="form-control" name="fmail" placeholder="Enter your email Address">
                    </div>
                </div>
 <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12">
                            <button type="submit" class="btn btn-success notika-btn-success"  name="forFarmer" value="Recover">Get password</button>
 </div></form>
                <a href="index.jsp" data-ma-action="nk-login-switch" data-ma-block="#l-login" class="btn btn-login btn-success btn-float"><i class="notika-icon notika-right-arrow"></i></a>
            </div>

            <div class="nk-navigation nk-lg-ic rg-ic-stl">
                <a href="" data-ma-action="nk-login-switch" data-ma-block="#l-login"><i class="notika-icon notika-right-arrow"></i> <span>Sign in</span></a>
                <a href="" data-ma-action="nk-login-switch" data-ma-block="#l-register"><i class="notika-icon notika-plus-symbol"></i> <span>Register</span></a>
            </div>
        </div>
    </div>
    <!-- Login Register area End-->
    <!-- jquery
		============================================ -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <!-- bootstrap JS
		============================================ -->
    <script src="js/bootstrap.min.js"></script>
    <!-- wow JS
		============================================ -->
    <script src="js/wow.min.js"></script>
    <!-- price-slider JS
		============================================ -->
    <script src="js/jquery-price-slider.js"></script>
    <!-- owl.carousel JS
		============================================ -->
    <script src="js/owl.carousel.min.js"></script>
    <!-- scrollUp JS
		============================================ -->
    <script src="js/jquery.scrollUp.min.js"></script>
    <!-- meanmenu JS
		============================================ -->
    <script src="js/meanmenu/jquery.meanmenu.js"></script>
    <!-- counterup JS
		============================================ -->
    <script src="js/counterup/jquery.counterup.min.js"></script>
    <script src="js/counterup/waypoints.min.js"></script>
    <script src="js/counterup/counterup-active.js"></script>
    <!-- mCustomScrollbar JS
		============================================ -->
    <script src="js/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
    <!-- sparkline JS
		============================================ -->
    <script src="js/sparkline/jquery.sparkline.min.js"></script>
    <script src="js/sparkline/sparkline-active.js"></script>
    <!-- flot JS
		============================================ -->
    <script src="js/flot/jquery.flot.js"></script>
    <script src="js/flot/jquery.flot.resize.js"></script>
    <script src="js/flot/flot-active.js"></script>
    <!-- knob JS
		============================================ -->
    <script src="js/knob/jquery.knob.js"></script>
    <script src="js/knob/jquery.appear.js"></script>
    <script src="js/knob/knob-active.js"></script>
    <!--  Chat JS
		============================================ -->
    <script src="js/chat/jquery.chat.js"></script>
    <!--  wave JS
		============================================ -->
    <script src="js/wave/waves.min.js"></script>
    <script src="js/wave/wave-active.js"></script>
    <!-- icheck JS
		============================================ -->
    <script src="js/icheck/icheck.min.js"></script>
    <script src="js/icheck/icheck-active.js"></script>
    <!--  todo JS
		============================================ -->
    <script src="js/todo/jquery.todo.js"></script>
    <!-- Login JS
		============================================ -->
    <script src="js/login/login-action.js"></script>
    <!-- plugins JS
		============================================ -->
    <script src="js/plugins.js"></script>
    <!-- main JS
		============================================ -->
    <script src="js/main.js"></script>
</body>

</html>
<%    
    if(request.getParameter("logFarmer")!=null && request.getParameter("logFarmer")!="")
    {
    Properties properties = new Properties();
    String u=request.getParameter("fuser");
    String p=request.getParameter("fpass");
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
rs=st.executeQuery("select * from farmerstb where (nationalid='"+u+"' or email='"+u+"' or telephone='"+u+"') and password='"+p+"'");
    rs.last();
    n=rs.getRow();
    if(n==1)
    {
        session.setAttribute("userCode", rs.getString("farmerid"));
        session.setAttribute("userFunction","Farmer");
        response.sendRedirect("dashboard.jsp");
        return;
    }
    else
    {
        rs.close();
        rs=st.executeQuery("select * from stafftb where (email='"+u+"' or telephone='"+u+"') and password='"+p+"' ");
        if(rs.last())
        {
            if(rs.getRow()==1)
            {
        session.setAttribute("userCode", rs.getString("staffid"));
        session.setAttribute("userFunction",rs.getString("position"));
        session.setAttribute("userLocation",rs.getString("assignedto"));
        response.sendRedirect("dashboard.jsp"); return;  
            }
            else
            {
        msg="<font color='red'>Username or password invalid</font>";
        session.setAttribute("info",msg);
        response.sendRedirect("index.jsp");return;  
            }
        }
        else
        {
        msg="<font color='red'>Username or password invalid</font>";
        session.setAttribute("info",msg);
        response.sendRedirect("index.jsp");return;
        }
    } 
       }
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("index.jsp");return;
       }
    }
%>
<%    
    if(request.getParameter("forFarmer")!=null && request.getParameter("forFarmer")!="")
    {
    Properties properties = new Properties();
    String p=request.getParameter("ftel");
    String m=request.getParameter("fmail");
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
rs=st.executeQuery("select * from farmerstb where email='"+m+"' and telephone='"+p+"'");
    rs.last();
    n=rs.getRow();
    if(n==1)
    {
  String title="E-Agriculture MIS forgot password";
String sms="Dear "+ rs.getString("name")+" "+ rs.getString("surname")+
        ";<br/> Your account password is:"+
        "<br/>Password:"+ rs.getString("password")+"<br/>"
        + "<br/>Regards;<br/><br/>E-Agriculture MIS automatic email.";
String result=sendMail(rs.getString("email"),title,sms);
msg="<font color='blue'>Password sent to your email,get it for access and "+result+"</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='index.jsp';</script>");      
       
    }
    else
    {
        rs.close();
        rs=st.executeQuery("select * from stafftb where email='"+m+"' or telephone='"+p+"'");
        if(rs.last())
        {
            if(rs.getRow()==1)
            {
         String title="E-Agriculture MIS forgot password";
String sms="Dear "+ rs.getString("name")+" "+ rs.getString("surname")+
        ";<br/> Your account password is:"+
        "<br/>Password:"+ rs.getString("password")+"<br/>"
        + "<br/>Regards;<br/><br/>E-Agriculture MIS automatic email.";
String result=sendMail(rs.getString("email"),title,sms);
msg="<font color='blue'>Password sent to your email,get it for access and "+result+"</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='index.jsp';</script>"); 
            }
            else
            {
        msg="<font color='red'>Your email or telephone is invalid</font>";
        session.setAttribute("info",msg);
        response.sendRedirect("index.jsp");return;  
            }
        }
        else
        {
        msg="<font color='red'>Your email or telephone is invalid</font>";
        session.setAttribute("info",msg);
        response.sendRedirect("index.jsp");return;
        }
    } 
       }
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("index.jsp");return;
       }
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

    final String pass = "agriculture12345";
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