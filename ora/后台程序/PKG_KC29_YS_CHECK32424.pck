CREATE OR REPLACE PACKAGE PKG_KC29_YS_CHECK IS

 PROCEDURE PRC_A_IMPORT(PRM_AKC290 IN VARCHAR2, --医院
                       -- PRM_AAC001 IN VARCHAR2, --工号
                        PRM_APPCODE    OUT NUMBER,
                        PRM_ERRORMSG     OUT VARCHAR2);

  PROCEDURE PRC_A_INSERT(PRM_akc290 IN VARCHAR2, --xuhao
                         PRM_AAE013 IN VARCHAR2, --状态（1新增，2变更，3注销）
                              PRM_APPCODE    OUT NUMBER,
                              PRM_ERRORMSG     OUT VARCHAR2);

  PROCEDURE PRC_KC29_YS_1_JY(PRM_AKC290 IN INTEGER,
                             PRM_nup    in varchar,        
                             PRM_APPCODE OUT NUMBER,
                             PRM_OUTDATA OUT VARCHAR2);
                             
  PROCEDURE PRC_OTHER_JY(PRM_AAC001 IN VARCHAR2,
                             PRM_AKB020 IN VARCHAR2,                     
                             PRM_APPCODE OUT NUMBER,
                             PRM_ERRORMSG OUT VARCHAR2);
  function Fun_kc29_ys_1_bkc331(bkc331 VARCHAR2, hz020 VARCHAR2)
    RETURN varchar2;
  -- Author  : VIVIAN
  -- Created : 2007-4-18 11:02:46
  -- Purpose : --就业局接口
  PROCEDURE prc_ID15TO18(prm_ID15     IN VARCHAR2,
                         prm_ID18     OUT VARCHAR2,
                         prm_AppCode  OUT NUMBER,
                         prm_ErrorMsg OUT VARCHAR2);
  PROCEDURE prc_ID18TO15(prm_ID18     IN VARCHAR2,
                         prm_ID15     OUT VARCHAR2,
                         prm_AppCode  OUT NUMBER,
                         prm_ErrorMsg OUT VARCHAR2);
END PKG_KC29_YS_CHECK;
/
CREATE OR REPLACE PACKAGE BODY PKG_KC29_YS_CHECK IS
  /*----------------------------------数据类型声明----------------------------------------*/
  TYPE TYPE_ARRY IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
  --源字符串
  STR_SOURCE VARCHAR2(32767);
  /*-------------------------------------------------------------------------
  || 函数名称 ：字符串分解函数，将一个以特殊分隔符隔开的字符串分解出来,没调用一次分解一个分隔符
  || 参数描述 ：参数标识        名称                输入/输出    类型
  ||            -------------------------------------------------------------
  ||            separatOR  分隔符              输入       VARCHAR2
  ||
  || 作    者 ：
  ||-------------------------------------------------------------------------
  || 修改记录 ：
  ||-------------------------------------------------------------------------*/
  FUNCTION FUNC_GET_TOKEN(SEPARATOR VARCHAR2) RETURN VARCHAR2 IS
    POSTION NUMBER;
    RET     VARCHAR2(4000);
  BEGIN
  
    POSTION := INSTR(STR_SOURCE, SEPARATOR);
    IF POSTION = 0 THEN
      RET        := STR_SOURCE;
      STR_SOURCE := ' ';
    ELSE
      RET        := SUBSTR(STR_SOURCE, 1, POSTION - 1);
      STR_SOURCE := SUBSTR(STR_SOURCE, POSTION + 1);
    END IF;
    RETURN RET;
  END;
  /*--------------------------------------------------------------------------
  || 过程名称 ：prc_k_分解字符串
  || 功能描述 ：将入参字符串中的参数放入到数组中
  || 参数描述 ：参数标识        名称                输入/输出    类型
  ||            -------------------------------------------------------------
  ||            prm_string      字符串入参              输入       VARCHAR2
  ||            prm_array       出参数组                输出       type_arry
  ||            prm_count       数组长度                输出       NUMBER
  ||            prm_AppCode     执行代码                输出       NUMBER
  ||            PRM_ERRORMSG      出错信息                输出       VARCHAR2
  || 作    者 ：董吉红   完成日期 ：20100926
  ||--------------------------------------------------------------------------
  || 修改记录 ：
  ||-------------------------------------------------------------------------*/
  PROCEDURE PRC_K_分解字符串(PRM_STRING  IN VARCHAR2,
                        PRM_ARRAY   OUT TYPE_ARRY,
                        PRM_COUNT   OUT NUMBER,
                        PRM_APPCODE OUT NUMBER,
                        PRM_ERRORMSG  OUT VARCHAR2) IS
  BEGIN
    PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;
    PRM_COUNT   := 0;
    -- 将入参赋值给全局变量，这样才能使用分解字符串的方法
    STR_SOURCE := PRM_STRING;
  
    WHILE TRIM(STR_SOURCE) IS NOT NULL LOOP
      PRM_COUNT := PRM_COUNT + 1;
      PRM_ARRAY(PRM_COUNT) := FUNC_GET_TOKEN(',');
    END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      PRM_APPCODE := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG  := SQLERRM;
  END PRC_K_分解字符串;
     /*-------------------------------------------------------------------------------
  * PRC_DOSAVERECIVER
  * chengzhp@neusoft.com
  * 功能描述：批量导入
  * date:2015-03-20
  /*-------------------------------------------------------------------------------*/
  
   PROCEDURE PRC_A_IMPORT(PRM_AKC290 IN VARCHAR2, --医院
                        --PRM_AAC001 IN VARCHAR2, --工号
                        PRM_APPCODE    OUT NUMBER,
                        PRM_ERRORMSG     OUT VARCHAR2) is
      V_AKC290 VARCHAR2(20);
      V_count number(20);
       REC_AKB020S TYPE_ARRY;
      REC_AAC001S TYPE_ARRY;
      REC_COUNT    NUMBER(3);
 BEGIN
    -- 1.初始化
    PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;
        --循环分解的数据插入收件人信息
          FOR REC_KC29_YSTMP IN (SELECT  *   
                                  FROM KC29_YS_TMP
                                  where akc290 =PRM_AKC290) LOOP
   
      if REC_KC29_YSTMP.AKB020  is not null and REC_KC29_YSTMP.AAC001 is not null then 
             PRC_OTHER_JY(REC_KC29_YSTMP.AAC001,
                          REC_KC29_YSTMP.AKB020 ,                     
                             PRM_APPCODE,
                             PRM_ERRORMSG);               
                if  PRM_APPCODE = PKG_CAA_MACRO.DEF_OK then 
                    INSERT INTO KC29_YS_1
                                       (AKC290,   --序号
                                        AKB020,   --医疗机构编号
                                        AAC001,   --医护人员编号
                                        AAC002,   --证件号码
                                        AAC003,   --姓名
                                        AAC004,   --性别
                                        BKC331,   --执业科别
                                        AAC020,   --行政职务
                                        BAC332,   --医师资格证书编号
                                        BAC337,   --执业医师类别
                                        BAC338,   --执业资格取得时间
                                        BAC339,   --医师执业范围
                                        BAC340,   --康复资质
                                        BAC341,   --第一执业地点
                                        BAC342,   --第二执业地点
                                        BAC343,   --第三执业地点
                                        BAC344,   --职称
                                        BAC345,   --职称取得时间
                                        BAC346,   --康复专业技术资格证书资格级别
                                        BAC347,   --康复专业技术资格证书专业技术名称
                                        BAC348,   --康复专业技术资格证书资格授予时间
                                        BAC349,   --本院服务开始时间
                                        AAE005,   --移动电话
                                        BAC350,   --医保服务资格状态
                                        AAE003,   --备注
                                        HZ050,   --审核标识
                                        AKC291,   --录入日期
                                        AKC293,   --反馈审核结果
                                        AAC020_1,   --行政职务_名称
                                        BAC344_1,   --职称_名称
                                        BAC337_1,   --执业医师类别_名称
                                        BAC339_1,   --医师执业范围_名称
                                        BAC351,   --本院服务结束时间
                                        BAC352,   --第四执业地点
                                        BKC331_1,   --执业科别名称
                                        BAC355,   --专业技术职务
                                        BAC355_1,   --专业技术职务_名称
                                        BKF054,   --医师执业证书编号
                                        BKE049,   --医师级别
                                        AAC058,   --证件类型
                                        BKE054,   --是否技术交流标志
                                        BKF049,   --是否签约医师标志
                                        BKF048,   --是否评估医师标志
                                        BKF094,   --技术交流开始时间
                                        BKF095,   --技术交流结束时间
                                        BKF093)   --移动电话
                                 VALUES
                                       (Pkg_caa_Comm.Fun_a_Getakc290,   --序号
                                         REC_KC29_YSTMP.akb020 ,   --医疗机构编号
                                        REC_KC29_YSTMP.AAC001,   --医护人员编号
                                        REC_KC29_YSTMP.AAC002,   --证件号码
                                        REC_KC29_YSTMP.AAC003,   --姓名
                                        substr(REC_KC29_YSTMP.AAC004,0,1),   --性别
                                        substr(REC_KC29_YSTMP.Bkc331,0,4),   --执业科别
                                        null,   --行政职务
                                        null,   --医师资格证书编号
                                        null,   --执业医师类别
                                        null,   --执业资格取得时间
                                        null,   --医师执业范围
                                        '1',   --康复资质
                                        null,   --第一执业地点
                                        null,   --第二执业地点
                                        null,   --第三执业地点
                                        null,   --职称
                                        null,   --职称取得时间
                                        REC_KC29_YSTMP.Bac346,   --康复专业技术资格证书资格级别
                                        REC_KC29_YSTMP.Bac347,   --康复专业技术资格证书专业技术名称
                                      to_date(REC_KC29_YSTMP.Bac348,'yyyy-MM-dd'),   --康复专业技术资格证书资格授予时间
                                      to_date(REC_KC29_YSTMP.Bac349,'yyyy-MM-dd'),   --本院服务开始时间
                                        null,   --移动电话
                                        null,   --医保服务资格状态
                                       REC_KC29_YSTMP.Aae003 ,   --备注
                                        '0' ,   --审核标识
                                        sysdate,   --录入日期
                                        null,   --反馈审核结果
                                        null,   --行政职务_名称
                                       null ,   --职称_名称
                                       null ,   --执业医师类别_名称
                                        null,   --医师执业范围_名称
                                       to_date(REC_KC29_YSTMP.Bac351,'yyyy-MM-dd') ,   --本院服务结束时间
                                        null,   --第四执业地点
                                     substr(REC_KC29_YSTMP.Bkc331,4,length(REC_KC29_YSTMP.Bkc331)),   --执业科别名称
                                      null ,   --专业技术职务
                                        null,   --专业技术职务_名称
                                        null,   --医师执业证书编号
                                        null,   --医师级别
                                        null,   --证件类型
                                        null,   --是否技术交流标志
                                       null ,   --是否签约医师标志
                                        null,   --是否评估医师标志
                                        null,   --技术交流开始时间
                                       null ,   --技术交流结束时间
                                        null);   --移动电话
                               update KC29_YS_TMP
                                set hz050='8'  --8 不通过 7 通过
                                where aac001= REC_KC29_YSTMP.AAC001
                                and   akb020= REC_KC29_YSTMP.akb020;
                       else
                                update KC29_YS_TMP
                                set hz050='7',  --8 不通过 7 通过
                                    AKC293=PRM_ERRORMSG
                                    where aac001= REC_KC29_YSTMP.AAC001
                                    and akb020= REC_KC29_YSTMP.akb020;
                                      GOTO NEXTPERSON;
                        end if;
               else 
                    delete from kc29_ys_tmp where akb020 is null or aac001 is null;
               end if;
               
                 <<NEXTPERSON>>
                               null; 
                       PRM_APPCODE := PKG_CAA_MACRO.DEF_OK; 
         
             END LOOP;
     EXCEPTION
    WHEN OTHERS THEN
      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG := '批量导入康复技师信息失败:' || SQLERRM;
      RETURN;
  END PRC_A_IMPORT;
  
  
   PROCEDURE PRC_OTHER_JY(PRM_AAC001 IN VARCHAR2,
                             PRM_AKB020 IN VARCHAR2,                     
                             PRM_APPCODE OUT NUMBER,
                             PRM_ERRORMSG OUT VARCHAR2) is
       V_AAC003 VARCHAR2(50);
        V_AAC002 VARCHAR2(30);
        V_AAC004 VARCHAR2(30);
        V_BAC346 VARCHAR2(30);
        V_BAC347  VARCHAR2(30);
        V_BKC331   VARCHAR2(30);
        V_BAC348    VARCHAR2(30);
        V_BAC349   VARCHAR2(30);
        V_count number(20);                    
    begin
        PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;
                select count(*)
                  into V_count
                  from kc29_ys_1
                  where aac001 = PRM_AAC001
                   and akb020 = PRM_AKB020;
                 if V_count>0 then
                       PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                       PRM_ERRORMSG  :=  '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员已存在，不能导入';
                        RETURN;
                  END IF;   
                      select  AAC003,
                               AAC002,
                               AAC004,
                               BAC346,
                               BAC347,
                               BKC331,
                               BAC348,
                               BAC349
                        into  V_AAC003,
                              V_AAC002,
                              V_AAC004,
                              V_BAC346,
                              V_BAC347,
                              V_BKC331,
                              V_BAC348,
                              V_BAC349
                        from kc29_ys_tmp
                       where aac001 = PRM_AAC001
                         and akb020 = PRM_AKB020;
                 IF V_AAC003 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员姓名为空，不能导入';
                      RETURN;
                  END IF;  
                  IF V_AAC002 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员身份证号码为空，不能导入';
                      RETURN;
                   END IF;  
                 IF V_AAC004 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                       PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员性别为空，不能导入';
                      RETURN;
                  END IF;  
                     IF V_BAC346 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员资格级别为空，不能导入';
                      RETURN;
                    END IF;  
                     IF V_BAC347 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                       PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员专业技术名称（类别）为空，不能导入';
                      RETURN;
                    END IF; 
                    IF V_BKC331 IS NULL THEN
                        PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                        PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员临床科别为空，不能导入';
                        RETURN;
                    END IF;   
                     IF V_BAC348 IS NULL THEN
                        PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                        PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员专业技术资格授予时间为空，不能导入';
                        RETURN;
                    END IF;  
                     IF V_BAC349 IS NULL THEN
                         PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                         PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员在本院服务开始时间为空，不能导入';
                         RETURN;
                    END IF;  
                  
   EXCEPTION
    WHEN OTHERS THEN
      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG := '校验不通过:' || SQLERRM;
      RETURN;
  END PRC_OTHER_JY;
                
   /*-------------------------------------------------------------------------------
  * PRC_DOSAVERECIVER
  * chengzhp@neusoft.com
  * 功能描述：插入收件人信息
  * date:2015-03-20
  /*-------------------------------------------------------------------------------*/
  PROCEDURE PRC_A_INSERT(PRM_akc290 IN VARCHAR2, --xuhao
                          PRM_AAE013 IN VARCHAR2, --状态（1新增，2变更，3注销）
                          PRM_APPCODE    OUT NUMBER,
                          PRM_ERRORMSG     OUT VARCHAR2) IS
    REC_AKC290S TYPE_ARRY;
     RESULT_STR varchar2(4000);
    REC_COUNT    NUMBER(3);
    V_AKC290     NUMBER(20);
    N_AKC290_OLD NUMBER(20);
    V_AKB020 varchar2(20);    --医院编号
    V_AAC147 varchar2(20);    --证件号码
    v_aae011   varchar2(50); 
    v_aaa027   varchar2(6);
  BEGIN
    -- 1.初始化
    PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;
    v_aae011 := pkg_caa_sys.FUN_GETAAE011;
    v_aaa027 := pkg_caa_sys.FUN_GETAAA027;
    --2.分解传入的收件人字符串
    PRC_K_分解字符串(PRM_akc290,
                REC_AKC290S,
                REC_COUNT,
                PRM_APPCODE,
                PRM_ERRORMSG);
    IF PRM_APPCODE = PKG_CAA_MACRO.DEF_ERR THEN
      PRM_ERRORMSG := '分解传入的康复技师序列号串出错：' || PRM_ERRORMSG;
      RETURN;
    END IF;
    --循环分解的数据插入收件人信息
    FOR I IN 1 .. REC_COUNT LOOP
      IF REC_AKC290S(I) IS NOT NULL THEN
                --获取序列号                    
                V_AKC290 :=  Pkg_caa_Comm.Fun_a_Getakc290;
                 prc_kc29_ys_1_jy( REC_AKC290S(I),
                                       PRM_AAE013,        --新增
                                      PRM_APPCODE,
                                      PRM_ERRORMSG);
                  IF  PRM_AAE013='1' THEN
                         INSERT INTO KC29_YS_2
                                     (AKC290,   --序号
                                      AKB020,   --医疗机构编号
                                      AAC001,   --医护人员编号
                                      AAC002,   --证件号码
                                      AAC003,   --姓名
                                      AAC004,   --性别
                                      BKC331,   --执业科别
                                      AAC020,   --行政职务
                                      BAC332,   --医师资格证书编号
                                      BAC337,   --执业医师类别
                                      BAC338,   --执业资格取得时间
                                      BAC339,   --医师执业范围
                                      BAC340,   --康复资质
                                      BAC341,   --第一执业地点
                                      BAC342,   --第二执业地点
                                      BAC343,   --第三执业地点
                                      BAC344,   --职称
                                      BAC345,   --职称取得时间
                                      BAC346,   --康复专业技术资格证书资格级别
                                      BAC347,   --康复专业技术资格证书专业技术名称
                                      BAC348,   --康复专业技术资格证书资格授予时间
                                      BAC349,   --本院服务开始时间
                                      AAE005,   --联系电话
                                      BAC350,   --医保服务资格状态
                                      AAE003,   --备注
                                      HZ050,   --审核标志
                                      AKC292,   --审核日期
                                      AKC293,   --审核反馈
                                      AAC020_1,   --行政职务_名称
                                      BAC344_1,   --职称_名称
                                      BAC337_1,   --执业医师类别_名称
                                      BAC339_1,   --医师执业范围_名称
                                      BAC353,   --封锁标记（0未封锁，1封锁）
                                      BAC354,   --审核结果（1,2分别对应通过和不通过）
                                      BAC351,   --本院服务结束时间
                                      BAC352,   --第四执业地点
                                      BKC331_1,   --执业科别名称
                                      AAE011,   --经办人
                                      AAE036,   --经办时间
                                      AAE012,   --审核工号
                                      AAE013,   --状态（1新增，2变更，3注销）
                                      BAC355,   --专业技术职务
                                      BAC355_1,   --专业技术职务_名称
                                      BKF054,   --医师执业证书编号
                                      BKE049,   --医师级别
                                      AAC058,   --证件类型
                                      BKE054,   --是否技术交流标志
                                      BKF049,   --是否签约医师标志
                                      BKF048,   --是否评估医师标志
                                      BKF094,   --技术开始交流时间
                                      BKF095,   --技术开始交流时间
                                      BKF093,   --移动电话
                                      BZE011,   --创建人
                                      BZE036,   --创建时间
                                      AAA027)   --统筹区编码
                         SELECT V_AKC290   AKC290,   --序号
                                 AKB020    AKB020,   --医疗机构编号
                                 AAC001    AAC001,   --医护人员编号
                                 AAC002    AAC002,   --证件号码
                                 AAC003    AAC003,   --姓名
                                 AAC004    AAC004,   --性别
                                 BKC331    BKC331,   --执业科别
                                 AAC020    AAC020,   --行政职务
                                 BAC332    BAC332,   --医师资格证书编号
                                 BAC337    BAC337,   --执业医师类别
                                 BAC338    BAC338,   --执业资格取得时间
                                 BAC339    BAC339,   --医师执业范围
                                 BAC340    BAC340,   --康复资质
                                 BAC341    BAC341,   --第一执业地点
                                 BAC342    BAC342,   --第二执业地点
                                 BAC343    BAC343,   --第三执业地点
                                 BAC344    BAC344,   --职称
                                 BAC345    BAC345,   --职称取得时间
                                 BAC346    BAC345,   --康复专业技术资格证书资格级别
                                 BAC347    BAC347,   --康复专业技术资格证书专业技术名称
                                 BAC348    BAC348,   --康复专业技术资格证书资格授予时间
                                 sysdate   BAC349,   --本院服务开始时间
                                 AAE005    AAE005,   --联系电话
                                 BAC350    BAC350,   --医保服务资格状态
                                 AAE003    AAE003,   --备注
                                 '1'     HZ050,   --审核标志
                                 sysdate,   --审核日期
                                 AKC293    AKC293,   --审核反馈
                                 AAC020_1   AAC020_1,   --行政职务_名称
                                 BAC344_1   BAC344_1,   --职称_名称
                                 BAC337_1   BAC377_1,   --执业医师类别_名称
                                 BAC339_1   BAC399_1,   --医师执业范围_名称
                                  '0',   --封锁标记（0未封锁，1封锁）
                                 null,   --审核结果（1,2分别对应通过和不通过）
                                 BAC351    BAC351,   --本院服务结束时间
                                 BAC352    BAC352,   --第四执业地点
                                 BKC331_1   BKC331_1,   --执业科别名称
                                 AAE011   AAE011 ,   --医院操作人员
                                 sysdate,   --医院操作日期
                                 null,   --审核工号
                                 PRM_AAE013,   --状态（1新增，2变更，3注销）
                                 BAC355    BAC355,   --专业技术职务
                                 BAC355_1   BAC355_1,   --专业技术职务_名称
                                 BKF054     BKF054,   --医师执业证书编号
                                 BKE049     BKE049,   --医师级别
                                 AAC058     AAC058,   --证件类型
                                 BKE054     BKE054,   --是否技术交流标志
                                 BKF049     BKF049,   --是否签约医师标志
                                 BKF048    BKF048,   --是否评估医师标志
                                 BKF094     BKF094,   --技术开始交流时间
                                 BKF095   BKF095,   --技术开始交流时间
                                 BKF093   BKF093,     --移动电话
                                 BZE011  BZE011,   --创建人
                                 BZE036  BZE036,   --创建时间
                                 AAA027   AAA027  --统筹区编码
                                FROM KC29_YS_1
                               WHERE akc290= REC_AKC290S(I);
                               commit;
                               --将新增信息插入一体化表
                                INSERT INTO KC29_YTH_KF
                                                 (BAZ001,
                                                  BAZ002,
                                                  AKC290,
                                                  AKB020,
                                                  AAC001,
                                                  AAC002,
                                                  AAC003,
                                                  AAC004,
                                                  BKC331,
                                                  AAC020,
                                                  BAC332,
                                                  BAC337,
                                                  BAC338,
                                                  BAC339,
                                                  BAC340,
                                                  BAC341,
                                                  BAC342,
                                                  BAC343,
                                                  BAC344,
                                                  BAC345,
                                                  BAC346,
                                                  BAC347,
                                                  BAC348,
                                                  BAC349,
                                                  AAE005,
                                                  BAC350,
                                                  AAE003,
                                                  HZ050,
                                                  AKC292,
                                                  AKC293,
                                                /*  AAC020_1,
                                                  BAC344_1,
                                                  BAC337_1,
                                                  BAC339_1,
                                                  BAC353,*/
                                                  BAC354,
                                                  BAC351,
                                                  BAC352,
                                                 -- BKC331_1,
                                                  AAE011,
                                                  AAE036,
                                                  AAE012,
                                                  AAE013,
                                                  BAC355,
                                                --  BAC355_1,
                                                  AAC058,
                                                  BKE054,
                                                  BKF049,
                                                  BKF048,
                                                  BKF094,
                                                  BKF095,
                                                  BKF093,
                                                  BZE011,
                                                  BZE036,
                                                  AAA027,
                                                  BKA712)
                                          SELECT SEQ_A_BAZ001HZYB.NEXTVAL,
                                                 SEQ_A_BAZ002HZYB.NEXTVAL,
                                                 AKC290,   --序号
                                             AKB020,   --医疗机构编号
                                             AAC001,   --医护人员编号
                                             AAC002,   --证件号码
                                             AAC003,   --姓名
                                             AAC004,   --性别
                                             BKC331,   --执业科别
                                             AAC020,   --行政职务
                                             BAC332,   --医师资格证书编号
                                             BAC337,   --执业医师类别
                                             BAC338,   --执业资格取得时间
                                             BAC339,   --医师执业范围
                                             BAC340,   --康复资质
                                             BAC341,   --第一执业地点
                                             BAC342,   --第二执业地点
                                             BAC343,   --第三执业地点
                                             BAC344,   --职称
                                             BAC345,   --职称取得时间
                                             BAC346,   --康复专业技术资格证书资格级别
                                             BAC347,   --康复专业技术资格证书专业技术名称
                                             BAC348,   --康复专业技术资格证书资格授予时间
                                             BAC349,   --本院服务开始时间
                                             AAE005,   --联系电话
                                             BAC350,   --医保服务资格状态
                                             AAE003,   --备注
                                             HZ050,   --审核标志
                                             AKC292,   --审核日期
                                             AKC293,   --审核反馈
                                           --  BAC353,   --封锁标记（0未封锁，1封锁）
                                             '0' BAC354,   --审核结果（1,2分别对应通过和不通过）
                                             BAC351,   --本院服务结束时间
                                             BAC352,   --第四执业地点
                                             AAE011,   --经办人
                                             AAE036,   --经办时间
                                             AAE012,   --审核工号
                                             AAE013,   --状态（1新增，2变更，3注销）
                                             BAC355,   --专业技术职务
                                             AAC058,   --证件类型
                                             BKE054,   --是否技术交流标志
                                             BKF049,   --是否签约医师标志
                                             BKF048,   --是否评估医师标志
                                             BKF094,   --技术开始交流时间
                                             BKF095,   --技术开始交流时间
                                             BKF093,   --移动电话
                                             BZE011,   --创建人
                                             BZE036,   --创建时间
                                             AAA027,   --统筹区编码
                                             ''
                                        FROM KC29_YS_2
                                       WHERE akc290=  V_AKC290;  
                                     --删除临时表
                                delete from kc29_ys_1
                                  where akc290= REC_AKC290S(I);
                                
                      elsif PRM_AAE013='3'then
                              INSERT INTO KC29_YS_2
                               (AKC290,   --序号
                                AKB020,   --医疗机构编号
                                AAC001,   --医护人员编号
                                AAC002,   --证件号码
                                AAC003,   --姓名
                                AAC004,   --性别
                                BKC331,   --执业科别
                                AAC020,   --行政职务
                                BAC332,   --医师资格证书编号
                                BAC337,   --执业医师类别
                                BAC338,   --执业资格取得时间
                                BAC339,   --医师执业范围
                                BAC340,   --康复资质
                                BAC341,   --第一执业地点
                                BAC342,   --第二执业地点
                                BAC343,   --第三执业地点
                                BAC344,   --职称
                                BAC345,   --职称取得时间
                                BAC346,   --康复专业技术资格证书资格级别
                                BAC347,   --康复专业技术资格证书专业技术名称
                                BAC348,   --康复专业技术资格证书资格授予时间
                                BAC349,   --本院服务开始时间
                                AAE005,   --联系电话
                                BAC350,   --医保服务资格状态
                                AAE003,   --备注
                                HZ050,   --审核标志
                                AKC292,   --审核日期
                                AKC293,   --审核反馈
                                AAC020_1,   --行政职务_名称
                                BAC344_1,   --职称_名称
                                BAC337_1,   --执业医师类别_名称
                                BAC339_1,   --医师执业范围_名称
                                BAC353,   --封锁标记（0未封锁，1封锁）
                                BAC354,   --审核结果（1,2分别对应通过和不通过）
                                BAC351,   --本院服务结束时间
                                BAC352,   --第四执业地点
                                BKC331_1,   --执业科别名称
                                AAE011,   --医院操作人员
                                AAE036,   --医院操作日期
                                AAE012,   --审核工号
                                AAE013,   --状态（1新增，2变更，3注销）
                                BAC355,   --专业技术职务
                                BAC355_1,   --专业技术职务_名称
                                BKF054,   --医师执业证书编号
                                BKE049,   --医师级别
                                AAC058,   --证件类型
                                BKE054,   --是否技术交流标志
                                BKF049,   --是否签约医师标志
                                BKF048,   --是否评估医师标志
                                BKF094,   --技术开始交流时间
                                BKF095,   --技术开始交流时间
                                BKF093)   --移动电话
                         SELECT V_AKC290   AKC290,   --序号
                                 AKB020    AKB020,   --医疗机构编号
                                 AAC001    AAC001,   --医护人员编号
                                 AAC002    AAC002,   --证件号码
                                 AAC003    AAC003,   --姓名
                                 AAC004    AAC004,   --性别
                                 BKC331    BKC331,   --执业科别
                                 AAC020    AAC020,   --行政职务
                                 BAC332    BAC332,   --医师资格证书编号
                                 BAC337    BAC337,   --执业医师类别
                                 BAC338    BAC338,   --执业资格取得时间
                                 BAC339    BAC339,   --医师执业范围
                                 BAC340    BAC340,   --康复资质
                                 BAC341    BAC341,   --第一执业地点
                                 BAC342    BAC342,   --第二执业地点
                                 BAC343    BAC343,   --第三执业地点
                                 BAC344    BAC344,   --职称
                                 BAC345    BAC345,   --职称取得时间
                                 BAC346    BAC345,   --康复专业技术资格证书资格级别
                                 BAC347    BAC347,   --康复专业技术资格证书专业技术名称
                                 BAC348    BAC348,   --康复专业技术资格证书资格授予时间
                                 sysdate BAC349,   --本院服务开始时间
                                 AAE005    AAE005,   --联系电话
                                 BAC350    BAC350,   --医保服务资格状态
                                 AAE003    AAE003,   --备注
                                 '1'     HZ050,   --审核标志
                                 sysdate,   --审核日期
                                 AKC293    AKC293,   --审核反馈
                                 AAC020_1   AAC020_1,   --行政职务_名称
                                 BAC344_1   BAC344_1,   --职称_名称
                                 BAC337_1   BAC377_1,   --执业医师类别_名称
                                 BAC339_1   BAC399_1,   --医师执业范围_名称
                                  '0',   --封锁标记（0未封锁，1封锁）
                                 null,   --审核结果（1,2分别对应通过和不通过）
                                 BAC351    BAC351,   --本院服务结束时间
                                 BAC352    BAC352,   --第四执业地点
                                 BKC331_1   BKC331_1,   --执业科别名称
                                  null ,   --医院操作人员
                                 sysdate,   --医院操作日期
                                 null,   --审核工号
                                 '2',   --状态（1新增，2变更，3注销）
                                 BAC355    BAC355,   --专业技术职务
                                 BAC355_1   BAC355_1,   --专业技术职务_名称
                                 BKF054     BKF054,   --医师执业证书编号
                                 BKE049     BKE049,   --医师级别
                                 AAC058     AAC058,   --证件类型
                                 BKE054     BKE054,   --是否技术交流标志
                                 BKF049     BKF049,   --是否签约医师标志
                                 BKF048    BKF048,   --是否评估医师标志
                                 BKF094     BKF094,   --技术开始交流时间
                                 BKF095   BKF095,   --技术开始交流时间
                                 BKF093   BKF093     --移动电话
                                FROM KC29_YS_1
                               WHERE akc290= REC_AKC290S(I);
                                 --将新增信息插入一体化表
                                INSERT INTO KC29_YTH_KF
                                                 (BAZ001,
                                                  BAZ002,
                                                  AKC290,
                                                  AKB020,
                                                  AAC001,
                                                  AAC002,
                                                  AAC003,
                                                  AAC004,
                                                  BKC331,
                                                  AAC020,
                                                  BAC332,
                                                  BAC337,
                                                  BAC338,
                                                  BAC339,
                                                  BAC340,
                                                  BAC341,
                                                  BAC342,
                                                  BAC343,
                                                  BAC344,
                                                  BAC345,
                                                  BAC346,
                                                  BAC347,
                                                  BAC348,
                                                  BAC349,
                                                  AAE005,
                                                  BAC350,
                                                  AAE003,
                                                  HZ050,
                                                  AKC292,
                                                  AKC293,
                                                /*  AAC020_1,
                                                  BAC344_1,
                                                  BAC337_1,
                                                  BAC339_1,
                                                  BAC353,*/
                                                  BAC354,
                                                  BAC351,
                                                  BAC352,
                                                 -- BKC331_1,
                                                  AAE011,
                                                  AAE036,
                                                  AAE012,
                                                  AAE013,
                                                  BAC355,
                                                --  BAC355_1,
                                                  AAC058,
                                                  BKE054,
                                                  BKF049,
                                                  BKF048,
                                                  BKF094,
                                                  BKF095,
                                                  BKF093,
                                                  BZE011,
                                                  BZE036,
                                                  AAA027,
                                                  BKA712)
                                          SELECT SEQ_A_BAZ001HZYB.NEXTVAL,
                                                 SEQ_A_BAZ002HZYB.NEXTVAL,
                                                 AKC290,   --序号
                                             AKB020,   --医疗机构编号
                                             AAC001,   --医护人员编号
                                             AAC002,   --证件号码
                                             AAC003,   --姓名
                                             AAC004,   --性别
                                             BKC331,   --执业科别
                                             AAC020,   --行政职务
                                             BAC332,   --医师资格证书编号
                                             BAC337,   --执业医师类别
                                             BAC338,   --执业资格取得时间
                                             BAC339,   --医师执业范围
                                             BAC340,   --康复资质
                                             BAC341,   --第一执业地点
                                             BAC342,   --第二执业地点
                                             BAC343,   --第三执业地点
                                             BAC344,   --职称
                                             BAC345,   --职称取得时间
                                             BAC346,   --康复专业技术资格证书资格级别
                                             BAC347,   --康复专业技术资格证书专业技术名称
                                             BAC348,   --康复专业技术资格证书资格授予时间
                                             BAC349,   --本院服务开始时间
                                             AAE005,   --联系电话
                                             BAC350,   --医保服务资格状态
                                             AAE003,   --备注
                                             HZ050,   --审核标志
                                             AKC292,   --审核日期
                                             AKC293,   --审核反馈
                                           --  BAC353,   --封锁标记（0未封锁，1封锁）
                                             '0' BAC354,   --审核结果（1,2分别对应通过和不通过）
                                             BAC351,   --本院服务结束时间
                                             BAC352,   --第四执业地点
                                             AAE011,   --经办人
                                             AAE036,   --经办时间
                                             AAE012,   --审核工号
                                             AAE013,   --状态（1新增，2变更，3注销）
                                             BAC355,   --专业技术职务
                                             AAC058,   --证件类型
                                             BKE054,   --是否技术交流标志
                                             BKF049,   --是否签约医师标志
                                             BKF048,   --是否评估医师标志
                                             BKF094,   --技术开始交流时间
                                             BKF095,   --技术开始交流时间
                                             BKF093,   --移动电话
                                             BZE011,   --创建人
                                             BZE036,   --创建时间
                                             AAA027,   --统筹区编码
                                             ''
                                        FROM KC29_YS_2
                                       WHERE akc290=  V_AKC290;
                                       --获取上一条数据的序列号
                                       select akb020,aac002
                                       into  V_AKB020,V_AAC147
                                        FROM KC29_YS_1
                                        WHERE akc290= REC_AKC290S(I);
                                       select akc290
                                       into N_AKC290_OLD
                                       from kc29_yth_kf 
                                        where akb020=V_AKB020
                                          and   aac002=V_AAC147
                                          and    aaa027=v_aaa027
                                          and   hz050='5'
                                          and   to_char(bac349,'yyyyMMdd')<=to_char(sysdate,'yyyyMMdd')
                                          and   (to_char(bac351,'yyyyMMdd')>=to_char(sysdate,'yyyyMMdd') or bac351 is null)
                                          and rownum=1;
                      if N_AKC290_OLD = null or trim(N_AKC290_OLD) <>'' then
                        --技师修改,先将最新一条有效信息置上终止时间，然后生成一条
                         update kc29_YTH_KF
                                set bac351=（TRUNC(SYSDATE,'dd')-1）
                                 where akb020=V_AKB020
                                          and   aac002=V_AAC147
                                          and    aaa027=v_aaa027
                                          and   hz050='5'
                                          and   to_char(bac349,'yyyyMMdd')<=to_char(sysdate,'yyyyMMdd')
                                          and   (to_char(bac351,'yyyyMMdd')>=to_char(sysdate,'yyyyMMdd') or bac351 is null)
                                          and rownum=1;
                        
                        else 
                                update kc29_YTH_KF
                                set bac351=（TRUNC(SYSDATE,'dd')-1）
                                where akc290=N_AKC290_OLD;
                     
                               PKG_K_DOCOMPARE.PRC_DOCOMPARE(N_AKC290_OLD, --老数据序列号
                                                              V_AKC290, --新数据序列号
                                                              'KC29_YTH_KF', --表名称
                                                             'AKB020,AAC003,AAC001,AAC058,AAC002,AAC004,BAC346,BAC347,BAC348,AAE003,BKC331', --进行对比的字段以逗号分隔
                                                              RESULT_STR, --返回结果字符串                  
                                                              PRM_APPCODE,
                                                              PRM_ERRORMSG);
                                 if  PRM_APPCODE = '0' THEN
                                           update kc29_YTH_KF
                                              set BKA712=RESULT_STR
                                              where akc290= V_AKC290;
                                   END IF;
                                   
                       end if;
                                   --删除临时表
                                 delete from kc29_ys_1
                                  where akc290= REC_AKC290S(I);
      
                      elsif PRM_APPCODE <> '1'then
                               update kc29_ys_1
                                  set hz050='8',
                                      akc291=sysdate,
                                      akc293=PRM_ERRORMSG
                                  where akc290= REC_AKC290S(I) ;
                      end if;

      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG := '提交失败:' || SQLERRM;
      RETURN;
  END PRC_A_INSERT;

     /*-------------------------------------------------------------------------------
  * PRC_DOSAVERECIVER
  * chengzhp@neusoft.com
  * 功能描述：新增康复技师校验
  * date:2015-03-20
  /*-------------------------------------------------------------------------------*/
  
  PROCEDURE prc_kc29_ys_1_jy(prm_AKC290  in INTEGER,
                             prm_nup     in varchar,
                             prm_appcode out number,
                             prm_outdata out varchar2) IS
    v_hz020           varchar2(1000); --医院信息中医院执业范围
    prm_aac002_15_out VARCHAR2(100);
    prm_aac002_18_out VARCHAR2(100);
    v_1               number(3);
    v_6               number(3);
    v_7               number(3);
    v_aac002 varchar2(25);
    v_akb020 varchar2(20);
    V_MSG    varchar2(20);
    v_bz1 varchar2(20);
    v_bz2 varchar2(20);
    
  Begin
    prm_appcode := 0;
    prm_outdata := '验证成功！';
    for item in (select * from kc29_ys_1 a where a.akc290 = prm_AKC290) loop
      --如果是新增的数据，需要判断kc29_ys_2是否有数据，如果有，就不让提交
      --新增规则：医师在该医院注销后，仍然可以继续申报该医院 20140217 郑莺莺提
      if prm_nup = 1 then
        select aac002, akb020
          into v_aac002, v_akb020
          from kc29_ys_1
         where akc290 = prm_AKC290;
        select count(1)
          into v_6
          from kc29_yth_kf
         where (aac002 = func_id15to18(v_aac002) or
                aac002 = func_id18to15(v_aac002))
             and akb020 = v_akb020
             and  nvl(to_char(bac349, 'yyyymmdd'), '9999999999') <=
             to_char(sysdate, 'yyyymmdd')
             and nvl(to_char(bac351, 'yyyymmdd'), '9999999999') >=
             to_char(sysdate, 'yyyymmdd');
        if v_6 > 0 then
          prm_appcode := -1;
          prm_outdata := '该人员已存在，不能再做新增！';
          EXIT;
        end if;
         --验证康复技师工号是否唯一
      /*  select count(*) 
           into v_1 
           from kc29_yth_kf
          where akb020 = item.akb020
            and aac002 = item.aac002
            and BAC340 ='1';
         if v_1 > 0 then
            prm_appcode := 1;
            prm_outdata := '该康复技师人员证件号码在此医院已经存在！';
           EXIT; 
          end if;  */
      elsif prm_nup = 2 then
        select aac002, akb020
          into v_aac002, v_akb020
          from kc29_ys_1
         where akc290 = prm_AKC290;
        select count(1)
          into v_7
          from kc29_yth_kf
         where (aac002 = func_id15to18(v_aac002) or
                aac002 = func_id18to15(v_aac002))
           and akb020 = v_akb020
           and  nvl(to_char(bac349, 'yyyymmdd'), '9999999999') <=
             to_char(sysdate, 'yyyymmdd')
           and nvl(to_char(bac351, 'yyyymmdd'), '9999999999') >=
             to_char(sysdate, 'yyyymmdd');
            if v_7 > 0 then
              prm_appcode := -1;
              prm_outdata := '该人员已存在，不能再做新增！';
              EXIT;
            end if;
       /*  --验证医师工号是否唯一
        select count(*) 
           into v_1 
           from kc29_yth_kf
          where akb020 = item.akb020
            and aac002 = item.aac002
            and BAC340 ='1';
         if v_1 > 0 then
            prm_appcode := 1;
            prm_outdata := '该康复技师人员证件号码在此医院已经存在！';
           EXIT; 
          end if;  
       else 
          --验证医师工号是否唯一
          select count(*) 
             into v_1 
             from kc29_yth_kf
            where akb020 = item.akb020
              and aac002 = item.aac002;
           if v_1 > 1 then
              prm_appcode := 1;
              prm_outdata := '该医护人员证件号码已经存在！';
             EXIT; 
            end if;  */
      end if;
        
         
      --1、验证身份证是否合法
      if (item.aac058 = '1')  then
         pkg_b_aac002.prc_check_aac002(item.aac002,
                                        prm_aac002_15_out,
                                        prm_aac002_18_out,
                                        prm_appcode,
                                        prm_outdata);
          IF prm_appcode = -1 THEN
             prm_appcode := -1;
              prm_outdata := '该人员身份证验证不通过'||prm_outdata;
            EXIT;
          END IF; 
        END IF;  
      --2、验证 临床科别bkc331 必须在 在医院信息中医院执业范围 hos_hz04_temp.HZ020之内；
     /* begin
        select hz020
          into v_hz020
          from hos_hz04_temp
         where hos_id = item.AKB020
           and rownum = 1;
      exception
        when no_data_found then
          v_hz020 := '';
      end;
      IF length(v_hz020) > 0 THEN
        V_MSG := Fun_kc29_ys_1_bkc331(item.bkc331, v_hz020);
        IF V_MSG = 'NO' THEN
          prm_appcode := 1;
          prm_outdata := '临床科别 不在医院信息中医院执业范围内';
       
        END IF;
      ELSE
        prm_appcode := 1;
        prm_outdata := '临床科别 不在医院信息中医院执业范围内';
      END IF;*/
    END LOOP;
  
    commit;
  
  END PRC_KC29_YS_1_JY;

  /*---------------------------------------------------------------------
  ||名称：Fun_kc29_ys_1_bkc331
  ||功能描述：匹配临床科别
  ||---------------------------------------------------------------------
  ||
  ||
  ---------------------------------------------------------------------*/
  FUNCTION Fun_kc29_ys_1_bkc331(bkc331 VARCHAR2, hz020 VARCHAR2)
    RETURN varchar2 IS
    v_ch      varchar2(4000);
    v_ch1     varchar2(100);
    v_ch2     varchar2(4000);
    v_ch1_1   varchar2(50);
    v_ch1_2   varchar2(50);
    v_ch_len  number(4);
    v_ch_len2 number(4);
    i         number(4);
    i2        number(4);
    v_msg     varchar2(6);
  begin
    i     := 0;
    i2    := 0;
    v_ch  := bkc331;
    v_ch2 := hz020;
    v_msg := 'NO';
    select length(v_ch) - length(replace(v_ch, ','))
      into v_ch_len
      from dual;
  
    select length(v_ch2) - length(replace(v_ch2, ','))
      into v_ch_len2
      from dual;
    --如果科别只有一个
    if v_ch_len = 0 and v_ch_len2 = 0 and v_ch = v_ch2 then
      v_msg := 'ok';
    else
      begin
        loop
          v_ch2 := hz020;
          v_msg := 'NO';
          i2    := 0;
          if i < v_ch_len then
            i     := i + 1;
            v_ch1 := nvl(substr(v_ch, '1', instr(v_ch, ',') - 1), 0);
            v_ch  := nvl(substr(v_ch, instr(v_ch, ',') + 1, length(v_ch)),
                         0);
            if v_ch_len2 = 0 and v_ch1 = v_ch2 then
              v_msg := 'ok';
            else
              begin
                loop
                  if i2 <= v_ch_len2 then
                    i2      := i2 + 1;
                    v_ch1_2 := nvl(substr(v_ch2, '1', instr(v_ch2, ',') - 1),
                                   0);
                    v_ch2   := nvl(substr(v_ch2,
                                          instr(v_ch2, ',') + 1,
                                          length(v_ch2)),
                                   0);
                    if v_ch1_2 = 0 then
                      v_ch1_2 := v_ch2;
                    end if;
                    if v_ch1 = v_ch1_2 then
                    
                      v_msg := 'ok';
                      exit;
                    end if;
                  else
                    if v_ch1 = v_ch1_2 then
                    
                      v_msg := 'ok';
                      exit;
                    else
                      exit;
                    end if;
                  end if;
                end loop;
              end;
            
            end if;
            if v_msg = 'NO' then
              exit;
            end if;
          else
            v_ch2 := hz020;
            v_msg := 'NO';
            i2    := 0;
            v_ch1 := v_ch;
            if v_ch_len2 = 0 and v_ch1 = 0 then
              v_msg := 'ok';
            else
              begin
                loop
                  if i2 <= v_ch_len2 then
                    i2      := i2 + 1;
                    v_ch1_2 := nvl(substr(v_ch2, '1', instr(v_ch2, ',') - 1),
                                   0);
                  
                    v_ch2 := nvl(substr(v_ch2,
                                        instr(v_ch2, ',') + 1,
                                        length(v_ch2)),
                                 0);
                    if v_ch1_2 = 0 then
                      v_ch1_2 := v_ch2;
                    end if;
                  
                    if v_ch1 = v_ch1_2 then
                      v_msg := 'ok';
                      exit;
                    end if;
                  else
                    if v_ch1 = v_ch1_2 then
                      v_msg := 'ok';
                      exit;
                    else
                      exit;
                    end if;
                  end if;
                end loop;
              end;
            end if;
            exit;
          
          end if;
        
        end loop;
      end;
    end if;
    dbms_output.put_line('v_msg=' || v_msg);
  
    return v_msg;
  end Fun_kc29_ys_1_bkc331;
  /*---------------------------------------------------------------------------------------------------
  
  根据〖中华人民共和国国家标准GB11643-1999〗中有关公民身份号码的规定，
  公民身份号码是特征组合码，由十七位数字本体码和一位数字校验码组成。
  排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
  地址码表示编码对象常住户口所在县(市、旗、区)的行政区划代码。
  生日期码表示编码对象出生的年、月、日，其中年份用四位数字表示，年、月、日之间不用分隔符。
  顺序码表示同一地址码所标识的区域范围内，对同年、月、日出生的人员编定的顺序号。
  顺序码的奇数分给男性，偶数分给女性。校验码是根据前面十七位数字码，
  按照ISO 7064:1983.MOD 11-2校验码计算出来的检验码。下面举例说明该计算方法。
  15位的身份证编码首先把出生年扩展为4位，简单的就是增加一个19，
  但是这对于1900年出生的人不使用（这样的寿星不多了）
  
    某男性公民身份号码本体码为34052419800101001，首先按照公式⑴计算：
  
    ∑(ai×Wi)(mod 11)……………………………………(1)
  
    公式(1)中：
    i----表示号码字符从由至左包括校验码在内的位置序号；
    ai----表示第i位置上的号码字符值；
    Wi----示第i位置上的加权因子，其数值依据公式Wi=2（n-1）(mod 11)计算得出。
  
    i 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
   
    ai 3 4 0 5 2 4 1 9 8 0 0 1 0 1 0 0 1 a1
  
    Wi 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2 1
  
    ai×Wi 21 36 0 25 16 16 2 9 48 0 0 9 0 5 0 0 2 a1
  
    根据公式(1)进行计算：
  
    ∑(ai×Wi) =（21+36+0+25+16+16+2+9+48++0+0+9+0+5+0+0+2) = 189
  
    189 ÷ 11 = 17 + 2/11
  
    ∑(ai×Wi)(mod 11) = 2
  
    然后根据计算的结果，从下面的表中查出相应的校验码，其中X表示计算结果为10：
  
    ∑(ai×WI)(mod 11) 0 1 2 3 4 5 6 7 8 9 10
    校验码字符值ai 1 0 X 9 8 7 6 5 4 3 2
    根据上表，查出计算结果为2的校验码为所以该人员的公民身份号码应该为 34052419800101001X。
  
    a[0]*7+a[1]*9+a[2]*10+a[3]*5+a[4]*8+a[5]*4+a[6]*2+a[7]*1+a[8]*6+a[9]*3
    +a[10]*7+a[11]*9+a[12]*10+a[13]*5+a[14]*8+a[15]*4+a[16]*2
    %11
  */
  PROCEDURE prc_ID15TO18(prm_ID15     IN VARCHAR2,
                         prm_ID18     OUT VARCHAR2,
                         prm_AppCode  OUT NUMBER,
                         prm_ErrorMsg OUT VARCHAR2) IS
    type ww is varray(18) of number(2);
    type aa is varray(11) of varchar2(1);
    i     number := 1;
    str   varchar2(18);
    v_sum number(10);
    ai    number(2);
    w     ww := ww(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
    a     aa := aa('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
  BEGIN
    prm_AppCode := '1';
  
    IF length(prm_ID15) = 15 then
      str   := substr(prm_ID15, 1, 6) || '19' || substr(prm_ID15, 7, 9);
      v_sum := 0;
      FOR i IN 1 .. 17 LOOP
        v_sum := v_sum + to_number(substr(str, i, 1)) * w(i);
      END LOOP;
      ai       := MOD(v_sum, 11);
      prm_ID18 := str || a(ai + 1);
    ELSIF LENGTH(prm_ID15) = 18 THEN
      prm_ID18 := prm_ID15;
      RETURN;
    ELSE
      prm_AppCode  := -1;
      prm_ErrorMsg := '所传入身份号码位数不对，请检查!';
      RETURN;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      prm_AppCode  := -1;
      prm_ErrorMsg := '身份证升位出现系统错误:' || SQLERRM;
      RETURN;
  END prc_ID15TO18;

  PROCEDURE prc_ID18TO15(prm_ID18     IN VARCHAR2,
                         prm_ID15     OUT VARCHAR2,
                         prm_AppCode  OUT NUMBER,
                         prm_ErrorMsg OUT VARCHAR2) IS
  BEGIN
    IF length(prm_id18) <= 15 THEN
      prm_id15 := prm_id18;
      RETURN;
    end IF;
    --2000年后身份证，不进行18转15的转换 Add by hanh 20110720 20014920 --begin   
    If substr(prm_id18, 7, 1) >= '2' then
      prm_id15 := prm_id18;
      RETURN;
    end if;
    --2000年后身份证，不进行18转15的转换 Add by hanh 20110720 20014920 --end     
    prm_id15 := substr(prm_id18, 1, 6) || substr(prm_id18, 9, 9);
  END;
end PKG_KC29_YS_CHECK;
/
