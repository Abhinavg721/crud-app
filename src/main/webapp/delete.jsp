<%@ page import="javax.naming.*,javax.sql.*,java.sql.*" %>
<%
Context initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
DataSource ds = (DataSource) envCtx.lookup("jdbc/testdb");
Connection conn = ds.getConnection();

String id = request.getParameter("id");

PreparedStatement ps = conn.prepareStatement(
    "DELETE FROM users WHERE id=?"
);
ps.setInt(1, Integer.parseInt(id));
ps.executeUpdate();

conn.close();

response.sendRedirect("view.jsp");
%>
