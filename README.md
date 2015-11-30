#JavaEEScaffold-----java web 脚手架搭建(用户角色权限管理系统)
##项目地址
[JavaEEScaffold](https://github.com/Vino007/javaEEScaffold)
用户名：admin
密码：1111
数据库文件：javaEEScaffold.sql
##项目介绍
* 在开发中经常会遇到需要设计不同用户的权限，为了方便使用，这个通用java web开发的框架就诞生了。本项目参考了[开涛的blog](http://jinnianshilongnian.iteye.com/)中介绍的一些技术，如shiro，es项目。
* 该项目实现了对用户的管理，角色管理，资源(权限)管理，以及对用户进行分配角色，对角色分配资源(权限)。
* 采用shiro来做权限验证，采用Druid来做数据库的监控
* 基本框架spring+springmvc+spring-jpa，几乎用的都是spring。
* 前端还是使用的jsp页面


##技术选型
* 容器框架:spring
* mvc:spring mvc
* 持久层:spring data jpa+hibernate jpa
* 数据库:mysql
* 数据库连接池、监控:druid
* 安全框架:shiro
* 前端:bootstrap，ZTree，Jquery，主题采用[adminLTE](https://www.almsaeedstudio.com/themes/AdminLTE/documentation/index.html#dependencies)
* json框架：fastjson
* 数据校验框架：jquery-validate
* 日志系统：门面slf4j,实现log4j
* 代码构建工具：gradle
* 版本控制：git
* excel解析:jxl

##功能设计
* 实现用户角色权限管理(基于资源(权限)的角色管理)✔
* 系统监控日志 druid的监控功能,github上有文档  ✔
* 根据用户拥有的资源动态生成侧边栏（即资源(权限),只使用单层目录）✔
* java mail





