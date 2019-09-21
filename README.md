# inpector
* 项目技术栈 SSM
* maven
* IDEA
* 面向切面
* 接口编程。


### 计划
* 分页加载
* 目前还是jsp，后期计划采用jQuery，ajax技术前后端分离。采用前端框架，Thymeleaf

### 项目构建
```shell
 mvn clean package -Dmaven.test.skip=true -Pprod
```


* 2019/09/21 开始重构inspector模块，完成log4j到log4j2的升级改造，并且升级了下mybatis。
* 2019/09/11 customer模块重构完成
* 2019/09/10 项目重构开始