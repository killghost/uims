// i:=Trunc(12.34);

unit Define;

interface

uses
  Graphics, windows, classes, Dialogs, Registry, forms, SysUtils;

//function  SendMsgToMML(sMsg:string):boolean;                        //发送MML命令, 判断返回值为E_SUCCESS即表示成功，否则表示失败;

procedure SaveXls(fDB:integer);                         //保存Xls文件
procedure SaveTxt(fDB:integer);                         //保存Txt文件



const
  MainCaption='西安铁通分公司数据业务管理收费系统I/O控制机';
  CrLf=#13+#10;                                         //回车换行（生成业务点时从List中提取业务点时使用）
  Test=false;

  iTest = 0;                                            //0-使用服务器、1-IP系统测试，使用本地IP

  sHour=08;                                             //数据定时扫描（此时iTELLIN和Voice不进行操作）
  MaxErr=5;                                             //最大错误次数-1
  iNub=1;                                               //IOCtrl每次进入：0点-8点30分钟一次处理50条记录，其他时间10秒钟1次只处理5条记录
  IOBnb = 11;
  IOBHBnb = 11;

  DSNb = 20;                                            //地市管理的数量，地市数量不能超过DSNb

  //iTELLIN接口操作查询选择项
  IODBField = 'Zh,Yhmc,Dhhm,'+                         //使用标志（0-未使用、1-帐号开户、2-帐号开机、3-帐号停用、4-修改密码）
              'case when IObz=1 then ''帐号开户''  '+
              '     when IObz=2 then ''帐号开机''  '+
              '     when IObz=3 then ''帐号停用''  '+
              '     else ''未使用''  '+
              'end as IObz,'+
              'Czlb,Tjsj,Wcsj,GS02,Fj,Zj,Yys,Bz';

  IOField:array[0..4,0..IOBnb] of string = (('Zh','Yhmc','Dhhm','IObz','Czlb',
                                             'Tjsj','Wcsj,','GS02','Fj','Zj',
                                             'Yys','Bz'),
  //使用状态（0-未提交、1-已提交、2-操作错误：由接口机写入，同时置错误标志，增加错误计数）
  //使用标志（0-未使用、1-帐号开通、2-帐号停用、3-修改密码）
                                             ('用户帐号','用户名称','安装电话','使用标志','操作类别',
                                              '提交时间','完成时间','市级公司','所属分局','所属支局',
                                              '所属营业所','备注'),
                                             ('1','1','1','1','1','1','1','1','1','1',
                                              '1','1'),
                                             ('58','68','62','62','62','62','62','68','68',
                                              '68','68','128'),
                                             ('1','1','1','1','1','1','3','3','1','1',
                                              '1','1'));



//系统标题、BDE设置参数 （使用MadeCord生成ADSL.mdb）
  x0 = '^宊:[T`塈hK=]PQF奬廝odG`僫mLaKnRaG_E';        //铁通陕西分公司宽带数据业务综合管理系统
  x1 = '嘲冒卑麓徑凹船杏廑';                            //'DATABASE NAME=adsl'
  x3 = '亩们睹懣簿懂ⅰ煥￥�';                       //'SERVER NAME=10.72.00.236'
  x2 = '缚媚惥苯淡饶潬牋';                            //'HOST NAME=XT-0004'
  x4 = '桥纺捓晨矾逵';                                  //'USER NAME=sa'

//2005-3-28 修改sa密码xtbai159->xtbai2126
//x5 = '么破事欧半缯攒え�';                             //'PASSWORD=xtbai159'，注意：因为有半个汉字，所以显示不规范
  x5 = '么破事欧半缯攒イォ';                            //'PASSWORD=xtbai2126'
  x6 = '独枚斍轿贡Еい';                                //'BLOB SIZE=6400'


var
  SPath:string;                                         //系统目录
  WorkOK:boolean;                                       //运行该终端登录标志（IP地址是否在终端列表中）
  ShowOK:boolean;                                       //员工登陆标志，与各窗体的FirstOK标志一起判断是否需要在激活窗体时初始化数据（）

  i:integer;
  s,ss:string;
  NB,LinkFun:integer;
  LinkNB:integer;                                       //MML命令计数器

  BeiLv:integer;                                        //IOCtrl()每次进入处理记录倍率器

  IP:array [0..15] of char;                             //保存iTELLIN服务器IP地址
  HComm:pointer;                                        //接口句柄（不能定义成THANDLE类型）
  pIP,pHComm:Pointer;                                   //IP指针、句柄指针
  Port:word;
  bAuto:boolean;
  dwTime:Longword;                                      //超时时间
  RT:pointer;
  bLogin:boolean;

  dlgCtrl:byte;
  cmd:string;
  service:string;


  OpId:string;                                          //操作员工号
  OpPass:string;                                        //操作员密码
  OpDj:string;                                          //操作员等级
  OpIn:boolean;                                         //操作员登录标志
  OpQx:string[50];                                      //操作员权限
  GSFun:integer;

	sXh:integer;                                          //序号，0=本地，然后从1开始各地列表
	sName:string;                                         //名称
	sArea:string;                                         //区域
	sHostIp:string;                                       //主机IP
	sHostName:string;                                     //主机名称
	sAlias:string;                                        //数据库别名
	sLink:integer;                                        //连接号
	slocalIp:string;                                      //本机IP
	slocalName:string;                                    //本机名称

  //仅作为写IO数据时的中间变量
  DSBh:    array[0..1,0..DSNb] of string;               //地市编号（地市区号、地市名称），地市管理的数量不能超过DSNb
  sDSBh:string;                                         //累计地市名称字符串
  sGs:string;                                           //所属市分公司（使用员工资料的地域）
  sDs:string;                                           //市分公司临时变量
  iDs:integer;                                          //市分公司临时变量

	sFj:string;                                           //分局
	sZj:string;                                           //支局
  sJd:string;	   	                                      //局点
  sYwd:string;   	                                      //业务点
	sYys:string;                                          //营业所
  sZdh:string;                                          //终端号

  GS01:integer;                                         //归属分类：省级分公司
  GS02:integer;                                         //归属分类：市级分公司
  GS03:integer;                                         //归属分类：市分分局、未用
  GS04:integer;                                         //归属分类：未用
  GS05:integer;                                         //归属分类：未用

  iTime:real;
  iYear:Word;                            //当前年
  iMon :Word;                            //当前月
  iDay :Word;                            //当前日
  iHour:Word;                            //当前时
  iMin :Word;                            //当前分
  iSec :Word;                            //当前秒
  iMSec:Word;                            //当前微秒
  lYear:Word;                            //保留年
  lMon :Word;                            //保留月
  lDay :Word;                            //保留日
  lHour:Word;                            //保留时
  lMin :Word;                            //保留分
  lSec :Word;                            //保留秒

implementation

//function StartComm(pRemoteAddr:Pointer; port:word; dwHandle:Pointer): WORD; external 'SMIDLL.DLL' name 'StartComm';


//生成Excel文件
procedure SaveXls(fDB:integer);                         //保存Xls文件
var
  lNB:integer;
  sNB:array[0..4,0..99] of String;
  i,j: Integer;
  Str: String;
  StrList: TStringList;                                 //用于存储数据的字符列表
begin
end;

//生成Txt文件
procedure SaveTxt(fDB:integer);                         //保存Txt文件
var
  lNB:integer;
  sNB:array[0..4,0..99] of String;
  i,j: Integer;
  Str: String;
  txtfile:Textfile;
begin
end;

end.







