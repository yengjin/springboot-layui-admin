# 基于SpringBoot与LayUI的后台管理系统
一套SpringBoot+MyBatis+FreeMarker+LayUI的后台管理系统.

## 特色/解决的一些问题:
### 后端:
- 抽取CRUD公共业务层和DAO, 结合反射, 实现了CRUD抽取(继承即可调用)
- 使用SqlSessionTemplate进行Mapper查找和执行
- 遵循RestFul API设计规范, 前后端分离
- Interceptor+Session检查登录状态
### 前端:
- Layui数据表格内嵌下拉框问题
- Layer弹窗Form组件渲染不出来的问题(使用回调函数)
- Layui数据表格分页问题
- 实时模糊匹配查询/数据表格重新渲染
- Layui+SpringBoot文件下载
## 包含模块:
- 权限管理
- 部门管理
- 职位管理
- 员工管理
- 部门管理
- 下载中心

## Developed By BruceYan
