/*
	销售报表，佣金报表
*/

DROP TABLE IF EXISTS `u_user_role`;
DROP TABLE IF EXISTS `u_role_permission`;

/*表结构插入 权限表*/
DROP TABLE IF EXISTS `u_permission`;

CREATE TABLE `u_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(256) NOT NULL unique COMMENT 'url地址',
  `name` varchar(64) NOT NULL COMMENT 'url描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Table structure for table `u_role` 角色表*/
DROP TABLE IF EXISTS `u_role`;

/*Table structure for table `u_appointments` 职务表 用于生成佣金与职务记录，一个职务对应一个佣金记录 */
DROP TABLE IF EXISTS `u_appointments`;

CREATE TABLE `u_appointments` (
  `id` bigint(3) NOT NULL unique COMMENT '职务主键',
  `name` varchar(64) NOT NULL COMMENT '职务名称',
  `commission_flag` bigint(1) NOT NULL  DEFAULT 1 COMMENT '可提佣金标记;0 不计佣金，1 可提佣金', 
  `commission_ratio` DECIMAL(5,5) NOT NULL DEFAULT 0  COMMENT '默认佣金比例;以千分计', 
  `commi_calcu_method` bigint(1)  NOT NULL  DEFAULT 2 COMMENT '日常佣金计算方法。1 职业顾问：是按照 计提比例表对应的比例 * 提佣办法比例 * 佣金提点 * 总房款；2 案场(含后台)：      提佣办法比例 * 佣金提点 * 本次收款', 
  `house_relation` bigint(1) NOT NULL  DEFAULT 1 COMMENT '职务对应的人员如何与具体房源关联标记(1 根据项目关联，2 跟房源直接关联)', 
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/*Table structure for table `u_role` 角色表*/
DROP TABLE IF EXISTS `u_role`;

CREATE TABLE `u_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL unique COMMENT '角色名称',
  `code` varchar(10) NOT NULL  unique  COMMENT '角色类型 code 唯一码',
  `appointments_id` bigint(3) DEFAULT NULL COMMENT '角色对应的职务id', 
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


/*Table structure for table `u_role` 
 * 子角色类型，主要用于记录 后台主管、后台专员，后台人员合计分1人份的佣金 */
/*
DROP TABLE IF EXISTS `u_sub_role`;

CREATE TABLE `u_sub_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL unique COMMENT '角色名称',
  `code` varchar(10) NOT NULL  DEFAULT '1' COMMENT '子角色类型 code 唯一码',
  'parent_role_code'  varchar(10) NOT NULL  COMMENT '父角色类型 code 唯一码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
  */
  
/*Table structure for table `u_role_permission` */
DROP TABLE IF EXISTS `u_role_permission`;

CREATE TABLE `u_role_permission` (
  `rid` bigint(20) NOT NULL COMMENT '角色ID',
  `pid` bigint(20) NOT NULL COMMENT '权限ID',
  FOREIGN KEY (rid) REFERENCES u_role(id) ON DELETE CASCADE,
  FOREIGN KEY (pid) REFERENCES u_permission(id) ON DELETE CASCADE,
  UNIQUE KEY rolePermission (rid,pid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `u_user` */

DROP TABLE IF EXISTS `u_user`;

CREATE TABLE `u_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL COMMENT '用户姓名',
  `mobile` varchar(15) NOT NULL UNIQUE COMMENT '手机号|登录帐号',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `pswd` varchar(32) NOT NULL COMMENT '密码',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `status` bigint(1) DEFAULT '1' COMMENT '1:有效，0:禁止登录',
  `dimission_status` bigint(1) DEFAULT '0' COMMENT '是否已离职; 1:已离职，0:未离职',
  `dimission_time` datetime DEFAULT NULL COMMENT '离职时间',
  `dimission_process_flag` bigint(1) DEFAULT '0' COMMENT '离职后佣金数据已处理标记; 1:已处理，0:未处理',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `u_user_role` */

DROP TABLE IF EXISTS `u_user_role`;

CREATE TABLE `u_user_role` (
  `uid` bigint(20) NOT NULL COMMENT '用户ID',
  `rid` bigint(20) NOT NULL COMMENT '角色ID',
  FOREIGN KEY (rid) REFERENCES u_role(id) ON DELETE CASCADE,
  FOREIGN KEY (uid) REFERENCES u_user(id) ON DELETE CASCADE,
  UNIQUE KEY user_role (rid,uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*Table structure for table `city_company` 城市公司*/

DROP TABLE IF EXISTS `city_company`;

CREATE TABLE `city_company` (
  `id` bigint(3) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '城市名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `project_company` 项目公司*/

DROP TABLE IF EXISTS `project_company`;

CREATE TABLE `project_company` (
  `id` bigint(3) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '城市名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '项目名称',
  `erp_code` varchar(50) NOT NULL unique COMMENT '项目erp code',
  `city_company_id` bigint(3) DEFAULT NULL COMMENT '城市公司Id',
  `project_company_id` bigint(3) DEFAULT NULL COMMENT '项目公司Id',
  `sale_start_time` datetime DEFAULT NULL COMMENT '项目起售时间',
  `saled_ratio` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '楼栋去化率，百分比', 
  `accepted_ratio` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '集中交付率，百分比', 
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (city_company_id) REFERENCES city_company(id),
  FOREIGN KEY (project_company_id) REFERENCES project_company(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `user_project_rel` */
DROP TABLE IF EXISTS `user_project_rel`;

CREATE TABLE `user_project_rel` (
  `user_id` bigint(20) NOT NULL COMMENT '用户',
  `project_id` bigint(20) NOT NULL COMMENT '项目Id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职位Id',
  `relation_type` bigint(1) NOT NULL  DEFAULT 1 COMMENT '1原配，2转岗再分配，3离职再分配', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  FOREIGN KEY (user_id) REFERENCES u_user(id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*Table structure for table `house_status` */

DROP TABLE IF EXISTS `house_status`;

CREATE TABLE `house_status` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '房源状态名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `house_sale_type` 销售类别*/

DROP TABLE IF EXISTS `house_sale_type`;

CREATE TABLE `house_sale_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '房源销售类型',
  `dimission_avaliable` bigint(1)  NOT NULL DEFAULT 1 COMMENT '是否计算佣金；0 不计算佣金；1 需要计算佣金', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table  `house_business_type` 业态大类*/
DROP TABLE IF EXISTS `house_business_type`;

CREATE TABLE `house_business_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '房源业态，商业类型',
  `dimission_avaliable` bigint(1) NOT NULL DEFAULT 1 COMMENT '是否计算佣金；0 不计算佣金；1 需要计算佣金', 
  `dimission_priority` bigint(5) NOT NULL DEFAULT 100 COMMENT '佣金计算优先级', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table 业态细类 `house_business_sub_type` */
DROP TABLE IF EXISTS `house_business_sub_type`;

CREATE TABLE `house_business_sub_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '房源业态，商业类型 名字',
  `dimission_priority` bigint(5) NOT NULL DEFAULT 200 COMMENT '佣金计算优先级', 
  `parent_id` bigint(2) NOT NULL ,
  PRIMARY KEY (`id`),
  FOREIGN KEY (parent_id) REFERENCES house_business_type(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `building` 楼栋数据表*/
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '楼栋名称',
  `land` varchar(50) DEFAULT NULL COMMENT '地块名称',
  `project_id` bigint(20) NOT NULL COMMENT '项目id外键',
  `project_phase` varchar(20) DEFAULT NULL COMMENT '项目分期名称',
  `erp_code` varchar(50) unique COMMENT 'building erp code',
  `fund_ready_time` datetime DEFAULT NULL COMMENT '楼栋公积金准入日期',
  PRIMARY KEY (`id`),
  FOREIGN KEY (project_id) REFERENCES project(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table  `house_type` 房源类型：大卡，小卡，签约，认购*/
DROP TABLE IF EXISTS `house_type`;

CREATE TABLE `house_type` (
  `id` bigint(2) NOT NULL  COMMENT '1大卡，2小卡，3签约，4认购',
  `name` varchar(20) NOT NULL COMMENT '房源类型：1大卡，2小卡，3签约，4认购',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `commission_calculate_type` 佣金计算方式：固定金额，按佣金提点，不计佣金*/
DROP TABLE IF EXISTS `commission_calculate_type`;

CREATE TABLE `commission_calculate_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '固定金额，按佣金提点，不计佣金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table 房源主数据表`house` */
DROP TABLE IF EXISTS `house`;

CREATE TABLE `house` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id`  bigint(2) NOT NULL COMMENT '房源类型：大卡，小卡，签约，认购',
  `building_id` bigint(20) NOT NULL COMMENT '楼栋id外键',
  `status_id` bigint(2) NOT NULL COMMENT '房源状态id外键',
  `sale_type_id` bigint(2) NOT NULL COMMENT '销售类型id',
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `business_sub_type_id` bigint(2) NOT NULL COMMENT '业态细类id',
  `erp_code` varchar(50) unique COMMENT 'house erp code',
  `erp_name` varchar(50) DEFAULT NULL  COMMENT 'house erp name',
  `erp_sale_code` varchar(50) DEFAULT NULL  COMMENT '销售凭证',
  `customer_code` varchar(50) DEFAULT NULL  COMMENT '客户编码',
  `customer_name` varchar(20) DEFAULT NULL  COMMENT '客户名称',
  `customer_mobile` varchar(20) DEFAULT NULL  COMMENT '客户手机号',
  `customer_number` varchar(20) DEFAULT NULL  COMMENT '客户身份证号码',
  `pre_size` DECIMAL(12,5) NOT NULL COMMENT '预售面积',
  `real_size` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '真实面积，平方米', 
  `is_carry_forward` bigint(1) NOT NULL DEFAULT 0 COMMENT '是否结转收入',
  `carry_forward_income` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '结转收入金额', 
  `carry_forward_cost_unit_price` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '结转成本单价', 
  `deliver_house_invoice_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '交房发票金额', 
  `deliver_house_invoice_code` varchar(50) DEFAULT NULL COMMENT '交房发票号',
  `is_change_name` bigint(1) NOT NULL DEFAULT 0 COMMENT '是否更名',
  `dimission_payoff_time` datetime DEFAULT NULL COMMENT '结佣时间',
  `dimission_remark` varchar(250) DEFAULT NULL  COMMENT '提佣备注',
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `extra_dimission_ratio` bigint(2) NOT NULL DEFAULT 100 COMMENT '额外佣金计提比例，默认100%，超出折扣销售计提标准 50%',
  `extra_dimission_ratio_remark` varchar(250) DEFAULT NULL  COMMENT '额外佣金计提比例说明',
  `commission_calcu_type_id` bigint(2) DEFAULT NULL COMMENT '佣金计算方式id',
  `overdue_remark` varchar(250) DEFAULT NULL  COMMENT '逾期情况说明',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (building_id) REFERENCES building(id),
  FOREIGN KEY (type_id) REFERENCES house_type(id),
  FOREIGN KEY (status_id) REFERENCES house_status(id),
  FOREIGN KEY (sale_type_id) REFERENCES house_sale_type(id),
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id),
  FOREIGN KEY (business_sub_type_id) REFERENCES house_business_sub_type(id),
  FOREIGN KEY (commission_calcu_type_id) REFERENCES commission_calculate_type(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `user_house_rel` */
DROP TABLE IF EXISTS `user_house_rel`;

CREATE TABLE `user_house_rel` (
  `user_id` bigint(20) NOT NULL COMMENT '用户',
  `house_id` bigint(20) NOT NULL COMMENT '房源Id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职位Id',
  `relation_type` bigint(1) NOT NULL  DEFAULT 1 COMMENT '1原配，2转岗再分配，3离职再分配', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  FOREIGN KEY (user_id) REFERENCES u_user(id) ON DELETE CASCADE,
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*Table structure for table `earnest_money` 诚意金*/
DROP TABLE IF EXISTS `earnest_money`;
CREATE TABLE `earnest_money` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `house_id` bigint(20) NOT NULL COMMENT '房源Id',
  `pos_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT 'pos金额', 
  `cash_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '现金金额', 
  `bank_bill_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '银行票据金额', 
  `bank_transfer_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '银行转账金额', 
  `pay_time` datetime DEFAULT NULL COMMENT '收款时间',
  `pay_type` bigint(1) NOT NULL COMMENT '收款方式；1 现金/2 pos/3 银行转账', 
  `bank_name` varchar(50) DEFAULT NULL COMMENT '入账行',
  `receipt_company` varchar(50) DEFAULT NULL COMMENT '出票单位',
  `bank_bill_type` bigint(1) NOT NULL  DEFAULT 1 COMMENT '银行票据；1 本票/2 支票/3 汇票', 
  `convert_house_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '转房款金额', 
  `refund_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '退款金额', 
  `remain_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '结余金额', 
  `receipt_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '换据金额', 
  `status` bigint(1) NOT NULL  DEFAULT 1 COMMENT '状态，1 已收款，2 已退款，3 已转房款', 
  `refund_check_number` varchar(50) DEFAULT NULL COMMENT '退款支票号',
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `house_buy_method` 一次性付款，按揭*/
DROP TABLE IF EXISTS `house_buy_method`;

CREATE TABLE `house_buy_method` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '购买方式：一次性付款；按揭',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `house_mortgage_type` 按揭类型表*/
DROP TABLE IF EXISTS `house_mortgage_type`;

CREATE TABLE `house_mortgage_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '纯公积金/纯商业/组合',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table 房源主数据表`house_contract` */
DROP TABLE IF EXISTS `house_contract`;

CREATE TABLE `house_contract` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `house_id` bigint(20) NOT NULL unique COMMENT '房源Id',
  `contract_code` varchar(50) NOT NULL COMMENT '合同编号',
  `unit_price` DECIMAL(12,5) NOT NULL COMMENT '合同单价',
  `buy_method_id` bigint(2) NOT NULL COMMENT '购买方式：一次性付款；按揭',
  `sign_date` date NOT NULL COMMENT '签约时间',
  `verification_date` date NOT NULL COMMENT '合同鉴定时间',
  `late_fee_ratio` bigint(2) NOT NULL COMMENT '合同违约金比率',
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `house_mortgage_data` 合同按揭数据表*/
DROP TABLE IF EXISTS `house_mortgage_data`;

CREATE TABLE `house_mortgage_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contract_id` bigint(20) NOT NULL unique COMMENT '合同Id',
  `mortgage_type_id` bigint(2) NOT NULL COMMENT '按揭类型',
  `downpayments_ratio` bigint(2) NOT NULL COMMENT '首付比例',
  `downpayments_amount` DECIMAL(12,5) NOT NULL COMMENT '首付金额',
  `business_loan_amount` DECIMAL(12,5) NOT NULL DEFAULT 0 COMMENT '商业贷款金额',
  `public_fund_loan_amount` DECIMAL(12,5) NOT NULL DEFAULT 0 COMMENT '公积金贷款金额',
  `loan_bank` varchar(50) DEFAULT NULL COMMENT '贷款行',
  `mortgage_department` varchar(50) DEFAULT NULL COMMENT '抵款单位',
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (contract_id) REFERENCES house_contract(id) ON DELETE CASCADE,
  FOREIGN KEY (mortgage_type_id) REFERENCES house_mortgage_type(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `money_type` 金额类型*/
DROP TABLE IF EXISTS `money_type`;

CREATE TABLE `money_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '金额类型:0 诚意金，1 定金, 2 一次性付款, 3 首付款, 4 公积金按揭款, 5 商业按揭款，6 交房发票, 7 违约金, 8 面积差，9 预收房款，10 工抵',
  `is_contract_money` bigint(1) NOT NULL DEFAULT 0 COMMENT '是否是合同金额，0 不是，1 是； 定金, 一次性付款, 首付款, 公积金按揭款, 商业按揭款 这几个是合同金额，可用来计提佣金。', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `overdue_reason` 逾期原因表*/
DROP TABLE IF EXISTS `overdue_reason`;

CREATE TABLE `overdue_reason` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '1工抵，2虚单，3已退房，4商办无银行按揭，5银行审批中，6面积差，7无预证，8系统总价错误，9全款清，10已诉讼，11待诉讼，12不逾期(提前进系统)，13已下款，14关系户，15更名待网签备案，16万元首付，17其他',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `contract_money` 合同金额数据*/
DROP TABLE IF EXISTS `contract_money`;

CREATE TABLE `contract_money` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `house_id` bigint(20) NOT NULL COMMENT '房源Id',
  `money_type_id` bigint(2) NOT NULL COMMENT '金额类型:1定金, 2一次性付款, 3首付款, 4公积金按揭款, 5商业按揭款',
  `amount` DECIMAL(12,5) NOT NULL COMMENT '合同金额', 
  `receivables_time` date DEFAULT NULL COMMENT '应收账款的时间 ',
  `status` bigint(1) NOT NULL DEFAULT 1 COMMENT '1 未收款，2 部分收款，3 全额收款', 
  `is_overdue` bigint(1) NOT NULL DEFAULT 0 COMMENT '0 未逾期，1 已逾期', 
  `overdue_reason_id` bigint(2) DEFAULT NULL  COMMENT '逾期原因；',
  `overdue_extend_remark` varchar(250) DEFAULT NULL  COMMENT '其他逾期原因',
  `is_recover_available` bigint(1) NOT NULL DEFAULT 1 COMMENT '是否能收回; 0 不能，1可以', 
  `expect_recover_date` date DEFAULT NULL COMMENT '预计收回时间', 
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE,
  FOREIGN KEY (money_type_id) REFERENCES money_type(id),
  FOREIGN KEY (overdue_reason_id) REFERENCES overdue_reason(id) 
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `money_pay_detail` 合同金额实际支付记录*/
DROP TABLE IF EXISTS `money_pay_detail`;

CREATE TABLE `money_pay_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contract_money_id` bigint(20) DEFAULT NULL COMMENT '合同金额id；如果不是合同金额，置空',
  `money_type_id` bigint(2) NOT NULL COMMENT '金额类型:0 诚意金，1 定金, 2 一次性付款, 3 首付款, 4 公积金按揭款, 5 商业按揭款，6 交房发票, 7 违约金, 8 面积差，9 预收房款，10 工抵',
  `pay_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  `pay_time` datetime DEFAULT NULL COMMENT '收款时间',
  `pay_type` bigint(1) NOT NULL default 1 COMMENT '收款方式；1 现金/2 pos/3 银行转账', 
  `bank_name` varchar(50) DEFAULT NULL COMMENT '入账行',
  `bank_bill_type` bigint(1) NOT NULL  DEFAULT 1 COMMENT '银行票据；1 本票/2 支票/3 汇票', 
  `bank_bill_number` varchar(50) DEFAULT NULL COMMENT '银行票据号',
  `receipt_company` varchar(50) DEFAULT NULL COMMENT '出票单位',
  `receipt_name` varchar(50) DEFAULT NULL COMMENT '收据姓名',
  `is_late_fee_calculate` bigint(1) NOT NULL DEFAULT 0 COMMENT '0 未计算，1 已计算; 只针对 合同金额', 
  `is_overdue` bigint(1) NOT NULL DEFAULT 0 COMMENT '0 未逾期，1 已逾期; 只针对 合同金额', 
  `late_fee` DECIMAL(12,5) DEFAULT 0 COMMENT '合同逾期违金; 只针对 合同金额',
  `overdue_reason_id` varchar(250) DEFAULT NULL  COMMENT '逾期原因; 只针对 合同金额',
  `erp_create_time` datetime DEFAULT NULL COMMENT '每次收款录入ERP系统日期',
  `erp_paid_amount` DECIMAL(12,5) DEFAULT 0 COMMENT 'ERP系统中已收款',
  `erp_late_fee_ratio` bigint(2) NOT NULL DEFAULT 0 COMMENT 'ERP违约金率',
  `erp_late_fee` DECIMAL(12,5) DEFAULT 0 COMMENT 'ERP违约金',
  `is_dimission_calculate` bigint(1) NOT NULL DEFAULT 0 COMMENT '佣金是否已计算：0 未计算，1 已计算; 只针对 合同金额', 
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (contract_money_id) REFERENCES contract_money(id),
  FOREIGN KEY (money_type_id) REFERENCES money_type(id),
  FOREIGN KEY (overdue_reason_id) REFERENCES overdue_reason(id) 
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table `receipt_invoice_data` 收据/发票数据*/
DROP TABLE IF EXISTS ` receipt_invoice_data`;

CREATE TABLE `receipt_invoice_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pay_detail_id` bigint(20) DEFAULT NULL COMMENT '支付记录Id；如果没有对应支付记录，置空',
  `money_type_id` bigint(2) NOT NULL COMMENT '金额类型:0 诚意金，1 定金, 2 一次性付款, 3 首付款, 4 公积金按揭款, 5 商业按揭款，6 交房发票, 7 违约金, 8 面积差，9 预收房款，10 工抵',
  `type` bigint(1) NOT NULL COMMENT '票据类型：1收据/ 2 普票/ 3 专票',
  `receipt_company` varchar(50) DEFAULT NULL COMMENT '出票单位，个人或者单位名称',
  `name` varchar(50) DEFAULT NULL COMMENT '收据/发票抬头',
  `code` varchar(50) DEFAULT NULL COMMENT '收据号/发票号',
  `old_code` varchar(50) DEFAULT NULL COMMENT '原收据号',
  `is_paid_added_tax` bigint(1) NOT NULL DEFAULT 0 COMMENT '是否已全额预缴增值税. 0 未缴纳，1 缴纳',
  `is_paid_sales_tax` bigint(1) NOT NULL DEFAULT 0 COMMENT '是否已缴营业税. 0 未缴纳，1 缴纳',
  `amount` DECIMAL(12,5) NOT NULL COMMENT '收据/发票 金额', 
  `isvalid` bigint(1) NOT NULL default 1 COMMENT '1 有效，0 无效', 
  `invoice_tax_rate` DECIMAL(12,5) default 0 COMMENT '开票税率', 
  `invoice_tax` DECIMAL(12,5) default 0 COMMENT '税额', 
  `invoice_time` datetime DEFAULT NULL COMMENT '开票时间',
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (money_type_id) REFERENCES money_type(id),
  FOREIGN KEY (pay_detail_id) REFERENCES money_pay_detail(id)  ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*
 * 佣金相关表
 * commission related tables
 * 
 */

/*
 * 角色对应的个人提佣比例配置表(销售支持 需求)
         配置的销售支持佣金提点比例是对应全部销售支持的总佣金，根据配置的人员数量不同，具体的佣金提点比例要再乘以下面的个人比例：
                    销售支持人数为3人的案场，主管岗位设置1人，个人提佣比例为60%，服务人员岗位设置2人，个人提佣比例为20%，合计提佣比例100%；
                    销售支持人数为2人的案场，主管岗位个人提佣比例为70%，服务人员岗位提佣比例为30%,合计提佣比例100%；
                    销售支持人数为1人的案场，合计提佣比例100%。
 */

/*Table structure for table `appointments_num_config` 单个职务跟同一个房源的人数配置表*/
DROP TABLE IF EXISTS `appointments_num_config`;

CREATE TABLE `appointments_num_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `user_number` bigint(2) NOT NULL COMMENT '当前职位在跟一个房源相关的人数', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


/*Table structure for table `commission_appoint_role_config` 职务下的角色 分成 置表表*/
DROP TABLE IF EXISTS `commission_appoint_role_config`;

CREATE TABLE `commission_appoint_role_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appoint_config_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `role_user_number` bigint(2) NOT NULL COMMENT '当前角色的人数', 
  `percent` DECIMAL(12,5) default 0 COMMENT '角色相关人占用的百分比', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (role_id) REFERENCES u_role(id) ON DELETE CASCADE,
  FOREIGN KEY (appoint_config_id) REFERENCES appointments_num_config(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;




/*
 * ***************佣金计算方式关系表*****************start
 */
/*Table structure for table `housetype_calculatetype` 房源类型与佣金计算方式关系表 (目前需求 只记录不计佣金的)*/
DROP TABLE IF EXISTS `housetype_calculatetype`;

CREATE TABLE `housetype_calculatetype` (
  `house_type_id` bigint(2) NOT NULL COMMENT '房源类型id',
  `commission_calcu_type_id` bigint(2) DEFAULT NULL COMMENT '佣金计算方式id',
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (house_type_id) REFERENCES house_type(id),
  FOREIGN KEY (commission_calcu_type_id) REFERENCES commission_calculate_type(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `house_saletype_calculatetype` 销售方式类别与佣金计算方式关系表*/
DROP TABLE IF EXISTS `house_saletype_calculatetype`;

CREATE TABLE `house_saletype_calculatetype` (
  `sale_type_id` bigint(2) NOT NULL COMMENT '销售类型id',
  `commission_calcu_type_id` bigint(2) DEFAULT NULL COMMENT '佣金计算方式id',
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (sale_type_id) REFERENCES house_sale_type(id),
  FOREIGN KEY (commission_calcu_type_id) REFERENCES commission_calculate_type(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `house_bizsubtype_calculatetype`业态细类与佣金计算方式关系表*/
DROP TABLE IF EXISTS `house_bizsubtype_calculatetype`;

CREATE TABLE `house_bizsubtype_calculatetype` (
  `business_sub_type_id` bigint(2) NOT NULL COMMENT '业态细类id',
  `commission_calcu_type_id` bigint(2) DEFAULT NULL COMMENT '佣金计算方式id',
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_sub_type_id) REFERENCES house_business_sub_type(id),
  FOREIGN KEY (commission_calcu_type_id) REFERENCES commission_calculate_type(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `house_biztype_calculatetype` 业态大类与佣金计算方式关系表*/
DROP TABLE IF EXISTS `house_biztype_calculatetype`;

CREATE TABLE `house_biztype_calculatetype` (
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `commission_calcu_type_id` bigint(2) DEFAULT NULL COMMENT '佣金计算方式id',
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id),
  FOREIGN KEY (commission_calcu_type_id) REFERENCES commission_calculate_type(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*
 * ************佣金计算方式关系表***************end
 */

/*
 * ************固定金额/佣金提点 对应 的职位 佣金配置表***************start
 */

/*Table structure for table `house_commission` 房源与职位对应的固定金额/佣金提点佣金配置表 */
DROP TABLE IF EXISTS `house_commission`;

CREATE TABLE `house_commission` (
  `house_id` bigint(20) NOT NULL unique COMMENT '房源Id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '房源与职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '房源与职位对应的佣金提点', 
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE,
    FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `project_bizsubtype_commission` 项目、 业态细类 与职位对应的 固定金额/佣金提点佣金 配置 */
DROP TABLE IF EXISTS `project_bizsubtype_commission`;

CREATE TABLE `project_bizsubtype_commission` (
  `project_id` bigint(20) NOT NULL COMMENT '项目Id',
  `business_sub_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的佣金提点', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_sub_type_id) REFERENCES house_business_sub_type(id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `project_biztype_commission` 项目、 业态大类 与职位对应的 固定金额/佣金提点佣金 配置 */
DROP TABLE IF EXISTS `project_biztype_commission`;

CREATE TABLE `project_biztype_commission` (
  `project_id` bigint(20) NOT NULL COMMENT '项目Id',
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的佣金提点', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `project_commission` 项目与职位对应的 固定金额/佣金提点佣金 配置 */
DROP TABLE IF EXISTS `project_commission`;

CREATE TABLE `project_commission` (
  `project_id` bigint(20) NOT NULL COMMENT '项目Id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的佣金提点', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `saletype_commission` 销售类型与职位对应的 固定金额/佣金提点佣金 配置 */
DROP TABLE IF EXISTS `saletype_commission`;

CREATE TABLE `saletype_commission` (
 `sale_type_id` bigint(2) NOT NULL COMMENT '销售类型id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的佣金提点', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (sale_type_id) REFERENCES house_sale_type(id)  ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `bizsubtype_commission`  业态细类 与职位对应的 固定金额/佣金提点佣金 配置 */
DROP TABLE IF EXISTS `bizsubtype_commission`;

CREATE TABLE `bizsubtype_commission` (
  `business_sub_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的佣金提点', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_sub_type_id) REFERENCES house_business_sub_type(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `biztype_commission`  业态大类 与职位对应的 固定金额/佣金提点佣金 配置 */
DROP TABLE IF EXISTS `biztype_commission`;

CREATE TABLE `biztype_commission` (
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的佣金提点', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `default_commission` 默认 职位对应的 固定金额/佣金提点佣金 配置 */
DROP TABLE IF EXISTS `default_commission`;

CREATE TABLE `default_commission` (
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `fixed_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的固定金额佣金', 
  `ratio_commission` DECIMAL(12,5) default 0 COMMENT '职位对应的佣金提点', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*
 * ************固定金额佣金配置表***************end
 */


/*
 * ************提佣办法配置表***************start
 */
/*Table structure for table `ratio_commission_type` 只针对佣金提点方式：佣金类型。  日常结佣，季度奖金，年度奖金，交房奖金*/
DROP TABLE IF EXISTS `ratio_commission_type`;
CREATE TABLE `ratio_commission_type` (
  `id` bigint(1) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `default_ratio_commission_method` 默认提佣办法 */
DROP TABLE IF EXISTS `default_ratio_commission_method`;

CREATE TABLE `default_ratio_commission_method` (
  `commission_type_id` bigint(1) NOT NULL COMMENT '佣金类型',
  `ratio` DECIMAL(12,5) default 0 COMMENT '佣金类型占比(百分比)', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (commission_type_id) REFERENCES ratio_commission_type(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `appoint_ratio_commission_method` 职位对应的提佣办法 */
DROP TABLE IF EXISTS `appoint_ratio_commission_method`;

CREATE TABLE `appoint_ratio_commission_method` (
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `commission_type_id` bigint(1) NOT NULL COMMENT '佣金类型',
  `ratio` DECIMAL(12,5) default 0 COMMENT '佣金类型占比(百分比)', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ON DELETE CASCADE,
  FOREIGN KEY (commission_type_id) REFERENCES ratio_commission_type(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*
 * ************提佣办法配置表***************end
 */


/*
 * ************资金到账与日结佣金提取比例关系***************start
 */

/*Table structure for table `house_daily_commission`房源相关的 资金到账与日结佣金提取比例关系 */
DROP TABLE IF EXISTS `house_daily_commission`;

CREATE TABLE `house_daily_commission` (
  `house_id` bigint(20) NOT NULL unique COMMENT '房源Id',
  `money_paid_ratio_start` bigint(3) NOT NULL COMMENT '付款最小比例',
  `money_paid_ratio_end` bigint(3) NOT NULL COMMENT '付款最高比例',
  `daily_commission_ratio` bigint(3) default 0 COMMENT '日结佣金可提取比例', 
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `house_money_paid_daily_commission` 项目与业态细类 对应的  资金到账与日结佣金提取比例关系 */
DROP TABLE IF EXISTS `project_bizsubtype_daily_commission`;

CREATE TABLE `house_money_paid_daily_commission` (
  `project_id` bigint(20) NOT NULL COMMENT '项目Id',
  `business_sub_type_id` bigint(2) NOT NULL COMMENT '业态细类id',
  `money_paid_ratio_start` bigint(3) NOT NULL COMMENT '资金到账最小比例',
  `money_paid_ratio_end` bigint(3) NOT NULL COMMENT '资金到账最高比例',
  `daily_commission_ratio` bigint(3) default 0 COMMENT '日结佣金可提取比例', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
   FOREIGN KEY (business_sub_type_id) REFERENCES house_business_sub_type(id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `project_biztype_daily_commission` 项目与业态大类 对应的  资金到账与日结佣金提取比例关系 */
DROP TABLE IF EXISTS `project_biztype_daily_commission`;
CREATE TABLE `project_biztype_daily_commission` (
  `project_id` bigint(20) NOT NULL COMMENT '项目Id',
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `money_paid_ratio_start` bigint(3) NOT NULL COMMENT '资金到账最小比例',
  `money_paid_ratio_end` bigint(3) NOT NULL COMMENT '资金到账最高比例',
  `daily_commission_ratio` bigint(3) default 0 COMMENT '日结佣金可提取比例', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `project_biztype_daily_commission` 项目应的  资金到账与日结佣金提取比例关系 */
DROP TABLE IF EXISTS `project__daily_commission`;
CREATE TABLE `project_daily_commission` (
  `project_id` bigint(20) NOT NULL COMMENT '项目Id',
  `money_paid_ratio_start` bigint(3) NOT NULL COMMENT '资金到账最小比例',
  `money_paid_ratio_end` bigint(3) NOT NULL COMMENT '资金到账最高比例',
  `daily_commission_ratio` bigint(3) default 0 COMMENT '日结佣金可提取比例', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `bizsubtype_daily_commission` 业态细类 对应的  资金到账与日结佣金提取比例关系 */
DROP TABLE IF EXISTS `bizsubtype_daily_commission`;

CREATE TABLE `bizsubtype_daily_commission` (
  `business_sub_type_id` bigint(2) NOT NULL COMMENT '业态细类id',
  `money_paid_ratio_start` bigint(3) NOT NULL COMMENT '资金到账最小比例',
  `money_paid_ratio_end` bigint(3) NOT NULL COMMENT '资金到账最高比例',
  `daily_commission_ratio` bigint(3) default 0 COMMENT '日结佣金可提取比例', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
   FOREIGN KEY (business_sub_type_id) REFERENCES house_business_sub_type(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `biztype_daily_commission` 项目与业态大类 对应的  资金到账与日结佣金提取比例关系 */
DROP TABLE IF EXISTS `biztype_daily_commission`;
CREATE TABLE `biztype_daily_commission` (
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `money_paid_ratio_start` bigint(3) NOT NULL COMMENT '资金到账最小比例',
  `money_paid_ratio_end` bigint(3) NOT NULL COMMENT '资金到账最高比例',
  `daily_commission_ratio` bigint(3) default 0 COMMENT '日结佣金可提取比例', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `default_daily_commission` 默认  资金到账与日结佣金提取比例关系 */
DROP TABLE IF EXISTS `default_daily_commission`;
CREATE TABLE `default_daily_commission` (
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `money_paid_ratio_start` bigint(3) NOT NULL COMMENT '资金到账最小比例',
  `money_paid_ratio_end` bigint(3) NOT NULL COMMENT '资金到账最高比例',
  `daily_commission_ratio` bigint(3) default 0 COMMENT '日结佣金可提取比例', 
  `start_time` datetime NOT NULL COMMENT '关系挂靠开始时间', 
  `end_time` datetime NOT NULL COMMENT '关系挂靠结束时间', 
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*
 * ************资金到账与日结佣金提取比例关系***************end
 */


/*
 * ************房源与职位 的 佣金/奖金记录表***************
Table structure for table `house_appoint_commission_record`房源与职位 的 佣金/奖金记录表 */
DROP TABLE IF EXISTS `house_appoint_commission_record`;

CREATE TABLE `house_appoint_commission_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `house_id` bigint(20) NOT NULL unique COMMENT '房源Id',
  `commission_type` bigint(1) NOT NULL default 2 COMMENT '佣金类型：1 固定佣金(一次性结算)/2 日常结佣/3 季度奖金/4 年度奖金/5 交房奖金',
  `appointments_id` bigint(3) NOT NULL COMMENT '职务id',
  `house_daily_commission_id` bigint(10) default NULL COMMENT '房源计提比例表外键; 当commission_type为2 日常解佣时使用',
  
  `commission_ratio` DECIMAL(12,5) default 0 COMMENT '房源与职位对应的佣金提点', 
  `commission_amount` DECIMAL(12,5) default 0 COMMENT '佣金金额', 
  `manual_commission_ratio` DECIMAL(12,5) default 0 COMMENT '手动调整后的房源与职位对应的佣金提点', 
  `manual_commission_amount` DECIMAL(12,5) default 0 COMMENT '手动调整后的佣金金额', 
  
  `status` bigint(1) NOT NULL default 1 COMMENT '状态：1 保存/2 提交/3 批准/4 已发放',
  `submitter` bigint(20) NOT NULL COMMENT '提交人',
  `submit_time` datetime NOT NULL COMMENT '提交时间',
  `approver` bigint(20) NOT NULL COMMENT '批准人',
  `approve_time` datetime NOT NULL COMMENT '批准时间',
  
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  PRIMARY KEY (`id`),
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE,
  FOREIGN KEY (appointments_id) REFERENCES u_appointments(id) ,
  FOREIGN KEY (house_daily_commission_id) REFERENCES u_appointments(id) ,
  FOREIGN KEY (submitter) REFERENCES u_user(id),
  FOREIGN KEY (approver) REFERENCES u_user(id) 
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*
 * ************人员与 房源、职位的佣金/奖金记录关系表***************
Table structure for table `user_house_appoint_commission_record`人员与 房源、职位的佣金/奖金记录关系表 */
DROP TABLE IF EXISTS `user_house_appoint_commission_record`;

CREATE TABLE `user_house_appoint_commission_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '指定的用户',
  `house_id` bigint(20) NOT NULL unique COMMENT '房源Id',
  `house_appoint_commission_id` bigint(20) NOT NULL unique COMMENT '房源与职位 的 佣金/奖金记录表 id',
  `ratio` DECIMAL(12,5) default 0 COMMENT '占对应职位佣金的比重', 
  `replacer` bigint(1) NOT NULL default 1 COMMENT '是否替换人员：0 不是/1 是',
  `commission_amount` DECIMAL(12,5) default 0 COMMENT '佣金金额', 
  
  `status` bigint(1) NOT NULL default 1 COMMENT '状态：1 保存/2 提交/3 批准/4 已发放',
  `submitter` bigint(20) NOT NULL COMMENT '提交人',
  `submit_time` datetime NOT NULL COMMENT '提交时间',
  `approver` bigint(20) NOT NULL COMMENT '批准人',
  `approve_time` datetime NOT NULL COMMENT '批准时间',
  
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  PRIMARY KEY (`id`),
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE,
  FOREIGN KEY (house_appoint_commission_id) REFERENCES house_appoint_commission_record(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES u_user(id) ,
  FOREIGN KEY (submitter) REFERENCES u_user(id) ,
  FOREIGN KEY (approver) REFERENCES u_user(id) 
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;





/*
 * ***********每月员工佣金记录表***************
Table structure for table `user_monthly_commission_record`人员与 房源、职位的佣金/奖金记录关系表 */
DROP TABLE IF EXISTS `user_monthly_commission_record`;

CREATE TABLE `user_monthly_commission_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '指定的用户',
  
  `fixed_commission_amount` DECIMAL(12,5) default 0 COMMENT '当月固定佣金总金额', 
  `daily_commission_amount` DECIMAL(12,5) default 0 COMMENT '当月日结佣金总金额', 
  `quarter_commission_amount` DECIMAL(12,5) default 0 COMMENT '该季度结佣金总金额', 
  `annual_commission_amount` DECIMAL(12,5) default 0 COMMENT '该年结佣金总金额', 
  `house_deliver_commission_amount` DECIMAL(12,5) default 0 COMMENT '交房结佣金总金额', 
  `rewards_amount` DECIMAL(12,5) default 0 COMMENT '奖励金',
  `rewards_remark` varchar(250) DEFAULT NULL  COMMENT '奖励金备注',
  `fine_amount` DECIMAL(12,5) default 0 COMMENT '罚金',
  `fine_remark` varchar(250) DEFAULT NULL  COMMENT '罚金备注',
  
  `status` bigint(1) NOT NULL default 1 COMMENT '状态：1 保存/2 提交/3 批准/4 已发放',
  `submitter` bigint(20) NOT NULL COMMENT '提交人',
  `submit_time` datetime NOT NULL COMMENT '提交时间',
  `approver` bigint(20) NOT NULL COMMENT '批准人',
  `approve_time` datetime NOT NULL COMMENT '批准时间',
  
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  PRIMARY KEY (`id`),
  FOREIGN KEY (user_id) REFERENCES u_user(id) ,
  FOREIGN KEY (submitter) REFERENCES u_user(id) ,
  FOREIGN KEY (approver) REFERENCES u_user(id) 
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;






