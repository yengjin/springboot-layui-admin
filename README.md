# 基于SpringBoot与LayUI的后台管理系统
一套SpringBoot+MyBatis+FreeMarker+LayUI的后台管理系统.
适用于**小体量,CRUD业务为主的后台系统快速搭建和学习**. 
在学习过程中发现很多地方网上没有给出一个整套的案例, 因此进行开源.

由于时间仓促, 没有加入权限验证和Redis等功能.但对于SpringBoot+LayUI开发来说是一个很好的例子.

![](https://note.youdao.com/yws/public/resource/58918c59a59ab57824426ac85e456ea7/xmlnote/35F174830F724A89AAC2B1E3BB20B455/4953)
![](https://note.youdao.com/yws/public/resource/58918c59a59ab57824426ac85e456ea7/xmlnote/522EA345E7774CEAA9FC6242FD6ABD7B/4957)
![](https://note.youdao.com/yws/public/resource/58918c59a59ab57824426ac85e456ea7/xmlnote/F8C9999E4F2B4CF58D66E039DB001899/4959)
## 使用方法 How To Use
1. 在MySQL(作者5.7)中创建数据库, 导入admin.sql文件至数据库.
2. 导入Maven工程
3. 修改相关配置application.properties
4. 在userauth表中添加测试帐号
5. 在D盘根目录下创建hrm-upload文件夹,用于文件上传 (可通过配置文件更改)
6. 运行Application.java
7. 访问http://localhost/login 登录即可使用

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

## 通用CRUD类图
![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9ub3RlLnlvdWRhby5jb20veXdzL3B1YmxpYy9yZXNvdXJjZS81ODkxOGM1OWE1OWFiNTc4MjQ0MjZhYzg1ZTQ1NmVhNy94bWxub3RlL0JBRDk2MTY2QkRBRjRERUFBMzRERTkyM0Q0Q0RCQkNFLzQ5MzA?x-oss-process=image/format,png)

注: 登录页面的背景图片引用自知乎首页, 请自行更换.

有任何问题或者建议, 欢迎联系交流!

联系方式: 450298429@qq.com
## Developed By BruceYan
