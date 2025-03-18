<%@page import="com.lowagie.text.Font"%>
<%@page import="com.lowagie.text.pdf.PdfDictionary.*"%>
<%@page import="java.awt.Color"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*,com.lowagie.text.*"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@ page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
if(session.getAttribute("userCode")==null || session.getAttribute("userCode")=="")
{
    session.setAttribute("info","<font color='red'>Please login</font>");
    response.sendRedirect("index.jsp");
}
    %> 
<%!
     public static PdfPCell getNormalCell(String string, String language, float size)
            throws DocumentException, IOException {
        if(string != null && "".equals(string)){
            return new PdfPCell();
        }
        Font f  = getFontForThisLanguage(language);
        if(size < 0) {
            f.setColor(Color.RED);
            size = -size;
        }
        f.setSize(size);
        PdfPCell cell = new PdfPCell(new Phrase(string, f));
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        return cell;
    }
 public static Font getFontForThisLanguage(String language) {
        if ("czech".equals(language)) {
            return FontFactory.getFont(language, "Cp1250", true);
        }
        if ("greek".equals(language)) {
            return FontFactory.getFont(language, "Cp1253", true);
        }
        return FontFactory.getFont(language, null, true);
    }
    %>
<%
Properties properties = new Properties();
Statement st;
ResultSet rs;
String msg;
int n=0;
int teacher=0;
int dos=0;
int head=0;
int male=0;
int female=0;
int active=0;
int nonActive=0;
String answer="";
%>
<%
properties.setProperty("user", "root");
properties.setProperty("password", "");
properties.setProperty("useSSL", "false");
properties.setProperty("autoReconnect", "true");
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/agridb",properties);
Statement rst=con.createStatement();
//1

                        try
                        {
                            ResultSet rrs=null;
                         if(!session.getAttribute("userFunction").equals("Farmer"))
                         {
                             if(session.getAttribute("userFunction").equals("Administrator"))
                             {
                               rrs=rst.executeQuery("select * from farmerstb,landstb where farmerstb.farmerid=landstb.farmerid order by name,surname,upi asc");  
                             }
                             else{
                                 
                          rrs=rst.executeQuery("select * from farmerstb,landstb where farmerstb.farmerid=landstb.farmerid and "
                                  + "landstb.location='"+session.getAttribute("userLocation")+"' order by name,surname,upi");
                             }
                          if(rrs.first())
                          {
                              rrs.beforeFirst();
                              response.setContentType("application/pdf");
Document document = new Document();
document.setPageSize(PageSize.A4.rotate());
try{
ByteArrayOutputStream buffer = new ByteArrayOutputStream();
PdfWriter.getInstance(document, buffer); 
document.open();
Font subfont = new Font(Font.TIMES_ROMAN, 11,Font.BOLD|Font.UNDERLINE);
document.addTitle("Farmers report");
document.add(new Paragraph("E-AGRICULTURE SYSTEM",new Font(Font.TIMES_ROMAN,12,Font.BOLD)));
if(session.getAttribute("userLocation")!=null && session.getAttribute("userLocation")!="")
{
    document.add(new Paragraph("Location:"+session.getAttribute("userLocation"),new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
}
SimpleDateFormat dte=new SimpleDateFormat("dd-MM-YYYY");
Date dt=new Date();
document.add(new Paragraph("Date:"+dte.format(dt),new Font(Font.TIMES_ROMAN,11,Font.BOLD)));
document.add(new Paragraph("List of lands",subfont));
//document.add(new Paragraph("\n"));
document.add(new Paragraph("\n"));
PdfPTable table = new PdfPTable(7);
table.setWidthPercentage(100);
table.addCell(getNormalCell("#","czech",11));
table.addCell(getNormalCell("UPI","czech",11));
table.addCell(getNormalCell("Size","czech",11));
table.addCell(getNormalCell("Location","czech",11));
table.addCell(getNormalCell("Owner","czech",11));
table.addCell(getNormalCell("Telephone","czech",11));
table.addCell(getNormalCell("Email","czech",11));

while(rrs.next())
                              {
                                  n++;
table.addCell(getNormalCell(String.valueOf(n),"greek",10));
table.addCell(getNormalCell(rrs.getString("upi"),"greek",10));
table.addCell(getNormalCell(rrs.getString("size"),"greek",10));
table.addCell(getNormalCell(rrs.getString("location"),"greek",10));
table.addCell(getNormalCell(rrs.getString("name")+" "+rrs.getString("surname"),"greek",10));
table.addCell(getNormalCell(rrs.getString("telephone"),"greek",10));
table.addCell(getNormalCell(rrs.getString("email"),"greek",10));

                       }
                              document.add(table); 
                          //  document.add(new Paragraph("\n"));
document.add(new Paragraph("Total:"+n,new Font(Font.TIMES_ROMAN,11,Font.BOLD)));   
document.close(); 
                              DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
byte[] bytes = buffer.toByteArray();
response.setContentLength(bytes.length);
for(int i = 0; i < bytes.length; i++)
{
dataOutput.writeByte(bytes[i]);
}
response.getOutputStream().flush();
response.getOutputStream().close();
}catch(DocumentException e){
e.printStackTrace();
}
                            
                          }
                          
                         }
                    }
                        catch(Exception e)
                        {
                        session.setAttribute("info","<font color='red'>"+e.toString()+"</font>");
                        response.sendRedirect("dashboard.jsp");
                        return;
                        }

%>
