<!-- 部门管理-->
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body>

<script type="text/html" id="position-insert">
    <form class="layui-form" method="post">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">职位名称</label>
            <div class="layui-input-block">
                <input id="position-name" type="text" name="name" required  lay-verify="required" placeholder="请输入职位, 如: Java开发工程师" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">职位描述</label>
            <div class="layui-input-block">
                <textarea id="position-description" name="description" placeholder="请输入描述, 如: 996" class="layui-textarea"></textarea>
            </div>
        </div>

    </form>

</script>

<table class="layui-hide" id="position-table" lay-filter="position-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addPosition">添加职位</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#position-table',
            url:'/positions',
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
                {field:'id', width:80, title: 'ID'},
                {field:'name', width:150, title: '职位名称', edit: true},
                {field:'description', width:200, title:'职位描述', edit: true},
                {field:'createdTime', width:180, title: '创建时间', sort: true},
                {fixed: 'right', width:150, align:'center', toolbar: '#barTpl'}
            ]]
            ,page: true
        });

        table.on('toolbar(position-table)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addPosition':
                    layer.open({
                        title: '添加职位',
                        content: $("#position-insert").text(),
                        offset: 'c',
                        area: ["500px", "300px"],
                        yes: function () {
                            var name = $("#position-name").val();
                            var description = $("#position-description").val();
                            if (name.length <= 0  || description.length <= 0) {
                                if (name.length <= 0) {
                                    layer.tips('职位名称不能为空', '#position-name',  {
                                        tipsMore: true
                                    });
                                }
                                if (description.length <= 0) {
                                    layer.tips('职位描述不能为空', '#position-description', {
                                        tipsMore: true
                                    });
                                }
                            } else {
                                // 调用新建API
                                var nowDate = new Date();
                                $.ajax({
                                    url: '/positions',
                                    method: 'post',
                                    data: {
                                        name: name,
                                        description: description,
                                        createdTime: nowDate
                                    },
                                    success: function (res) {
                                        console.log(res);
                                        if (res.code == 200) {
                                            // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                                            var dataBak = [];
                                            var tableBak = table.cache.position-table;
                                            for (var i = 0; i < tableBak.length; i++) {
                                                dataBak.push(tableBak[i]);      //将之前的数组备份
                                            }
                                            dataBak.push({
                                                name: $("#dept-name"),
                                                description: $("#dept-description"),
                                                createdTime: nowDate
                                            });
                                            //console.log(dataBak);
                                            table.reload("position-table",{
                                                data:dataBak   // 将新数据重新载入表格
                                            });
                                            layer.msg('新建职位成功', {icon: 1});
                                        } else {
                                            layer.msg('新建职位失败', {icon: 2});
                                        }
                                    }
                                });
                            }
                        }
                    });
            }
        });


        //监听工具条(右侧)
        table.on('tool(position-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'del'){ //删除
                layer.confirm('删除用户' + data.name + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/positions/' + data.id,
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
                    url: '/positions',
                    method: 'put',
                    data: JSON.stringify({
                        id: data.id,
                        name: data.name,
                        description: data.description
                    }),
                    contentType: "application/json",
                    success: function (res) {
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更新成功', {icon: 1});
                            obj.update({
                                name: data.name,
                                description: data.description
                            });
                        } else {
                            layer.msg('更新失败', {icon: 2});
                        }
                    }
                });
            }
        });


    });
</script>
</body>
</html>