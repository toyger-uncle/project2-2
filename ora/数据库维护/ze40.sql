prompt Importing table ze40...
set feedback off
set define off
insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-031-00', '定点医疗机构信息维护', null, '1', '定点医疗机构信息变更', 'hospitalModifyInteraction', 'modifyHospitalInfo', '定点医疗机构', 'UCK030');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-031-01', '定点医疗机构信息维护提交', null, '1', '定点医疗机构信息维护提交', 'hospitalModifyInteraction', 'summitHospitalInfo', '定点医疗机构', 'UCK030');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-034-00', '上传常用文档', null, '1', '上传常用文档', 'announcementInteraction', 'FILeSave', null, 'UCK041');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-034-02', '删除已上传的附件', null, '1', '删除已上传的附件', 'announcementInteraction', 'deleteFile', null, 'UCK041');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-037-00', '康复技师信息注销', null, '1', '康复技师信息注销', 'hospitalPersonAddInteraction', 'lockKf', null, 'UCK037');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-038-00', '康复技师注销恢复', null, '1', '康复技师注销恢复', 'hospitalPersonAddInteraction', 'unlockKf', null, 'UCK038');
insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-022-00', '已发布公告信息变更', null, '1', '已发布公告信息变更', 'announcementInteraction', 'noticemodify', null, 'UCK022,UCK023,UCK024');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-027-00', '短信发送保存', null, '1', '短信发送保存', 'messageInteraction', 'MessageSave', '短信发送', 'UCK027');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-021-00', '保存公告发布信息', null, '1', '保存公告发布信息', 'announcementInteraction', 'saveBulletinInfo', null, 'UCK022,UCK023,UCK024');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-Q-041-00', '根据序号（个编）查询康复技师信息', null, '1', '根据序号（个编）查询康复技师信息', 'hospitalPersonAddInteraction', 'queryKfjsInfo', null, 'UCK034');


insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-041-00', '康复技师人员新增', null, '1', '康复技师人员新增', 'hospitalPersonAddInteraction', 'addPersonInfo', null, 'UCK034');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-041-01', '康复技师人员变更', null, '1', '康复技师人员变更', 'hospitalPersonAddInteraction', 'modifyKfjsInfo', null, 'UCK034');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-041-02', '康复技师人员删除', null, '1', '康复技师人员删除', 'hospitalPersonAddInteraction', 'delPersonInfo', null, 'UCK034');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-041-03', '提交康复技师人员信息', null, '1', '提交康复技师人员信息', 'hospitalPersonAddInteraction', 'summitKfjsInfo', null, 'UCK034');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-041-04', '批量导入康复技师信息', null, '1', '批量导入康复技师信息', 'hospitalPersonAddInteraction', 'plimportPersonInfo', null, 'UCK034');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-Q-057-00', '医师基本信息查询', null, '1', '根据医师资格证书编号查询医师基本信息', 'hospitalDoctorInteraction', 'queryBasicInfo', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-Q-057-01', '医师信息查询', null, '1', '根据医师资格证书编号和所在医院工号查询医师信息', 'hospitalDoctorInteraction', 'queryPersonInfo', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-Q-058-00', '查询医师库医师已上传的资料', null, '1', '查询医师库医师已上传的资料', 'uploadDoctoeInfoInteraction ', 'queryphoto', null, 'UCK058');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-057-05', '修改医师其他信息', null, '1', '修改医师其他信息', 'hospitalDoctorInteraction', 'modifydoctoyqtInfo', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-058-00', '医保库医师提交材料的上传', null, '1', '上传医保库医师提交材料', 'uploadDoctoeInfoInteraction ', 'filesave', null, 'UCK058');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-057-06', '批量导入医师信息', null, '1', '批量导入医师信息', 'hospitalDoctorInteraction', 'plimportinfo', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-057-02', '医师第一执业点暂存信息', null, '1', '医师第一执业点暂存信息', 'hospitalDoctorInteraction', 'saveFirstDoctor', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-057-01', '医师其他职业点暂存信息', null, '1', '医师其他执业点暂存信息', 'hospitalDoctorInteraction', 'saveotherdoctor', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-057-10', '医师信息提交审核', null, '1', '医师信息提交审核', 'hospitalDoctorInteraction', 'sumitdoctorInfo', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-057-03', '修改医师信息', null, '1', '修改医师信息', 'hospitalDoctorInteraction', 'modifydoctor', null, 'UCK057');

insert into ze40 (BZE400, BZE401, BZE402, BZE403, BZE404, BZE405, BZE406, BZE407, BZE090)
values ('REQ-KA-M-057-04', '删除医师信息', null, '1', '删除医师信息', 'hospitalDoctorInteraction', 'deleteDoctorinfo', null, 'UCK057');




prompt Done.
