<%@ page import="javax.naming.*,javax.sql.*,java.sql.*" %>
<html>
<body>
<h2>Edit User</h2>

<%
Context initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
DataSource ds = (DataSource) envCtx.lookup("jdbc/testdb");
Connection conn = ds.getConnection();

String id = request.getParameter("id");

if(request.getParameter("name") != null) {
    PreparedStatement ps = conn.prepareStatement(
        "UPDATE users SET name=?, email=? WHERE id=?"
    );
    ps.setString(1, request.getParameter("name"));
    ps.setString(2, request.getParameter("email"));
    ps.setInt(3, Integer.parseInt(id));
    ps.executeUpdate();

    out.println("Updated!");
}

PreparedStatement ps2 = conn.prepareStatement(
    "SELECT * FROM users WHERE id=?"
);
ps2.setInt(1, Integer.parseInt(id));
ResultSet rs = ps2.executeQuery();

if(rs.next()) {
%>

<form method="post">
Name: <input type="text" name="name" value="<%=rs.getString("name")%>"/><br>
Email: <input type="text" name="email" value="<%=rs.getString("email")%>"/><br>
<input type="submit" value="Update"/>
</form>

<%
}
conn.close();
%>

</body>
</html>
