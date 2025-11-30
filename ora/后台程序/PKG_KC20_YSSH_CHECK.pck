CREATE OR REPLACE PACKAGE PKG_KC20_YSSH_CHECK IS

  PROCEDURE PRC_A_IMPORTOTHER(PRM_AKC290 IN VARCHAR2, --医院 
                              PRM_APPCODE    OUT NUMBER,
                              PRM_ERRORMSG     OUT VARCHAR2);
                              
  PROCEDURE PRC_A_IMPORTBASIC(PRM_BAZ002 IN VARCHAR2, --导入的操作序号
                               PRM_APPCODE    OUT NUMBER,
                               PRM_ERRORMSG     OUT VARCHAR2);
 
  PROCEDURE PRC_A_INSERT(PRM_akc290 IN VARCHAR2, --xuhao
                         PRM_AAE013 IN VARCHAR2, --状态（1新增，2变更，3注销）
                         PRM_APPCODE    OUT NUMBER,
                         PRM_ERRORMSG     OUT VARCHAR2);

  PROCEDURE PRC_KC20_YSJY(PRM_AKC290 IN INTEGER,
                             PRM_nup    in varchar,
                             PRM_APPCODE OUT NUMBER,
                             PRM_ERRORMSG OUT VARCHAR2);
                             
  PROCEDURE PRC_BASIC_JY(PRM_BAC332 IN VARCHAR2,                     
                             PRM_APPCODE OUT NUMBER,
                             PRM_ERRORMSG OUT VARCHAR2);
                             
  PROCEDURE PRC_OTHER_JY(PRM_AKC290 IN VARCHAR2, --xuhao
                             PRM_AAC001 IN VARCHAR2,
                             PRM_AKB020 IN VARCHAR2,                     
                             PRM_APPCODE OUT NUMBER,
                             PRM_ERRORMSG OUT VARCHAR2);
  function Fun_kc29_yszc_bkc331(bkc331 VARCHAR2, hz020 VARCHAR2)
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
END PKG_KC20_YSSH_CHECK;
/
CREATE OR REPLACE PACKAGE BODY PKG_KC20_YSSH_CHECK IS
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
  * date:2015-04-22
  /*-------------------------------------------------------------------------------*/
   PROCEDURE PRC_A_IMPORTBASIC(PRM_BAZ002 IN VARCHAR2, --导入的操作序号
                               PRM_APPCODE    OUT NUMBER,
                               PRM_ERRORMSG     OUT VARCHAR2) is 
       V_count number(20);
       N_BAZ002  number(20); 
      begin
        -- 1.初始化
            PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;
            N_BAZ002 := to_number(PRM_BAZ002);
              FOR REC_AC01_YSTMP IN (SELECT  *   
                                      FROM AC01_YS_TMP
                                      where baz002 =PRM_BAZ002) LOOP
                          if  REC_AC01_YSTMP.bac332 is not null then
                             PRC_BASIC_JY(REC_AC01_YSTMP.bac332,                     
                                         PRM_APPCODE,
                                         PRM_ERRORMSG);
                                if  PRM_APPCODE = PKG_CAA_MACRO.DEF_OK then 
                                       INSERT INTO AC01_YS
                                         (BAZ001,   --记录编号
                                          BAZ002,   --操作序号
                                          AAC001,   --医师资格证书编号
                                          AAC999,   --医师服务编码
                                          AAC002,   --社保障号
                                          AAC003,   --姓名
                                          AAC004,   --性别
                                          AAC005,   --民族
                                          AAC006,   --出生日期
                                          AAC058,   --证件类型
                                          AAC147,   --证件号码
                                          BAC337,   --执业医师类别
                                          BAC338,   --执业资格取得时间
                                          BAC339,   --医师执业范围
                                          BAC344,   --职称
                                          BAC345,   --职称取得时间
                                          BAC349,   --本地化-备用
                                          BAC351,   --本地化-备用
                                          BAC352,   --本地化-备用
                                          BAC353,   --本地化-备用
                                          BZE011,   --创建人
                                          BZE036,   --创建时间
                                          BZE034,   --创建机构编码
                                          AAE011,   --经办人
                                          AAE036,   --经办时间
                                          AAB034,   --经办机构编码
                                          AAA027,   --统筹区编码
                                          BAC332,   --医师资格证书编号
                                          BAC341,   --第一执业点医疗机构编码
                                          BKE049,   --医师级别
                                          BAC342,   --第一执业点医疗机构名称
                                          BKF054)   --医师执业证书编号
                                   VALUES
                                         (PKG_CAA_COMM.Fun_a_Getbaz001,   --记录编号
                                          N_BAZ002,   --操作序号
                                         Pkg_caa_Comm.Fun_a_Getakc290,   --医师资格证书编号
                                          'YB'||REC_AC01_YSTMP.BAC332,   --医师服务编码
                                         REC_AC01_YSTMP.AAC147 ,   --社保障号
                                         REC_AC01_YSTMP.Aac003,   --姓名
                                         substr(REC_AC01_YSTMP.AAC004,0,1) ,   --性别
                                          null,   --民族
                                          null,   --出生日期
                                         substr(REC_AC01_YSTMP.Aac058,0,1) ,   --证件类型
                                         REC_AC01_YSTMP.AAC147 ,   --证件号码
                                         substr(REC_AC01_YSTMP.BAC337,0,2) ,   --执业医师类别
                                         to_date(REC_AC01_YSTMP.BAC338,'yyyy-MM-dd') ,   --执业资格取得时间
                                         substr(REC_AC01_YSTMP.BAC339,0,3) ,   --医师执业范围
                                         substr(REC_AC01_YSTMP.Bac344,0,1) ,   --职称
                                          to_date(REC_AC01_YSTMP.BAC345,'yyyy-MM-dd'),   --职称取得时间
                                         null ,   --本地化-备用
                                         null ,   --本地化-备用
                                         null ,   --本地化-备用
                                         null ,   --本地化-备用
                                          REC_AC01_YSTMP.BAC341,   --创建人
                                         sysdate ,   --创建时间
                                         null ,   --创建机构编码
                                         REC_AC01_YSTMP.BAC341 ,   --经办人
                                         sysdate ,   --经办时间
                                         null ,   --经办机构编码            
                                         null ,   --统筹区编码
                                        REC_AC01_YSTMP.BAC332 ,   --医师资格证书编号
                                        REC_AC01_YSTMP.BAC341 ,   --第一执业点医疗机构编码
                                        substr(REC_AC01_YSTMP.BKE049,0,1),   --医师级别
                                        REC_AC01_YSTMP.BAC342 ,   --第一执业点医疗机构名称
                                        REC_AC01_YSTMP.BKF054);   --医师执业证书编号
                                       update ac01_ys_tmp
                                       set bac351='1'      --1 校验通过，2校验不通过 null 导入未校验
                                       where bac332=REC_AC01_YSTMP.bac332;
                                        GOTO NEXTPERSON;
                                        
                              else
                                 update ac01_ys_tmp
                                       set bac351='1',      --1 校验通过，2校验不通过 null 导入未校验
                                           bac352=PRM_ERRORMSG
                                       where bac332=REC_AC01_YSTMP.bac332;
                                        
                              end if;
                                 delete from  ac01_ys_tmp where  bac332 is null; 
                            end if; 
                                
                        <<NEXTPERSON>>
                               null; 
                       PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;                                                                    
               end loop;
   EXCEPTION
    WHEN OTHERS THEN
      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG := '批量导入医师基本信息失败:' || SQLERRM;
     RETURN;
 end PRC_A_IMPORTBASIC;
 
/* ------------------------------------------------------------------------------------------------
  * PRC_DOSAVERECIVER
  * chengzhp@neusoft.com
  * 功能描述：批量导入校验
  * date:2015-04-22
 
 
 ------------------------------------------------------------------------------------------------*/
  PROCEDURE PRC_BASIC_JY(PRM_BAC332 IN VARCHAR2,                     
                             PRM_APPCODE OUT NUMBER,
                             PRM_ERRORMSG OUT VARCHAR2) is
      V_AAC003 VARCHAR2(50);
      V_AAC004 VARCHAR2(30);
      V_AAC058 VARCHAR2(30);
      V_AAC147 VARCHAR2(30);
      V_BKE049  VARCHAR2(30);
      V_BAC337   VARCHAR2(30);
      V_BAC338   VARCHAR2(30);
      V_BAC339   VARCHAR2(30);
      V_BAC344   VARCHAR2(30);
      V_BAC345   VARCHAR2(30);
      V_BAC341  VARCHAR2(30);
      V_BAC342  VARCHAR2(100);
      V_BKF054  VARCHAR2(50);
       V_count number(20);
 begin
        PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;
                select count(*)
                  into V_count
                  from ac01_ys
                 where bac332 =PRM_BAC332;
                 if V_count>0 then
                       PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                       PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员已经存在，不能导入';
                        RETURN;
                  END IF;   
                      
                  SELECT AAC003,
                         AAC004,
                         AAC058,
                         AAC147,
                         BKE049,
                         BAC337,
                         BAC338,
                         BAC339,
                         BAC344,
                         BAC345,
                         BAC341,
                         BAC342,
                         BKF054
                    into V_AAC003,
                         V_AAC004,
                         V_AAC058,
                         V_AAC147,
                         V_BKE049,
                         V_BAC337,
                         V_BAC338,
                         V_BAC339,
                         V_BAC344,
                         V_BAC345,
                         V_BAC341,
                         V_BAC342,
                         V_BKF054
                    FROM AC01_YS_TMP 
                   where bac332 = PRM_BAC332;
                   IF V_AAC003 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员姓名为空，不能导入';
                      RETURN;
                    END IF;  
                     IF V_AAC004 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员性别为空，不能导入';
                      RETURN;
                    END IF;  
                     IF V_AAC058 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员证件类型为空，不能导入';
                      RETURN;
                    END IF;  
                     IF V_AAC147 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员证件号码为空，不能导入';
                      RETURN;
                    END IF;  
                     IF V_BKE049 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员医师级别为空，不能导入';
                      RETURN;
                    END IF; 
                    IF V_BAC337 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员执业医师类别为空，不能导入';
                      RETURN;
                    END IF;   
                     IF V_BAC338 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员执业资格取得时间为空，不能导入';
                      RETURN;
                    END IF;  
                     IF V_BAC339 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员执业范围为空，不能导入';
                      RETURN;
                    END IF;  
                    IF V_BAC344 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员职称为空，不能导入';
                      RETURN;
                    END IF;  
                      IF V_BAC345 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员职称取得时间为空，不能导入';
                      RETURN;
                    END IF; 
                        IF V_BAC341 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员医疗机构编号为空，不能导入';
                      RETURN;
                    END IF;  
                    IF V_BAC342 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员医疗机构名称为空，不能导入';
                      RETURN;
                    END IF; 
                      IF V_BKF054 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医师资格证书编号为'||PRM_BAC332||'的人员医师执业证书编号为空，不能导入';
                      RETURN;
                    END IF;   
 
     EXCEPTION
    WHEN OTHERS THEN
      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG := '校验不通过:' || SQLERRM;
     RETURN;
   end PRC_BASIC_JY;
   
    PROCEDURE PRC_OTHER_JY(PRM_AKC290 IN VARCHAR2, --xuhao
                            PRM_AAC001 IN VARCHAR2,
                             PRM_AKB020 IN VARCHAR2,                     
                             PRM_APPCODE OUT NUMBER,
                             PRM_ERRORMSG OUT VARCHAR2) is
        V_BAC332 VARCHAR2(50);
        V_AAC020 VARCHAR2(30);
        V_BKE054 VARCHAR2(30);
        V_BAC341 VARCHAR2(30);
        V_BKF049  VARCHAR2(30);
        V_BKF048   VARCHAR2(30);
        V_BAC349   VARCHAR2(30);
        V_AAE005   VARCHAR2(30);
        V_AKC291  VARCHAR2(30);
        V_BKC331  VARCHAR2(30);
        V_count number(20); 
        V_count2 number(20);                       
    begin
        PRM_APPCODE := PKG_CAA_MACRO.DEF_OK;
                select count(*)
                  into V_count
                  from kc29_yszc
                  where aac001 = PRM_AAC001
                   and akb020 = PRM_AKB020;
                 if V_count>0 then
                       PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                       PRM_ERRORMSG  :=  '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员已存在，不能导入';
                        RETURN;
                  END IF;   
                      select BAC332,
                             AAC020,
                             BKE054,
                             BAC341,
                             BKF049,    
                             BKF048,
                             BAC349,
                             AAE005,
                             AKC291,
                             BKC331
                        into V_BAC332,
                             V_AAC020,
                             V_BKE054,
                             V_BAC341,
                             V_BKF049,  
                             V_BKF048,
                             V_BAC349,
                             V_AAE005,
                             V_AKC291,
                             V_BKC331
                        from kc29_ys_tmp
                       where aac001 = PRM_AAC001
                         and akb020 = PRM_AKB020
                         and akc290 = PRM_AKC290;
                 IF V_BAC332 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员医师资格证书编号为空，不能导入';
                      RETURN;
                  END IF;  
                  IF V_AAC020 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员行政职务为空，不能导入';
                      RETURN;
                   END IF;  
                 IF V_BKE054 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                       PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员技术交流标志为空，不能导入';
                      RETURN;
                  END IF;  
                     IF V_BAC341 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                      PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员自由执业标志为空，不能导入';
                      RETURN;
                    END IF;  
                     IF V_BKF049 IS NULL THEN
                      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                       PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员签约医师标志为空，不能导入';
                      RETURN;
                    END IF; 
                    IF V_BKF048 IS NULL THEN
                        PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                        PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员评估医师标志为空，不能导入';
                        RETURN;
                    END IF;   
                     IF V_BAC349 IS NULL THEN
                        PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                        PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的协议开始时间为空，不能导入';
                        RETURN;
                    END IF;  
                     IF V_AAE005 IS NULL THEN
                         PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                         PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的手机号码为空，不能导入';
                         RETURN;
                    END IF;  
                    IF V_AKC291 IS NULL THEN
                          PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                           PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员医师首次申报时间为空，不能导入';
                          RETURN;
                    END IF;  
                      IF V_BKC331 IS NULL THEN
                            PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                              PRM_ERRORMSG  := '医疗机构编号为'||PRM_AKB020||'工号为'||PRM_AAC001||'的人员执业科别为空，不能导入';
                            RETURN;
                    END IF;
                    if V_BAC332 is not null
                      then 
                        select count(*) into  V_count2 from ac01_ys where bac332= V_BAC332;
                          if V_count2= 0 then
                             PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
                                PRM_ERRORMSG  := '医师资格证书编号为'||V_BAC332||'的医师基本信息为空，不能导入其他信息';
                              RETURN;
                          end if;
                     end if;                           
  EXCEPTION
    WHEN OTHERS THEN
      PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG := '校验不通过:' || SQLERRM;
     RETURN;
   end PRC_OTHER_JY;
                               
                              
 /*-------------------------------------------------------------------------------
  * PRC_DOSAVERECIVER
  * chengzhp@neusoft.com
  * 功能描述：批量导入
  * date:2015-03-20
  /*-------------------------------------------------------------------------------*/
  
   PROCEDURE PRC_A_IMPORTOTHER(PRM_AKC290 IN VARCHAR2, --医院 
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
             PRC_OTHER_JY(REC_KC29_YSTMP.AKC290,
                          REC_KC29_YSTMP.AAC001,
                          REC_KC29_YSTMP.AKB020 ,                     
                             PRM_APPCODE,
                             PRM_ERRORMSG);               
                if  PRM_APPCODE = PKG_CAA_MACRO.DEF_OK then 
                     INSERT INTO kc29_yszc
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
                              (select aac147 from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --证件号码
                              (select aac003 from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --姓名
                              (select aac004  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --性别
                              substr(REC_KC29_YSTMP.Bkc331,0,4),   --执业科别
                              substr(REC_KC29_YSTMP.Aac020,0,1),   --行政职务
                              REC_KC29_YSTMP.Bac332,   --医师资格证书编号
                               (select bac337  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --执业医师类别
                               (select /*to_date(to_char(bac338,'yyyy-MM-dd'),'yyyy-MM-dd')*/bac338  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --执业资格取得时间
                               (select bac339  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --医师执业范围
                              '1',   --康复资质
                              REC_KC29_YSTMP.Bac341,   --第一执业地点
                              null,   --第二执业地点
                              null,   --第三执业地点
                              (select BAC344  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --职称
                              (select BAC345  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --职称取得时间
                           to_date(REC_KC29_YSTMP.Bac349,'yyyy-MM-dd'),   --本院服务开始时间
                              REC_KC29_YSTMP.Aae005,   --移动电话
                              null,   --医保服务资格状态
                            null ,   --备注
                              '0' ,   --审核标识
                           to_date(REC_KC29_YSTMP.AKC291,'yyyy-MM-dd'),   --录入日期
                              null,   --反馈审核结果
                              null,   --行政职务_名称
                             null ,   --职称_名称
                             null ,   --执业医师类别_名称
                              null,   --医师执业范围_名称
                            null ,   --本院服务结束时间
                              null,   --第四执业地点
                           null,   --执业科别名称
                            null ,   --专业技术职务
                              null,   --专业技术职务_名称
                           (select BKF054  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --医师执业证书编号
                           (select BKE049  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --医师级别BKE049
                           (select aac058  from ac01_ys where bac332=REC_KC29_YSTMP.Bac332),   --证件类型
                             substr(REC_KC29_YSTMP.Bke054,0,1),   --是否技术交流标志
                             substr(REC_KC29_YSTMP.Bkf049,0,1) ,   --是否签约医师标志
                             substr(REC_KC29_YSTMP.Bkf048,0,1),   --是否评估医师标志
                              null,   --技术交流开始时间
                             null ,   --技术交流结束时间
                              null);   --移动电话
                               update KC29_YS_TMP
                                set hz050='5'  --4 不通过 5 通过
                                where aac001= REC_KC29_YSTMP.AAC001
                                and   akb020= REC_KC29_YSTMP.akb020;
                       else
                                update KC29_YS_TMP
                                set hz050='4',  --4 不通过 5 通过
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
      PRM_ERRORMSG := '批量导入医师其他信息失败:' || SQLERRM;
      RETURN;
  END PRC_A_IMPORTOTHER;
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
    V_AKB020 varchar2(20);    --医院编号
    V_BAC332 varchar2(30);    --医师资格证书
    V_AAC147 varchar2(20);    --医师资格证书
    V_HZ050 varchar2(3);      --审核标志
    N_AKC290_OLD NUMBER(20);
    V_BAC349 varchar2(20);
    V_AKC290   NUMBER(20);
    REC_COUNT    NUMBER(3);
    v_aae011   varchar2(50);
    v_aac001   varchar2(30);
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
                 PRC_KC20_YSJY( REC_AKC290S(I),
                                       PRM_AAE013,        --新增
                                      PRM_APPCODE,
                                      PRM_ERRORMSG);
                  --获取序列号                    
                  V_AKC290 :=  Pkg_caa_Comm.Fun_a_Getakc290;
                  select akb020, bac332, aac147, hz050,bac349,aac001
                    into V_AKB020, V_BAC332,V_AAC147, V_HZ050，V_BAC349,v_aac001
                    FROM kc20_zc
                   WHERE akc290 = REC_AKC290S(I);
                  IF PRM_APPCODE = '1' and PRM_AAE013='1' THEN
                    --生成日志表
                    INSERT INTO KC20
                             (AKC290,   --序列号
                              AKB020,   --医院编号
                              AAC001,   --连锁机构编号
                              AAC002,   --身份证号码
                              AAC003,   --姓名
                              AAC004,   --性别
                              BAC332,   --资格证书编号
                              CAC022,   --药学专业技术职务确认证书编号
                              AAE041,   --注册（确认）证书有效期开始时间
                              AAE042,   --注册（确认）证书有效期结束时间
                              AAE005,   --手机号码
                              HZ050,   --审核标志
                              BAC349,   --药店服务开始时间
                              AKC293,   --审核反馈结果
                              BAC353,   --封锁标志
                              BAC354,   --审核结果
                              BAC351,   --药店服务终止时间
                              AAE011,   --经办人
                              AAE036,   --经办日期
                              AAE012,   --审核工号
                              AAE013,   --修改标志（1.新增 2.修改 3.注销）
                              BKF054,   --备用字段
                              BKE049,   --备用字段
                              AAC058,   --证件类型
                              BKE054,   --备用字段
                              BKF049,   --备用字段
                              BKF048,   --备用字段
                              BKF094,   --备用字段
                              BKF095,   --备用字段
                              BKF093,   --备用字段
                              BKF096,   --备用字段
                              BZE011,   --创建人
                              BZE036,   --创建日期
                              AAA027,   --统筹区
                              CAC020,   --专业类型
                              CAC021,   --药学专业技术类型
                              CAC023,   --是否提供远程视频药学服务
                              AAC147,   --证件号码
                              AKB021,   --医院名称
                              BAZ001,   --记录编号
                              BAZ002,   --操作序号
                              CAC024,   --执业药师注册证编号
                              AKC292)   --审核日期
                            select 
                                   V_AKC290 AKC290,   --序列号
                                    AKB020,   --医院编号
                                    AAC001,   --连锁机构编号
                                    AAC002,   --身份证号码
                                    AAC003,   --姓名
                                    AAC004,   --性别
                                    BAC332,   --资格证书编号
                                    CAC022,   --药学专业技术职务确认证书编号
                                    AAE041,   --注册（确认）证书有效期开始时间
                                    AAE042,   --注册（确认）证书有效期结束时间
                                    AAE005,   --手机号码
                                    '1',   --审核标志
                                    TRUNC(SYSDATE,'dd'),   --药店服务开始时间
                                    null,   --审核反馈结果
                                    '0',   --封锁标志
                                    null,   --审核结果
                                    null,   --药店服务终止时间
                                    AAE011,   --经办人
                                    sysdate,   --经办日期
                                    AAE012,   --审核工号
                                    '1',   --修改标志（1.新增 2.修改 3.注销）
                                    BKF054,   --备用字段
                                    BKE049,   --备用字段
                                    AAC058,   --证件类型
                                    BKE054,   --备用字段
                                    BKF049,   --备用字段
                                    BKF048,   --备用字段
                                    BKF094,   --备用字段
                                    BKF095,   --备用字段
                                    BKF093,   --备用字段
                                    BKF096,   --备用字段
                                    BZE011,   --创建人
                                    sysdate,   --创建日期
                                    AAA027,   --统筹区
                                    CAC020,   --专业类型
                                    CAC021,   --药学专业技术类型
                                    CAC023,   --是否提供远程视频药学服务
                                    AAC147,   --证件号码
                                    AKB021,   --医院名称
                                    BAZ001,   --记录编号
                                    BAZ002,   --操作序号
                                    CAC024,   --执业药师注册证编号
                                    null   --审核日期
                              from kc20_zc
                              where akc290=REC_AKC290S(I);
                          --生成kc29_yssh并修改kc29_yszc,备份
                          --20150510 改为删除暂存表
                                /*update kc20_zc
                                  set hz050='7',
                                      aae036=sysdate,
                                      akc293='校验通过'
                                  where akc290= REC_AKC290S(I);*/
                             delete from kc20_zc where akc290=REC_AKC290S(I);
                                  
                               --提交成功之后，反写到一体化内网
                                 INSERT INTO KC20_YTH
                                         (AKC290,   --序列号
                                          AKB020,   --医院编号
                                          AAC001,   --连锁机构编号
                                          AAC002,   --身份证号码
                                          AAC003,   --姓名
                                          AAC004,   --性别
                                          BAC332,   --资格证书编号
                                          CAC022,   --药学专业技术职务确认证书编号
                                          AAE041,   --注册（确认）证书有效期开始时间
                                          AAE042,   --注册（确认）证书有效期结束时间
                                          AAE005,   --手机号码
                                          HZ050,   --审核标志
                                          BAC349,   --药店服务开始时间
                                          AKC293,   --审核反馈结果
                                          BAC353,   --封锁标志
                                          BAC354,   --审核结果
                                          BAC351,   --药店服务终止时间
                                          AAE011,   --经办人
                                          AAE036,   --经办日期
                                          AAE012,   --审核工号
                                          AAE013,   --修改标志（1.新增 2.修改 3.注销）
                                          BKF054,   --修改药师字段信息
                                          BKE049,   --备用字段
                                          AAC058,   --证件类型
                                          BKE054,   --备用字段
                                          BKF049,   --备用字段
                                          BKF048,   --备用字段
                                          BKF094,   --备用字段
                                          BKF095,   --备用字段
                                          BKF093,   --备用字段
                                          BKF096,   --备用字段
                                          BZE011,   --创建人
                                          BZE036,   --创建日期
                                          AAA027,   --统筹区
                                          CAC020,   --专业类型
                                          CAC021,   --药学专业技术类型
                                          CAC023,   --是否提供远程视频药学服务
                                          AAC147,   --证件号码
                                          AKB021,   --医院名称
                                          BAZ001,   --记录编号
                                          BAZ002,   --操作序号
                                          CAC024,   --执业药师注册证编号
                                          AKC292,   --审核日期
                                          BKA712)   --变更字段
                                  select AKC290,   --序列号
                                          AKB020,   --医院编号
                                          AAC001,   --连锁机构编号
                                          AAC002,   --身份证号码
                                          AAC003,   --姓名
                                          AAC004,   --性别
                                          BAC332,   --资格证书编号
                                          CAC022,   --药学专业技术职务确认证书编号
                                          AAE041,   --注册（确认）证书有效期开始时间
                                          AAE042,   --注册（确认）证书有效期结束时间
                                          AAE005,   --手机号码
                                          HZ050,   --审核标志
                                          BAC349,   --药店服务开始时间
                                          AKC293,   --审核反馈结果
                                          BAC353,   --封锁标志
                                          BAC354,   --审核结果
                                          BAC351,   --药店服务终止时间
                                          AAE011,   --经办人
                                          AAE036,   --经办日期
                                          AAE012,   --审核工号
                                          AAE013,   --修改标志（1.新增 2.修改 3.注销）
                                          BKF054,   --修改药师字段信息
                                          BKE049,   --备用字段
                                          AAC058,   --证件类型
                                          BKE054,   --备用字段
                                          BKF049,   --备用字段
                                          BKF048,   --备用字段
                                          BKF094,   --备用字段
                                          BKF095,   --备用字段
                                          BKF093,   --备用字段
                                          BKF096,   --备用字段
                                          BZE011,   --创建人
                                          BZE036,   --创建日期
                                          AAA027,   --统筹区
                                          CAC020,   --专业类型
                                          CAC021,   --药学专业技术类型
                                          CAC023,   --是否提供远程视频药学服务
                                          AAC147,   --证件号码
                                          AKB021,   --医院名称
                                          BAZ001,   --记录编号
                                          BAZ002,   --操作序号
                                          CAC024,   --执业药师注册证编号
                                          AKC292,   --审核日期
                                          ''
                                  from  kc20
                               WHERE akc290= V_AKC290;
                                
                      elsif  PRM_APPCODE = '1' and PRM_AAE013='3' then
                                INSERT INTO KC20
                                         (AKC290,   --序列号
                                          AKB020,   --医院编号
                                          AAC001,   --连锁机构编号
                                          AAC002,   --身份证号码
                                          AAC003,   --姓名
                                          AAC004,   --性别
                                          BAC332,   --资格证书编号
                                          CAC022,   --药学专业技术职务确认证书编号
                                          AAE041,   --注册（确认）证书有效期开始时间
                                          AAE042,   --注册（确认）证书有效期结束时间
                                          AAE005,   --手机号码
                                          HZ050,   --审核标志
                                          BAC349,   --药店服务开始时间
                                          AKC293,   --审核反馈结果
                                          BAC353,   --封锁标志
                                          BAC354,   --审核结果
                                          BAC351,   --药店服务终止时间
                                          AAE011,   --经办人
                                          AAE036,   --经办日期
                                          AAE012,   --审核工号
                                          AAE013,   --修改标志（1.新增 2.修改 3.注销）
                                          BKF054,   --备用字段
                                          BKE049,   --备用字段
                                          AAC058,   --证件类型
                                          BKE054,   --备用字段
                                          BKF049,   --备用字段
                                          BKF048,   --备用字段
                                          BKF094,   --备用字段
                                          BKF095,   --备用字段
                                          BKF093,   --备用字段
                                          BKF096,   --备用字段
                                          BZE011,   --创建人
                                          BZE036,   --创建日期
                                          AAA027,   --统筹区
                                          CAC020,   --专业类型
                                          CAC021,   --药学专业技术类型
                                          CAC023,   --是否提供远程视频药学服务
                                          AAC147,   --证件号码
                                          AKB021,   --医院名称
                                          BAZ001,   --记录编号
                                          BAZ002,   --操作序号
                                          CAC024,   --执业药师注册证编号
                                          AKC292)   --审核日期
                                        select 
                                               V_AKC290 AKC290,   --序列号
                                                AKB020,   --医院编号
                                                AAC001,   --连锁机构编号
                                                AAC002,   --身份证号码
                                                AAC003,   --姓名
                                                AAC004,   --性别
                                                BAC332,   --资格证书编号
                                                CAC022,   --药学专业技术职务确认证书编号
                                                AAE041,   --注册（确认）证书有效期开始时间
                                                AAE042,   --注册（确认）证书有效期结束时间
                                                AAE005,   --手机号码
                                                '1',   --审核标志
                                                TRUNC(SYSDATE,'dd'),   --药店服务开始时间
                                                null,   --审核反馈结果
                                                '0',   --封锁标志
                                                null,   --审核结果
                                                null,   --药店服务终止时间
                                                AAE011,   --经办人
                                                sysdate,   --经办日期
                                                AAE012,   --审核工号
                                                '1',   --修改标志（1.新增 2.修改 3.注销）
                                                BKF054,   --备用字段
                                                BKE049,   --备用字段
                                                AAC058,   --证件类型
                                                BKE054,   --备用字段
                                                BKF049,   --备用字段
                                                BKF048,   --备用字段
                                                BKF094,   --备用字段
                                                BKF095,   --备用字段
                                                BKF093,   --备用字段
                                                BKF096,   --备用字段
                                                BZE011,   --创建人
                                                sysdate,   --创建日期
                                                AAA027,   --统筹区
                                                CAC020,   --专业类型
                                                CAC021,   --药学专业技术类型
                                                CAC023,   --是否提供远程视频药学服务
                                                AAC147,   --证件号码
                                                AKB021,   --医院名称
                                                BAZ001,   --记录编号
                                                BAZ002,   --操作序号
                                                CAC024,   --执业药师注册证编号
                                                null   --审核日期
                                          from kc20_zc
                                          where akc290=REC_AKC290S(I);
                        --提交成功之后，反写到一体化内网
                                INSERT INTO KC20_YTH
                                         (AKC290,   --序列号
                                          AKB020,   --医院编号
                                          AAC001,   --连锁机构编号
                                          AAC002,   --身份证号码
                                          AAC003,   --姓名
                                          AAC004,   --性别
                                          BAC332,   --资格证书编号
                                          CAC022,   --药学专业技术职务确认证书编号
                                          AAE041,   --注册（确认）证书有效期开始时间
                                          AAE042,   --注册（确认）证书有效期结束时间
                                          AAE005,   --手机号码
                                          HZ050,   --审核标志
                                          BAC349,   --药店服务开始时间
                                          AKC293,   --审核反馈结果
                                          BAC353,   --封锁标志
                                          BAC354,   --审核结果
                                          BAC351,   --药店服务终止时间
                                          AAE011,   --经办人
                                          AAE036,   --经办日期
                                          AAE012,   --审核工号
                                          AAE013,   --修改标志（1.新增 2.修改 3.注销）
                                          BKF054,   --修改药师字段信息
                                          BKE049,   --备用字段
                                          AAC058,   --证件类型
                                          BKE054,   --备用字段
                                          BKF049,   --备用字段
                                          BKF048,   --备用字段
                                          BKF094,   --备用字段
                                          BKF095,   --备用字段
                                          BKF093,   --备用字段
                                          BKF096,   --备用字段
                                          BZE011,   --创建人
                                          BZE036,   --创建日期
                                          AAA027,   --统筹区
                                          CAC020,   --专业类型
                                          CAC021,   --药学专业技术类型
                                          CAC023,   --是否提供远程视频药学服务
                                          AAC147,   --证件号码
                                          AKB021,   --医院名称
                                          BAZ001,   --记录编号
                                          BAZ002,   --操作序号
                                          CAC024,   --执业药师注册证编号
                                          AKC292,   --审核日期
                                          BKA712)   --变更字段
    
                                  select AKC290,   --序列号
                                          AKB020,   --医院编号
                                          AAC001,   --连锁机构编号
                                          AAC002,   --身份证号码
                                          AAC003,   --姓名
                                          AAC004,   --性别
                                          BAC332,   --资格证书编号
                                          CAC022,   --药学专业技术职务确认证书编号
                                          AAE041,   --注册（确认）证书有效期开始时间
                                          AAE042,   --注册（确认）证书有效期结束时间
                                          AAE005,   --手机号码
                                          HZ050,   --审核标志
                                          BAC349,   --药店服务开始时间
                                          AKC293,   --审核反馈结果
                                          BAC353,   --封锁标志
                                          BAC354,   --审核结果
                                          BAC351,   --药店服务终止时间
                                          AAE011,   --经办人
                                          AAE036,   --经办日期
                                          AAE012,   --审核工号
                                          AAE013,   --修改标志（1.新增 2.修改 3.注销）
                                          BKF054,   --修改药师字段信息
                                          BKE049,   --备用字段
                                          AAC058,   --证件类型
                                          BKE054,   --备用字段
                                          BKF049,   --备用字段
                                          BKF048,   --备用字段
                                          BKF094,   --备用字段
                                          BKF095,   --备用字段
                                          BKF093,   --备用字段
                                          BKF096,   --备用字段
                                          BZE011,   --创建人
                                          BZE036,   --创建日期
                                          AAA027,   --统筹区
                                          CAC020,   --专业类型
                                          CAC021,   --药学专业技术类型
                                          CAC023,   --是否提供远程视频药学服务
                                          AAC147,   --证件号码
                                          AKB021,   --医院名称
                                          BAZ001,   --记录编号
                                          BAZ002,   --操作序号
                                          CAC024,   --执业药师注册证编号
                                          AKC292,   --审核日期
                                          ''
                                  from  kc20
                               WHERE akc290= V_AKC290;
                                 
                               SELECT AKC290 
                               INTO  N_AKC290_OLD
                               FROM KC20_YTH
                                where akb020=V_AKB020
                                and   aac147=V_AAC147
                                and (aac001=v_aac001 or aac001 is null)
                                and    aaa027=v_aaa027
                                and   hz050='5'
                                and   to_char(bac349,'yyyy-MM-dd')<=to_char(sysdate,'yyyy-MM-dd')
                                and   (to_char(bac351,'yyyy-MM-dd')>=to_char(sysdate,'yyyy-MM-dd') or bac351 is null)
                                and rownum=1;
            
                  if  N_AKC290_OLD is not null then
                        --药师修改,先将最新一条有效信息置上终止时间，然后生成一条
                                update kc20_YTH
                                set bac351=（TRUNC(SYSDATE,'dd')-1）
                                where akc290=N_AKC290_OLD;
                     
                               PKG_K_DOCOMPARE.PRC_DOCOMPARE(N_AKC290_OLD, --老数据序列号
                                                              V_AKC290, --新数据序列号
                                                              'KC20', --表名称
                                                             'AKB020,AKB021,AAC001,AAC003,AAC004,AAC058,AAC147,CAC020,CAC021,BAC332,CAC024,CAC022,AAE041,AAE042,CAC023,AAE005', --进行对比的字段以逗号分隔
                                                              RESULT_STR, --返回结果字符串                  
                                                              PRM_APPCODE,
                                                              PRM_ERRORMSG);
                                 if  PRM_APPCODE = '0' THEN
                                           update kc20_YTH
                                              set BKA712=RESULT_STR
                                              where akc290= V_AKC290;
                                   END IF;
                                   
                       end if;
                    --删除暂存表                                               
                       delete from kc20_zc where akc290=REC_AKC290S(I);
                                                     
                      elsif PRM_APPCODE = '-1'then
                             delete from  kc20_zc 
                            where akc290= REC_AKC290S(I) ;
                               
                      end if;

      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
       PRM_APPCODE  := PKG_CAA_MACRO.DEF_ERR;
      PRM_ERRORMSG := '提交失败:' || PRM_ERRORMSG;
      RETURN;
  END PRC_A_INSERT;

     /*-------------------------------------------------------------------------------
  * PRC_DOSAVERECIVER
  * chengzhp@neusoft.com
  * 功能描述：新增康复技师校验
  * date:2015-03-20
  /*-------------------------------------------------------------------------------*/
  
  PROCEDURE PRC_KC20_YSJY(prm_AKC290  in INTEGER,
                             prm_nup     in varchar,
                             prm_appcode out number,
                             PRM_ERRORMSG out varchar2) IS
    v_hz020           varchar2(1000); --医院信息中医院执业范围
    prm_aac002_15_out VARCHAR2(100);
    prm_aac002_18_out VARCHAR2(100);
    v_1               number(3);
    v_2               number(3);
    v_3               number(3);
    v_4               number(3);
    v_5               number(3);
    v_6               number(3);
    v_7               number(3);
    v_8               number(3);
    v_9               number(3);
    v_aac002 varchar2(25);
    V_AAC001  varchar2(10);
    v_akb020 varchar2(20);
    v_aaa027 varchar2(20);
    V_MSG    varchar2(20);
    v_bz1 varchar2(20);
    v_bz2 varchar2(20);
    V_ZYFW varchar2(2000);
    V_ZC   varchar2(50);
    V_BAC332   varchar2(50);
     v_qtxx   number(3);
    
  Begin
    prm_appcode := 1;
    PRM_ERRORMSG := '验证成功！';
    for item in (select * from kc20_zc a where a.akc290 = prm_AKC290 ) loop
            --如果是新增的数据，需要判断kc29_yssh是否有数据，如果有，就不让提交
            --新增规则：医师在该医院注销后，仍然可以继续申报该医院 20140217 郑莺莺提
            if prm_nup = 1 then
                          select aac147, akb020,aac001,aaa027
                            into v_aac002, v_akb020,V_AAC001,v_aaa027
                            from kc20_zc
                           where akc290 = item.akc290;
                           --判断是否存在医师是否存在在该医院
                          select count(1)
                            into v_6
                            from kc20
                           where  akb020 = v_akb020
                            and aac147=v_aac002
                            and aaa027=v_aaa027
                            and (aac001=V_AAC001 or aac001=null)
                            and nvl(to_char(bac349, 'yyyymmdd'), '9999999999') <=
                                  to_char(sysdate, 'yyyymmdd')
                            and (bac351>=sysdate or bac351 is null);
                          if v_6 > 0 then
                            prm_appcode := -1;
                            PRM_ERRORMSG := '该药师在此定点医疗机构已存在，不能再做新增！';
                            update kc20_zc
                               set AKC293 = PRM_ERRORMSG
                             where AKC290 = item.akc290;
                            commit;
                            EXIT;
                          end if;
                         
            end if;   
              
         
              --1、验证身份证是否合法
              if (item.aac058 = '1')  then
                       pkg_b_aac002.prc_check_aac002(item.aac002,
                                                      prm_aac002_15_out,
                                                      prm_aac002_18_out,
                                                      prm_appcode,
                                                      PRM_ERRORMSG);
                        IF prm_appcode = -1 THEN
                          update kc20_zc
                             set AKC293 = PRM_ERRORMSG
                           where AKC290 = item.akc290;
                          EXIT;
                        
                        else
                          update kc20_zc
                             set AKC293 = '校验通过'
                           where AKC290 = item.akc290;
                        END IF; 
              else 
                        update kc20_zc
                             set AKC293 = '校验通过'
                           where AKC290 = item.akc290;
                END IF;  
            
      
    END LOOP; 
    commit;
  END PRC_KC20_YSJY;

  /*---------------------------------------------------------------------
  ||名称：Fun_kc29_yszc_bkc331
  ||功能描述：匹配临床科别
  ||---------------------------------------------------------------------
  ||
  ||
  ---------------------------------------------------------------------*/
  FUNCTION Fun_kc29_yszc_bkc331(bkc331 VARCHAR2, hz020 VARCHAR2)
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
  end Fun_kc29_yszc_bkc331;
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
end PKG_KC20_YSSH_CHECK;
/
