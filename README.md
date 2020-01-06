# 基于SpringBoot与LayUI的后台管理系统
一套SpringBoot+MyBatis+FreeMarker+LayUI的后台管理系统.
适用于**小体量,CRUD业务为主的后台系统快速搭建和学习**. 
在学习过程中发现很多地方网上没有给出一个整套的案例, 因此想和众多大神们一起讨论共同进步.

由于时间仓促, 没有加入权限验证和Redis等功能.但对于SpringBoot+LayUI开发来说是一个很好的小例子.

![](https://note.youdao.com/yws/public/resource/58918c59a59ab57824426ac85e456ea7/xmlnote/007965B6D0714609B17C891FB951CB05/4938)
![](https://note.youdao.com/yws/public/resource/58918c59a59ab57824426ac85e456ea7/xmlnote/F96F700BCBB5484E9C91AD0D4EC6BB65/4937)
## 使用方法 How To Use
1. 创建数据库hrm, 导入hrm.sql文件至数据库.
2. 导入Maven工程
3. 运行Application.java
4. 在userauth表中添加帐号
5. 在D盘根目录下创建hrm-upload文件夹,用于文件上传 (可通过配置文件更改)
5. 访问http://localhost/login 登录即可使用

## 特色/解决的一些问题:
### 后端:
- 抽取CRUD公共业务层和DAO, 结合反射, 实现了公共CRUD抽取(继承+Mapper配置即可使用)
- 使用SqlSessionTemplate进行Mapper查找和执行
- 遵循RestFul API设计规范, 结合FreeMarker进行前后端分离
- Interceptor+Session检查登录状态

### 前端:
- iframe实现页面局部刷新
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

注: 登录页面的背景图片引用自知乎首页, 请自行更换
## Developed By BruceYan
