<%@ page import="javax.naming.*,javax.sql.*,java.sql.*" %>
<html>
<body>
<h2>User List</h2>

<table border="1">
<tr><th>ID</th><th>Name</th><th>Email</th></tr>

<%
Context initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
DataSource ds = (DataSource) envCtx.lookup("jdbc/testdb");
Connection conn = ds.getConnection();

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM users");

while(rs.next()) {
%>
<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("email") %></td>

<td>
<a href="edit.jsp?id=<%=rs.getInt("id")%>">Edit</a>
<a href="delete.jsp?id=<%=rs.getInt("id")%>">Delete</a>
</td>
</tr>
<%
}
conn.close();
%>

</table>

</body>
</html>
