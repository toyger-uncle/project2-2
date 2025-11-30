CREATE OR REPLACE PACKAGE PKG_CAA_SYS IS
   -- Author  : ZENGJ
   -- Created : 2011-5-21 12:00:00
   -- Purpose : 系统信息，三经信息，交互及业务编号，
   -- 引用：PKG_CAA_COMM（操作员，操作序号），不可再引用其他包
   -- 被其他包调用

   -- Public type declarations
   -- Public constant declarations
   -- Public variable declarations
   -- Public function and procedure declarations

   ---------------------------定义全局变量---------------------------


   --全局参数
   /*-- 辅助参数的结构体 ----------------------------------------------------------*/
   TYPE TYP_REC_sys IS RECORD(
      /*-- 变量声明 ----------------------------------------------------------*/
      aae002    NUMBER(6),   --结算期
      SEQtype   VARCHAR2(20),-- 批次流水
      batchseq  VARCHAR2(20),-- 批次流水
      seq        VARCHAR2(20),-- 单笔流水
      baz001    NUMBER(16),   --记录编号
      baz002    NUMBER(16),   --操作序号
      bae999    NUMBER(16),   --对应唯一的标识
      aae011    VARCHAR2(500),   --经办人
      aae036    DATE,           --经办日期
      aab034    VARCHAR2(16),   --社会保险经办机构编码
      aaa027    VARCHAR2(6),   --所属统筹区
      aab034_si VARCHAR2(16),  --社会保险经办机构编码-- base
      aaa027_si VARCHAR2(6),   --所属统筹区-- base
      BUSI_TYPE VARCHAR2(1000),   --
      aab034_MODE VARCHAR2(6),   --经办业务模式，0--正常；1--代办
      aaa027_MODE VARCHAR2(6),   --经办业务模式，0--正常；1--代办
      VPDPARA      VARCHAR2(4000),
      aae013      VARCHAR2(5000)   --备注

      );

		grec_sys 	TYP_REC_sys;

   PROCEDURE PRC_SYSCONSTRUCTOR;

   -- get systeminfo
   FUNCTION FUN_GETBAZ002 RETURN NUMBER;
   FUNCTION FUN_GETAAE011 RETURN VARCHAR2;

	 FUNCTION FUN_GETAAB034 RETURN VARCHAR2;
	 FUNCTION FUN_GETAAA027 RETURN VARCHAR2;

   PROCEDURE "=============GETSYS==";

   FUNCTION FUN_GETUserID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETUnitID RETURN VARCHAR2;

   /*-------------------------------------------------------------------------
   || 方法名称 FUN_GETBusinessID
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETBusinessID RETURN VARCHAR2;

   /*-------------------------------------------------------------------------
   || 方法名称 FUN_GETRequestID
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETRequestID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETSIOfficeID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETKindID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETSIPoolID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETAreaID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETMenuID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETHosID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETUnitType RETURN VARCHAR2;

   --
   FUNCTION FUN_GETRecordiDCurrval RETURN VARCHAR2;

   --
   FUNCTION FUN_GETOperationID RETURN VARCHAR2;

   --
   FUNCTION FUN_GETUserName RETURN VARCHAR2;

   --
   FUNCTION FUN_GETCUSTOMVPDPARA RETURN VARCHAR2;

   --
   FUNCTION FUN_GETvpd_value RETURN VARCHAR2;

   PROCEDURE "=============GETVALUE==";
   --
   FUNCTION FUN_GETVALUE(prm_value IN VARCHAR2) RETURN VARCHAR2;

END PKG_CAA_SYS;
/
CREATE OR REPLACE PACKAGE BODY PKG_CAA_SYS IS

   -- Private type declarations
   -- Private constant declarations
   -- Private variable declarations

   PROCEDURE PRC_SYSCONSTRUCTOR IS
   BEGIN
      GREC_SYS := NULL;
   END PRC_SYSCONSTRUCTOR;

   /*-------------------------------------------------------------------------
   || 方法名称 ：FUN_GETBAZ002
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETBAZ002 RETURN NUMBER IS
   BEGIN
      /*IF N_BAZ002 IS NULL OR N_BAZ002 = 0 THEN
         SELECT SEQ_A_BAZ002.NEXTVAL INTO N_BAZ002 FROM DUAL;
         PKG_CAA_SYS.FUN_GETBAZ002 := N_BAZ002;
      END IF;*/
      RETURN FUN_GETOperationID;
   END;

   /*-------------------------------------------------------------------------
   || 方法名称 FUN_GETAAE011
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETAAE011 RETURN VARCHAR2 IS
   BEGIN
      RETURN FUN_GETUserName/*V_AAE011*/;
   END;

   /*-------------------------------------------------------------------------
   || 方法名称 FUN_GETAAB034
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETAAB034 RETURN VARCHAR2 IS
   BEGIN
      --SELECT SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'siofficeid') INTO V_AAB034 FROM DUAL;
      RETURN FUN_GETSIOfficeID;
   END;

   /*-------------------------------------------------------------------------
   || 方法名称 FUN_GETAAA027
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETAAA027 RETURN VARCHAR2 IS
   BEGIN
      --SELECT SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'sipoolid') INTO V_AAA027 FROM DUAL;
      RETURN /*V_AAA027*/FUN_GETSIPoolID;
   END;


   PROCEDURE "=============GETSYS==" IS BEGIN NULL; END;

   --
   FUNCTION FUN_GETUserID RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'userid');
   END;

   --
   FUNCTION FUN_GETUnitID RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'unitid');
   END;

   /*-------------------------------------------------------------------------
   || 方法名称 FUN_GETBusinessID
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETBusinessID RETURN VARCHAR2 IS
      V_AAA027 VARCHAR2(50);
   BEGIN
       SELECT SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'businessid') INTO V_AAA027 FROM DUAL;
      RETURN V_AAA027;
   END;

   /*-------------------------------------------------------------------------
   || 方法名称 FUN_GETRequestID
   ||-------------------------------------------------------------------------*/
   FUNCTION FUN_GETRequestID RETURN VARCHAR2 IS
      V_AAA027 VARCHAR2(50);
   BEGIN
       SELECT SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'requestid') INTO V_AAA027 FROM DUAL;
      RETURN V_AAA027;
   END;

   --
   FUNCTION FUN_GETSIOfficeID RETURN VARCHAR2 IS
      V_AAB034 VARCHAR2(50);
   BEGIN
      V_AAB034:=SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'siofficeid');
      IF nvl(V_AAB034,'0') = '0' THEN
        RAISE_APPLICATION_ERROR(-20000, 'SESSION数据空' );
      END IF;
      RETURN V_AAB034;
   END;

   --
   FUNCTION FUN_GETKindID RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'kindid');
   END;

   --
   FUNCTION FUN_GETSIPoolID RETURN VARCHAR2 IS
      V_AAA027 VARCHAR2(50);
   BEGIN
      V_AAA027:=SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'sipoolid');
      IF nvl(V_AAA027,'0') = '0' THEN
        RAISE_APPLICATION_ERROR(-20000, 'SESSION数据空' );
      END IF;
      RETURN V_AAA027;
      --RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'sipoolid');
   END;

   --
   FUNCTION FUN_GETAreaID RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'areaid');
   END;

   --
   FUNCTION FUN_GETMenuID RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'menuid');
   END;

   --
   FUNCTION FUN_GETHosID RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'hosid');
   END;

   --
   FUNCTION FUN_GETUnitType RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'unittype');
   END;

   --
   FUNCTION FUN_GETRecordiDCurrval RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'recordidcurrval');
   END;

   --
   FUNCTION FUN_GETOperationID RETURN VARCHAR2 IS
      N_BAZ002 NUMBER(18);
   BEGIN
      N_BAZ002 := SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'operationid');
      IF nvl(n_baz002,0) = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'SESSION数据空' );
      END IF;
      RETURN N_BAZ002;
   END;

   --
   FUNCTION FUN_GETUserName RETURN VARCHAR2 IS
      V_AAE011 VARCHAR2(50);
   BEGIN
      V_AAE011 := SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'username');
      IF nvl(V_AAE011,'0') = '0' THEN
        RAISE_APPLICATION_ERROR(-20000, 'SESSION数据空' );
      END IF;
      RETURN V_AAE011;
   END;

   --
   FUNCTION FUN_GETCUSTOMVPDPARA RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'CUSTOMVPDPARA');
   END;

   --
   FUNCTION FUN_GETvpd_value RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'vpd_value');
   END;

   PROCEDURE "=============GETVALUE==" IS BEGIN NULL; END;

   --
   FUNCTION FUN_GETvalue(prm_value IN VARCHAR2) RETURN VARCHAR2 IS
   BEGIN
      RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), prm_value);
   END;

END PKG_CAA_SYS;
/
