<!-- 后台管理系统问题列表-->
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="../static/js/jquery-3.4.1.min.js"></script>
    <script src="../static/layui/layui.js"></script>
    <link rel="stylesheet" href="../static/layui/css/layui.css">
</head>
<body>

<script type="text/html" id="post-update">
    <form class="layui-form" method="post">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input id="update-title" type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">内容</label>
            <div class="layui-input-block">
                <textarea id="update-content" name="desc" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
    </form>
</script>

<script type="text/html" id="post-insert">
    <form class="layui-form" method="post">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input id="post-title" type="text" name="title" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">内容</label>
            <div class="layui-input-block">
                <textarea id="post-content" name="desc" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
    </form>

</script>

<script type="text/html" id="post-detail">
    <form class="layui-form" method="post">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input id="post-detail-title" type="text" name="title" required  lay-verify="required" placeholder="请输入职位, 如: Java开发工程师" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">内容</label>
            <div class="layui-input-block">
                <textarea id="post-detail-content" name="content" placeholder="暂无内容" class="layui-textarea"></textarea>
            </div>
        </div>

    </form>
</script>
<table class="layui-hide" id="post-table" lay-filter="post-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addPost">添加公告</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>

    var layerCallback;
    var json;
    function layerFunc(row) {
        layer.open({
            title: "公告 " + row.title,
            content: '#post-detail',
            offset: 'c',
            area: ["500px", "300px"],
            success: function (layero, index) {
                $("#post-detail-title").val(row.title);
                $("#post-detail-content").val(row.content);
            }
        });
    };
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#post-table',
            url:'/posts/',
            toolbar: '#toolbar',
            parseData: function (res) {
                console.log(res);
                return {
                    "code": 0,
                    "msg": "",
                    "count": res.size,
                    data: res.data
                }
            }
            ,cols: [[
                {field:'id', width:60, title: 'ID'},
                {field:'title', width:200, title: '公告名称', templet: function (row) {
                        return row.title;
                    }},
                {field:'content', width:400, title:'公告内容'},
                {field:'username', width:150, title: '公告人', templet: function (row) {
                        if (row.username == null ) return "无此用户";
                        return row.username;
                    }},
                {field:'createdTime', width:180, title: '创建时间', sort: true},

                {fixed: 'right', width:150, align:'center', toolbar: '#barTpl'}
            ]]
            ,page: true
        });



        //监听工具条(右侧)
        table.on('tool(post-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'del'){ //删除
                layer.confirm('删除公告' + data.title + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/posts/' + data.id,
                        type: 'delete',
                        success: function (res) {
                            console.log(res);
                            if (res.code == 200) {
                                layer.msg('删除成功', {icon: 1, skin: 'layui-layer-molv', offset:'c'});
                                // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                                var dataBak = [];
                                var tableBak = table.cache.post-table;
                                for (var i = 0; i < tableBak.length; i++) {
                                    if (dataBak[i].id != data.id) dataBak.push(tableBak[i]);      //将之前的数组备份
                                }
                                //console.log(dataBak);
                                table.reload("post-table",{
                                    data:dataBak   // 将新数据重新载入表格
                                });
                            } else {
                                layer.msg('删除失败', {icon: 2, skin: 'layui-layer-molv', offset:'c'});
                            }
                        }
                    })
                });
            } else if(layEvent === 'edit'){ //编辑
                // 定义回调函数(子容器执行AJAX)
                layerCallback = function(postTitle, postContent) {
                    // 子容器回调, 执行缓存刷新
                    obj.update({
                        title: postTitle,
                        content: postContent
                    });
                    layer.close(layer.index);
                };
                json = JSON.stringify(obj.data);
                layer.open({
                    title: '编辑公告',
                    content: 'static/html/layers/post-update.html',
                    type: 2,
                    //content: $("#post-insert").text(),

                    offset: 'c',
                    area: ["500px", "300px"]
                });
            }
        });

        table.on('toolbar(post-table)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addPost':

                    layer.open({
                        title: '新建公告',
                        content: $("#post-insert").text(),
                        offset: 'c',
                        area: ["500px", "300px"],
                        yes: function () {
                            var title = $("#post-title").val();
                            var content = $("#post-content").val();
                            if (title.length <= 0  || content.length <= 0) {
                                if (title.length <= 0) {
                                    layer.tips('标题不能为空', '#post-title',  {
                                        tipsMore: true
                                    });
                                }
                                if (content.length <= 0) {
                                    layer.tips('内容不能为空', '#post-content', {
                                        tipsMore: true
                                    });
                                }
                            } else {
                                // 调用新建API
                                var nowDate = new Date();
                                // 获取session中数据
                                var username = "${(user.username)!'未登陆'}";
                                $.ajax({
                                    url: '/posts',
                                    method: 'post',
                                    data: {
                                        title: title,
                                        content: content,
                                        username: username,
                                        createdTime: nowDate
                                    },
                                    success: function (res) {
                                        console.log(res);
                                        if (res.code == 200) {
                                            // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                                            var dataBak = [];
                                            var tableBak = table.cache.post-table;
                                            for (var i = 0; i < tableBak.length; i++) {
                                                dataBak.push(tableBak[i]);      //将之前的数组备份
                                            }
                                            dataBak.push({
                                                title: $("#post-title"),
                                                content: $("#post-content"),
                                                username: username,
                                                createdTime: nowDate
                                            });
                                            //console.log(dataBak);
                                            table.reload("post-table",{
                                                data:dataBak   // 将新数据重新载入表格
                                            });
                                            layer.msg('新建公告成功', {icon: 1});
                                        } else {
                                            layer.msg('新建公告失败', {icon: 2});
                                        }
                                    }
                                });
                            }
                        }
                    });
            }
        })
    });
</script>
</body>
</html>