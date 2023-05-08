<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="loginHtml">
<head>
	<meta charset="utf-8">
	<title>茂茂</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="icon" href="/HangCaiCarRental/resources/favicon.ico">
	<link rel="stylesheet" href="/HangCaiCarRental/resources/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="/HangCaiCarRental/resources/css/public.css" media="all" />
</head>
<body class="loginBody">

	<form class="layui-form" id="loginFrm" method="post" action="/HangCaiCarRental/login/passwordLogin">

		<br>
			<h3 align="center" id="title" style="color:#6e54a6 ; font-size: 36px;text-align:center;">航财汽车租赁管理系统</h3>
		<br>


		<div class="layui-form-item input-item">
			<label for="loginname">工号</label>
			<input type="text" placeholder="请输入工号" autocomplete="off" name="jobId" id="loginname" class="layui-input" lay-verify="required">
		</div>

		<div class="layui-form-item input-item" id="password-item">
			<label for="employeePassword">密码</label>
			<input type="password" placeholder="请输入密码" autocomplete="off" name="employeePassword" id="employeePassword" class="layui-input" lay-verify="required">

			<!-- 小眼睛部分新加内容 -->
			<button id="toggle-password-visibility" aria-label="切换密码可见性"></button>
			<i class="fa-eye fa-eye-slash"></i>
		</div>
		<!-- 明文显示的js -->
		<script>
			var passwordInput = document.getElementById('employeePassword');
			var togglePasswordBtn = document.getElementById('toggle-password-visibility');

			togglePasswordBtn.addEventListener('click', function () {
				if (passwordInput.type === 'password') {
					passwordInput.type = 'text';
					togglePasswordBtn.setAttribute('aria-label', '隐藏密码');
				} else {
					passwordInput.type = 'password';
					togglePasswordBtn.setAttribute('aria-label', '显示密码');
				}
			});
		</script>
		<script>
			$(".layui-form-item input-item").on("click", ".fa-eye-slash", function () {
				$(this).removeClass("fa-eye-slash").addClass("fa-eye");
				$(this).prev().attr("type", "text");
			});

			$(".layui-form-item input-item").on("click", ".fa-eye", function () {
				$(this).removeClass("fa-eye").addClass("fa-eye-slash");
				$(this).prev().attr("type", "password");
			});
		</script>


		<div class="layui-form-item input-item" id="imgCode">
			<label for="code">验证码</label>
			<input type="text" placeholder="请输入验证码" autocomplete="off" name="code" id="code" class="layui-input" lay-verify="required">
			<img src="/HangCaiCarRental/login/getImageCaptcha" onclick="this.src=this.src+'?'">
		</div>

		<div class="layui-form-item">
			<button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
		</div>

		<div class="layui-more-tips-warp">
			<span class="layui-more-tips-warp-left"></span>
			<span class="layui-login-wal1">其他登陆方式</span>
			<span class="layui-more-tips-warp-right"></span>
		</div>

		<div class=layui-toggle-btn>
			<!-- 或使用按钮实现页面跳转 -->
			<!-- <button type="button" class="toggle-btn">邮箱登录</button> -->
			<style>
				a {
					text-decoration: none;
				}
			</style>
			<!-- 现在使用<a>标签进行页面跳转 -->
			<a href="login_by_email.html" class="layui-toggle-btn1">邮箱登录</a>
		</div>

		<div class="layui-form-item layui-row" style="text-align: center;color: red;">
		</div>
	</form>
	<script type="text/javascript" src="/HangCaiCarRental/resources/layui/layui.js"></script>
	<script type="text/javascript" src="/HangCaiCarRental/resources/js/cache.js"></script>
	<script type="text/javascript">
	layui.use(['form','layer','jquery'],function(){
	    var form = layui.form,
	        layer = parent.layer === undefined ? layui.layer : top.layer
	        $ = layui.jquery;
	    //登录按钮
	    form.on("submit(login)",function(data){
	        $(this).text("登录中...").attr("disabled","disabled").addClass("layui-disabled");
	        setTimeout(function(){
	           $("#loginFrm").submit();
	        },1000);
	        return false;
	    })

	    //表单输入效果
	    $(".loginBody .input-item").click(function(e){
	        e.stopPropagation();
	        $(this).addClass("layui-input-focus").find(".layui-input").focus();
	    })
	    $(".loginBody .layui-form-item .layui-input").focus(function(){
	        $(this).parent().addClass("layui-input-focus");
	    })
	    $(".loginBody .layui-form-item .layui-input").blur(function(){
	        $(this).parent().removeClass("layui-input-focus");
	        if($(this).val() != ''){
	            $(this).parent().addClass("layui-input-active");
	        }else{
	            $(this).parent().removeClass("layui-input-active");
	        }
	    })
	})

	</script>
</body>
</html>