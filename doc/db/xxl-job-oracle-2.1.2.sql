-- Create table
create table XXL_JOB_GROUP
(
  id           INTEGER not null,
  app_name     VARCHAR2(64) not null,
  title        NVARCHAR2(32) not null,
  order_sort   INTEGER not null,
  address_type INTEGER not null,
  address_list NVARCHAR2(1024)
);
-- Add comments to the columns 
comment on column XXL_JOB_GROUP.app_name
  is '执行器AppName';
comment on column XXL_JOB_GROUP.title
  is '执行器名称';
comment on column XXL_JOB_GROUP.order_sort
  is '排序';
comment on column XXL_JOB_GROUP.address_type
  is '执行器地址类型：0=自动注册、1=手动录入';
comment on column XXL_JOB_GROUP.address_list
  is '执行器地址列表，多地址逗号分隔';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_GROUP
  add primary key (ID);


-- Create table
create table XXL_JOB_INFO
(
  id                        INTEGER not null,
  job_group                 INTEGER not null,
  job_cron                  NVARCHAR2(128) not null,
  job_desc                  NVARCHAR2(1024) not null,
  add_time                  DATE,
  update_time               DATE,
  author                    VARCHAR2(64),
  alarm_email               NVARCHAR2(1024),
  executor_route_strategy   VARCHAR2(64),
  executor_handler          NVARCHAR2(1024),
  executor_param            NVARCHAR2(1024),
  executor_block_strategy   VARCHAR2(64),
  executor_timeout          INTEGER not null,
  executor_fail_retry_count INTEGER not null,
  glue_type                 VARCHAR2(64) not null,
  glue_source               CLOB,
  glue_remark               NVARCHAR2(128),
  glue_updatetime           DATE,
  child_jobid               NVARCHAR2(1024),
  trigger_status            INTEGER not null,
  trigger_last_time         NUMBER not null,
  trigger_next_time         NUMBER not null
);
-- Add comments to the columns 
comment on column XXL_JOB_INFO.job_group
  is '执行器主键ID';
comment on column XXL_JOB_INFO.job_cron
  is '任务执行CRON';
comment on column XXL_JOB_INFO.author
  is '作者';
comment on column XXL_JOB_INFO.alarm_email
  is '报警邮件';
comment on column XXL_JOB_INFO.executor_route_strategy
  is '执行器路由策略';
comment on column XXL_JOB_INFO.executor_handler
  is '执行器任务handler';
comment on column XXL_JOB_INFO.executor_param
  is '执行器任务参数';
comment on column XXL_JOB_INFO.executor_block_strategy
  is '阻塞处理策略';
comment on column XXL_JOB_INFO.executor_timeout
  is '任务执行超时时间，单位秒';
comment on column XXL_JOB_INFO.executor_fail_retry_count
  is '失败重试次数';
comment on column XXL_JOB_INFO.glue_type
  is 'GLUE类型';
comment on column XXL_JOB_INFO.glue_source
  is 'GLUE源代码';
comment on column XXL_JOB_INFO.glue_remark
  is 'GLUE备注';
comment on column XXL_JOB_INFO.glue_updatetime
  is 'GLUE更新时间';
comment on column XXL_JOB_INFO.child_jobid
  is '子任务ID，多个逗号分隔';
comment on column XXL_JOB_INFO.trigger_status
  is '调度状态：0-停止，1-运行';
comment on column XXL_JOB_INFO.trigger_last_time
  is '上次调度时间';
comment on column XXL_JOB_INFO.trigger_next_time
  is '下次调度时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_INFO
  add primary key (ID);


-- Create table
create table XXL_JOB_LOCK
(
  lock_name VARCHAR2(64) not null
);
-- Add comments to the columns 
comment on column XXL_JOB_LOCK.lock_name
  is '锁名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOCK
  add primary key (LOCK_NAME)
;

-- Create table
create table XXL_JOB_LOG
(
  id                        NUMBER not null,
  job_group                 INTEGER not null,
  job_id                    INTEGER not null,
  executor_address          NVARCHAR2(1024),
  executor_handler          NVARCHAR2(1024),
  executor_param            NVARCHAR2(1024),
  executor_sharding_param   NVARCHAR2(32),
  executor_fail_retry_count INTEGER,
  trigger_time              DATE,
  trigger_code              INTEGER,
  trigger_msg               CLOB,
  handle_time               DATE,
  handle_code               INTEGER,
  handle_msg                CLOB,
  alarm_status              INTEGER
);
-- Add comments to the columns 
comment on column XXL_JOB_LOG.job_group
  is '执行器主键ID';
comment on column XXL_JOB_LOG.job_id
  is '任务，主键ID';
comment on column XXL_JOB_LOG.executor_address
  is '执行器地址，本次执行的地址';
comment on column XXL_JOB_LOG.executor_handler
  is '执行器任务handler';
comment on column XXL_JOB_LOG.executor_param
  is '执行器任务参数';
comment on column XXL_JOB_LOG.executor_sharding_param
  is '执行器任务分片参数，格式如 1/2';
comment on column XXL_JOB_LOG.executor_fail_retry_count
  is '失败重试次数';
comment on column XXL_JOB_LOG.trigger_time
  is '调度-时间';
comment on column XXL_JOB_LOG.trigger_code
  is '调度-结果';
comment on column XXL_JOB_LOG.trigger_msg
  is '调度-日志';
comment on column XXL_JOB_LOG.handle_time
  is '执行-时间';
comment on column XXL_JOB_LOG.handle_code
  is '执行-状态';
comment on column XXL_JOB_LOG.handle_msg
  is '执行-日志';
comment on column XXL_JOB_LOG.alarm_status
  is '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOG
  add primary key (ID);


-- Create table
create table XXL_JOB_LOGGLUE
(
  id          INTEGER not null,
  job_id      INTEGER not null,
  glue_type   VARCHAR2(64),
  glue_source CLOB,
  glue_remark NVARCHAR2(128) not null,
  add_time    DATE,
  update_time DATE
);
-- Add comments to the columns 
comment on column XXL_JOB_LOGGLUE.job_id
  is '任务，主键ID';
comment on column XXL_JOB_LOGGLUE.glue_type
  is 'GLUE类型';
comment on column XXL_JOB_LOGGLUE.glue_source
  is 'GLUE源代码';
comment on column XXL_JOB_LOGGLUE.glue_remark
  is 'GLUE备注';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOGGLUE
  add primary key (ID);


-- Create table
create table XXL_JOB_LOG_REPORT
(
  id            INTEGER not null,
  trigger_day   DATE,
  running_count INTEGER not null,
  suc_count     INTEGER not null,
  fail_count    INTEGER not null
);
-- Add comments to the columns 
comment on column XXL_JOB_LOG_REPORT.trigger_day
  is '调度-时间';
comment on column XXL_JOB_LOG_REPORT.running_count
  is '运行中-日志数量';
comment on column XXL_JOB_LOG_REPORT.suc_count
  is '执行成功-日志数量';
comment on column XXL_JOB_LOG_REPORT.fail_count
  is '执行失败-日志数量';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOG_REPORT
  add primary key (ID);


-- Create table
create table XXL_JOB_REGISTRY
(
  id             INTEGER not null,
  registry_group VARCHAR2(64) not null,
  registry_key   NVARCHAR2(1024) not null,
  registry_value NVARCHAR2(1024) not null,
  update_time    DATE
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_REGISTRY
  add primary key (ID);

-- Create table
create table XXL_JOB_USER
(
  id         INTEGER not null,
  username   VARCHAR2(64) not null,
  password   VARCHAR2(64) not null,
  role       INTEGER not null,
  permission NVARCHAR2(1024)
);
-- Add comments to the columns 
comment on column XXL_JOB_USER.username
  is '账号';
comment on column XXL_JOB_USER.password
  is '密码';
comment on column XXL_JOB_USER.role
  is '角色：0-普通用户、1-管理员';
comment on column XXL_JOB_USER.permission
  is '权限：执行器ID列表，多个逗号分割';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_USER
  add primary key (ID);


-- Create sequence
create sequence XXL_JOB_GROUP_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_INFO_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_LOGGLUE_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_LOG_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_REGISTRY_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_USER_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;

create sequence XXL_JOB_LOG_REPORT_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;


insert into XXL_JOB_GROUP (ID, APP_NAME, TITLE, ORDER_SORT, ADDRESS_TYPE, ADDRESS_LIST)
values (1, 'xxl-job-executor-sample', '示例执行器', 1, 0, null);

insert into XXL_JOB_INFO (ID, JOB_GROUP, JOB_CRON, JOB_DESC, ADD_TIME, UPDATE_TIME, AUTHOR, ALARM_EMAIL, EXECUTOR_ROUTE_STRATEGY, EXECUTOR_HANDLER, EXECUTOR_PARAM, EXECUTOR_BLOCK_STRATEGY, EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT, GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK, GLUE_UPDATETIME, CHILD_JOBID, TRIGGER_STATUS, TRIGGER_LAST_TIME, TRIGGER_NEXT_TIME)
values (1, 1, '0/20 * * * * ?', '测试任务1', to_date('17-07-2021', 'dd-mm-yyyy'), to_date('18-07-2021 12:50:47', 'dd-mm-yyyy hh24:mi:ss'), 'XXL', null, 'FIRST', 'demoJobHandler', null, 'SERIAL_EXECUTION', 0, 0, 'BEAN', '<CLOB>', 'GLUE代码初始化', to_date('17-07-2021', 'dd-mm-yyyy'), null, 0, 0, 0);

insert into XXL_JOB_LOCK (LOCK_NAME)
values ('schedule_lock');

insert into XXL_JOB_USER (ID, USERNAME, PASSWORD, ROLE, PERMISSION)
values (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, null);