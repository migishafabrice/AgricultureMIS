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
        xmlhttp.send("f="+str);
    }
    }
     function getLocation(str)
    {
    if (str == "") {
        document.getElementById("location").innerHTML = "";
        return;
    } else {
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() 
        {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("location").innerHTML="";
                document.getElementById("location").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("POST","data.jsp",true);
        xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlhttp.send("loc="+str);
    }
    }
      </script>
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
                            <h2>Online application</h2>
                           </div>
                        
                        <div class="row">
                            <form action="farmerApplication.jsp" method="POST">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="form-group">
                                    <div class="nk-int-st">
                                        <label>Owner national ID[Click out of the input field to load information.]</label>
                                        <input type="text" class="form-control" name="landownerid" id="ownerlandid" placeholder="Enter owner national ID"  onblur="getNames(this.value);">
                                    </div>
                                </div>
                            </div>
                            <div id="ownerid"></div>
                            <div id="location"></div>
                            
                         </form>  
                        </div>                          
                </div>
            </div>
            
        </div>
        </div>
</div>
<jsp:include page="footer.jsp"/>
 <%   
   if(request.getParameter("regApplication")!=null && request.getParameter("regApplication")!="")
   {
    String msg;
    try
       {
Statement st=con.createStatement();
ResultSet rs;
String code="",list="The following criterias are a must:<br/>";
Boolean found=false,missed=false;
SimpleDateFormat dte;
dte=new SimpleDateFormat("dd");
Date dt=new Date();
rs=st.executeQuery("select * from landstb where landid='"+request.getParameter("landupi")+"'");
    if(rs.first())
    {
        Statement cst=con.createStatement();
        ResultSet crs=cst.executeQuery("select * from criteriastb where location='"+rs.getString("location")+"'");
        crs.last();
        if(crs.getRow()>=1)
        {
            crs.beforeFirst();
            while(crs.next())
            {
            found=false;
            if(crs.getString("priority").equals("A must"))
            {
                if(!(request.getParameterValues("criteria")==null))
                 {
                 String criterias[]=request.getParameterValues("criteria");
                for(int a=0;a<criterias.length;a++)
                {
                   if(crs.getString("criteriaid").equals(criterias[a])) 
                   {
                       found=true;
                   }
                }
                 }
                if(found==false)
                {
                    missed=true;
                    list+="*"+crs.getString("title")+"<br/>";
                }
            }
            }
            if(missed==true)
            {
                session.setAttribute("info", "<font color='red'>"+list+"</font>");
                out.println("<script>location.href='farmerApplicationManage.jsp';</script>");
                return;
            }
        }
    }
    else
    {
     session.setAttribute("info", "<font color='red'>Land information missing contact the administrator.</font>");
                out.println("<script>location.href='farmerApplicationManage.jsp';</script>");
                return;   
    }
    if(missed==false)
    {
    rs.close();
    rs=st.executeQuery("select * from applicantstb order by id desc limit 1");
    if(rs.first())
    {
code=(Integer.valueOf(rs.getString("id"))+1)+"-FMA-"+dte.format(dt);
         dte=new SimpleDateFormat("MM");
code+=dte.format(dt);
dte=new SimpleDateFormat("yy");
code+=dte.format(dt);
    }
    else
    {
code="1-FMA-"+dte.format(dt);
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
PreparedStatement pt=con.prepareStatement("INSERT INTO `applicantstb`(`id`, `applicationid`, `farmerid`, `landid`, `availablecriteria`,`season`,`year`,`date`,`decision`,`decidedby`,`decisiondate`,`comment`)"
        + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
String criterias[]=request.getParameterValues("criteria");
String req="";
for(int i=0;i<criterias.length;i++)
{
 req+=criterias[i]+";";
}

pt.setString(1,null);
pt.setString(2, code);
pt.setString(3,rs.getString("farmerid"));
pt.setString(4, request.getParameter("landupi"));
pt.setString(5, req);
pt.setString(6, request.getParameter("lseason"));
pt.setString(7, request.getParameter("lyear"));
dte=new SimpleDateFormat("dd-MM-yyyy");
pt.setString(8, dte.format(dt));
pt.setString(9, "Submitted");
pt.setString(10, "");
pt.setString(11, "");
pt.setString(12, "");
pt.execute();
msg="<font color='blue'>Application confirmed</font>";
session.setAttribute("info", msg);
out.println("<script>location.href='farmerApplicationManage.jsp';</script>");
}
}
}
catch(Exception e)
       {
session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
out.println("<script>location.href='farmerApplicationManage.jsp';</script>");
return;
       }
}
%>