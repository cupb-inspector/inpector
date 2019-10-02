mvn clean package -Dmaven.test.skip=true -Pbeta
scp inspector/target/inspector.war  root@119.23.236.94:/home/apache-tomcat-9.0.19/webapps
scp admin/target/admin.war root@119.23.236.94:/home/apache-tomcat-9.0.19/webapps
scp customer/target/customer.war root@119.23.236.94:/home/apache-tomcat-9.0.19/webapps
# ssh root@119.23.236.94 sh /home/apache-tomcat-9.0.19/bin/shutdown.sh
# ssh root@119.23.236.94 sh /home/apache-tomcat-9.0.19/bin/startup.sh