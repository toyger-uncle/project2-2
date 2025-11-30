CREATE OR REPLACE Package pkg_b_aac002 Is

  -- Author  : NEUSOFT-HZ
  -- Created : 2008-11-30 12:34:01
  -- Purpose : 处理身份证号码相关业务逻辑

  -- Public type declarations
  --type <TypeName> is <Datatype>;

  -- Public constant declarations
  --<ConstantName> constant <Datatype> := <Value>;
/*  def_ok    Constant Number := pkg_a_macro.def_ok;*/
 /* def_error Constant Number := pkg_a_macro.def_err;*/
   def_OK                    CONSTANT NUMBER      := 1;            -- 成功
 def_error                CONSTANT NUMBER      := -1 ; 

  -- Public variable declarations
  --<VariableName> <Datatype>;

  -- Public function and procedure declarations
  --function <FunctionName>(<Parameter> <Datatype>) return <Datatype>;
  Function func_get_paritybit(prm_aac002_num_17 In Varchar2) Return Varchar2;

  Function func_get_areaname(prm_areacode In Number) Return Varchar2;

  Procedure prc_check_aac002
  (
    prm_aac002        In Varchar,
    prm_aac002_15_out Out Varchar2,
    prm_aac002_18_out Out Varchar2,
    prm_appcode       Out Number,
    prm_errormsg      Out Varchar2
  );

    Procedure prc_check_idcard
  (
    prm_aac002        In Varchar,
       prm_appcode       Out Number,
    prm_errormsg      Out Varchar2
  );



End pkg_b_aac002;
/
CREATE OR REPLACE Package Body pkg_b_aac002 Is

  -- Private type declarations
  --type <TypeName> is <Datatype>;

  -- Private constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Private variable declarations
  --<VariableName> <Datatype>;

  -- Function and procedure implementations
  /*
  function <FunctionName>(<Parameter> <Datatype>) return <Datatype> is
    <LocalVariable> <Datatype>;
  begin
    <Statement>;
    return(<Result>);
  end;
  */

  --计算逻辑校验位
  Function func_get_paritybit(prm_aac002_num_17 In Varchar2) Return Varchar2 Is
    Result Varchar2(18);
    i      Number;
    r      Varchar2(3);
  Begin
    If length(prm_aac002_num_17) = 17
    Then
      i := substr(prm_aac002_num_17, 1, 1) * 7 +
           substr(prm_aac002_num_17, 2, 1) * 9 +
           substr(prm_aac002_num_17, 3, 1) * 10 +
           substr(prm_aac002_num_17, 4, 1) * 5 +
           substr(prm_aac002_num_17, 5, 1) * 8 +
           substr(prm_aac002_num_17, 6, 1) * 4 +
           substr(prm_aac002_num_17, 7, 1) * 2 +
           substr(prm_aac002_num_17, 8, 1) * 1 +
           substr(prm_aac002_num_17, 9, 1) * 6 +
           substr(prm_aac002_num_17, 10, 1) * 3 +
           substr(prm_aac002_num_17, 11, 1) * 7 +
           substr(prm_aac002_num_17, 12, 1) * 9 +
           substr(prm_aac002_num_17, 13, 1) * 10 +
           substr(prm_aac002_num_17, 14, 1) * 5 +
           substr(prm_aac002_num_17, 15, 1) * 8 +
           substr(prm_aac002_num_17, 16, 1) * 4 +
           substr(prm_aac002_num_17, 17, 1) * 2;

      i := Mod(i, 11);

      Select (Case i
               When 0 Then
                '1'
               When 1 Then
                '0'
               When 2 Then
                'X'
               When 3 Then
                '9'
               When 4 Then
                '8'
               When 5 Then
                '7'
               When 6 Then
                '6'
               When 7 Then
                '5'
               When 8 Then
                '4'
               When 9 Then
                '3'
               When 10 Then
                '2'
               Else
                '/'
             End)
        Into r
        From dual;

      Result := r;
      Return(Result);
    End If;
  End func_get_paritybit;

  --获取地区名称
  Function func_get_areaname(prm_areacode In Number) Return Varchar2 Is
    Result Varchar2(100) := Null;
  Begin
    Select decode(prm_areacode,
                  11,
                  '北京',
                  12,
                  '天津',
                  13,
                  '河北',
                  14,
                  '山西',
                  15,
                  '内蒙古',
                  21,
                  '辽宁',
                  22,
                  '吉林',
                  23,
                  '黑龙江',
                  31,
                  '上海',
                  32,
                  '江苏',
                  33,
                  '浙江',
                  34,
                  '安徽',
                  35,
                  '福建',
                  36,
                  '江西',
                  37,
                  '山东',
                  41,
                  '河南',
                  42,
                  '湖北',
                  43,
                  '湖南',
                  44,
                  '广东',
                  45,
                  '广西',
                  46,
                  '海南',
                  50,
                  '重庆',
                  51,
                  '四川',
                  52,
                  '贵州',
                  53,
                  '云南',
                  54,
                  '西藏',
                  61,
                  '陕西',
                  62,
                  '甘肃',
                  63,
                  '青海',
                  64,
                  '宁夏',
                  65,
                  '新疆',
                  71,
                  '台湾',
                  81,
                  '香港',
                  82,
                  '澳门',
                  91,
                  '国外',
                  Null)
      Into Result
      From dual;

    Return Result;
  End func_get_areaname;

  --检验格式合法性
  Procedure prc_check_format
  (
    prm_aac002        In Varchar2,
    prm_aac002_length In Number,
    prm_appcode       Out Number,
    prm_errormsg      Out Varchar2
  ) Is
    ln_num_length    Number; --数字部分长度
    lv_aac002_number Varchar(17);
    ln_aac002_number Number(17);
  Begin
    prm_appcode := def_ok;

    --长度校验
    If prm_aac002_length In (15, 18)
    Then
      If prm_aac002_length = 15
      Then
        ln_num_length := 15;
      Elsif prm_aac002_length = 18
      Then
        ln_num_length := 17;
      End If;

      --数字校验部分
      lv_aac002_number := substr(prm_aac002, 1, ln_num_length);
      Begin
        ln_aac002_number := to_number(lv_aac002_number);
      Exception
        When Others Then
          prm_appcode  := def_error;
          prm_errormsg := '传入[' || prm_aac002_length || ']位身份证号码[' ||
                          prm_aac002 || ']前[' || ln_num_length || ']位的[' ||
                          lv_aac002_number || ']数字校验不通过';
          Goto return_;
      End;
    Else
      prm_appcode  := def_error;
      prm_errormsg := '身份证号码必须为15或18位,传入的身份证号码[' || prm_aac002 || ']为[' ||
                      prm_aac002_length || ']位';
      Goto return_;
    End If;

    <<return_>>
    Return;
  End prc_check_format;

  --检验所属地区
  Procedure prc_check_areacode
  (
    prm_aac002   In Varchar,
    prm_appcode  Out Number,
    prm_errormsg Out Varchar2
  ) Is
    lv_areacode Varchar2(2);
    lv_areaname Varchar2(100);
  Begin
    prm_appcode := def_ok;

    Begin
      lv_areacode := substr(prm_aac002, 1, 2);
      lv_areaname := func_get_areaname(lv_areacode);
    Exception
      When Others Then
        prm_appcode  := def_error;
        prm_errormsg := '查询所属地区信息时出错!';
        Goto return_;
    End;

    If lv_areaname Is Null
    Then
      prm_appcode  := def_error;
      prm_errormsg := '无地区编码[' || lv_areacode || ']对应所属地区';
      Goto return_;
    End If;

    <<return_>>
    Return;
  End prc_check_areacode;

  --检验出生日期
  Procedure prc_check_birthday
  (
    prm_aac002        In Varchar,
    prm_aac002_length In Varchar2,
    prm_appcode       Out Number,
    prm_errormsg      Out Varchar2
  ) Is
    lv_date_format Varchar2(10) := 'yyyy-mm-dd';

    lv_birthdate  Varchar2(10);
    ldt_birthdate Date;

    lv_19000101  Varchar2(10) := '1900-01-01';
    ldt_19000101 Date := to_date(lv_19000101, lv_date_format);

    ldt_today Date := Sysdate;
    lv_today  Varchar2(10) := to_char(ldt_today, lv_date_format);
  Begin
    prm_appcode := def_ok;

    If prm_aac002_length = 15
    Then
      lv_birthdate := '19' || substr(prm_aac002, 7, 2) || '-' ||
                      substr(prm_aac002, 9, 2) || '-' ||
                      substr(prm_aac002, 11, 2);
    Elsif prm_aac002_length = 18
    Then
      lv_birthdate := substr(prm_aac002, 7, 4) || '-' ||
                      substr(prm_aac002, 11, 2) || '-' ||
                      substr(prm_aac002, 13, 2);
    End If;

    Begin
      ldt_birthdate := to_date(lv_birthdate, lv_date_format);
    Exception
      When Others Then
        prm_appcode  := def_error;
        prm_errormsg := '出生日期[' || lv_birthdate || ']不合法';
        Goto return_;
    End;

    If ldt_birthdate <= ldt_19000101
    Then
      prm_appcode  := def_error;
      prm_errormsg := '出生日期[' || lv_birthdate || ']不能早于[' || lv_19000101 || ']';
      Goto return_;
    End If;

    If ldt_birthdate >= ldt_today
    Then
      prm_appcode  := def_error;
      prm_errormsg := '出生日期[' || lv_birthdate || ']不能晚于当前时间[' || lv_today || ']';
      Goto return_;
    End If;

    <<return_>>
    Return;
  End prc_check_birthday;

  --逻辑校验部分
  Procedure prc_check_paritybit
  (
    prm_aac002         In Varchar2,
    prm_aac002_length  In Number,
    prm_aac002_18_temp Out Varchar2,
    prm_appcode        Out Number,
    prm_errormsg       Out Varchar2

  ) Is
    ln_aac002_num_17 Number(17);
    lv_aac002_18     Char(1);
    lv_aac002_chr_18 Char(1);
  Begin
    prm_appcode := def_ok;

    If prm_aac002_length = 15
    Then
      ln_aac002_num_17 := substr(prm_aac002, 1, 6) || '19' ||
                          substr(prm_aac002, 7, 9);
    Elsif prm_aac002_length = 18
    Then
      ln_aac002_num_17 := substr(prm_aac002, 1, 17);
      lv_aac002_18     := substr(prm_aac002, 18, 1);
    End If;
    lv_aac002_chr_18 := func_get_paritybit(ln_aac002_num_17);
    If prm_aac002_length = 18 And
       lv_aac002_chr_18 <> upper(lv_aac002_18)
    Then
      prm_appcode  := def_error;
      prm_errormsg := '传入的18位身份证号码[' || prm_aac002 || ']逻辑校验位[' ||
                      lv_aac002_18 || ']不合法';
      Goto return_;
    End If;

    If prm_appcode = def_ok
    Then
      prm_aac002_18_temp := to_char(ln_aac002_num_17) || lv_aac002_chr_18;
    End If;

    <<return_>>
    Return;
  End prc_check_paritybit;

  Procedure prc_check_aac002
  (
    prm_aac002        In Varchar,
    prm_aac002_15_out Out Varchar2,
    prm_aac002_18_out Out Varchar2,
    prm_appcode       Out Number,
    prm_errormsg      Out Varchar2
  ) Is
    ln_aac002_length  Number(2);
    lv_aac002_18_temp Varchar2(18);
  Begin
    prm_appcode := def_ok;

    ln_aac002_length := length(prm_aac002);

    --检验格式合法性
    prc_check_format(prm_aac002,
                     ln_aac002_length,
                     prm_appcode,
                     prm_errormsg);
    If prm_appcode <> def_ok
    Then
      Goto return_;
    End If;

    --检验所属地区
    prc_check_areacode(prm_aac002, prm_appcode, prm_errormsg);
    If prm_appcode <> def_ok
    Then
      Goto return_;
    End If;

    --检验出生日期
    prc_check_birthday(prm_aac002,
                       ln_aac002_length,
                       prm_appcode,
                       prm_errormsg);
    If prm_appcode <> def_ok
    Then
      Goto return_;
    End If;

    --检验逻辑校验位
    prc_check_paritybit(prm_aac002,
                        ln_aac002_length,
                        lv_aac002_18_temp,
                        prm_appcode,
                        prm_errormsg);
    If prm_appcode <> def_ok
    Then
      Goto return_;
    End If;

    If prm_appcode = def_ok
    Then
      prm_aac002_15_out := substr(lv_aac002_18_temp, 1, 6) ||
                           substr(lv_aac002_18_temp, 9, 9);
      prm_aac002_18_out := lv_aac002_18_temp;
    End If;

    <<return_>>
    Return;
  End prc_check_aac002;


    Procedure prc_check_idcard
  (
    prm_aac002        In Varchar,
       prm_appcode       Out Number,
    prm_errormsg      Out Varchar2
  )Is
  lv_aac002_15_out Varchar2(15);
    lv_aac002_18_out Varchar2(18);
  Begin
     prc_check_aac002(prm_aac002,
                     lv_aac002_15_out,
                     lv_aac002_18_out,
                     prm_appcode,
                     prm_errormsg);
    If prm_appcode <> def_ok
    Then
      Goto return_;
    End If;
    <<return_>>
    Return;
  End prc_check_idcard;


Begin
  -- Initialization
  --<Statement>;
  Null;
End pkg_b_aac002;
/
