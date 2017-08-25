/*
	资金报表 表结构
*/

/*
DROP TABLE IF EXISTS `c_invalid_capital`;
DROP TABLE IF EXISTS `c_sub_company_total_balance`;
DROP TABLE IF EXISTS `c_invalid_capital`;

	DROP TABLE IF EXISTS `c_income`;
	DROP TABLE IF EXISTS `c_user_sub_company_rel`;
	DROP TABLE IF EXISTS `c_cost`;
	DROP TABLE IF EXISTS `c_sub_company_bank_balance`;
	DROP TABLE IF EXISTS `c_sub_company_bank_balance`;
	DROP TABLE IF EXISTS `c_sub_company_his_bank_balance`;
	DROP TABLE IF EXISTS `c_sub_company_total_balance`;
	DROP TABLE IF EXISTS `c_invalid_capital`;
	DROP TABLE IF EXISTS `c_his_invalid_capital`;

DROP TABLE IF EXISTS `c_sub_company_balance`;
DROP TABLE IF EXISTS `c_sub_company_his_balance`;

DROP TABLE IF EXISTS `c_sub_company_bank_balance`;

DROP TABLE IF EXISTS `c_user_sub_company_rel`;
DROP TABLE IF EXISTS `c_sms_record`;

DROP TABLE IF EXISTS `c_sub_company`;

DROP TABLE IF EXISTS `c_branch_company`;


DROP TABLE IF EXISTS `c_income`;
DROP TABLE IF EXISTS `c_income_type`;
DROP TABLE IF EXISTS `c_cost`;


DROP TABLE IF EXISTS `c_bank`;
/* 支出类型表*/
DROP TABLE IF EXISTS `c_cost_type`;
/* 分公司所属区域*/
DROP TABLE IF EXISTS `c_district`;
 * 
 */



/* 分公司所属区域*/
DROP TABLE IF EXISTS `c_district`;

CREATE TABLE `c_district` (
  `id` bigint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Table structure for table `c_branch_company` 分公司*/
DROP TABLE IF EXISTS `c_branch_company`;

CREATE TABLE `c_branch_company` (
  `id` bigint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL unique COMMENT '名称',
  `district_id` bigint(3) NOT NULL COMMENT '分公司所属区域',
  PRIMARY KEY (`id`),
  FOREIGN KEY (district_id) REFERENCES c_district(id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


/*Table structure for table `c_sub_company` 分公司*/
DROP TABLE IF EXISTS `c_sub_company`;

CREATE TABLE `c_sub_company` (
  `id` bigint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL unique COMMENT '名称',
  `branch_company_id` bigint(3) NOT NULL COMMENT '子公司所属分公司id',
  `type` bigint(1) DEFAULT '1' COMMENT '1:全资公司，2:合资公司',
  
  PRIMARY KEY (`id`),
  FOREIGN KEY (branch_company_id) REFERENCES c_branch_company(id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


/*Table structure for table `c_user_sub_company_rel` */

DROP TABLE IF EXISTS `c_user_sub_company_rel`;

CREATE TABLE `c_user_sub_company_rel` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  FOREIGN KEY (user_id) REFERENCES u_user(id) ON DELETE CASCADE,
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/* 收入类型表*/
DROP TABLE IF EXISTS `c_income_type`;

CREATE TABLE `c_income_type` (
  `id` bigint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;



/* 收入表*/
DROP TABLE IF EXISTS `c_income`;

CREATE TABLE `c_income` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `income_type_id` bigint(3) NOT NULL  COMMENT '收入类型',
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `desc` varchar(64) default null COMMENT '描述',
  `date` date NOT NULL  COMMENT '日期',
  `amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE,
  FOREIGN KEY (income_type_id) REFERENCES c_income_type(id) 
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/* 支出类型表*/
DROP TABLE IF EXISTS `c_cost_type`;

CREATE TABLE `c_cost_type` (
  `id` bigint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;



/* 支出表*/
DROP TABLE IF EXISTS `c_cost`;

CREATE TABLE `c_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cost_type_id` bigint(3) NOT NULL  COMMENT '收入类型',
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `desc` varchar(64) default null COMMENT '描述',
  `date` date NOT NULL  COMMENT '日期',
  `amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE,
  FOREIGN KEY (cost_type_id) REFERENCES c_cost_type(id) 
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/* 支出类型表*/
DROP TABLE IF EXISTS `c_bank`;

CREATE TABLE `c_bank` (
  `id` bigint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '银行名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;



/* 子公司银行余额*/
DROP TABLE IF EXISTS `c_sub_company_bank_balance`;

CREATE TABLE `c_sub_company_balance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `bank_id` bigint(3)  default null COMMENT '银行id',
  `amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE,
  FOREIGN KEY (bank_id) REFERENCES c_bank(id)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;



/* 子公司银行余额历史表*/
DROP TABLE IF EXISTS `c_sub_company_his_balance`;

CREATE TABLE `c_sub_company_his_balance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `bank_id`  bigint(3) default null COMMENT '银行id',
  `amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  `date` date NOT NULL COMMENT '日期',
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE,
  FOREIGN KEY (bank_id) REFERENCES c_bank(id)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/* 子公司银行余额历史表*/
DROP TABLE IF EXISTS `c_sub_company_total_balance`;

CREATE TABLE `c_sub_company_total_balance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  `date` date NOT NULL COMMENT '日期',
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;




/* 不可用资金类型 */
DROP TABLE IF EXISTS `c_invalid_capital_type`;

CREATE TABLE `c_invalid_capital_type` (
  `id` bigint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/* 子公司 不可用资金 表*/
DROP TABLE IF EXISTS `c_invalid_capital`;

CREATE TABLE `c_invalid_capital` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invalid_capital_type_id` bigint(3) NOT NULL  COMMENT '不可用资金类型',
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `desc` varchar(64) default null COMMENT '描述',
  `date` date NOT NULL  COMMENT '日期',
  `amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  `change_amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '与昨日差异', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE,
  FOREIGN KEY (invalid_capital_type_id) REFERENCES c_invalid_capital_type(id) 
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;



/* 子公司 不可用资金 历史纪录 表*/
DROP TABLE IF EXISTS `c_his_invalid_capital`;

CREATE TABLE `c_his_invalid_capital` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invalid_capital_type_id` bigint(3) NOT NULL  COMMENT '不可用资金类型',
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `desc` varchar(64) default null COMMENT '描述',
  `date` date NOT NULL  COMMENT '日期',
  `amount` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '金额', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE,
  FOREIGN KEY (invalid_capital_type_id) REFERENCES c_invalid_capital_type(id) 
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/* 工抵余额纪录 表*/
DROP TABLE IF EXISTS `c_gongdi_balance`;

CREATE TABLE c_gongdi_balance ( 
    id            	bigint(20) NOT NULL AUTO_INCREMENT,
    date          	date COMMENT '日期'  NOT NULL,
    amount        	decimal(12,5) COMMENT '工抵余额' default  0,
    sub_company_id	bigint(3) COMMENT '子公司ID'  NOT NULL ,
     PRIMARY KEY (`id`),
     FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE
    )ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 
COMMENT = '工抵余额信息' ;


/* sms 记录表 */
DROP TABLE IF EXISTS `c_sms_record`;

CREATE TABLE `c_sms_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content1` TEXT NOT NULL COMMENT '资金余额',
  `content2` TEXT NOT NULL COMMENT '可用资金差异',
  `content3` TEXT NOT NULL COMMENT '收入明细',
  `content4` TEXT NOT NULL COMMENT '支出明细',
  `content5` TEXT NOT NULL COMMENT '工抵余额',
  `content6` TEXT NOT NULL COMMENT '合资公司',
  `content7` TEXT NOT NULL COMMENT '扩展字段',
  `content8` TEXT NOT NULL COMMENT '扩展字段',
  `content9` TEXT NOT NULL COMMENT '扩展字段',
  `date` date NOT NULL  COMMENT '日期',
  `random_code` varchar(64) NOT NULL COMMENT '访问随机码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/* 资金数据提交状态*/
DROP TABLE IF EXISTS `c_process_status`;

CREATE TABLE `c_process_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_company_id` bigint(3) NOT NULL COMMENT '子公司ID',
  `date` date NOT NULL  COMMENT '日期',
  `status` bigint(1) NOT NULL  DEFAULT 0 COMMENT '0 保存未提交；1 已上报；-1 被撤回', 
  PRIMARY KEY (`id`),
  FOREIGN KEY (sub_company_id) REFERENCES c_sub_company(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

