%% MySQL数据库导入数据示例代码

% 初始化参数
clear;
sqlquery = 'select u.user,u.password,u.host from user u'; % 查询脚本
dbname='mysql'; % 数据库名称
username='fansy';
password='fansy';
host = 'localhost';
dpath='D:\Program Files\MySQL\Connector J 5.1.25\mysql-connector-java-5.1.25-bin.jar'; % MySQL驱动路径
datafile = '../tmp/user.xls'; % 数据保存路径

%% 连接数据库并查询
javaaddpath(dpath);
conn = database(dbname,username,password,'Vendor','MySQL',...
          'Server',host); % 连接数据库
curs = exec(conn,sqlquery); % 执行查询
setdbprefs('DataReturnFormat','cellarray') % 设置数据格式
curs = fetch(curs); % 获取数据

%% 保存数据
data = curs.data;  % 获取数据 
xlswrite(datafile,data); % 数据写入EXCEL