# Enterprise Computing - **Project 4**

## How to compile:

```cmd
$ javac -cp /usr/local/apache-tomcat-10.0.27/lib/servlet-api.jar:/Library/Java/mysql-connector-j-8.0.31/mysql-connector-j-8.0.31.jar $(find . -name '*.java')
```

### ...then run your apache tomcat server with:

```cmd
$ bash /usr/local/apache-tomcat-10.0.27/bin/startup.sh
```

### and to shutdown:

```cmd
$ bash /usr/local/apache-tomcat-10.0.27/bin/shutdown.sh
```
