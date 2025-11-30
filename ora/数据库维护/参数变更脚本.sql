
------------------------add by wu.xf 20150423    begin--------------------------------------
prompt Importing table az10...
set feedback off
set define off
insert into az10 (BAZ001, BAZ002, AAZ011, AAZ012, AAZ013, AAZ014, AAZ015, TABLE_NAME, IMP_LOGIC_ID, DATASETNAME, CALLBACKBEANNAME)
values ('3', '3', 'medOraInfoManage', '0', '1', '0', '90', 'kb01_jl', 'medOraInfoManage', 'local.medicare.kb01_jl', null);

insert into az10 (BAZ001, BAZ002, AAZ011, AAZ012, AAZ013, AAZ014, AAZ015, TABLE_NAME, IMP_LOGIC_ID, DATASETNAME, CALLBACKBEANNAME)
values ('2', '2', 'recoveryNew', '0', '1', '0', '11', 'kc29_ys_tmp', 'recoveryNew', 'local.medicare.hospital.kc29_ys_tmp', null);

insert into az10 (BAZ001, BAZ002, AAZ011, AAZ012, AAZ013, AAZ014, AAZ015, TABLE_NAME, IMP_LOGIC_ID, DATASETNAME, CALLBACKBEANNAME)
values ('6', '6', 'doctorOtherIn', '0', '1', '0', '11', 'kc29_ys_tmp', 'doctorOtherIn', 'local.medicare.hospital.kc29_ys_tmp', 'doctorOtherImportApplogic');

insert into az10 (BAZ001, BAZ002, AAZ011, AAZ012, AAZ013, AAZ014, AAZ015, TABLE_NAME, IMP_LOGIC_ID, DATASETNAME, CALLBACKBEANNAME)
values ('1', '1', 'sortMessageIn', '0', '1', '0', '8', 'km01_imp', 'sortMessageIn', 'local.medicare.Message.km01_imp', null);

insert into az10 (BAZ001, BAZ002, AAZ011, AAZ012, AAZ013, AAZ014, AAZ015, TABLE_NAME, IMP_LOGIC_ID, DATASETNAME, CALLBACKBEANNAME)
values ('4', '4', 'reciver', '0', '1', '0', '1', 'reciver', 'reciver', 'local.medicare.baseoffice.reciver', 'notsave');

insert into az10 (BAZ001, BAZ002, AAZ011, AAZ012, AAZ013, AAZ014, AAZ015, TABLE_NAME, IMP_LOGIC_ID, DATASETNAME, CALLBACKBEANNAME)
values ('5', '5', 'doctorBasicIn', '0', '1', '0', '13', 'ac01_ys_tmp', 'doctorBasicIn', 'local.medicare.hospital.ys.ac01_ys_tmp', 'doctorBasicImportApplogic');

prompt Done.

prompt Importing table az11...
set feedback off
set define off
insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '1', 'AC01_YS_TMP_BAC342', '定点机构名称', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '2', 'AC01_YS_TMP_BAC332', '医师资格证书编号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '3', 'AC01_YS_TMP_AAC003', '姓名', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '4', 'AC01_YS_TMP_AAC004', '性别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '5', 'AC01_YS_TMP_AAC058', '证件类型', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '6', 'AC01_YS_TMP_AAC147', '证件号码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '7', 'AC01_YS_TMP_BKE049', '医师级别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '8', 'AC01_YS_TMP_BAC337', '执业医师类别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '9', 'AC01_YS_TMP_BAC338', '执业资格取得时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '10', 'AC01_YS_TMP_BAC344', '职称', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '11', 'AC01_YS_TMP_BAC345', '职称取得时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '12', 'AC01_YS_TMP_BAC339', '执业范围', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '13', 'AC01_YS_TMP_BKF054', '医师执业证书编号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '13', 'KB01_JL_BKB301', '医保等级', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '14', 'KB01_JL_BKB302', '分管医保办负责人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '15', 'KB01_JL_BKA100', '定点机构经济类型', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '16', 'KB01_JL_BKA081', '对内服务标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '17', 'KB01_JL_BKA937', '所有制类型 ', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '18', 'KB01_JL_BKA938', '营利类型 ', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '19', 'KB01_JL_BKB010', '分院标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '20', 'KB01_JL_BKA940', '联网结算标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '21', 'KB01_JL_BKA941', '市内医院标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '22', 'KB01_JL_BKA943', '定点机构其他名称', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '23', 'KB01_JL_AAE004', '医保联系人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '24', 'KB01_JL_AAE005', '联系电话', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '25', 'KB01_JL_AAE006', '地址', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '26', 'KB01_JL_AAE007', '邮政编码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '27', 'KB01_JL_BAE010', '银行类别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '28', 'KB01_JL_BAB024', '开户银行名称', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '29', 'KB01_JL_AAE008', '银行行号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '30', 'KB01_JL_AAE009', '户名', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '31', 'KB01_JL_AAE010', '银行账号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '32', 'KB01_JL_BKA932', '体检医院标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '33', 'KB01_JL_BKA967', '支付联行号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '34', 'KB01_JL_BKA968', '营业许可证号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '35', 'KB01_JL_BKA975', '分管医保负责人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '36', 'KB01_JL_BKA976', '医疗技术范围', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '37', 'KB01_JL_BKA977', '手机号码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '38', 'KB01_JL_BKA978', '传真号码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '39', 'KB01_JL_BKA979', '开发商', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '40', 'KB01_JL_BKA980', '开发商负责人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '41', 'KB01_JL_BKA981', '开发商联系电话', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '42', 'KB01_JL_BKA983', '首次批准定点日期', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '43', 'KB01_JL_BKA994', '省一卡通标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '44', 'KB01_JL_BKA995', '市一卡通标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '45', 'KB01_JL_BKA997', '邮箱', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '46', 'KB01_JL_BKB310', '单病种资格', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '47', 'KB01_JL_AAB301', '所属地行政区代码（备用）', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '48', 'KB01_JL_BAZ001', '记录编号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '49', 'KB01_JL_BAZ002', '操作序号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '50', 'KB01_JL_BZE011', '创建经办人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '51', 'KB01_JL_BZE036', '创建经办日期', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '52', 'KB01_JL_AAE011', '经办人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '53', 'KB01_JL_AAE036', '经办时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '54', 'KB01_JL_AAA027', '所属统筹区编码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '55', 'KB01_JL_AAB034', '社保经办机构编码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '56', 'KB01_JL_BKE160', '复核结果', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '57', 'KB01_JL_BKE161', '复核人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '58', 'KB01_JL_BKE162', '复核时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '59', 'KB01_JL_BKC864', '复核意见', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '60', 'KB01_JL_BKA998', '康复定点资格', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '61', 'KB01_JL_AKB040', '工伤新增标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '62', 'KB01_JL_BKA996', '医保办负责人电话', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '63', 'KB01_JL_BKA993', '公立医院改革标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '64', 'KB01_JL_BKB011', '基本医疗保险管理部门', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '65', 'KB01_JL_BKB028', '体检医院联系电话', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '66', 'KB01_JL_BKB029', '药品许可证', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '67', 'KB01_JL_AKB135', '上城区公费医疗标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '68', 'KB01_JL_AKB136', '下城区公费医疗标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '69', 'KB01_JL_AKB137', '江干区公费医疗标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '70', 'KB01_JL_AKB138', '拱墅区公费医疗标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '71', 'KB01_JL_AKB139', '西湖区公费医疗标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '72', 'KB01_JL_AKB140', '滨江区公费医疗标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '73', 'KB01_JL_AKB141', '所属城区', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '74', 'KB01_JL_BKA992', '医保评级', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '75', 'KB01_JL_BKB500', '医保联系人手机', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '76', 'KB01_JL_BKB501', '医院信息部门联系人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '77', 'KB01_JL_BKB502', '医院信息部门联系电话', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '78', 'KB01_JL_BKB503', '医保办负责人', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '79', 'KB01_JL_BKB504', '医保办联系电话', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '80', 'KB01_JL_BKB505', '医院信息部门手机', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '81', 'KB01_JL_BKF993', '公立医院诊疗费改革标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '82', 'KB01_JL_BKA990', '公立医院标志开始时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '83', 'KB01_JL_BKB801', '核定床位数', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '84', 'KB01_JL_BKB800', '省统一编码 ', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '85', 'KB01_JL_BKB803', '建床机构标志 ', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '86', 'KB01_JL_BKB802', '护理机构标志 ', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '87', 'KB01_JL_BKB600', '异地就医启用标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '88', 'KB01_JL_BKB601', '异地就医启用时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '89', 'KB01_JL_AAE901', '暂停中药饮片资格开始时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'medOraInfoManage', '90', 'KB01_JL_AAE902', '暂停中药饮片资格终止时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '11', 'KC29_YS_TMP_AAE003', '备注', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '10', 'KC29_YS_TMP_BAC351', '本院服务结束时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '9', 'KC29_YS_TMP_BAC349', '本院服务开始时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '8', 'KC29_YS_TMP_BAC348', '专业技术资格授予时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '7', 'KC29_YS_TMP_BKC331', '临床科别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '6', 'KC29_YS_TMP_BAC347', '专业技术名称（类别）', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '5', 'KC29_YS_TMP_BAC346', '资格级别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '4', 'KC29_YS_TMP_AAC004', '性别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '3', 'KC29_YS_TMP_AAC002', '身份证号码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '2', 'KC29_YS_TMP_AAC001', '工号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '1', 'KC29_YS_TMP_AAC003', '姓名', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'recoveryNew', '0', 'KC29_YS_TMP_AKB020', '医疗服务机构编号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '11', 'KC29_YS_TMP_BKC331', '执业科别', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '10', 'KC29_YS_TMP_AKC291', '医师首次申报时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '9', 'KC29_YS_TMP_AAE005', '手机号码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '8', 'KC29_YS_TMP_BAC349', '协议开始时间', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '7', 'KC29_YS_TMP_BKF048', '评估医师标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '6', 'KC29_YS_TMP_BKF049', '签约医师标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '5', 'KC29_YS_TMP_BAC341', '自由执业标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '4', 'KC29_YS_TMP_BKE054', '技术交流标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '3', 'KC29_YS_TMP_AAC020', '行政职务', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '2', 'KC29_YS_TMP_AAC001', '工号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '1', 'KC29_YS_TMP_BAC332', '医师资格证书编号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '0', 'KC29_YS_TMP_AKB020', '医疗机构编号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorOtherIn', '90', 'KC29_YS_TMP_AKC290', 'SEQ_KC29_YS_2_AKC290', '91');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '4', 'KM01_IMP_AKA101', '医疗等级', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '3', 'KM01_IMP_AKB022', '类型', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '2', 'KM01_IMP_AKC803', '所属统筹区', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '1', 'KM01_IMP_AKB021', '定点医疗机构名称', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '0', 'KM01_IMP_AKB020', '定点医疗机构编码', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '8', 'KM01_IMP_BKA995', '市一卡通标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '7', 'KM01_IMP_BKA994', '省一卡通标志', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '6', 'KM01_IMP_BKA938', '营利类型', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'sortMessageIn', '5', 'KM01_IMP_AKB023', '定点医疗机构状态', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'reciver', '1', 'REVNAME', '收件人姓名', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'reciver', '0', 'REVID', '收件人id', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '0', 'AC01_YS_TMP_BAC341', '医疗机构编号', '12');

insert into az11 (BAZ001, BAZ002, IMP_LOGIC_ID, AAZ015, COLUMN_NAME, OHTHERINFO, DATATYPE)
values (null, null, 'doctorBasicIn', '90', 'AC01_YS_TMP_BAZ002', 'SEQ_A_BAZ002', '91');

prompt Done.

------------------------add by wu.xf 20150423    end--------------------------------------

