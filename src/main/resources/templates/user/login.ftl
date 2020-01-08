<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/layui/layui.js"></script>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
</head>

<style>
    body {
        background-image: url("/static/images/main-back.png");
        background-repeat: no-repeat;
        background-size: 100% 150%;
        background-attachment: fixed;
    }
    .main-div {
    }
</style>

<script>
    doLogin = function() {
        layui.use('layer', function () {
            var username = $("#username").val();
            var password = $("#password").val();
            if ($("#username").val().trim().length <= 0) {
                layer.tips('帐号不能为空', '#username', {
                    tipsMore: true
                });
            }
            if ($("#password").val().trim().length <= 0) {
                layer.tips('密码不能为空', '#password', {
                    tipsMore: true
                });
            }
            if ($("#username").val().trim().length <= 0 || $("#password").val().trim().length <= 0) {
                return false;
            }
            $.ajax({
                url: '/auths/login',
                method: 'post',
                data: {
                    username: username,
                    password: password
                },
                success: function (res) {
                    console.log(res);
                    if (res.code == 200) {
                        parent.window.location.href = "/index";
                    } else {
                        parent.window.location.href = "/login";
                    }
                    //parent.window.location.href = "/";
                }
            });
        });

    }
    $(document).ready(function () {
        $("#reset").click(function () {
            $("input[name='username']").val("");
            $("input[name='password']").val("");
        });
        $("#login").click(function () {
            doLogin();
        });
        $(document).keyup(function (event) {
            if (event.keyCode == 13) {
                doLogin();
            }
        })
    });

</script>

<body>
<div class="main-div">
    <div class="layui-layout layui-layout-admin" style="height: 100%">
        <div class="layui-header" style="background-color: #2066CE">
            <div style="padding-left: 5px; width: 600px; height: 60px">
                <!-- 在这里替换具体的LOGO和标语 -->
                <img width="120px" src="static/images/logos/diandian-logo.png" style="float: left; margin-top: 5px">
                <!-- color:#009688-->
                <div style="color: #E6E6E6; margin-left:20px;float:left;width:300px;height:100%;line-height:60px;text-align:left;font-size:16px;">SpringBoot+LayUI后台管理系统</div>
            </div>

            <ul class="layui-nav layui-layout-right" style="background-color: #2066CE">
                <li class="layui-nav-item">
                    <a id="name-a" href="javascript:;">
                        <img src="static/images/icons/diandian-icon.png" class="layui-nav-img">
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="">基本资料</a></dd>
                        <dd><a href="">更改密码</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="http://diandian2.cn">点点OJ</a></li>
            </ul>
        </div>
    </div>
    <div style="opacity: 0.9; position: absolute; background: #FFFFFF;border-radius: 10px;left: 50%; width: 450px; height: 300px; margin-left: -250px; margin-top: 100px; padding-left: 40px; padding-top: 50px;box-shadow: 0 0 10px 3px #a9a2a0">
        <div style="text-align: center; font-size: 20px; margin-right: 50px; margin-bottom: 30px">登录</div>
        <div class="layui-form">
            <div class="layui-form-item" style="font-size: 16px; opacity: 1">
                <label class="layui-form-label" style="width: 100px; margin-bottom: 10px">帐号</label>
                <div class="layui-input-inline" style="width: 200px">
                    <input type="text" id="username" required  lay-verify="required" placeholder="请输入帐号" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item" style="font-size: 16px; margin-bottom: 30px; opacity: 1">
                <label class="layui-form-label" style="width: 100px">密码</label>
                <div class="layui-input-inline" style="width: 200px">
                    <input type="password" id="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" style="font-size: 16px; margin-left: 5px; margin-top: 10px">
                <label class="layui-form-label" style="width: 100px"></label>
                <div class="layui-input-inline" style="width: 200px">
                    <button type="submit" class="layui-btn" style="background-color: #0084ff; outline: none" id="login" lay-submit="">登录</button>
                    <button type="button" class="layui-btn" style="background-color: #0084ff; outline: none" id="reset">重置</button>
                </div>
            </div>
        </div>
    </div>

</div>
<div style="color: black;font-size: 18px; position: fixed; bottom: 20px; right: 20px" class="layui-footer">
    © Copyright BruceYan
</div>


</body>
</html>
