<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
</head>
<body>
    <h1>Change Password</h1>
    <form action="ChangePasswordServlet" method="post">
        <input type="hidden" name="accountno" value="${param.accountno}">
        <label for="newpassword">New Password:</label>
        <input type="password" id="newpassword" name="newpassword" required><br><br>
        <input type="submit" value="Change Password">
    </form>
</body>
</html>
