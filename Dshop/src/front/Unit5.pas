unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, ExtCtrls, INIFiles,
  RzForms;

type
  TGathering = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RzEdit1: TRzEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RzFormShape1: TRzFormShape;
    CheckBox1: TCheckBox;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzEdit1KeyDown(Sender: TObject; var Key:
      Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure JZ;
    { Public declarations }
  end;

var
  Gathering: TGathering;
  Count: Integer;
implementation

uses Unit2, Unit6, Unit8;

{$R *.dfm}

procedure TGathering.FormCreate(Sender: TObject);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))
    +
    'Config.Ini');
  Label2.Caption := Main.Label7.Caption;
  CheckBox1.Checked := vIniFile.ReadBool('System', 'PB',
    True);

  {根据支付方式填写周到金额}
  if Main.cbb1.Text <> '现金' then
  begin
    RzEdit1.Text := Label2.Caption;
  end;
end;

procedure TGathering.FormKeyDown(Sender: TObject; var Key:
  Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: Gathering.Close;
    VK_F1:
      begin
        if CheckBox1.Checked then
        begin
          CheckBox1.Checked := False;
          RzEdit1.SetFocus;
        end
        else
        begin
          CheckBox1.Checked := True;
          RzEdit1.SetFocus;
        end;
      end;
    VK_F2:
      begin
        if MoLing <> nil then
        begin
          MoLing.RzEdit1.Text := Label2.Caption;
          MoLing.RzEdit1.SelectAll;
          MoLing.ShowModal;
        end
        else
        begin
          MoLing := TMoLing.Create(Application);
          MoLing.RzEdit1.Text := Label2.Caption;
          MoLing.RzEdit1.SelectAll;
          MoLing.ShowModal;
        end;
      end;
    {
    VK_F3:
      begin
        RzEdit1.Text := Label2.Caption;
        if Card <> nil then
          Card.ShowModal
        else
        begin
          Card := TCard.Create(Application);
          Card.ShowModal;
        end;
      end;
      }
    VK_RETURN: //回车确认等于结帐
      begin
        count := count + key;

        Main.ADOQuery2.SQL.Clear;
        Main.ADOQuery2.SQL.Add('select * from selllogmains where slid="' +
          Main.Label26.Caption
          + '"');
        Main.ADOQuery2.Open;
        if (Main.ADOQuery2.RecordCount = 1) and
          (Main.ADOQuery2.FieldByName('pdate').AsString <> '') then
        begin
          JZ;
          Exit;
        end;

        if RzEdit1.ReadOnly and (Main.cbb1.Text = '现金') then
          Gathering.Close;
        if not (RzEdit1.ReadOnly) or (Main.cbb1.Text <> '现金')
          then
          JZ;
      end;
  end;
end;

{结账操作}

procedure TGathering.jz;
var
  vIniFile: TIniFile;
  vaamount: string;
  vavolume: string;
begin

  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))
    +
    'Config.Ini');
  {
  //输入数据检查
  try
    begin
      StrToCurr(RzEdit1.Text); //收到的金额
    end;
  except
    begin
      ShowMessage('输入非法字符~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;
  end;
  }

  if Main.cbb1.Text = '' then
  begin
    ShowMessage('请选择支付方式~~!');
    Gathering.Close;
    Main.RzEdit4.SetFocus;
    Exit;
  end
  else if (Main.cbb1.Text <> '现金') and (Main.cbb1.Text <> '转账') and
    (Main.cbb1.Text <> '托运部代收') and (Main.cbb1.Text <> '记账') then
  begin
    ShowMessage('支付方式无效，请选择正确的支付方式~~!');
    Gathering.Close;
    Main.RzEdit4.SetFocus;
    Exit;
  end;

  {
  //如果使用现金支付，检查输入金额是否小于应付款
  if Main.cbb1.Text = '现金' then
  begin
    if StrToCurr(RzEdit1.Text) - StrToCurr(Label2.Caption)
      < 0 then
    begin
      ShowMessage('现金支付时，收到金额不能小于应收款~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;

    //计算找零
    Label7.Caption := FormatFloat('0.00',
      StrToCurr(RzEdit1.Text) -
      StrToCurr(Label2.Caption));
  end;
  }

  //结束输入
  RzEdit1.ReadOnly := True;
  //显示提示语
  Label9.Visible := True;

  //写主窗口记录
  Main.Label14.Caption := FormatFloat('0.00',
    StrToCurr(Label2.Caption));
  {
Main.Label15.Caption := FormatFloat('0.00',
  StrToCurr(RzEdit1.Text));
Main.Label16.Caption := FormatFloat('0.00',
  StrToCurr(Label7.Caption));
  }

//打印小票
  if CheckBox1.Checked then
  begin
    if messagedlg('确认打印物流单吗？', mtconfirmation, [mbyes,
      mbno], 0) = mryes then
    begin
      {
      Main.QuickRep1.Height := 200 + Main.DetailBand1.Height * Main.ADOQuery1.RecordCount;
      Main.QuickRep1.Page.LeftMargin := vIniFile.ReadInteger('System', 'P0', 0);
      }

      Main.QuickRepExpress.Print;
      //Main.QuickRep1.Preview;
    end;

    if messagedlg('确认打印发货清单吗？', mtconfirmation, [mbyes,
      mbno], 0) = mryes then
    begin
      {
      Main.QuickRep1.Height := 200 + Main.DetailBand1.Height * Main.ADOQuery1.RecordCount;
      Main.QuickRep1.Page.LeftMargin := vIniFile.ReadInteger('System', 'P0', 0);
      }

      try
        Main.QuickRep1.Prepare;
        Main.FTotalPages := Main.QuickRep1.QRPrinter.PageCount;
      finally
        Main.QuickRep1.QRPrinter.Cleanup;
      end;

      Main.QuickRep1.Print;
      //Main.QuickRep1.Preview;
    end;
  end;

  //保存是否打印小票信息
  if CheckBox1.Checked then
  begin
    vIniFile.WriteBool('System', 'PB', True);
  end
  else
  begin
    vIniFile.WriteBool('System', 'PB', False);
  end;

  //补打凭证时不修改销售数据

  Main.ADOQuery2.SQL.Clear;
  Main.ADOQuery2.SQL.Add('select * from selllogmains where slid="' +
    Main.Label26.Caption
    + '"');
  Main.ADOQuery2.Open;
  if (Main.ADOQuery2.RecordCount = 1) and
    (Main.ADOQuery2.FieldByName('pdate').AsString <> '') then
  begin
    //处理单据补打

    Main.Labeluid.Caption := Main.uid;
    Main.Label19.Caption := Main.uname;

    Main.edt1.Enabled := True;
    Main.edt2.Enabled := True;
    Main.edt3.Enabled := True;
    Main.edt7.Enabled := True;
    Main.edt8.Enabled := True;
    Main.RzEdit7.Enabled := True;

    Main.edt4.Enabled := True;
    Main.edt5.Enabled := True;
    Main.edt6.Enabled := True;

    Main.cbb1.Enabled := True;
    Main.mmo1.Enabled := True;

    Main.RzEdit1.Enabled := True;
    Main.RzEdit2.Enabled := True;
    Main.RzEdit3.Enabled := True;
    Main.RzEdit5.Enabled := True;

    Main.rzchckbx1.Enabled := True;

  end
  else //交易数据处理
  begin

    Main.ADOConnection1.BeginTrans;
    try

      //记录新客户信息
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('insert into customers(cid,loginname,cname,shopname,sex,address,tel,state,cdate,remark,created_at,updated_at) values("","","' + Main.edt1.Text + '","' + Main.RzEdit7.Text + '","","' +
        Main.edt3.Text + '","'
        + Main.edt2.Text + '","' + Main.edt8.Text +
        '",now(),"",now(),now()) on duplicate key update cname="' +
        Main.edt1.Text + '",shopname="' + Main.RzEdit7.Text +
        '",address="' + Main.edt3.Text + '",state="' +
        Main.edt8.Text + '",updated_at=now()');
      Main.ADOQuerySQL.ExecSQL;

      //记录新托运部信息
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('insert into shippers(sid,sname,tel,address,custid,custname,custtel,cdate,remark,created_at,updated_at) values("","' + Main.edt4.Text + '","' + Main.edt5.Text + '","' +
        Main.edt6.Text + '","","' +
        Main.edt1.Text + '","' + Main.edt2.Text +
        '",now(),"",now(),now()) on duplicate key update sname="' +
        Main.edt4.Text + '",tel="' + Main.edt5.Text +
        '",address="' + Main.edt6.Text + '",custname="' +
        Main.edt1.Text + '",custtel="' + Main.edt2.Text +
        '",cdate=now(),updated_at=now()');
      Main.ADOQuerySQL.ExecSQL;

      //写销售记录，分别更新各自库存
      Main.ADOQuery1.First;
      while not (Main.ADOQuery1.Eof) do
      begin
        if Main.ADOQuery1.FieldByName('additional').AsString
          =
          '-' then
        begin
          Main.ADOQuerySQL.SQL.Clear;
          Main.ADOQuerySQL.SQL.Add('update stocks set amount=amount-' +
            Main.ADOQuery1.FieldByName('amount').AsString +
            ', updated_at=now() where pid="' +
            Main.ADOQuery1.FieldByName('pid').AsString +
            '"');
          Main.ADOQuerySQL.ExecSQL;
        end
        else if
          Main.ADOQuery1.FieldByName('additional').AsString =
          '赠品' then
        begin

        end
        else if
          Main.ADOQuery1.FieldByName('additional').AsString =
          '补件' then
        begin

        end
        else if
          Main.ADOQuery1.FieldByName('additional').AsString =
          '' then //合计行
        begin
          vaamount := Main.ADOQuery1.FieldByName('amount').AsString;
          vavolume := Main.ADOQuery1.FieldByName('volume').AsString;
        end;
        Main.ADOQuery1.Next;
      end;

      //更新销售主表，包括修改的客户，托运部信息，合计的订单产品数量，体积，金额信息
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('insert into selllogmains(slid,custid,custstate,custname,shopname,custtel,custaddr,yingshou,shishou,shoukuan,zhaoling,aamount,avolume,sid,sname,stel,saddress,payment,status,dtype,uid,uname,cdate,pdate,remark,created_at,updated_at) values("' + Main.Label26.Caption + '","","' + Main.edt8.Text + '","' +
        Main.edt1.Text + '","' +
        Main.RzEdit7.Text + '","' + Main.edt2.Text + '","' +
        Main.edt3.Text + '","' +
        Main.Label7.Caption + '","' + Label2.Caption
        +
        '","' + RzEdit1.Text + '","' + Label7.Caption + '","' + vaamount + '","'
        + vavolume + '","' + Main.Labelsid.Caption +
        '","' +
        Main.edt4.Text + '","' + Main.edt5.Text + '","' + Main.edt6.Text
        + '","' + Main.cbb1.Text +
        '","1","已出库","' + Main.Labeluid.Caption + '","' + Main.Label19.Caption
        + '",now(),now(),"' +
        Main.mmo1.Lines.GetText +
        '",now(),now()) on duplicate key update custstate="' +
        Main.edt8.Text +
        '",custname="' + Main.edt1.Text + '",shopname="' +
        Main.RzEdit7.Text +
        '",custtel="' + Main.edt2.Text + '",custaddr="' +
        Main.edt3.Text + '",sid="' +
        Main.Labelsid.Caption + '",sname="' +
        Main.edt4.Text + '",stel="' + Main.edt5.Text +
        '",saddress="' + Main.edt6.Text +
        '",payment="' + Main.cbb1.Text + '",uid="' +
        Main.Labeluid.Caption + '",uname="' +
        Main.Label19.Caption + '",remark="'
        + Main.mmo1.Lines.GetText + '", yingshou="' +
        Main.Label7.Caption + '", shishou="' + Label2.Caption
        +
        '",shoukuan="' + RzEdit1.Text + '",zhaoling="' + Label7.Caption +
        '",aamount="' + vaamount + '",avolume="' + vavolume +
        '", status="1", dtype="已出库",pdate=now(),updated_at=now()');
      Main.ADOQuerySQL.ExecSQL;

      {
      //更改销售标记
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update selllogmains set yingshou="' +
        Main.Label7.Caption + '", shishou="' + Label2.Caption
        +
        '", status="1", type="已出库", remark="' +
        Main.mmo1.Lines.GetText +
        '", updated_at=now() where slid="' +
        Main.Label26.Caption + '"');
      Main.ADOQuerySQL.ExecSQL;
      }

      //根据支付方式记帐

      if Main.cbb1.Text = '现金' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","'
          + Label2.Caption + '","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end
      else if Main.cbb1.Text = '转账' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","'
          + Label2.Caption + '","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end
      else if Main.cbb1.Text = '托运部代收' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","'
          + Label2.Caption + '","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end
      else if Main.cbb1.Text = '记账' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,proof,ticketid,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
          Main.Label7.Caption + '","0","' +
          CurrToStr(StrToCurr(Main.Label7.Caption) -
          StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
          '","","' + Main.Label26.Caption + '",now(),"' +
          Main.mmo1.Lines.GetText + '",now(),now())');
        Main.ADOQuerySQL.ExecSQL;
      end;

      //修改成交数据
      //补件不计入本次销售，也不计算盈亏
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update selllogmains sm,selllogdetails sd set sd.camount=sd.amount,sd.cbundle=sd.bundle,sd.updated_at=now() where sm.slid="' + Main.Label26.Caption +
        '" and sd.slid=sm.slid and sd.additional<>"补件"');
      Main.ADOQuerySQL.ExecSQL;

      //如果是在线渠道过来的订单 source /preid
      //跟新实际发货数量，一边日后到货提醒
      //前提是控制好实际发货数量不能超过订单数量
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update selllogmains a,ordermains b,orderdetails c,selllogdetails d set c.ramount=d.amount,c.rbundle=d.bundle,c.additional=d.additional,c.updated_at=now() where a.slid="' + Main.Label26.Caption +
        '" and a.preid=b.oid and b.oid=c.oid and d.slid=a.slid and d.pid=c.pid');
      Main.ADOQuerySQL.ExecSQL;

      //更新订单状态
      Main.ADOQuerySQL.SQL.Clear;
      Main.ADOQuerySQL.SQL.Add('update ordermains set dtype="已发货",status="1", updated_at=now() where nextid="' + Main.Label26.Caption + '"');
      Main.ADOQuerySQL.ExecSQL;

      //维修库存状态更新
      Main.ADOConnection1.CommitTrans;

    except
      Main.ADOConnection1.RollbackTrans;
    end;

  end;

  //查找最小单号
  Main.GetOrderId;

  //重新计算主窗口商品价格
  Main.QH2;

  {清空数据项}
  Main.edt1.Text := '';
  Main.edt2.Text := '';
  Main.edt3.Text := '';
  Main.edt7.Text := '';
  Main.edt8.Text := '';
  Main.RzEdit7.Text := '';

  Main.edt4.Text := '';
  Main.edt5.Text := '';
  Main.edt6.Text := '';

  Main.cbb1.Text := '';
  Main.mmo1.Text := '';

  //刷新销售列表
  Main.ListRefresh;
  //关闭结算窗口
  Gathering.Close;
end;

procedure TGathering.RzEdit1KeyDown(Sender: TObject; var
  Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    count := count + key;

    Main.ADOQuery2.SQL.Clear;
    Main.ADOQuery2.SQL.Add('select * from selllogmains where slid="' +
      Main.Label26.Caption
      + '"');
    Main.ADOQuery2.Open;
    if (Main.ADOQuery2.RecordCount = 1) and
      (Main.ADOQuery2.FieldByName('pdate').AsString <> '') then
    begin
      JZ;
      Exit;
    end;

    if RzEdit1.ReadOnly and (Main.cbb1.Text = '现金') then
      Gathering.Close;
    if not (RzEdit1.ReadOnly) or (Main.cbb1.Text <> '现金')
      then
      JZ;
  end;
end;

procedure TGathering.FormActivate(Sender: TObject);
begin
  if Main.cbb1.Text <> '现金' then
  begin
    RzEdit1.ReadOnly := True;
  end;

  Main.ADOQuery2.SQL.Clear;
  Main.ADOQuery2.SQL.Add('select * from selllogmains where slid="' +
    Main.Label26.Caption
    + '"');
  Main.ADOQuery2.Open;
  if (Main.ADOQuery2.RecordCount = 1) and
    (Main.ADOQuery2.FieldByName('pdate').AsString <> '') then
  begin
    Label2.Caption := Main.ADOQuery2.FieldByName('yingshou').AsString;
    RzEdit1.Text := Main.ADOQuery2.FieldByName('shoukuan').AsString;

    RzEdit1.Enabled := True;
  end;
end;

end.
