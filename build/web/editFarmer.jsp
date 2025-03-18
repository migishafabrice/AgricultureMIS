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
<%!
	public String generateRandomPassword(int len) {
		String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijk"
          +"lmnopqrstuvwxyz!@#$%&";
		Random rnd = new Random();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++)
			sb.append(chars.charAt(rnd.nextInt(chars.length())));
		return sb.toString();
	}

%>
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
String fileName="",fieldName="",fuser="",luser="",sexuser="",muser="",tuser="",functuser="",url="",fid="",pass="",rpass="";
 SimpleDateFormat dte;

                dte=new SimpleDateFormat("dd");
                Date dt=new Date();
 File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
String s = request.getRealPath("/");
   String filePath = s+"fimages\\";
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File(filePath));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
      try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
         while ( i.hasNext () ) 
         {
             
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField ())  {
                fieldName = fi.getFieldName();
                fileName = fi.getName();
                if(!StringUtils.isNullOrEmpty(fileName))
                {
                String ext;
                
    int lastIndexOf = fileName.lastIndexOf(".");
    if (lastIndexOf == -1) 
    {
     ext=""; // empty extension
    }
    else
    {
    ext=fileName.substring(lastIndexOf);
    }
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                fileName=session.getAttribute("userCode")+ext;
                file = new File( filePath + fileName) ;
                fi.write( file ) ;
               // out.println("Uploaded Filename: " + filePath + fileName + "<br>");
               url="fimages\\"+fileName;
               //url=url.replace("\\", "/");
                }
            }
            else
            {
           fieldName = fi.getFieldName();
                fileName = fi.getName();
                if(fieldName.equals("fname"))
                {
                 fuser=fi.getString();
                }
                if(fieldName.equals("fsurname"))
                {
                 luser=fi.getString();
                }
                if(fieldName.equals("fgender"))
                {
                 sexuser=fi.getString();
                }
                if(fieldName.equals("fmail"))
                {
                 muser=fi.getString();
                }
                if(fieldName.equals("ftel"))
                {
                 tuser=fi.getString();
                }
                if(fieldName.equals("fid"))
                {
                 fid=fi.getString();
                }
                 if(fieldName.equals("fpass"))
                {
                 pass=fi.getString();
                }
                  if(fieldName.equals("frpass"))
                {
                 rpass=fi.getString();
                }
            }
         }
      }catch(Exception e) {
         session.setAttribute("info",e.toString());
response.sendRedirect("farmerEdit.jsp");
return;
      }
   }
if(pass.equals(rpass))
{
PreparedStatement pt=con.prepareStatement("update `farmerstb` set `name`=?, `surname`=?, `sex`=?, `nationalid`=?, `telephone`=?, `email`=?"
        + " where farmerid=?");
pt.setString(1, fuser);
pt.setString(2, luser);
pt.setString(3, sexuser);
pt.setString(4, fid);
pt.setString(5, tuser);
pt.setString(6, muser);
pt.setString(7, session.getAttribute("userCode").toString());
pt.execute();
String receiver=muser;
String title="E-Agriculture MIS says congratulations to you "+fuser+" "+luser;
String sms="Dear "+ fuser+" "+luser+
        ";<br/> You have edited your information into E-Agriculture MIS"
         + "<br/>Regards;<br/><br/>E-Agriculture MIS automatic email.";
String result=sendMail(receiver,title,sms);
msg="<font color='blue'>Edit done successfully and "+result+"</font>";
session.setAttribute("info", msg);
response.sendRedirect("farmerEdit.jsp");
}
else
{
  msg="<font color='red'>Password don't match</font>";
session.setAttribute("info", msg);
response.sendRedirect("farmerEdit.jsp");  
}
}
catch(Exception e)
       {
session.setAttribute("info",e.toString());
response.sendRedirect("farmerEdit.jsp");
return;
       }
%>
<%
  
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