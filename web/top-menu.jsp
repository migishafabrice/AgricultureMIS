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
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>E-Agriculture MIS</title>
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
    <!-- meanmenu CSS
		============================================ -->
    <link rel="stylesheet" href="css/meanmenu/meanmenu.min.css">
    <!-- animate CSS
		============================================ -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- normalize CSS
		============================================ -->
    <link rel="stylesheet" href="css/normalize.css">
	<!-- wave CSS
		============================================ -->
    <link rel="stylesheet" href="css/wave/waves.min.css">
    <link rel="stylesheet" href="css/wave/button.css">
    <!-- mCustomScrollbar CSS
		============================================ -->
    <link rel="stylesheet" href="css/scrollbar/jquery.mCustomScrollbar.min.css">
    <!-- Notika icon CSS
		============================================ -->
    <link rel="stylesheet" href="css/notika-custom-icon.css">
    <!-- Data Table JS
		============================================ -->
    <link rel="stylesheet" href="css/jquery.dataTables.min.css">
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
    <!-- Start Header Top Area -->
    <%
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
if(session.getAttribute("userFunction").equals("Farmer"))
{
rs=st.executeQuery("select * from farmerstb where farmerid='"+session.getAttribute("userCode").toString()+"'");
}
else
{
 rs=st.executeQuery("select * from stafftb where staffid='"+session.getAttribute("userCode").toString()+"'");   
}
%>
    <div class="header-top-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="logo-area">
                        <font size="6">UMUHOZA LILIANE</font>
                    </div>
                </div>
                <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                    <div class="header-top-menu">
                        <ul class="nav navbar-nav notika-top-nav">
                               <%
    rs.last();
    n=rs.getRow();
    if(n==1)
    {
      %>
                            <li class="nav-item dropdown">
                                <div class="hd-message-sn">
                                                <div class="hd-message-img">
                                                    <img src="<%= rs.getString("profilepic")%>" alt="<%= rs.getString("name")+" "+rs.getString("surname")%>" />
                                                </div>
                                                <div class="hd-mg-ctn">
                                                    <h3><%= "Names:"+rs.getString("name")+" "+rs.getString("surname")%></h3>
                                                    <h3><%= "Position:"+session.getAttribute("userFunction")%></h3>
                                                    <% if(session.getAttribute("userLocation")!=null && session.getAttribute("userLocation")!="")
                                                    {
                                                        %>
                                                    <h3><%= "Location:"+session.getAttribute("userLocation")%></h3>
                                                    <%}%>
                                                    
                                                </div>
                                            </div>
                                
                            </li>
                              <%
       
    }
                                        %>
                            
                            
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Header Top Area -->
    <!-- Mobile Menu start -->
    <!--<div class="mobile-menu-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="mobile-menu">
                        <nav id="dropdown">
                            <ul class="mobile-menu-nav">
                                <li><a data-toggle="collapse" data-target="#Charts" href="#">Home</a>
                                    <ul class="collapse dropdown-header-top">
                                        <li><a href="dashboard.jsp">Dashboard One</a></li>
                                        <!--<li><a href="index-2.html">Dashboard Two</a></li>
                                        <li><a href="index-3.html">Dashboard Three</a></li>
                                        <li><a href="index-4.html">Dashboard Four</a></li>
                                        <li><a href="analytics.html">Analytics</a></li>
                                        <li><a href="widgets.html">Widgets</a></li>
                                    </ul>
                                </li>
                               <li><a data-toggle="collapse" data-target="#demoevent" href="#">Email</a>
                                    <ul id="demoevent" class="collapse dropdown-header-top">
                                        <li><a href="inbox.html">Inbox</a></li>
                                        <li><a href="view-email.html">View Email</a></li>
                                        <li><a href="compose-email.html">Compose Email</a></li>
                                    </ul>
                                </li>
                                <li><a data-toggle="collapse" data-target="#democrou" href="#">Manage</a>
                                    <ul id="democrou" class="collapse dropdown-header-top">
                                        <li><a href="staffManage.jsp">Staff</a></li>
                                        <li><a href="farmerManage.jsp">Farmer</a></li>
                                        <li><a href="criteriaManage.jsp">Criteria</a></li>
                                        <li><a href="applicationManage.jsp">Application</a></li>
                                        
                                    </ul>
                                </li>
                                
                                
                                <li><a data-toggle="collapse" data-target="#demo" href="#">Report</a>
                                    <ul id="demo" class="collapse dropdown-header-top">
                                        <li><a href="form-elements.html">Staff</a></li>
                                        <li><a href="form-components.html">Farmer</a></li>
                                        <li><a href="form-examples.html">Application</a></li>
                                    </ul>
                                </li>
                                
                                <li><a data-toggle="collapse" data-target="#Pagemob" href="#">Logout</a>
                                    <ul id="Pagemob" class="collapse dropdown-header-top">
                                        <li><a href="logout.jsp">Logout</a>
                                        </li>
                                        
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>-->
    <!-- Mobile Menu end -->
    <!-- Main Menu area start-->
    <div class="main-menu-area mg-tb-40">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <ul class="nav nav-tabs notika-menu-wrap menu-it-icon-pro">
                        <li class="active"><a data-toggle="tab" href="#Home"><i class="notika-icon notika-house"></i> Home</a>
                        </li>
                         <li><a data-toggle="tab" href="#Interface"><i class="notika-icon notika-edit"></i> Manage</a>
                        </li>
                        <li><a data-toggle="tab" href="#Forms"><i class="notika-icon notika-form"></i> Report</a>
                        </li>
                        <li><a data-toggle="tab" href="#Page"><i class="notika-icon notika-support"></i> Logout</a>
                        </li>
                    </ul>
                    <div class="tab-content custom-menu-content">
                        <div id="Home" class="tab-pane in active notika-tab-menu-bg animated flipInX">
                            <ul class="notika-main-menu-dropdown">
                                <li><a href="dashboard.jsp">Dashboard</a>
                                </li>
                               
                            </ul>
                        </div>
                        
                        <div id="Interface" class="tab-pane notika-tab-menu-bg animated flipInX">
                            <ul class="notika-main-menu-dropdown">
                                <% if(!session.getAttribute("userFunction").equals("Farmer") && !session.getAttribute("userFunction").equals("District officer"))
                                {
                                    %>
                                    <li><a href="staffManage.jsp">Staff</a>
                                </li>
                                    <%
                                } %>
                                <% if(session.getAttribute("userFunction").equals("Farmer"))
                                {
                                    %>
                                <li><a href="farmerManage.jsp">Farmer</a>
                                </li><%}%>
                                 <% if(!session.getAttribute("userFunction").equals("Farmer") && !session.getAttribute("userFunction").equals("Administrator"))
                                {  %>
                                <li><a href="criteriaManage.jsp">Infrastructure requirement </a>
                                </li><%}%>
                                <li><a href="landManage.jsp">Lands</a>
                                </li>
                                 <% if(session.getAttribute("userFunction").equals("Farmer") || session.getAttribute("userFunction").equals("District officer"))
                                {
                                    %>
                                <li><a href="farmerApplicationManage.jsp">Application</a>
                                </li><%}%>
                                <li><a href="changePassword.jsp">Change password</a>
                                </li>
                            </ul>
                        </div>
                        
                        
                        <div id="Forms" class="tab-pane notika-tab-menu-bg animated flipInX">
                            <ul class="notika-main-menu-dropdown">
                                 <% if(!session.getAttribute("userFunction").equals("Farmer") && !session.getAttribute("userFunction").equals("District officer"))
                                {
                                    %>
                                <li><a href="staffReport.jsp">Staff</a>
                                    <%
                                        }
                                    %>
                                </li>
                                <li><a href="farmerReport.jsp">Farmer</a>
                                </li>
                                 <% if(!session.getAttribute("userFunction").equals("Farmer"))
                                {  %>
                                <li><a href="criteriaReport.jsp">Infrastructure requirement</a>
                                </li><%}%>
                                <li><a href="landReport.jsp">Lands</a>
                                </li>
                                <li><a href="applicationReport.jsp">All application</a>
                                </li>
                                <li><a href="approvedApplicationReport.jsp">Approved application</a>
                                </li>
                                <li><a href="rejectedApplicationReport.jsp">Rejected application</a>
                                </li>
                            </ul>
                        </div>
                        
                        <div id="Page" class="tab-pane notika-tab-menu-bg animated flipInX">
                            <ul class="notika-main-menu-dropdown">
                                <li><a href="logout.jsp">Logout</a>
                                </li>
                                
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
                <%                
     
       }
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
response.sendRedirect("index.jsp");return;
       }
    %>