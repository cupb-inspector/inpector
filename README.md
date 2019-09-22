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
##### 安装，自己的包依赖
```shell
mvn install
```
##### 打包
```shell
mvn clean package -Dmaven.test.skip=true -Pprod
```
##### 依赖分析，解决冲突
```
mvn dependency:tree -Dverbose
```
参考：[maven 依赖jar包时版本冲突的解决：mvn dependency:tree -Dverbose](https://cloud.tencent.com/developer/article/1188322)
##### 强制更新
```jshelllanguage
mvn clean install -e -U
```
参考解决：[IDEA的右侧maven报红](https://blog.csdn.net/dongchen2017/article/details/77157508)

### log

* 2019/09/21 开始重构inspector模块，完成log4j到log4j2的升级改造，并且升级了下mybatis。
* 2019/09/11 customer模块重构完成
* 2019/09/10 项目重构开始