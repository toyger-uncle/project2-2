CREATE OR REPLACE PACKAGE Pkg_CAA_Comm IS
  /*-------------------------------------------------------------------------*/
  /* 后台包功能说明                                                          */
  /*-------------------------------------------------------------------------*/
  /*-------------------------------------------------------------------------
  || 包的名称 ：PKG_A_COMM
  || 功能描述 ：本包中主要完成共用函数、序列号、财务接口等的编写
  ||-------------------------------------------------------------------------*/

  /*-------------------------------------------------------------------------*/
  /* 系统全局常量                                                            */
  /*-------------------------------------------------------------------------*/
  Agetype       CONSTANT VARCHAR2(1) := '1'; -- 截止到月
  v_Setsysinfo  VARCHAR2(3000);
  Str_User      VARCHAR2(200);
  n_Baz001      NUMBER(18);
  n_Baz002      NUMBER(18);

  /*-------------------------------------------------------------------------*/
  /* 公有类型声明(系统综合)                                                  */
  /*-------------------------------------------------------------------------*/
  -- 字符串集合
  TYPE Typ_Tab_Str IS TABLE OF VARCHAR(100) INDEX BY BINARY_INTEGER;

  /*-------------------------------------------------------------------------*/
  /*== 公用方法 ==========================================*/
  /*-------------------------------------------------------------------------*/
  -- 取精度函数
  FUNCTION Fun_a_Preci(Prm_Realnum IN NUMBER, -- 要处理的实数
                       Prm_Style   IN VARCHAR2, -- '1'-- "进一法"；'2'-- "去尾法"；'3'-- "四舍五入法"
                       Prm_Preci   IN NUMBER) -- 例如：-1 -- "十位"； 0 -- "各位" ； 1 -- "个位"等
   RETURN NUMBER;

  -- 字符串解析成数组
  FUNCTION Fun_a_Stringtoarrary(Prm_Sourcestr IN VARCHAR2, -- 原字符串
                                Prm_Separator IN VARCHAR2, -- 分隔符
                                Prm_Arrary    OUT Typ_Tab_Str, -- 字符串数组
                                Prm_Appcode   OUT NUMBER, -- 返回值
                                Prm_Errormsg  OUT VARCHAR2) -- 错误信息
   RETURN NUMBER;

  -- 字符串数组拼接成字符串
  FUNCTION Fun_a_Arrarytostring(Prm_Arrary    IN Typ_Tab_Str, -- 字符串数组
                                Prm_Separator IN VARCHAR2, -- 分隔符
                                Prm_Sourcestr OUT VARCHAR2, -- 字符串
                                Prm_Appcode   OUT NUMBER, -- 返回值
                                Prm_Errormsg  OUT VARCHAR2) -- 错误信息
   RETURN NUMBER;

  -- 取两个字符串（逗号分隔的多个字符串组合）的交集
  FUNCTION Fun_a_IntersectStrings( Prm_SourceStr1 IN  VARCHAR2,
                                   Prm_SourceStr2 IN  VARCHAR2,
                                   Prm_Appcode    OUT NUMBER,
                                   Prm_Errormsg   OUT VARCHAR2 )
  RETURN VARCHAR2;

  -- 取两个字符串（逗号分隔的多个字符串组合）的差集
  FUNCTION Fun_a_MinusStrings( Prm_SourceStr1 IN  VARCHAR2,
                                   Prm_SourceStr2 IN  VARCHAR2,
                                   Prm_Appcode    OUT NUMBER,
                                   Prm_Errormsg   OUT VARCHAR2 )
  RETURN VARCHAR2;

  -- 取两个字符串（逗号分隔的多个字符串组合）的合集
  FUNCTION Fun_a_UnionStrings( Prm_SourceStr1 IN  VARCHAR2,
                                   Prm_SourceStr2 IN  VARCHAR2,
                                   Prm_Appcode    OUT NUMBER,
                                   Prm_Errormsg   OUT VARCHAR2 )
  RETURN VARCHAR2;

  -- 根据出生年月、截止日期，计算年龄
  FUNCTION Fun_a_Getage(Prm_Birthday   IN VARCHAR2, --生日：格式yyyymmdd
                        Prm_Presentday IN VARCHAR2, --截止日期：格式yyyymmdd，为空取系统时间
                        Prm_Caltype    IN VARCHAR2) --计算方式：'0'|'1'|'2'|'3'|null--截止到日|月|年|按年虚岁|日）
   RETURN NUMBER;
  -- 根据出生日期、截止日期()，计算年龄
  FUNCTION Fun_a_Getage(Prm_Birthday   IN DATE,
                        Prm_Presentday IN VARCHAR2, --格式yyyymmdd
                        Prm_Caltype    IN VARCHAR2) RETURN NUMBER;
  -- 根据出生年月、截止日期，计算年龄(计算方式:系统参数（aa01.AGETYPE)）-- '0'|'1'|'2'|'3'|null--截止到日|月|年|按年虚岁|日）)
  FUNCTION Fun_a_Getage(Prm_Birthday   IN VARCHAR2, --生日：格式yyyymmdd
                        Prm_Presentday IN VARCHAR2) --截止日期：格式yyyymmdd，为空取系统时间
   RETURN NUMBER;

  /*-------------------------------------------------------------------------*/
  /*== 公用过程 ==========================================*/
  /*-------------------------------------------------------------------------*/
  -- 取系统信息
  /*PROCEDURE Prc_Setsysinfo(Prm_User   IN VARCHAR2,
                           Prm_Baz001 IN NUMBER,
                           Prm_Baz002 IN NUMBER);*/

  -- 设置系统全局参数
  /*FUNCTION FUN_A_setsysinfo(Prm_Setsysinfo  IN VARCHAR2)
  RETURN BOOLEAN;*/

  -- 获取系统全局参数
  /*FUNCTION FUN_A_getsysinfo
  RETURN VARCHAR2;*/

  -- 取操作员
  FUNCTION Fun_a_GetUser RETURN VARCHAR2;
  -- 取序列号--唯一索引
  FUNCTION Fun_a_Getbaz001 RETURN NUMBER;
  FUNCTION Fun_a_Getbaz002 RETURN NUMBER;
  
   FUNCTION Fun_a_Getakc290 RETURN NUMBER;
  -- 取流水号
  FUNCTION Fun_a_Getlsh RETURN NUMBER;
  -- 增减月数(要求输入格式正确的6位年月)
  FUNCTION Fun_a_Add_Months(Prm_Issue NUMBER, Prm_Months NUMBER)
    RETURN NUMBER;

  -- 两个年月差(要求输入格式正确的6位年月)
  FUNCTION Fun_a_Months_Between(Prm_EndIssue NUMBER, Prm_BeginIssue NUMBER)
    RETURN NUMBER;

  -- 取时间序列号 格式 yyyymmddhhmiss + 6位循环序列号
  FUNCTION Fun_a_Gettimeseq RETURN NUMBER;

  -- 取时间序列号 格式 yyyymmddhhmiss + 6位循环序列号
  PROCEDURE Prc_a_Gettimeseq(Prm_Timeseq  OUT NUMBER,
                             Prm_Appcode  OUT NUMBER,
                             Prm_Errormsg OUT VARCHAR2);

  -- 获取综合参数
  PROCEDURE Prc_a_Getparameter(Prm_Sikind   IN VARCHAR2,
                               Prm_Prmcode  IN VARCHAR2,
                               Prm_Date     IN DATE,
                               Prm_Prmvalue OUT VARCHAR2,
                               Prm_Appcode  OUT NUMBER,
                               Prm_Errormsg OUT VARCHAR2);

  /*-------------------------------------------------------------------------------*/
  -- 计算人员年龄
  /*-------------------------------------------------------------------------------*/
  PROCEDURE Prc_a_GetAge(Prm_Birthday   IN VARCHAR2, --生日：格式yyyymmdd
                         Prm_Presentday IN VARCHAR2, --截止日期：格式yyyymmdd，为空取系统时间
                         Prm_Caltype    IN VARCHAR2, --计算方式：'0'|'1'|'2'|'3'|null--截止到日|月|年|按年虚岁|日）
                         prm_age        OUT NUMBER,
                         Prm_Appcode    OUT NUMBER,
                         Prm_Errormsg   OUT VARCHAR2);

  /*-------------------------------------------------------------------------------*/
  -- 校验身份证号
  /*-------------------------------------------------------------------------------*/
  FUNCTION Fun_Check_Peopleid(Prm_Sfzh IN VARCHAR2,
                              Prm_Msg  IN OUT VARCHAR2) RETURN BOOLEAN;

  /*-------------------------------------------------------------------------------*/
  -- 获取ab07id
  /*-------------------------------------------------------------------------------*/
  FUNCTION Fun_a_GetAB07ID RETURN NUMBER;
/*-------------------------------------------------------------------------------*/
  -- 根据序列名取序列值
  /*-------------------------------------------------------------------------------*/
  function Fun_getSeqByName(seqName in varchar2) return number;
  FUNCTION fun_getsyssettleym return varchar2;
/*  FUNCTION FUN_GetExemptFromFlag(prm_个人编号 IN VARCHAR2,
                                 prm_业务类别 IN VARCHAR2,--1城居免缴，2职工免缴
                                 prm_费款所属期     IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION Fun_copyFee (Prm_aac001 IN VARCHAR2) RETURN VARCHAR2 ;
  FUNCTION Fun_getFeeFlag(prm_aac001 in varchar2,prm_aae003 in varchar2)RETURN VARCHAR2 ;*/


 
 /* FUNCTION GetHzPYCAP(p_String varchar2) RETURN VARCHAR2;*/
END Pkg_CAA_Comm;
/
CREATE OR REPLACE PACKAGE BODY Pkg_CAA_Comm AS

  /*-------------------------------------------------------------------------
  || 过程名称 ：取精度函数
  || 功能描述 ：输入一个实数，按照取整方式和取整精度返回取整后的实数
  || 参数描述 ：参数标识        名称                输入/输出  类型
  ||            -------------------------------------------------------------
  ||            prm_RealNum     要处理的实数        输入       NUMBER,
  ||            prm_Style       取精度类型          输入       VARCHAR2,
  ||                            '0'-- "四舍五入法";'1'-- "进一法"；'2'-- "去尾法"；
  ||            prm_preci       取精度，精度值      输入       NUMBER
  ||                            例如：-1 -- "十位"； 0 -- "各位" ； 1 -- "个位"等
  || 作    者 ：ft         完成日期 ：2002-11-12
  ||-------------------------------------------------------------------------
  || 修改记录 ：
  ||-------------------------------------------------------------------------*/
  FUNCTION Fun_a_Preci(Prm_Realnum IN NUMBER,
                       Prm_Style   IN VARCHAR2,
                       Prm_Preci   IN NUMBER) RETURN NUMBER IS
    /*-- Data Type Declarations ---------------------------------------------------*/
    /*-- Cursor Declarations ------------------------------------------------------*/
    /*-- Variable Declarations ----------------------------------------------------*/
    Ln_Valrtn NUMBER; -- 返回值
  BEGIN

    IF Prm_Style = pkg_CAA_MACRO.Def_Precision_Ceil THEN
      -- "进一法"
      Ln_Valrtn := Ceil(Prm_Realnum * Power(10, Prm_Preci)) /
                   Power(10, Prm_Preci);
      RETURN(Ln_Valrtn);

    ELSIF Prm_Style = pkg_CAA_MACRO.Def_Precision_Trunc THEN
      -- "去尾法"
      Ln_Valrtn := Trunc(Prm_Realnum, Prm_Preci);
      RETURN(Ln_Valrtn);

    ELSIF Prm_Style = pkg_CAA_MACRO.Def_Precision_Round THEN
      -- "四舍五入法"
      Ln_Valrtn := Round(Prm_Realnum, Prm_Preci);
      RETURN(Ln_Valrtn);

    ELSE
      RETURN Prm_Style;

    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN - 99999999;
  END Fun_a_Preci;

  /*-------------------------------------------------------------------------
  || 过程名称 ：字符串解析成数组
  || 功能描述 ：根据输入字符串和分隔符，把一个长字符串按照分隔符解析成小字符串组
  || 调用说明 ：
  || 参数描述 ：参数标识        名称                输入/输出  类型
  ||            -------------------------------------------------------------
  ||            prm_SourceStr   原字符串            输入       VARCHAR2
  ||            prm_Separator   分隔符              输入       VARCHAR2
  ||            prm_Arrary      字符串数组          输出       TYP_TAB_STR
  ||            prm_AppCode     返回值              输出       NUMBER
  ||            prm_ErrorMsg    错误信息            输出       VARCHAR2
  ||
  || 作    者 ：FengT         完成日期 ：2004-06
  ||-------------------------------------------------------------------------
  || 修改记录 ：
  ||-------------------------------------------------------------------------*/
  FUNCTION Fun_a_Stringtoarrary(Prm_Sourcestr IN VARCHAR2,
                                Prm_Separator IN VARCHAR2,
                                Prm_Arrary    OUT Typ_Tab_Str,
                                Prm_Appcode   OUT NUMBER,
                                Prm_Errormsg  OUT VARCHAR2) RETURN NUMBER IS

    /*-- Data Type Declarations ---------------------------------------------------*/
    /*-- Cursor Declarations ------------------------------------------------------*/
    /*-- Variable Declarations ----------------------------------------------------*/
    n_Count NUMBER(6); -- 分隔符的个数
    n_Posb  NUMBER(6); -- 初始位置
    n_Pose  NUMBER(6); -- 分隔符的位置

  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;
    n_Count     := 0;
    n_Posb      := 1;

    -- 非空校验
    IF Prm_Sourcestr IS NULL THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Warning;
      Prm_Errormsg := '被解析的字符串不能为空!';
      RETURN 0;

    ELSIF Prm_Separator IS NULL THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Warning;
      Prm_Errormsg := '分隔符不能为空!';
      RETURN 0;

    END IF;

    LOOP
      n_Pose := Instr(Prm_Sourcestr, Prm_Separator, n_Posb, 1);

      n_Count := n_Count + 1;
      IF n_Pose = 0 THEN
        Prm_Arrary(n_Count) := Substr(Prm_Sourcestr,
                                      n_Posb,
                                      Length(Prm_Sourcestr) - n_Posb + 1);
        EXIT;
      END IF;

      Prm_Arrary(n_Count) := Rtrim(Ltrim(Substr(Prm_Sourcestr,
                                                n_Posb,
                                                n_Pose - n_Posb)));
      n_Posb := n_Pose + Length(Prm_Separator);

    END LOOP;

    RETURN n_Count;

  EXCEPTION
    WHEN OTHERS THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '解析字符串失败！：' || SQLERRM;
  END Fun_a_Stringtoarrary;

  /*-------------------------------------------------------------------------
  || 过程名称 ：字符串数组拼接成字符串
  || 功能描述 ：根据输入字符串数组和分隔符，把小字符串组按照分隔符拼接成一个长字符串
  || 调用说明 ：
  || 参数描述 ：参数标识        名称                输入/输出  类型
  ||            -------------------------------------------------------------
  ||            prm_Arrary      字符串数组          输入       TYP_TAB_STR
  ||            prm_Separator   分隔符              输入       VARCHAR2
  ||            prm_SourceStr   原字符串            输出       VARCHAR2
  ||            prm_AppCode     返回值              输出       NUMBER
  ||            prm_ErrorMsg    错误信息            输出       VARCHAR2
  ||
  || 作    者 ：FengT         完成日期 ：2004-06
  ||-------------------------------------------------------------------------
  || 修改记录 ：
  ||-------------------------------------------------------------------------*/
  FUNCTION Fun_a_Arrarytostring(Prm_Arrary    IN Typ_Tab_Str,
                                Prm_Separator IN VARCHAR2,
                                Prm_Sourcestr OUT VARCHAR2,
                                Prm_Appcode   OUT NUMBER,
                                Prm_Errormsg  OUT VARCHAR2) RETURN NUMBER IS

    /*-- Data Type Declarations ---------------------------------------------------*/
    /*-- Cursor Declarations ------------------------------------------------------*/
    /*-- Variable Declarations ----------------------------------------------------*/
  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;

    Prm_Sourcestr := '';

    -- 非空校验
    IF Prm_Arrary.COUNT = 0 THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Warning;
      Prm_Errormsg := '被拼接的字符串数组不能为空!';
      RETURN 0;

    ELSIF Prm_Separator IS NULL THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Warning;
      Prm_Errormsg := '分隔符不能为空!';
      RETURN 0;

    END IF;

    FOR i IN 1 .. Prm_Arrary.COUNT LOOP
      IF Prm_Arrary(i) IS NULL THEN
        Prm_Sourcestr := Prm_Sourcestr || Prm_Separator;
      ELSE
        Prm_Sourcestr := Prm_Sourcestr || Prm_Arrary(i) || Prm_Separator;
      END IF;

    END LOOP;

    IF Length(Prm_Sourcestr) > Length(Prm_Separator) THEN
      Prm_Sourcestr := Substr(Prm_Sourcestr,
                              1,
                              Length(Prm_Sourcestr) - Length(Prm_Separator));
    END IF;

    RETURN Prm_Arrary.COUNT;

  EXCEPTION
    WHEN OTHERS THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '拼接字符串数组失败！：' || SQLERRM;
  END Fun_a_Arrarytostring;

  /*---------------------------------------------------------------------------------
  || 过程名称 ：取两个字符串（逗号分隔的多个字符串组合）的交集
  || 功能描述 ：比较两个逗号分隔的字符串集中，找到相同的字符串，
  ||          然后组合成一个新字符串集（逗号分隔）
  || 调用说明 ：
  || 参数描述 ：参数标识        名称                               输入/输出  类型
  ||            ----------------------------------------------------------------------
  ||            prm_SourceStr1  输入字符串1（逗号分隔的字符串集）  输入       VARCHAR2
  ||            prm_SourceStr2  输入字符串2（逗号分隔的字符串集）  输入       VARCHAR2
  ||            prm_AppCode     返回值                             输出       NUMBER
  ||            prm_ErrorMsg    错误信息                           输出       VARCHAR2
  ||
  || 作    者 ：FengT         完成日期 ：2010-01
  ||---------------------------------------------------------------------------------
  || 修改记录 ：
  ||--------------------------------------------------------------------------------*/
  FUNCTION Fun_a_IntersectStrings( Prm_SourceStr1 IN  VARCHAR2,
                                   Prm_SourceStr2 IN  VARCHAR2,
                                   Prm_Appcode    OUT NUMBER,
                                   Prm_Errormsg   OUT VARCHAR2 )
  RETURN VARCHAR2
  IS

    /*-- Data Type Declarations ---------------------------------------------------*/
    /*-- Cursor Declarations ------------------------------------------------------*/
    /*-- Variable Declarations ----------------------------------------------------*/
    v_Str1Array  typ_tab_Str;
    v_resultStr  VARCHAR2(3000);
    n_rtn        NUMBER(6);
  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;
    v_resultStr := ' ';

    -- 空串处理
    IF ( Prm_SourceStr1 IS NULL OR length(TRIM(Prm_SourceStr1))=0 OR lower(Prm_SourceStr1) = 'null' OR
         Prm_SourceStr2 IS NULL OR length(TRIM(Prm_SourceStr2))=0 OR lower(Prm_SourceStr2) = 'null' ) THEN
       RETURN '';
    END IF;

    -- 解析字符串1
    n_rtn := Fun_a_Stringtoarrary(Prm_SourceStr1,',',v_Str1Array,Prm_Appcode,Prm_Errormsg);
    IF Prm_Appcode <> pkg_CAA_MACRO.DEF_OK THEN
       RETURN '';
    END IF;

    -- Intersect
    FOR i IN 1..v_Str1Array.COUNT LOOP
       IF instr( ','||Prm_SourceStr2||',',','||v_Str1Array(i)||',') > 0 AND
          instr( ','||v_resultStr||',',','||v_Str1Array(i)||',') = 0 THEN
          v_resultStr := trim( v_resultStr ) ||','||v_Str1Array(i);
       END IF;
    END LOOP;

    IF length(TRIM(v_resultStr)) > 0 THEN
       v_resultStr := substr(TRIM(v_resultStr),2);
    END IF;

    RETURN TRIM(v_resultStr);

  EXCEPTION
    WHEN OTHERS THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '取两个字符串（逗号分隔的多个字符串组合）的交集失败！：' || SQLERRM;
  END Fun_a_IntersectStrings;

  /*---------------------------------------------------------------------------------
  || 过程名称 ：取两个字符串（逗号分隔的多个字符串组合）的差集
  || 功能描述 ：比较两个逗号分隔的字符串集中，找到第一个字符串集中包含，但第二个不包含的字符串
  ||          然后组合成一个新字符串集（逗号分隔）
  || 调用说明 ：
  || 参数描述 ：参数标识        名称                               输入/输出  类型
  ||            ----------------------------------------------------------------------
  ||            prm_SourceStr1  输入字符串1（逗号分隔的字符串集）  输入       VARCHAR2
  ||            prm_SourceStr2  输入字符串2（逗号分隔的字符串集）  输入       VARCHAR2
  ||            prm_AppCode     返回值                             输出       NUMBER
  ||            prm_ErrorMsg    错误信息                           输出       VARCHAR2
  ||
  || 作    者 ：FengT         完成日期 ：2010-01
  ||---------------------------------------------------------------------------------
  || 修改记录 ：
  ||--------------------------------------------------------------------------------*/
  FUNCTION Fun_a_MinusStrings( Prm_SourceStr1 IN  VARCHAR2,
                                   Prm_SourceStr2 IN  VARCHAR2,
                                   Prm_Appcode    OUT NUMBER,
                                   Prm_Errormsg   OUT VARCHAR2 )
  RETURN VARCHAR2
  IS

    /*-- Data Type Declarations ---------------------------------------------------*/
    /*-- Cursor Declarations ------------------------------------------------------*/
    /*-- Variable Declarations ----------------------------------------------------*/
    v_Str1Array  typ_tab_Str;
    v_resultStr  VARCHAR2(3000);
    n_rtn        NUMBER(6);
  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;
    v_resultStr := ' ';

    -- 空串处理
    IF Prm_SourceStr1 IS NULL OR length(TRIM(Prm_SourceStr1))=0 OR lower(Prm_SourceStr1) = 'null' THEN
       RETURN '';
    END IF;

    IF Prm_SourceStr2 IS NULL OR length(TRIM(Prm_SourceStr2))=0 OR lower(Prm_SourceStr2) = 'null' THEN
       RETURN Prm_SourceStr1;
    END IF;

    -- 解析字符串1
    n_rtn := Fun_a_Stringtoarrary(Prm_SourceStr1,',',v_Str1Array,Prm_Appcode,Prm_Errormsg);
    IF Prm_Appcode <> pkg_CAA_MACRO.DEF_OK THEN
       RETURN '';
    END IF;

    -- Intersect
    FOR i IN 1..v_Str1Array.COUNT LOOP
       IF instr( ','||Prm_SourceStr2||',',','||v_Str1Array(i)||',') = 0 AND
          instr( ','||v_resultStr||',',','||v_Str1Array(i)||',') = 0 THEN
          v_resultStr := trim( v_resultStr ) ||','||v_Str1Array(i);
       END IF;
    END LOOP;

    IF length(TRIM(v_resultStr)) > 0 THEN
       v_resultStr := substr(TRIM(v_resultStr),2);
    END IF;

    RETURN TRIM(v_resultStr);

  EXCEPTION
    WHEN OTHERS THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '取两个字符串（逗号分隔的多个字符串组合）的交集失败！：' || SQLERRM;
  END Fun_a_MinusStrings;

  /*---------------------------------------------------------------------------------
  || 过程名称 ：取两个字符串（逗号分隔的多个字符串组合）的合集
  || 功能描述 ：两个逗号分隔的字符串集中，找到在第一个字符串集中包含，或第二个包含的字符串
  ||          然后组合成一个新字符串集（逗号分隔）
  || 调用说明 ：
  || 参数描述 ：参数标识        名称                               输入/输出  类型
  ||            ----------------------------------------------------------------------
  ||            prm_SourceStr1  输入字符串1（逗号分隔的字符串集）  输入       VARCHAR2
  ||            prm_SourceStr2  输入字符串2（逗号分隔的字符串集）  输入       VARCHAR2
  ||            prm_AppCode     返回值                             输出       NUMBER
  ||            prm_ErrorMsg    错误信息                           输出       VARCHAR2
  ||
  || 作    者 ：FengT         完成日期 ：2010-01
  ||---------------------------------------------------------------------------------
  || 修改记录 ：
  ||--------------------------------------------------------------------------------*/
  FUNCTION Fun_a_UnionStrings( Prm_SourceStr1 IN  VARCHAR2,
                                   Prm_SourceStr2 IN  VARCHAR2,
                                   Prm_Appcode    OUT NUMBER,
                                   Prm_Errormsg   OUT VARCHAR2 )
  RETURN VARCHAR2
  IS

    /*-- Data Type Declarations ---------------------------------------------------*/
    /*-- Cursor Declarations ------------------------------------------------------*/
    /*-- Variable Declarations ----------------------------------------------------*/
    v_Str1Array  typ_tab_Str;
    v_Str2Array  typ_tab_Str;
    v_resultStr  VARCHAR2(3000);
    n_rtn        NUMBER(6);
  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;
    v_resultStr := ' ';

    -- 空串处理
    IF ( Prm_SourceStr1 IS NULL OR length(TRIM(Prm_SourceStr1))=0 OR lower(Prm_SourceStr1) = 'null' ) AND
       ( Prm_SourceStr2 IS NULL OR length(TRIM(Prm_SourceStr2))=0 OR lower(Prm_SourceStr2) = 'null' ) THEN
          RETURN '';
    END IF;

    -- 解析字符串1
    IF NOT ( Prm_SourceStr1 IS NULL OR length(TRIM(Prm_SourceStr1))=0 OR lower(Prm_SourceStr1) = 'null' ) THEN
       n_rtn := Fun_a_Stringtoarrary(Prm_SourceStr1,',',v_Str1Array,Prm_Appcode,Prm_Errormsg);
       IF Prm_Appcode <> pkg_CAA_MACRO.DEF_OK THEN
          RETURN '';
       END IF;
    END IF;
    -- Uion
    FOR i IN 1..v_Str1Array.COUNT LOOP
       IF instr( ','||v_resultStr||',',','||v_Str1Array(i)||',') = 0 THEN
          v_resultStr := trim( v_resultStr ) ||','||v_Str1Array(i);
       END IF;
    END LOOP;

    -- 解析字符串2
    IF NOT ( Prm_SourceStr2 IS NULL OR length(TRIM(Prm_SourceStr2))=0 OR lower(Prm_SourceStr2) = 'null' ) THEN
       n_rtn := Fun_a_Stringtoarrary(Prm_SourceStr2,',',v_Str2Array,Prm_Appcode,Prm_Errormsg);
       IF Prm_Appcode <> pkg_CAA_MACRO.DEF_OK THEN
          RETURN '';
       END IF;
    END IF;

    -- Uion
    FOR i IN 1..v_Str2Array.COUNT LOOP
       IF instr( ','||v_resultStr||',',','||v_Str2Array(i)||',') = 0 THEN
          v_resultStr := trim( v_resultStr ) ||','||v_Str2Array(i);
       END IF;
    END LOOP;

    IF length(TRIM(v_resultStr)) > 0 THEN
       v_resultStr := substr(TRIM(v_resultStr),2);
    END IF;

    RETURN TRIM(v_resultStr);

  EXCEPTION
    WHEN OTHERS THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '取两个字符串（逗号分隔的多个字符串组合）的合集失败！：' || SQLERRM;
  END Fun_a_UnionStrings;

  /*-------------------------------------------------------------------------
  || 过程名称 ：Fun_Getuser
  || 功能描述 ：取用户名
  ||
  || 参数描述 ：参数标识      名称          输入输出  类型
  ||            -------------------------------------------------------------
  ||            Prm_User      用户名　　  输入      VARCHAR2
  ||
  || 作    者 ：孙广奎       完成日期 ：2005-10-27
  ||-------------------------------------------------------------------------
  ||-------------------------------------------------------------------------*/
  /*PROCEDURE Prc_Setsysinfo(Prm_User   IN VARCHAR2,
                           Prm_Baz001 IN NUMBER,
                           Prm_Baz002 IN NUMBER) IS
  BEGIN
    Str_User   := Prm_User;
    n_Baz001   := Prm_Baz001;
    n_Baz002   := Prm_Baz002;

    v_Setsysinfo := Str_User ||'|'|| n_Baz001 ||'|'||
                    n_Baz002;
  END Prc_Setsysinfo;*/

  /*-------------------------------------------------------------------------
  || 过程名称 ：FUN_A_setsysinfo
  || 功能描述 ：设置系统全局参数
  ||
  || 参数描述 ：参数标识        名称          输入输出  类型
  ||            -------------------------------------------------------------
  ||            Prm_Setsysinfo  系统全局参数  输入      VARCHAR2('|'分隔的字符串)
  ||
  || 作    者 ：冯涛       完成日期 ：2007-7-22
  ||-------------------------------------------------------------------------
  ||-------------------------------------------------------------------------*/
  /*FUNCTION FUN_A_setsysinfo(Prm_Setsysinfo  IN VARCHAR2)
  RETURN BOOLEAN
  IS
     \*-- variable Declarations ---------------------------------------------------*\
     tab_para       Typ_Tab_Str;
     n_rtn      NUMBER(3);
     n_Appcode  NUMBER(3);
     v_Errormsg VARCHAR2(100);
  BEGIN
     v_Setsysinfo := Prm_Setsysinfo;
     n_rtn := Fun_a_Stringtoarrary(v_Setsysinfo,'|',tab_para,n_Appcode,v_Errormsg );
     IF n_Appcode <> pkg_CAA_MACRO.def_ok THEN
        RETURN FALSE;
     END IF;

     Str_User   := tab_para(1);
     n_Baz001   := tab_para(2);
     n_Baz002   := tab_para(3);

     RETURN TRUE;
  END FUN_A_setsysinfo;*/

  /*-------------------------------------------------------------------------
  || 过程名称 ：FUN_A_getsysinfo
  || 功能描述 ：获取系统全局参数
  ||
  || 参数描述 ：参数标识        名称          输入输出  类型
  ||            -------------------------------------------------------------
  || 返回值：  系统全局参数（VARCHAR2）
  ||
  || 作    者 ：冯涛       完成日期 ：2007-7-22
  ||-------------------------------------------------------------------------
  ||-------------------------------------------------------------------------*/
  /*FUNCTION FUN_A_getsysinfo RETURN VARCHAR2
  IS
  BEGIN
    RETURN v_Setsysinfo;
  END FUN_A_getsysinfo;*/

  /*-------------------------------------------------------------------------
  || 函数名称 ：计算人员年龄
  || 功能描述 ：
  ||
  || 参数描述 ：参数标识          名称                  输入/输出  类型
  ||            -------------------------------------------------------------
  ||            prm_BirthDay      生日                  输入       VARCHAR2
  ||            prm_PrensentDay   截止日                输入       VARCHAR2
  ||            prm_CalType       计算方式              输入       VARCHAR2
  || 参数说明：
  ||        prm_PrensentDay   截止日  ：为空时默认为系统时间
  ||        prm_CalType       计算方式：'0'--截止到日;'1'--截止到月;
  ||                                    '2'--年初；   '3'--虚岁
  ||                                    null--截止到日;
  ||-------------------------------------------------------------------------
  || 作者     ：ft
  ||-------------------------------------------------------------------------
  || 修改     ：
  ||-------------------------------------------------------------------------*/
  FUNCTION Fun_a_Getage(Prm_Birthday   IN VARCHAR2, --格式yyyymmdd
                        Prm_Presentday IN VARCHAR2, --格式yyyymmdd
                        Prm_Caltype    IN VARCHAR2) RETURN NUMBER IS
    /*-- Data Type Declarations ---------------------------------------------------*/
    Lv_Enddate VARCHAR2(8); -- 截止日
    Lv_Caltype Aa01.Aaa005%TYPE; -- 计算方式数字型

    Ln_Birthyear  NUMBER(4); -- 生日年
    Ln_Birthmonth NUMBER(2); -- 生日月
    Ln_Birthday   NUMBER(2); -- 生日日
    Ln_Endyear    NUMBER(4); -- 截止年
    Ln_Endmonth   NUMBER(2); -- 截止月
    Ln_Endday     NUMBER(2); -- 截止日

    Ln_Age NUMBER(5); -- 年龄

  BEGIN
    -- 出生日期空参数处理
    -- 出生日期yyyymmdd
    IF Prm_Birthday IS NULL THEN
      RETURN - 1;
    END IF;

    -- 计算类型为空，则默认截止到日
    Lv_Caltype := NULL;
    IF Prm_Caltype IS NULL THEN
      Lv_Caltype := '0';
    ELSE
      Lv_Caltype := Prm_Caltype;
    END IF;

    -- 截止日期yyyymmdd
    IF Prm_Presentday IS NULL THEN
      Lv_Enddate := To_Char(SYSDATE, 'yyyymmdd');
    ELSIF Length(Prm_Presentday) = '4' THEN
      Lv_Enddate := Prm_Presentday || '0101';
    ELSIF Length(Prm_Presentday) = '6' THEN
      Lv_Enddate := Prm_Presentday || '01';
    ELSIF Length(Prm_Presentday) = '8' THEN
      Lv_Enddate := Prm_Presentday;
    ELSE
      Lv_Enddate := To_Char(SYSDATE, 'yyyymmdd');
    END IF;

    Ln_Birthyear  := To_Number(Substr(Prm_Birthday, 1, 4)); -- 生日年
    Ln_Birthmonth := To_Number(Substr(Prm_Birthday, 5, 2)); -- 生日月
    Ln_Birthday   := To_Number(Substr(Prm_Birthday, 7, 2)); -- 生日日
    Ln_Endyear    := To_Number(Substr(Lv_Enddate, 1, 4)); -- 截止年
    Ln_Endmonth   := To_Number(Substr(Lv_Enddate, 5, 2)); -- 截止月
    Ln_Endday     := To_Number(Substr(Lv_Enddate, 7, 2)); -- 截止日

    -- 计算到截止日期
    IF Lv_Caltype = '0' THEN
      IF Ln_Endday < Ln_Birthday THEN
        Ln_Endmonth := Ln_Endmonth - 1;
      END IF;

      IF Ln_Endmonth < Ln_Birthmonth THEN
        Ln_Endyear := Ln_Endyear - 1;
      END IF;

    END IF;

    -- 计算到截止月份
    IF Lv_Caltype = '1' THEN
      IF Ln_Endmonth < Ln_Birthmonth THEN
        Ln_Endyear := Ln_Endyear - 1;
      END IF;

    END IF;

    -- 计算到截止年度
    -- 计算年龄
    Ln_Age := Ln_Endyear - Ln_Birthyear;
    IF Lv_Caltype = '3' THEN
      Ln_Age := Ln_Age + 1;
    END IF;

    RETURN Ln_Age;

  END Fun_a_Getage;

  /*-------------------------------------------------------------------------
  || 函数名称 ：计算人员年龄
  || 功能描述 ：
  ||
  || 参数描述 ：参数标识          名称                  输入/输出  类型
  ||            -------------------------------------------------------------
  ||            prm_BirthDay      生日                  输入       date
  ||            prm_PrensentDay   截止日                输入       VARCHAR2
  ||            prm_CalType       计算方式              输入       VARCHAR2
  || 参数说明：
  ||        prm_PrensentDay   截止日  ：为空时默认为系统时间
  ||        prm_CalType       计算方式：'0'--截止到日;'1'--截止到月;
  ||                                    '2'--年初；   '3'--虚岁
  ||                                    null--截止到日;
  ||-------------------------------------------------------------------------
  || 作者     ：ft
  ||-------------------------------------------------------------------------
  || 修改     ：
  ||-------------------------------------------------------------------------*/
  FUNCTION Fun_a_Getage(Prm_Birthday   IN DATE,
                        Prm_Presentday IN VARCHAR2, --格式yyyymmdd
                        Prm_Caltype    IN VARCHAR2) RETURN NUMBER IS
    /*-- Data Type Declarations ---------------------------------------------------*/
  BEGIN
    RETURN Fun_a_Getage(To_Char(Prm_Birthday, 'yyyymmdd'),
                        Prm_Presentday,
                        Prm_Caltype);

  END Fun_a_Getage;

  /*-------------------------------------------------------------------------
  || 函数名称 ：计算人员年龄
  || 功能描述 ：
  ||
  || 参数描述 ：参数标识          名称                  输入/输出  类型
  ||            -------------------------------------------------------------
  ||            prm_BirthDay      生日                  输入       VARCHAR2
  ||            prm_PrensentDay   截止日                输入       VARCHAR2
  ||            prm_CalType       计算方式              输入       VARCHAR2
  || 参数说明：
  ||        prm_PrensentDay   截止日  ：为空时默认为系统时间
  ||        prm_CalType       计算方式：'0'--截止到日;'1'--截止到月;
  ||                                    '2'--年初；   '3'--虚岁
  ||                                    null--系统参数（aa01.AGETYPE)）
  ||-------------------------------------------------------------------------
  || 作者     ：ft
  ||-------------------------------------------------------------------------
  || 修改     ：
  ||-------------------------------------------------------------------------*/
  FUNCTION Fun_a_Getage(Prm_Birthday   IN VARCHAR2, --格式yyyymmdd
                        Prm_Presentday IN VARCHAR2) --格式yyyymmdd
   RETURN NUMBER IS
    /*-- Data Type Declarations ---------------------------------------------------*/
    Lv_Enddate VARCHAR2(8); -- 截止日
    Lv_Caltype Aa01.Aaa005%TYPE; -- 计算方式数字型

    Ln_Appcode  NUMBER(5); -- 返回值
    Lv_Errormsg VARCHAR2(100); -- 返回错误信息

  BEGIN

    -- 截止日期yyyymmdd为空
    IF Prm_Presentday IS NULL THEN
      Lv_Enddate := To_Char(SYSDATE, 'yyyymmdd');
    ELSIF Length(Prm_Presentday) = '4' THEN
      Lv_Enddate := Prm_Presentday || '0101';
    ELSIF Length(Prm_Presentday) = '6' THEN
      Lv_Enddate := Prm_Presentday || '01';
    ELSIF Length(Prm_Presentday) = '8' THEN
      Lv_Enddate := Prm_Presentday;
    ELSE
      Lv_Enddate := To_Char(SYSDATE, 'yyyymmdd');
    END IF;

    -- 年龄计算类型为空，择取系统参数（aa01.AGETYPE）；系统参数为空，则默认截止到日
    Lv_Caltype := Agetype;

    RETURN Fun_a_Getage(Prm_Birthday, Prm_Presentday, Lv_Caltype);

  END Fun_a_Getage;

  -- 取操作员
  FUNCTION Fun_a_GetUser RETURN VARCHAR2 IS
  BEGIN
    RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'username');
  END Fun_a_GetUser;

  -- 取序列号--唯一索引
  FUNCTION Fun_a_Getbaz001 RETURN NUMBER IS
    n_Seq_a_Baz001 NUMBER(20);
  BEGIN
    SELECT Seq_a_Baz001.NEXTVAL INTO n_Seq_a_Baz001 FROM Dual; -- 唯一索引
    RETURN n_Seq_a_Baz001;
  END Fun_a_Getbaz001;

  FUNCTION Fun_a_Getbaz002 RETURN NUMBER IS
  BEGIN
    RETURN SYS_CONTEXT(SYS_CONTEXT ('USERENV', 'CURRENT_SCHEMA'), 'operationid');
  END;
  
   FUNCTION Fun_a_Getakc290 RETURN NUMBER IS
      n_Seq_aAkc290 NUMBER(20);
  BEGIN
    SELECT SEQ_A_AKC290.NEXTVAL INTO n_Seq_aAkc290 FROM Dual; -- 唯一索引
    RETURN n_Seq_aAkc290;
  END Fun_a_Getakc290;
     
  -- 取流水号
  FUNCTION Fun_a_Getlsh RETURN NUMBER IS
    n_Seq_a_Lsh NUMBER(20);
  BEGIN
    SELECT Seq_a_Lsh.NEXTVAL INTO n_Seq_a_Lsh FROM Dual; -- 取流水号
    RETURN n_Seq_a_Lsh;
  END Fun_a_Getlsh;

  -- 增减月数(要求输入格式正确的6位年月)
  FUNCTION Fun_a_Add_Months(Prm_Issue NUMBER, Prm_Months NUMBER)
    RETURN NUMBER IS
  BEGIN
    RETURN To_Number(To_Char(Add_Months(To_Date(To_Char(Prm_Issue),
                                                'yyyymm'),
                                        Prm_Months),
                             'yyyymm'));
  END Fun_a_Add_Months;

  -- 两个年月差(要求输入格式正确的6位年月)
  FUNCTION Fun_a_Months_Between(Prm_EndIssue NUMBER, Prm_BeginIssue NUMBER)
    RETURN NUMBER IS
  BEGIN
    RETURN Months_between(To_Date(To_Char(Prm_EndIssue),
                                                'yyyymm'),
                                        To_Date(To_Char(Prm_BeginIssue),
                                                'yyyymm'));
  END Fun_a_Months_Between;

  -- 取时间序列号 格式 yyyymmddhhmiss + 6位循环序列号
  FUNCTION Fun_a_Gettimeseq RETURN NUMBER IS
    -- Declare variable-----------------------------------
    n_Seq NUMBER(20);
  BEGIN
    --song.jh 20131018 修改流水号为18为，将序列改为4位，同时左拼接也要改为4.（由6改为4）。
    SELECT To_Number(To_Char(SYSDATE, 'yyyymmddhhmiss') ||
                     Lpad(Seq_a_6cycle.NEXTVAL, 4, '0'))
      INTO n_Seq
      FROM Dual;
    RETURN n_Seq;

  END Fun_a_Gettimeseq;

  /*-------------------------------------------------------------------------
  || 过程名称 ：Prc_GetTimeSeq
  || 功能描述 ：取时间序列号 格式 yyyymmddhhmiss + 6位循环序列号
  ||
  || 参数描述 ：参数标识      名称          输入输出  类型
  ||            -------------------------------------------------------------
  ||            prm_timeSeq   序列号        输入      VARCHAR2
  ||
  || 作    者 ：孙广奎       完成日期 ：2005-10-27
  ||-------------------------------------------------------------------------
  ||-------------------------------------------------------------------------*/
  PROCEDURE Prc_a_Gettimeseq(Prm_Timeseq  OUT NUMBER,
                             Prm_Appcode  OUT NUMBER,
                             Prm_Errormsg OUT VARCHAR2) IS
  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;

    Prm_Timeseq := Fun_a_Gettimeseq;

    IF Prm_Timeseq IS NULL OR Prm_Timeseq < 0 THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '生成时间序列号失败';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '出错:' || SQLERRM;
  END Prc_a_Gettimeseq;

  /*-------------------------------------------------------------------------
  || 过程名称 ：获取综合参数
  || 功能描述 ：根据险种类型、参数类别代码及参数代码，取得综合参数信息中相应
  ||            参数值。
  || 参数描述 ：参数标识        名称                输入/输出  类型
  ||            -------------------------------------------------------------
  ||            prm_SIKind      险种类型            输入       VARCHAR2
  ||            prm_PrmCode     参数代码            输入       VARCHAR2
  ||            prm_Date        时间                输入       DATE
  ||            prm_PrmValue    参数值              输出       VARCHAR
  ||            prm_AppCode     执行代码            输出       NUMBER
  ||            prm_ErrorMsg    出错信息            输出       VARCHAR2
  ||
  || 作    者 ：A       完成日期 ：200509
  ||-------------------------------------------------------------------------
  || 修改记录 ：
  ||-------------------------------------------------------------------------*/
  PROCEDURE Prc_a_Getparameter(Prm_Sikind   IN VARCHAR2,
                               Prm_Prmcode  IN VARCHAR2,
                               Prm_Date     IN DATE,
                               Prm_Prmvalue OUT VARCHAR2,
                               Prm_Appcode  OUT NUMBER,
                               Prm_Errormsg OUT VARCHAR2) IS
    /*-- 变量声明 ----------------------------------------------------------*/
    d_Date DATE; -- 时间
    /*-- Cursor 声明 -------------------------------------------------------*/
    CURSOR cur_aa01 IS
      SELECT aaa005 -- 参数值
        FROM aa01 -- 综合参数信息
       WHERE bae130 = Prm_Sikind -- 险种大类
         AND aaa001 = Prm_Prmcode -- 参数代码
         AND aae030 <= d_Date -- 开始时间
         AND (aae031 >= d_Date OR -- 终止时间
             aae031 IS NULL);
  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;
    d_Date      := To_Date(To_Char(Prm_Date, 'YYYYMM'), 'YYYYMM') + .99999;
    OPEN cur_aa01;
    FETCH cur_aa01
      INTO prm_prmValue;
    IF cur_aa01%NOTFOUND THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Warning;
      Prm_Errormsg := '险种类型 = ' || Prm_Sikind || '参数代码 = ' ||
                      Prm_Prmcode || ',综合参数未设置';
    END IF;
    CLOSE Cur_Aa01;
  EXCEPTION
    WHEN OTHERS THEN
      IF Cur_Aa01%ISOPEN THEN
        CLOSE Cur_Aa01;
      END IF;
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '获取综合参数,系统错误';
  END Prc_a_Getparameter;

  /*-------------------------------------------------------------------------
  || 过程名称 ：Prc_a_GetAge
  || 功能描述 ：计算人员年龄,包装函数  供前台调用
  ||
  ||
  || 作    者 ：伍云飞      完成日期 ：2008-08-08
  ||-------------------------------------------------------------------------
  ||-------------------------------------------------------------------------*/
  PROCEDURE Prc_a_GetAge(Prm_Birthday   IN VARCHAR2,
                         Prm_Presentday IN VARCHAR2,
                         Prm_Caltype    IN VARCHAR2,
                         prm_age        OUT NUMBER,
                         Prm_Appcode    OUT NUMBER,
                         Prm_Errormsg   OUT VARCHAR2) IS
  BEGIN
    -- 初始化
    Prm_Appcode := pkg_CAA_MACRO.Def_Ok;
    -- 包装函数调用
    prm_age := Fun_a_Getage(Prm_Birthday, Prm_Presentday, Prm_Caltype);

  EXCEPTION
    WHEN OTHERS THEN
      Prm_Appcode  := pkg_CAA_MACRO.Def_Err;
      Prm_Errormsg := '出错:' || SQLERRM;
  END Prc_a_GetAge;

  /*-------------------------------------------------------------------------------*/
  -- 校验身份证号
  -- caoxj Add
  /*-------------------------------------------------------------------------------*/
  FUNCTION Fun_Check_Peopleid(Prm_Sfzh IN VARCHAR2,
                              Prm_Msg  IN OUT VARCHAR2) RETURN BOOLEAN IS
    v_Sfzh_Cssj VARCHAR2(20);
    v_Last      VARCHAR2(20);
    v_Cssj      DATE;
  BEGIN
    Prm_Msg := '';

    --判断身份证号输入长度是否满足条件
    IF Length(Prm_Sfzh) <> 15 AND Length(Prm_Sfzh) <> 18 THEN
      Prm_Msg := '公民身份证号码长度不符合要求！';
      RETURN FALSE;
    END IF;

    --由输入身份证号获取个人出生日期，并校验
    IF Length(Prm_Sfzh) = 15 THEN
      v_Sfzh_Cssj := '19' || Substr(Prm_Sfzh, 7, 6);
    ELSIF Length(Prm_Sfzh) = 18 THEN
      v_Sfzh_Cssj := Substr(Prm_Sfzh, 7, 8);
    END IF;

    v_Cssj := To_Date(v_Sfzh_Cssj, 'YYYYMMDD');

    IF v_Cssj <= To_Date('19000101', 'YYYYMMDD') THEN
      Prm_Msg := '公民身份证号码格式不符合要求，出生日期过小，请核实！';
      RETURN FALSE;
    END IF;

    --校验身份证最后三或四位
    IF Length(Prm_Sfzh) = 15 THEN
      v_Last := Substr(Prm_Sfzh, 13, 3); --取后三位;
      IF Translate(v_Last, '1234567890', '9999999999') <> '999' THEN
        Prm_Msg := '公民身份证号码格式不符合要求，校验码不和法，请核实！';
        RETURN FALSE;
      END IF;
    ELSIF Length(Prm_Sfzh) = 18 THEN
      v_Last := Substr(Prm_Sfzh, 15, 4); --取后四位
      IF Translate(Substr(v_Last, 1, 3), '1234567890', '9999999999') <>
         '999' THEN
        Prm_Msg := '公民身份证号码格式不符合要求，校验码不和法，请核实！';
        RETURN FALSE;
      END IF;
      IF Translate(Substr(v_Last, 4, 1), '1234567890', '9999999999') <> '9' AND
         Upper(Substr(v_Last, 4, 1)) <> 'X' THEN
        Prm_Msg := '公民身份证号码格式不符合要求，校验位不合法，请核实！';
        RETURN FALSE;
      END IF;
    END IF;

    RETURN TRUE;

  EXCEPTION
    WHEN OTHERS THEN
      Prm_Msg := '校验身份证号码合法性时出错：' || SQLERRM;
      RETURN FALSE;
  END Fun_Check_Peopleid;

  --获取ab07id
  FUNCTION Fun_a_GetAB07ID RETURN NUMBER IS
    n_Seq_a_AB07ID NUMBER(20);
  BEGIN

    SELECT Seq_a_ab07id.NEXTVAL INTO n_Seq_a_AB07ID FROM Dual; -- 唯一索引

    RETURN n_Seq_a_AB07ID;

  END Fun_a_GetAB07ID;

    /*-------------------------------------------------------------------------
  || 过程名称 ：FUN_A_setsysinfo
  || 功能描述 ：设置系统全局参数
  ||
  || 参数描述 ：参数标识        名称          输入输出  类型
  ||            -------------------------------------------------------------
  ||            Prm_Setsysinfo  系统全局参数  输入      VARCHAR2('|'分隔的字符串)
  ||
  || 作    者 ：冯涛       完成日期 ：2007-7-22
  ||-------------------------------------------------------------------------
  ||-------------------------------------------------------------------------*/
  FUNCTION FUN_A_setsysinfo(Prm_Setsysinfo  IN VARCHAR2)
  RETURN BOOLEAN
  IS
     /*-- variable Declarations ---------------------------------------------------*/
     tab_para       Typ_Tab_Str;
     n_rtn      NUMBER(3);
     n_Appcode  NUMBER(3);
     v_Errormsg VARCHAR2(100);
  BEGIN
     v_Setsysinfo := Prm_Setsysinfo;
     n_rtn := Fun_a_Stringtoarrary(v_Setsysinfo,'|',tab_para,n_Appcode,v_Errormsg );
     IF n_Appcode <> pkg_caa_macro.def_ok THEN
        RETURN FALSE;
     END IF;

     Str_User   := tab_para(1);
     n_Baz001   := tab_para(2);
     n_Baz002   := tab_para(3);
    -- Str_Aic114 := tab_para(4);

     RETURN TRUE;
  END FUN_A_setsysinfo;
    /*-------------------------------------------------------------------------
  || 过程名称 ：FUN_A_getsysinfo
  || 功能描述 ：获取系统全局参数
  ||
  || 参数描述 ：参数标识        名称          输入输出  类型
  ||            -------------------------------------------------------------
  || 返回值：  系统全局参数（VARCHAR2）
  ||
  || 作    者 ：冯涛       完成日期 ：2007-7-22
  ||-------------------------------------------------------------------------
  ||-------------------------------------------------------------------------*/
  FUNCTION FUN_A_getsysinfo RETURN VARCHAR2
  IS
  BEGIN
    RETURN v_Setsysinfo;
  END FUN_A_getsysinfo;
  function Fun_getSeqByName(seqName in varchar2) return number is
    retSeq number;
  begin
    execute immediate 'select ' || seqName || '.nextVal from dual'
      into retSeq;
    return retSeq;
  end Fun_getSeqByName;
  FUNCTION fun_getsyssettleym return varchar2
  is
   Lv_Settleym VARCHAR2(20); -- 系统结算期
  BEGIN
      -- 获得系统结算期
      SELECT Aaa005
        INTO Lv_Settleym
        FROM Aa01
       WHERE BAE130 = '0'
         AND aaa001 = 'XTJSQ';

      IF SQLCODE < 0 THEN
        RETURN - 1;
      END IF;

      RETURN Lv_Settleym;

  EXCEPTION
      WHEN OTHERS THEN
        RETURN - 1;
  end fun_getsyssettleym;
  
 
  




function CARDID_VALID(CardId IN VARCHAR2) RETURN NUMBER IS

   n_SysYear      NUMBER(4);
   n_IdYear       NUMBER(4);
   n_IdMonth      NUMBER(2);
   n_IdDay        NUMBER(3);
   v_Last         VARCHAR2(1);
BEGIN
   n_SysYear := to_char(SYSDATE,'yyyy');
   IF lengthb(CardId) = 18 OR lengthb(CardId) = 15 THEN
      IF length(CardId) = 18 THEN
         IF translate(substr(CardId,1,17),'12314567890', '99999999999999999') <> '99999999999999999' THEN
            --前17位不全是数字
            RETURN 0;
         END IF;
         n_IdYear := to_number(substr(CardId,7,4));
         n_IdMonth := to_number(substr(CardId,11,2));
         n_IdDay := to_number(substr(CardId,13,2));
         v_Last := substr(CardId,18,1);
         IF v_Last < '0' AND v_Last > '9' AND v_Last <> 'X' THEN
            --校验位不在合法范围内
            RETURN 0;
         END IF;
      ELSE
         IF translate(substr(CardId,1,15),'12314567890', '999999999999999') <> '999999999999999' THEN
            --前15位不全是数字
            RETURN 0;
         END IF;
         n_IdYear := to_number('19'||substr(CardId,7,2));
         n_IdMonth := to_number(substr(CardId,9,2));
         n_IdDay := to_number(substr(CardId,11,2));
      END IF;

      IF n_IdYear< n_SysYear-150 THEN
         --出生年度过早，大于150岁
         RETURN 0;
      ELSIF n_IdYear > n_SysYear THEN
         --出生年度不能晚于当前年度
         RETURN 0;
      END IF;

      IF n_IdMonth < 1 OR n_IdMonth > 12 THEN
         --出生月份
         RETURN 0;
      END IF;

      IF n_IdDay < 1 THEN
         --出生日期小于1
         RETURN 0;
      END IF;

      IF n_IdMonth IN(1,3,5,7,8,10,12) AND n_IdDay > 31 THEN
         RETURN 0;
      ELSIF n_IdMonth IN(4,6,9,11) AND n_IdDay > 30 THEN
         RETURN 0;
      ELSIF n_IdMonth = 02 THEN
         IF MOD(n_IdYear,4) <> 0 THEN
            IF n_IdDay > 28 THEN
               RETURN 0;
            END IF;
         ELSE
            IF n_IdDay > 29 THEN
               RETURN 0;
            END IF;
         END IF;
      END IF;
      /*--判断18位的校验位是否合法
      IF length(CardId) = 18 AND id_card_15_18(substr(CardId,1,6)||substr(CardId,9,9)) <> CardId THEN
         RETURN 0;
      END IF;*/
   ELSE
      --不是15或18位
      RETURN 0;
   END IF;
   RETURN 1;
END CARDID_VALID;

function id_card_15_18(prm_id15 in Varchar2)
  return varchar2 is
  prm_ID18 Varchar2(20);

  type ww is varray(18) of number(2);
  type aa is varray(11) of varchar2(1);
  i     number := 1;
  str   varchar2(18);
  Str2  Varchar2(18);
  v_sum number(10);
  ai    number(2);
  w     ww := ww(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
  a     aa := aa('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
BEGIN

  IF length(prm_ID15) = 15 then
    str   := substr(prm_ID15, 1, 6) || '19' || substr(prm_ID15, 7, 9);
    v_sum := 0;
    FOR i IN 1 .. 17 LOOP
      v_sum := v_sum + to_number(substr(str, i, 1)) * w(i);
    END LOOP;
    ai       := MOD(v_sum, 11);
    prm_ID18 := str || a(ai + 1);
    Return prm_ID18;
  ELSIF LENGTH(prm_ID15) = 18 THEN

    if substr(Prm_Id15, 18, 1) = 'x' then
      Str2     := substr(Prm_Id15, 1, 17) || 'X';
      Prm_Id18 := Str2;
      Return prm_ID18;
    else
      Prm_Id18 := Prm_Id15;
      Return prm_ID18;
    end if;

  ELSE
    Return prm_id15;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    Return prm_id15;
end id_card_15_18;

function get_codeName(COL_NAME in Varchar2,COL_VALUE in varchar2)
  return varchar2 is
  v_result Varchar2(300);
BEGIN
  v_result := '';

  select decode((select aaa103
                from aa10
               where aaa100 = COL_NAME
                 and aaa102 = COL_VALUE
                 and rownum = 1),
              null,
              COL_VALUE,
              (select aaa103
                 from aa10
                where aaa100 = COL_NAME
                  and aaa102 = COL_VALUE
                  and rownum = 1))
  into
   v_result
  from dual;

  return v_result;

EXCEPTION
  WHEN OTHERS THEN
    Return '没有取到二级代码值';
end get_codeName;


function FUN_GET_BASE(prm_Salary in NUMBER,prm_UnitCode in NUMBER,prm_PersonCode in NUMBER,prm_Issue IN VARCHAR2)
 return varchar2 is

   n_AAC040             NUMBER(16,2);
   n_AIC020             NUMBER(16,2);
   n_AKC010             NUMBER(16,2);
   n_AJC020             NUMBER(16,2);
   n_ALC001             NUMBER(16,2);
   n_AMC001             NUMBER(16,2);
   n_AppCode            NUMBER(3);
   v_ErrorMsg           VARCHAR2(1000);
   v_result             varchar2(100);
BEGIN
   n_AppCode := pkg_caa_macro.DEF_OK;
   v_ErrorMsg := '';
   v_result := '';

   n_AAC040 := prm_salary;
   n_AIC020 := 0;
   n_AKC010 := 0;
   n_AJC020 := 0;
   n_ALC001 := 0;
   n_AMC001 := 0;


  /*PKG_CAD_SALARYDECLARE.Prc_A_基数计算(prm_PersonCode,
                           prm_UnitCode,
                           prm_Issue,
                           n_AAC040,
                           n_AIC020,
                           n_AJC020,
                           n_AKC010,
                           n_ALC001,
                           n_AMC001,
                           n_AppCode,
                           v_ErrorMsg);*/
  IF n_AppCode = pkg_caa_macro.DEF_ERR THEN
     v_ErrorMsg := 'error';
  END IF;

  if v_ErrorMsg is not null then
	    v_result := v_ErrorMsg;
  else
      v_result := n_AIC020 || ',' || n_AJC020 || ',' || n_AKC010 || ',' || n_ALC001 || ',' || n_AMC001;
  end if;

  return v_result;

EXCEPTION
  WHEN OTHERS THEN
    Return v_result;
end FUN_GET_BASE;









/*function FUN_CHECK_15OR18(PRM_IDIN in VARCHAR2)
  return VARCHAR2 is

  PRM_IDOUT VARCHAR2(18);
  TYPE WW IS VARRAY(18) OF NUMBER(2);
  TYPE AA IS VARRAY(11) OF VARCHAR2(1);
  I     NUMBER := 1;
  STR   VARCHAR2(18);
  V_SUM NUMBER(10);
  AI    NUMBER(2);
  W     WW := WW(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
  A     AA := AA('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
  N_RESULT NUMBER(3);
BEGIN
  PRM_IDOUT := '0';
  N_RESULT := 1;

  if LENGTH(PRM_IDIN) = 15 OR LENGTH(PRM_IDIN) = 18 then
	    N_RESULT := CARDID_VALID(PRM_IDIN);
  end if;

  if N_RESULT = 0 then
	   RETURN PRM_IDIN;
  end if;

  --15位升级为18位
  IF LENGTH(PRM_IDIN) = 15 THEN
    STR   := SUBSTR(PRM_IDIN, 1, 6) || '19' || SUBSTR(PRM_IDIN, 7, 9);
    V_SUM := 0;
    FOR I IN 1 .. 17 LOOP
      V_SUM := V_SUM + TO_NUMBER(SUBSTR(STR, I, 1)) * W(I);
    END LOOP;
    AI        := MOD(V_SUM, 11);
    PRM_IDOUT := STR || A(AI + 1);
    --18位转换为15位
  ELSIF LENGTH(PRM_IDIN) = 18 THEN
    PRM_IDOUT := SUBSTR(PRM_IDIN, 1, 6) || SUBSTR(PRM_IDIN, 9, 9);
    --否则返回原来的身份证号码
  ELSE
    PRM_IDOUT := PRM_IDIN;
  END IF;
  return PRM_IDOUT;
end FUN_CHECK_15OR18;

FUNCTION GetHzFullPY(p_String varchar2)
 RETURN VARCHAR2 IS
--declare
 --p_String varchar2(200) := '???????';
 v_char varchar2(2);  --????
 n_loop number;    --??
 n_len number;     --????
 n_ascii number;   --??ASCII?
 n_ord_high number; --n_ascii/156
 n_ord_low number;  --n mod 256
 n_temp number;
 n_temp1 number;
 v_PY varchar2(32767);

BEGIN
  v_PY := '';
  n_len := length(p_String);
  FOR n_loop IN 1..n_len LOOP
    v_char := substr(p_string,n_loop,1);
    IF upper(v_char) IN (
        'A','B','C','D','E','F','G',
        'H','I','J','K','L','M','N',
        'O','P','Q','R','S','T',
        'U','V','W','X','Y','Z',
        '0','1','2','3','4','5','6','7','8','9',
        '(', ')', '[', ']','.', '!', '@', '#', '$',
        '%', '^', '&', '*', '-', '+','<', '>', '?', ':', '"')  THEN
      v_PY := v_PY||v_char;
    ELSE
        n_ascii := ascii(v_char);
        n_ord_high := trunc(n_ascii/256,0);
        n_ord_low := n_ascii-(n_ord_high*256);
        --DBMS_OUTPUT.PUT_LINE('n_ascii = '||to_char(n_ascii,'9999999'));
        --DBMS_OUTPUT.PUT_LINE('n_ord_high = '||to_char(n_ord_high,'9999999'));
        --DBMS_OUTPUT.PUT_LINE('n_ord_low = '||to_char(n_ord_low,'9999999'));
        IF (n_ord_high>128) and (n_ord_low>63) THEN
          CASE n_ord_high
            WHEN 162 THEN     --????
              IF n_ord_low>160 THEN
               -- v_PY := v_PY||get_roma_num_py(n_ord_low-160);
               null;
              END IF;
            WHEN 163 THEN     --??ASCII
              IF n_ord_low>128 THEN
                v_char := chr(n_ord_low-128);
                IF upper(v_char) IN (
                   'A','B','C','D','E','F','G',
                   'H','I','J','K','L','M','N',
                   'O','P','Q','R','S','T',
                   'U','V','W','X','Y','Z',
                   '0','1','2','3','4','5','6','7','8','9',
                   '(', ')', '[', ']') THEN
                  v_PY := v_PY||v_char;
                END IF;
              END IF;
            WHEN 166 THEN     --????
              IF (n_ord_low>160) AND (n_ord_low<185) THEN --A1--B8
                v_PY := v_PY||get_greece_alphabet_py(n_ord_low-160);
              ELSE
                IF (n_ord_low>192) AND (n_ord_low<217) THEN --C1--D8
                  v_PY := v_PY||get_greece_alphabet_py(n_ord_low-192);
                END IF;
              END IF;
            ELSE
            BEGIN
              n_temp := n_ord_high-128;
              n_ord_low := n_ord_low-63;
              n_temp1 := trunc(n_temp/10,0);
              n_temp1 := n_temp-n_temp1*10;
              IF n_temp1=0 THEN
                n_temp1 := 10;
              END IF;
              --DBMS_OUTPUT.PUT_LINE('n_temp = '||to_char(n_temp,'9999999'));
              --DBMS_OUTPUT.PUT_LINE('n_temp1 = '||to_char(n_temp1,'9999999'));
              CASE
              WHEN n_temp<11 THEN
                n_temp1 := get_py_index_01(n_temp1,n_ord_low);
              WHEN n_temp<21 THEN
                n_temp1 := get_py_index_02(n_temp1,n_ord_low);
              WHEN n_temp<31 THEN
                n_temp1 := get_py_index_03(n_temp1,n_ord_low);
              WHEN n_temp<41 THEN
                n_temp1 := get_py_index_04(n_temp1,n_ord_low);
              WHEN n_temp<51 THEN
                n_temp1 := get_py_index_05(n_temp1,n_ord_low);
              WHEN n_temp<61 THEN
                n_temp1 := get_py_index_06(n_temp1,n_ord_low);
              WHEN n_temp<71 THEN
                n_temp1 := get_py_index_07(n_temp1,n_ord_low);
              WHEN n_temp<81 THEN
                n_temp1 := get_py_index_08(n_temp1,n_ord_low);
              WHEN n_temp<91 THEN
                n_temp1 := get_py_index_09(n_temp1,n_ord_low);
              WHEN n_temp<101 THEN
                n_temp1 := get_py_index_10(n_temp1,n_ord_low);
              WHEN n_temp<111 THEN
                n_temp1 := get_py_index_11(n_temp1,n_ord_low);
              WHEN n_temp<121 THEN
                n_temp1 := get_py_index_12(n_temp1,n_ord_low);
              WHEN n_temp<121 THEN
                n_temp1 := get_py_index_13(n_temp1,n_ord_low);
              ELSE
                n_temp1 := 0;
              END CASE;
              v_PY := v_PY||GetHzPY_by_index(n_temp1);
            END;
          END CASE;
        END IF;
    END IF;
  END LOOP;
  RETURN v_PY;
  --DBMS_OUTPUT.PUT_LINE(v_PY);
END;*/


/*FUNCTION GETHZFULLPY_NEW(p_String varchar2)
 RETURN VARCHAR2 DETERMINISTIC IS
v_PY varchar2(32767);
begin
  v_PY := GetHzFullPY(p_String);
  return(v_PY);
end GetHzFullPY_new;*/

/*FUNCTION GetHzPYCAP(p_String varchar2) --?????
 RETURN VARCHAR2 IS
--declare
 --p_String varchar2(200) := '???????';
 v_char varchar2(2);  --????
 n_loop number;    --??
 n_len number;     --????
 n_ascii number;   --??ASCII?
 n_ord_high number; --n_ascii/156
 n_ord_low number;  --n mod 256
 n_temp number;
 n_temp1 number;
 v_PY varchar2(32767);

BEGIN
  v_PY := '';
  n_len := length(p_String);
  FOR n_loop IN 1..n_len LOOP
    v_char := substr(p_string,n_loop,1);
    IF upper(v_char) IN (
        'A','B','C','D','E','F','G',
        'H','I','J','K','L','M','N',
        'O','P','Q','R','S','T',
        'U','V','W','X','Y','Z',
        '0','1','2','3','4','5','6','7','8','9',
        '(', ')', '[', ']','.', '!', '@', '#', '$',
        '%', '^', '&', '*', '-', '+','<', '>', '?', ':', '"')  THEN
      v_PY := v_PY||v_char;
    ELSE
        n_ascii := ascii(v_char);
        n_ord_high := trunc(n_ascii/256,0);
        n_ord_low := n_ascii-(n_ord_high*256);
        --DBMS_OUTPUT.PUT_LINE('n_ascii = '||to_char(n_ascii,'9999999'));
        --DBMS_OUTPUT.PUT_LINE('n_ord_high = '||to_char(n_ord_high,'9999999'));
        --DBMS_OUTPUT.PUT_LINE('n_ord_low = '||to_char(n_ord_low,'9999999'));
        IF (n_ord_high>128) and (n_ord_low>63) THEN
          CASE n_ord_high
            WHEN 162 THEN     --????
              IF n_ord_low>160 THEN
                v_PY := v_PY||get_roma_num_py(n_ord_low-160);
              END IF;
            WHEN 163 THEN     --??ASCII
              IF n_ord_low>128 THEN
                v_char := chr(n_ord_low-128);
                IF upper(v_char) IN (
                   'A','B','C','D','E','F','G',
                   'H','I','J','K','L','M','N',
                   'O','P','Q','R','S','T',
                   'U','V','W','X','Y','Z',
                   '0','1','2','3','4','5','6','7','8','9',
                   '(', ')', '[', ']') THEN
                  v_PY := v_PY||v_char;
                END IF;
              END IF;
            WHEN 166 THEN     --????
              IF (n_ord_low>160) AND (n_ord_low<185) THEN --A1--B8
                v_PY := v_PY||get_greece_alphabet_py(n_ord_low-160);
              ELSE
                IF (n_ord_low>192) AND (n_ord_low<217) THEN --C1--D8
                  v_PY := v_PY||get_greece_alphabet_py(n_ord_low-192);
                END IF;
              END IF;
            ELSE
            BEGIN
              n_temp := n_ord_high-128;
              n_ord_low := n_ord_low-63;
              n_temp1 := trunc(n_temp/10,0);
              n_temp1 := n_temp-n_temp1*10;
              IF n_temp1=0 THEN
                n_temp1 := 10;
              END IF;
              --DBMS_OUTPUT.PUT_LINE('n_temp = '||to_char(n_temp,'9999999'));
              --DBMS_OUTPUT.PUT_LINE('n_temp1 = '||to_char(n_temp1,'9999999'));
              CASE
              WHEN n_temp<11 THEN
                n_temp1 := get_py_index_01(n_temp1,n_ord_low);
              WHEN n_temp<21 THEN
                n_temp1 := get_py_index_02(n_temp1,n_ord_low);
              WHEN n_temp<31 THEN
                n_temp1 := get_py_index_03(n_temp1,n_ord_low);
              WHEN n_temp<41 THEN
                n_temp1 := get_py_index_04(n_temp1,n_ord_low);
              WHEN n_temp<51 THEN
                n_temp1 := get_py_index_05(n_temp1,n_ord_low);
              WHEN n_temp<61 THEN
                n_temp1 := get_py_index_06(n_temp1,n_ord_low);
              WHEN n_temp<71 THEN
                n_temp1 := get_py_index_07(n_temp1,n_ord_low);
              WHEN n_temp<81 THEN
                n_temp1 := get_py_index_08(n_temp1,n_ord_low);
              WHEN n_temp<91 THEN
                n_temp1 := get_py_index_09(n_temp1,n_ord_low);
              WHEN n_temp<101 THEN
                n_temp1 := get_py_index_10(n_temp1,n_ord_low);
              WHEN n_temp<111 THEN
                n_temp1 := get_py_index_11(n_temp1,n_ord_low);
              WHEN n_temp<121 THEN
                n_temp1 := get_py_index_12(n_temp1,n_ord_low);
              WHEN n_temp<121 THEN
                n_temp1 := get_py_index_13(n_temp1,n_ord_low);
              ELSE
                n_temp1 := 0;
              END CASE;
              v_PY := v_PY||substr(GetHzPY_by_index(n_temp1),1,1);
            END;
          END CASE;
        END IF;
    END IF;
  END LOOP;
  RETURN v_PY;
  --DBMS_OUTPUT.PUT_LINE(v_PY);
END GetHzPYCAP;*/





END Pkg_CAA_Comm;
/
