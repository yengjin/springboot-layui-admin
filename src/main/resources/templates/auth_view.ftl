<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户管理iFrame</title>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body>

<!-- 上方工具栏-->
<script type="text/html" id="auth-insert">
    <form class="layui-form" method="post">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">登录名</label>
            <div class="layui-input-block">
                <input id="post-username" type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input id="post-name" type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input id="post-password" type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">管理员</label>
            <div class="layui-input-block">
                <input type="checkbox" lay-filter="insert_switch" lay-skin="switch" name="close" lay-text="是|否" checked>
            </div>
        </div>
    </form>
</script>

<table class="layui-hide" id="auth-table" lay-filter="auth-table" style="height: 100%"></table>

<script type="text/html" id="isAdminTpl">
    <input type="checkbox" lay-filter="insert_switch" name="close" lay-skin="switch" lay-text="是|否" checked>
</script>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addPost">添加管理员</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>



<script>
    var layerCallback;
    layui.use(['table', 'form'], function(){
        var table = layui.table;
        var form = layui.form;
        table.render({
            elem: '#auth-table',
            url:'/auths',
            toolbar: '#toolbar',
            parseData: function (res) {
                console.log(res);
                return {
                    "code": 0,
                    "msg": "",
                    data: res.data,
                    count: res.size
                }
            }
            ,cols: [[
                <!--{type:'checkbox', fixed:'left'},-->
                {field:'id', width:60, title: 'ID'},
                {field:'username', width:120, title: '登录名', edit: 'text', templet:function (row) {
                        return [
                            '<div>',
                            '<a href="#">' + row.username + '</a>',
                            '</div>'
                        ].join('');
                    }},
                {field:'password', width:150, title: '密码', edit: 'text'},

                {field:'isAdmin', width:130, title: '是否为管理员', templet:function (row) {
                        return [
                            '<input type="checkbox" lay-filter="admin_switch" lay-skin="switch" lay-text="是|否" ',
                            row.isAdmin == true ? "checked />" : " />"
                        ].join('');
                        /*return [
                            '<input type="checkbox" name="admin_switch" id="admin_switch" lay-skin="switch" lay-text="是|否"/>'
                        ].join('');*/
                    }},
                {field:'createdTime', width:180, title: '创建时间', sort: true},
                {fixed: 'right', width:150, align:'center', toolbar: '#barTpl'}
            ]],
            page: true
        });

        var temp;
        form.on('switch(admin_switch)', function (obj) {
            temp = obj.elem.checked;
        });

        //监听工具条(右侧)
        table.on('tool(auth-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'del'){ //删除
                layer.confirm('删除用户' + data.username + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/auths/' + data.id,
                        type: 'delete',
                        success: function (res) {
                            console.log(res);
                            if (res.code == 200) {
                                layer.msg('删除成功', {icon: 1, skin: 'layui-layer-molv', offset:'c'});
                            } else {
                                layer.msg('删除失败', {icon: 2, skin: 'layui-layer-molv', offset:'c'});
                            }
                        }
                    })
                });
            } else if(layEvent === 'edit'){ //编辑
                // 发送更新请求
                $.ajax({
                    url: '/auths/' + data.id,
                    method: 'put',
                    data: JSON.stringify({
                        username: data.username,
                        password: data.password,
                        empId: data.empId,
                        isAdmin: temp == null ? data.isAdmin : temp
                    }),
                    contentType: "application/json",
                    success: function (res) {
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更新成功', {icon: 1});
                            obj.update({
                                username: data.username,
                                password: data.password,
                                empId: data.empId
                            });
                        } else {
                            layer.msg('更新失败', {icon: 2});
                        }
                    }
                });
            }
        });

        /*上方工具栏监听*/
        table.on('toolbar(auth-table)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event) {
                case 'addPost':
                    layerCallback= function(callbackData) {
                        // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                        var dataBak = [];
                        var tableBak = table.cache.auth-table;
                        for (var i = 0; i < tableBak.length; i++) {
                            dataBak.push(tableBak[i]);      //将之前的数组备份
                        }
                        dataBak.push(callbackData);
                        table.reload("auth-table",{
                            data:dataBak   // 将新数据重新载入表格
                        });
                     };
                    layer.open({
                        title: '添加用户',
                        content: 'static/html/layers/auth-insert.html',
                        type: 2,
                        offset: 'c',
                        area: ["500px", "350px"]
                    });
            }
        });
    });
</script>

</body>
</html>