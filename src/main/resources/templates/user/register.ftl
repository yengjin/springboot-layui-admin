<!DOCTYPE html>
<html>
<head>
    <title>注册</title>
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/layui/layui.js"></script>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css" />
    <script src="/static/js/bootstrap.min.js"></script>
</head>

<script>
    $(document).ready(function () {
        $("#reset").click(function () {
            $("input[name='username']").val("");
            $("input[name='password']").val("");
            $("input[name='nickname']").val("");
        });
    });

</script>

<div style="position: absolute; border-radius: 10px;left: 50%; width: 450px; height: 350px; margin-left: -220px; margin-top: 150px; padding-left: 50px; padding-top: 50px;box-shadow: 0 0 10px 3px #a9a2a0">
    <form class="layui-form" action="/user/create" method="post">
        <div style="text-align: center; font-size: 20px; margin-right: 50px; margin-bottom: 20px">注册</div>
        <div class="layui-form-item" style="font-size: 16px">
            <label class="layui-form-label" style="width: 100px">学号</label>
            <div class="layui-input-inline" style="width: 200px">
                <input type="text" name="username" required lay-verify="required" placeholder="请输入学号" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="font-size: 16px">
            <label class="layui-form-label" style="width: 100px">用户名</label>
            <div class="layui-input-inline" style="width: 200px">
                <input type="text" name="nickname" required lay-verify="required" placeholder="专业班级,如:计科191XXX"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="font-size: 16px">
            <label class="layui-form-label" style="width: 100px">密码</label>
            <div class="layui-input-inline" style="width: 200px">
                <input type="password" name="password" required lay-verify="required" placeholder="请输入密码"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="font-size: 16px">
            <label class="layui-form-label" style="width: 100px"></label>
            <div class="layui-input-inline" style="width: 200px">
                <button type="submit" class="layui-btn" style="outline: none">注册</button>
                <button type="button" class="layui-btn" style="outline: none" id="reset">重置</button>
            </div>
        </div>

    </form>
</div>
</body>
</html>
