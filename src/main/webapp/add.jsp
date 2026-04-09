<%@ page import="javax.naming.*,javax.sql.*,java.sql.*" %>
<html>
<body>
<h2>Add User</h2>

<form method="post">
Name: <input type="text" name="name"/><br>
Email: <input type="text" name="email"/><br>
<input type="submit" value="Add"/>
</form>

<%
if(request.getParameter("name") != null) {
    Context initCtx = new InitialContext();
    Context envCtx = (Context) initCtx.lookup("java:comp/env");
    DataSource ds = (DataSource) envCtx.lookup("jdbc/testdb");
    Connection conn = ds.getConnection();

    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO users(name,email) VALUES (?,?)"
    );
    ps.setString(1, request.getParameter("name"));
    ps.setString(2, request.getParameter("email"));
    ps.executeUpdate();

    out.println("User Added!");
    conn.close();
}
%>

</body>
</html>
