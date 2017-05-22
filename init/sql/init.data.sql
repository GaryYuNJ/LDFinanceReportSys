/*
SQLyog 企业版 - MySQL GUI v7.14 
MySQL - 5.6.16-log : Database - i_wenyiba_com
*********************************************************************
*/

/*所有的表数据插入*/

/*Data for the table `u_permission` */

insert  into `u_permission`(`id`,`url`,`name`) values (4,'/permission/index.shtml','权限列表'),(6,'/permission/addPermission.shtml','权限添加'),(7,'/permission/deletePermissionById.shtml','权限删除'),(8,'/member/list.shtml','用户列表'),(9,'/member/online.shtml','在线用户'),(10,'/member/changeSessionStatus.shtml','用户Session踢出'),(11,'/member/forbidUserById.shtml','用户激活&禁止'),(12,'/member/deleteUserById.shtml','用户删除'),(13,'/permission/addPermission2Role.shtml','权限分配'),(14,'/role/clearRoleByUserIds.shtml','用户角色分配清空'),(15,'/role/addRole2User.shtml','角色分配保存'),(16,'/role/deleteRoleById.shtml','角色列表删除'),(17,'/role/addRole.shtml','角色列表添加'),(18,'/role/index.shtml','角色列表'),(19,'/permission/allocation.shtml','权限分配'),(20,'/role/allocation.shtml','角色分配');

/*Data for the table `u_appointments` */
insert  into `u_appointments`
(id, `name`, commission_flag, commission_ratio, commi_calcu_method, house_relation)
 values 
 (1, '置业顾问', 1, 1.4, 1, 2), 
(2, '案场经理', 1, 1.4, 2, 1), (3, '案场副经理（主持工作）', 1, 1.4, 2, 1), (4, '案场副经理（非主持工作）', 1, 1.4, 2, 1), (5, '案场经理助理', 1, 1.4, 2, 1), 
(6, '渠道业务管理', 1, 1.4, 2, 1), (7, '渠道专员', 1, 1.4, 2, 1), (8, '渠道经理', 1, 1.4, 2, 1), (9, '渠道总监', 1, 1.4, 2, 1), 
(10, '大客户经理', 1, 1.4, 2, 1), (11, '大客户经理助理', 1, 1.4, 2, 1), (12, '大客户总监', 1, 1.4, 2, 1), (13, '大客户副总监', 1, 1.4, 2, 1), 
(14, '销售支持', 1, 1.4, 2, 1), 
(15, '收银员', 0, 1.4, 2, 1), (16, '会计', 0, 1.4, 2, 1), (17, '财务经理', 0, 1.4, 2, 1), (18, '内审', 0, 1.4, 2, 1), 
(19, '其他', 0, 1.4, 2, 1)
;

/*Data for the table `u_role` */

insert  into `u_role`
(id, `name`, code, appointments_id)
 values 
 (1,'系统管理员','888888',null), (3,'权限角色','100003',null), (4,'用户中心','100002',null),
 (5, '置业顾问', '100004', 1), 
(6, '案场经理', '100005', 2), (7, '案场副经理（主持工作）', '100006', 3), (8, '案场副经理（非主持工作）', '100007', 4), (9, '案场经理助理', '100008', 5), 
(10, '渠道业务管理', '100009', 6), (11, '渠道专员', '100010', 7), (12, '渠道经理', '100011', 8), (13, '渠道总监', '100012', 9), 
(14, '大客户经理', '100013', 10), (15, '大客户经理助理', '100014', 11), (16, '大客户总监', '100015', 12), (17, '大客户副总监', '100016', 13), 
(18, '销售支持后台主管', '100017', 14), (19, '销售支持后台服务', '100018', 14), 
(20, '收银员', '100019', 15), (21, '会计', '100020', 16), (22, '财务经理', '100021', 17), (23, '内审', '100022', 18), 
(24, '其他', '100023', 19)
;

/*Data for the table `u_role_permission` */

insert  into `u_role_permission`(`rid`,`pid`) values (4,8),(4,9),(4,10),(4,11),(4,12),(3,4),(3,6),(3,7),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(1,4),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20);

/*Data for the table `u_user` */

insert  into `u_user`(`id`,`nickname`,`mobile`,`email`,`pswd`,`create_time`,`last_login_time`,`status`) values 
(1,'管理员','admin','admin','57dd03ed397eabaeaa395eb740b770fd','2016-06-16 11:15:33','2016-06-16 11:24:10',1),
(11,'1111','1111','8446@qq.com','d57ffbe486910dd5b26d0167d034f9ad','2016-05-26 20:50:54','2016-06-16 11:24:35',1),
(12,'2222','2222','2222','4afdc875a67a55528c224ce088be2ab8','2016-05-27 22:34:19','2016-06-15 17:03:16',1);

/*Data for the table `u_user_role` */

insert  into `u_user_role`(`uid`,`rid`) values (12,4),(11,3),(11,4),(1,1);


insert  into `house_status`
(`id`,`name`) 
values 
(1,'在售'),(2,'已收诚意金订金'),(3,'已签约'),(4,'已全额支付'),
(5,'已收首付'),(6,'已收按揭款'),(7,'已交房'),(8,'已结佣');


	
insert  into `house_sale_type`
(`id`,`name`,dimission_avaliable) 
values 
(1,'普通',1),(2,'团购/大单',1),(3,'正常工抵',1),(4,'集中工抵',1),
(5,'定向销售',1),(6,'工抵转自销',1);



insert  into `house_business_type`
(`id`,`name`,dimission_avaliable) 
values 
(1,'办公',1),(2,'车库/储藏',1),(3,'商业',1),(4,'住宅',1),
(5,'未分配',0);


insert  into `house_business_sub_type`
(`id`,`name`,parent_id) 
values 
(1,'非人防车库',2),(2,'地上车库位',2),(3,'人防车库',2),(13,'储藏室',2),
(4,'配套商业',3),(5,'整体商业',3),(14,'商业街',3),
(7,'普通住宅',4),(15,'花园洋房',4),(6,'联排别墅',4),
(8,'甲级办公',1),(9,'普通办公',1),(10,'loft',1),(11,'酒店式公寓',1),(16,'准甲办公',1),
(12,'未分配',5);



insert  into `house_type`
(`id`,`name`) 
values 
(1,'大卡'),(2,'小卡'),(3,'签约'),(4,'认购');


insert  into `commission_calculate_type`
(`id`,`name`) 
values 
(1,'固定金额'),(2,'按佣金提点'),(3,'不计佣金');



insert  into `house_buy_method`
(`id`,`name`) 
values 
(1,'一次性付款'),(2,'按揭');



insert  into `house_mortgage_type`
(`id`,`name`) 
values 
(1,'纯公积金'),(2,'纯商业'),(3,'组合');



insert  into `contract_money_type`
(`id`,`name`) 
values 
(1,'定金'),(2,'一次性付款'),(3,'首付款'),(4,'公积金按揭款'),(5,'商业按揭款');




/*
 * 角色对应的个人提佣比例配置表(销售支持 需求)
         配置的销售支持佣金提点比例是对应全部销售支持的总佣金，根据配置的人员数量不同，具体的佣金提点比例要再乘以下面的个人比例：
                    销售支持人数为3人的案场，主管岗位设置1人，个人提佣比例为60%，服务人员岗位设置2人，个人提佣比例为20%，合计提佣比例100%；
                    销售支持人数为2人的案场，主管岗位个人提佣比例为70%，服务人员岗位提佣比例为30%,合计提佣比例100%；
                    销售支持人数为1人的案场，合计提佣比例100%。
 */

insert  into `appointments_num_config`
(id,`appointments_id`,user_number) 
values 
(1,14,1),(2,14,2),(3,14,3);


insert  into `commission_appoint_role_config`
(id, `appoint_config_id`, role_id, role_user_number, percent) 
values 
(1,1,18,1,100),(2,1,19,1,100),
(3,2,18,1,70),(4,2,18,2,50),(5,2,19,1,30),(6,2,19,2,50),
(7,3,18,1,60),(8,3,18,2,40),(9,3,18,3,33.3),(10,3,19,1,20),(11,3,19,2,20),(12,3,19,3,33.3)
;


insert  into `ratio_commission_type`
(`id`,`name`) 
values 
(1,'日常结佣'),(2,'季度奖金'),(3,'年度奖金'),(4,'交房奖金');


insert  into `default_ratio_commission_method`
(`commission_type_id`,`ratio`,start_time,end_time) 
values 
(1,70, '2000-12-30 00:00:00', '2016-12-31 23:59:59'),
(2,10, '2000-12-30 00:00:00', '2016-12-31 23:59:59'),
(3,15, '2000-12-30 00:00:00', '2016-12-31 23:59:59'),
(4,5, '2000-12-30 00:00:00', '2016-12-31 23:59:59'),

(1,80, '2017-1-1 00:00:00', '2099-12-31 23:59:59'),
(2,5, '2017-1-1 00:00:00', '2099-12-31 23:59:59'),
(3,10, '2017-1-1 00:00:00', '2099-12-31 23:59:59'),
(4,5, '2017-1-1 00:00:00', '2099-12-31 23:59:59')
;
/*销售支持岗位(后台)岗位:
           日常结佣(85%)、
                     季度奖金 0
           年度奖金(10%)、
           交房奖金(5%)
 * */


insert  into `appoint_ratio_commission_method`
(appointments_id,`commission_type_id`,`ratio`,start_time,end_time) 
values 
(14, 1,85, '2000-12-30 00:00:00', '2099-12-31 23:59:59'),
(14, 2,0, '2000-12-30 00:00:00', '2099-12-31 23:59:59'),
(14, 3,10, '2000-12-30 00:00:00', '2099-12-31 23:59:59'),
(14, 4,5, '2000-12-30 00:00:00', '2099-12-31 23:59:59');













