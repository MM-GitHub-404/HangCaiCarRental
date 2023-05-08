<%--
  Created by IntelliJ IDEA.
  User: mm
  Date: 2022/11/11
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type="text/javascript">
    function reloadPage3() {
        parent.location.reload();
    }
</script>
<div style="color: #e60000;size: 40px;font-size: 40px">已在其他位置登录，请重新登录</div>
<button type="button" value="刷星3" name="abc" onclick="reloadPage3()" style="size: 110px;color: #b563ed">重新登录</button>
</body>
</html>
