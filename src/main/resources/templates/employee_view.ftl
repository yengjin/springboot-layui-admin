<!-- 员工管理-->
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body>

<!-- 卡片搜索面板-->
<div style="padding: 20px; background-color: #F2F2F2;">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header"><span style="margin-right: 10px; margin-bottom: 2px" class="layui-badge-dot"></span>快速搜索</div>
                <div class="layui-card-body">
                    <div style="margin-bottom: 10px">
                        <label class="layui-form-label">姓名</label>
                        <div class="layui-input-block" style="width: 200px">
                            <input id="search-input-name" type="text" name="title" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div style="margin-bottom: 10px">
                        <label class="layui-form-label">手机</label>
                        <div class="layui-input-block" style="width: 200px">
                            <input id="search-input-phone" type="text" name="title" required  lay-verify="required" placeholder="请输入手机号" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div style="margin-bottom: 10px">
                        <label class="layui-form-label">身份证</label>
                        <div class="layui-input-block" style="width: 200px">
                            <input id="search-input-idcard" type="text" name="title" required  lay-verify="required" placeholder="请输入身份证" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<table class="layui-hide" id="employee-table" lay-filter="employee-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addEmployee">添加员工</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script type="text/html" id="positionTpl">
    <select id="position-select" name="position" lay-verify="required">
        <#if positionList?? && positionList?size gt 0>
            <#list positionList as position>
                <option value=${position.id}
                                {{#if (d.position.id == ${position.id}) { }}
                        selected
                        {{# }}}
                >
                    ${position.name}</option>
            </#list>
        </#if>
    </select>
</script>

<script type="text/html" id="departmentTpl">
    <select id="department-select" name="department" lay-verify="required">
        <#if departmentList?? && departmentList?size gt 0>
            <#list departmentList as department>
                <option value=${department.id}
                                {{#if (d.department.id == ${department.id}) { }}
                        selected
                        {{# }}}
                >
                    ${department.name}</option>
            </#list>
        </#if>
    </select>

</script>

<script type="text/html" id="educationTpl">
    <select id="education-select" name="city" lay-verify="required">
        <#list ["本科", "硕士", "博士"] as education>
            <option value=${education_index}
                            {{#if (d.education == ${education_index?c}) { }}    <#-- 这里需要类型转换?c-->
                    selected
                    {{# }}}
            >
                ${education}</option>
        </#list>
    </select>
</script>

<style type="text/css">
    .layui-table-cell{
        height:36px;
        line-height: 36px;
    }
</style>



<script>

    var tableContent = [];
    layui.use('table', function(){

        var table = layui.table;
        table.render({
            elem: '#employee-table',
            url:'/employees',
            toolbar: '#toolbar',
            parseData: function (res) {
                console.log(res);
                tableContent = res.data;
                return {
                    "code": 0,
                    "msg": "",
                    "count": res.size,
                    data: res.data
                }
            }
            ,cols: [[
                {field:'id', width:30, title: 'ID'},
                {field:'name', width:120, title: '姓名'},
                {field:'sex', width:50, title: '性别', templet:function (row) {
                        return [
                            '<div>',
                            row.sex == 0 ? '男' : '女',
                            '</div>'
                        ].join('');
                    }},
                {field:'phone', width: 120, title:'电话', edit: true},
                {field:'email', width: 160, title:'邮箱', edit: true},
                {field:'education', width: 100, title:'学历', templet: '#educationTpl'},
                {field:'idcard', width: 160, title:'身份证', edit: true},
                <!--{field:'address', width: 140, title:'地址', edit: true},-->
                {field:'position.name', width: 150, title:'职位', templet: '#positionTpl'

                },
                /*{field:'position.name', width: 110, title:'职位', templet: function (d) {
                    if (d.position == null) return "未分配";
                    return d.position.name
                }},*/
                {field:'department.name', width: 120, title:'部门', templet: '#departmentTpl'},
                    /*templet: function (d) {
                        if (d.department == null) return "未分配";
                        return d.department.name
                    }},*/
                {field:'createdTime', width: 120, title: '创建时间', sort: true},
                {fixed: 'right', title: '操作', align:'center', toolbar: '#barTpl'}
            ]]
            ,page: true
            ,done: function (res, curr, count) {
                // 支持表格内嵌下拉框
                $(".layui-table-body, .layui-table-box, .layui-table-cell").css('overflow', 'visible')
                // 下拉框CSS重写 (覆盖父容器的CSS - padding)
                $(".laytable-cell-1-0-5").css("padding", "0px")
                $(".laytable-cell-1-0-7").css("padding", "0px")
                $(".laytable-cell-1-0-8").css("padding", "0px")
                $(".laytable-cell-1-0-5 span").css("padding", "0 10px")
                $(".laytable-cell-1-0-7 span").css("padding", "0 10px")
                $(".laytable-cell-1-0-8 span").css("padding", "0 10px")

                $("td").css("padding", "0px")
            }
        });

        /* 搜索实现, 使用reload, 进行重新请求 */
        $("#search-input-name").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            table.reload("employee-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });
        $("#search-input-phone").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            table.reload("employee-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });
        $("#search-input-idcard").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            table.reload("employee-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });


        table.on('toolbar(employee-table)', function (obj) {
            // 回调函数
            layerCallback= function(callbackData) {
                // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                var dataBak = [];
                var tableBak = table.cache.employee-table;
                for (var i = 0; i < tableBak.length; i++) {
                    dataBak.push(tableBak[i]);      //将之前的数组备份
                }
                // 添加到表格缓存
                dataBak.push(callbackData);
                //console.log(dataBak);
                table.reload("employee-table",{
                    data:dataBak   // 将新数据重新载入表格
                });
            };
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addEmployee':
                    layer.open({
                        title: '新建员工',
                        content: 'static/html/layers/employee-insert.html',
                        type: 2,
                        offset: 't',
                        area: ["500px", "600px"],
                        success: function (layero, index) {
                            var iframe = window['layui-layer-iframe' + index];
                            var departments = [];
                            var positions = [];
                            <!-- 向子页面进行数据传递 (下拉框选项, 及主键 -> 不一定连续)-->
                            <#list positionList as position>
                                positions.push({
                                    'id' : '${position.id}',
                                    'name' : '${position.name}'
                                });
                            </#list>
                            <#list departmentList as department>
                                departments.push({
                                    'id' : '${department.id}',
                                    'name' : '${department.name}'
                                });
                            </#list>
                            var dataDict = {
                                'positions': positions,
                                'departments': departments
                            };
                            iframe.child(dataDict);
                        }
                    });
            }
        });

        //监听工具条(右侧)
        table.on('tool(employee-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'edit'){ //编辑
                console.log($("#department-select").val());
                // 发送更新请求
                $.ajax({
                    url: '/employees',
                    method: 'put',
                    data: JSON.stringify({
                        id: data.id,
                        phone: data.phone,
                        email: data.email,
                        education: $("#education-select").val(),
                        idcard: data.idcard,
                        address: data.address,
                        positionId: $("#position-select").val(),
                        departmentId: $("#department-select").val()
                    }),
                    contentType: "application/json",

                    success: function (res) {
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更改员工信息成功', {icon: 1});
                            obj.update({
                                phone: data.phone,
                                email: data.email,
                                idcard: data.idcard,
                                address: data.address
                            });
                        } else {
                            layer.msg('更改员工信息失败', {icon: 2});
                        }
                    }
                });
            } else if (layEvent == 'del') {
                layer.confirm('删除员工' + data.name + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/employees/' + data.id,
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
            }
        });
    });
</script>
</body>
</html>