unit psReportBuilder;

interface

{$I psBarcode.inc}
{$R *.res}

{ TODO : v Barcode studio 2010.3 dorobit lepsie popup menu, samostatne editory pre caption, options, quiet zone ..., PDF417, ... }

uses Windows, Classes,  Forms, SysUtils, Controls, Graphics, Menus,
     psCodeSpecs, psTypes, psCodeFN, psBarcodeComp,

     psBarcodeFmt,
     psBoxes,
     psCodeExceptions,

     Dialogs,
     ppCtrls,
     ppDevice,
     ppClass,
     ppUtils,
     ppDB,
     ppPopupMenus,
     ppDrwCmd,
     ppTypes,
     ppRTTI,
     ppEnum,
     ppDesignControls,
     ppDesignControlsEx,
     ppInspector,
     ppTBX;

type

     TpsRBBarcode = class(TppCustomComponent, IpsBarcodeInterface)
     private
         FBarcodeObject : TpsBarcodeComponent;

         procedure DoChange(Sender:TObject);

         function  GetOptions:TpsBarcodeOptions;
         procedure SetOptions(const Value:TpsBarcodeOptions);
        
         function  GetAngle: Integer;
         procedure SetAngle(const Value:Integer);
    
         function  GetBarcode:String;
         procedure SetBarcode(const Value:String);
    
         function  GetBarcodeSymbology:TpsBarcodeSymbology;
         procedure SetBarcodeSymbology(const value :TpsBarcodeSymbology);
    
         function  GetLinesColor:TColor;
         procedure SetLinesColor(const Value:TColor);
    
         function  GetQuietZone:TpsQuietZone;
         procedure SetQuietZone(const Value:TpsQuietZone);
    
         function  GetHorzLines:TpsHorzLines;
         procedure SetHorzLines(const Value:TpsHorzLines);
    
         function  GetParams:TpsParams;
         procedure SetParams(const Value:TpsParams);
    
         function  GetCaptionUpper:TpsBarcodeCaption;
         procedure SetCaptionUpper(const Value:TpsBarcodeCaption);
    
         function  GetCaptionBottom:TpsBarcodeCaption;
         procedure SetCaptionBottom(const Value:TpsBarcodeCaption);

         function  GetCaptionHuman:TpsBarcodeCaption;
         procedure SetCaptionHuman(const Value:TpsBarcodeCaption);

         function  GetBackgroundColor: TColor;
         procedure SetBackgroundColor(const Value:TColor);

         function  GetErrorInfo:TpsBarcodeError;
         procedure SetErrorInfo(Value : TpsBarcodeError);


     protected
         procedure    PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

         function     GetDefaultPropHint: String; override;
         procedure    ChangeBarcode;

         procedure    SettingsMenuClick(Sender: TObject);
     public
         constructor  Create(AOwner:TComponent); override;
         function     HasFont:Boolean;  override;
         procedure    GetDefaultPropEnumNames(aList: TStrings); override;
         function     BarcodeComponent : TpsBarcodeComponent;


         procedure    Edit;
         procedure    Copyright;

         procedure    UpdateDesignBarcode;
         function     GetAbout:String;
     published

      {inherited from TmyPrintable}
          property Anchors;
          property Height;
          property Left;
          property ReprintOnOverFlow;
          property Top;
          property Visible;
          property Width;

          {events - inherited from TmyPrintable}
          property OnDrawCommandClick;
          property OnDrawCommandCreate;
          property OnPrint;

          property BarcodeSymbology:TpsBarcodeSymbology read GetBarcodeSymbology write SetBarcodeSymbology;
          property Barcode:String read GetBarcode write SetBarcode;
          property CaptionUpper:TpsBarcodeCaption read GetCaptionUpper write SetCaptionUpper;
          property CaptionHuman:TpsBarcodeCaption read GetCaptionHuman write SetCaptionHuman;
          property CaptionBottom:TpsBarcodeCaption read GetCaptionBottom write SetCaptionBottom;
          property Params:TpsParams read GetParams write SetParams;
          property HorzLines:TpsHorzLines read GetHorzLines write SetHorzLines;
          property QuietZone:TpsQuietZone read GetQuietZone write SetQuietZone;
          property LinesColor:TColor read GetLinesColor write SetLinesColor;
          property Options:TpsBarcodeOptions read GetOptions write SetOptions;
          property BackgroundColor:TColor read GetBackgroundColor write SetBackgroundColor;
          property Angle:Integer read GetAngle write SetAngle;
          property ErrorInfo:TpsBarcodeError read GetErrorInfo write SetErrorInfo;
     end;

  TraTpsRBBarcodeRTTI = class(TraTppComponentRTTI)
    public
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end;


  TpsRBBarcodeControl=class(TppCustomComponentControl)
  protected
        function  ParentBarcode : TpsBarcodeComponent;
        procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;

  TpsRBBarcodePopupMenu=class(TppComponentPopupMenu)
  private
        procedure AboutMenuClick(Sender:TObject);
        procedure SettingsMenuClick(Sender:TObject);
  protected
        function  ParentBarcode : TpsBarcodeComponent; virtual;
        procedure CreateMenuItems;override;
  end;

  TpsRbDBBarcode = class(TpsRBBarcode)
    private
    protected
            procedure DataChange(Sender: TObject);
    public
            function  IsDataAware:Boolean; override;
    published
            property DataField;
            property DataPipeLine;
  end;

{  TRbDBBarcodePopupMenu=class(TpsRBBarcodePopupMenu)
  private
        procedure SettingsMenuClick(Sender:TObject);
  public
        function  ParentBarcode : TpsBarcodeComponent; virtual;
        procedure CreateMenuItems;override;
  end;
}

procedure Register;

procedure PSOFT_ReportBuilderInitialization;
procedure PSOFT_ReportBuilderFinalization;

implementation

const psReportBuilderComponentName = 'BarcodeComponent';

constructor TpsRBBarcode.Create(AOwner:TComponent);
// var i:Integer;
//    llWidth, llHeight : LongInt;
begin
     inherited Create(AOwner);
     FBarcodeObject         := TpsBarcodeComponent.Create(self);
     FBarcodeObject.Options := FBarcodeObject.Options-[boSecurity]+[boPaintIfSmall];

     // properties needed by Report Builder
     DrawCommandClass    := TppDrawImage;
     DefaultPropName     := 'BarCode';
     // DefaultPropEditType := etValueList;

     spWidth  := FBarcodeObject.MinWidth;
     spHeight := FBarcodeObject.MinHeight;
end;

procedure    TpsRBBarcode.DoChange(Sender:TObject);
begin
  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

  {repaint control}
  InvalidateDesignControl;
end;

function  TpsRBBarcode.GetOptions:TpsBarcodeOptions;
begin
  Result:=FBarcodeObject.Options;
end;

procedure TpsRBBarcode.SetOptions(const Value:TpsBarcodeOptions);
begin
  if Value<>Options then begin
    FBarcodeObject.Options := Value;
    DoChange(FBarcodeObject);
  end;
end;

function  TpsRBBarcode.GetBackgroundColor: TColor;
begin
  Result:=FBarcodeObject.BackGroundColor;
end;

procedure TpsRBBarcode.SetBackgroundColor(const Value:TColor);
begin
  if Value<>BackgroundColor then begin
    FBarcodeObject.BackgroundColor := Value;
    DoChange(FBarcodeObject);
  end;
end;


function TpsRBBarcode.GetAbout: String;
begin
    Result := BarcodeComponent.About;
end;

function  TpsRBBarcode.GetAngle: Integer;
begin
  Result:=FBarcodeObject.Angle;
end;


procedure TpsRBBarcode.SetAngle(const Value:Integer);
begin
  if Value<>Angle then begin
    FBarcodeObject.Angle:= Value;
    DoChange(FBarcodeObject);
  end;
end;

function  TpsRBBarcode.GetBarcode:String;
begin
  Result:=FBarcodeObject.Barcode;
end;

procedure TpsRBBarcode.SetBarcode(const Value:String);
begin
  if Value<>Barcode then begin
    FBarcodeObject.Barcode:= Value;
    DoChange(FBarcodeObject);
  end;
end;

function  TpsRBBarcode.GetBarcodeSymbology:TpsBarcodeSymbology;
begin
  Result:=FBarcodeObject.BarcodeSymbology;
end;

procedure TpsRBBarcode.SetBarcodeSymbology(const value :TpsBarcodeSymbology);
begin
  if Value<>BarcodeSymbology then begin
    FBarcodeObject.BarcodeSymbology:= Value;
    DoChange(FBarcodeObject);
  end;
end;

function  TpsRBBarcode.GetLinesColor:TColor;
begin
  Result:=FBarcodeObject.LinesColor;
end;

procedure TpsRBBarcode.SetLinesColor(const Value:TColor);
begin
  if Value<>LinesColor then begin
    FBarcodeObject.LinesColor:= Value;
    DoChange(FBarcodeObject);
  end;
end;

function  TpsRBBarcode.GetQuietZone:TpsQuietZone;
begin
  Result:=FBarcodeObject.QuietZone;
end;

procedure TpsRBBarcode.SetQuietZone(const Value:TpsQuietZone);
begin
  FBarcodeObject.QuietZone.Assign(Value);
  DoChange(FBarcodeObject);
end;

function  TpsRBBarcode.GetHorzLines:TpsHorzLines;
begin
  Result:=FBarcodeObject.HorzLines;
end;


procedure TpsRBBarcode.SetHorzLines(const Value:TpsHorzLines);
begin
  FBarcodeObject.HorzLines.Assign(Value);
  DoChange(FBarcodeObject);
end;

function  TpsRBBarcode.GetParams:TpsParams;
begin
  Result:=FBarcodeObject.Params;
end;

procedure TpsRBBarcode.SetParams(const Value:TpsParams);
begin
  FBarcodeObject.Params.Assign(Value);
  DoChange(FBarcodeObject);
end;

function  TpsRBBarcode.GetCaptionUpper:TpsBarcodeCaption;
begin
  Result:=FBarcodeObject.CaptionUpper;
end;

procedure TpsRBBarcode.SetCaptionUpper(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionUpper.Assign(Value);
end;

procedure TpsRBBarcode.SetErrorInfo(Value: TpsBarcodeError);
begin
    FBarcodeObject.ErrorInfo.Assign(Value);
end;

function  TpsRBBarcode.GetCaptionHuman:TpsBarcodeCaption;
begin
  Result:=FBarcodeObject.CaptionHuman;
end;

procedure TpsRBBarcode.SetCaptionHuman(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionHuman.Assign(Value);
end;

function  TpsRBBarcode.GetCaptionBottom:TpsBarcodeCaption;
begin
  Result:=FBarcodeObject.CaptionBottom;
end;

procedure TpsRBBarcode.SetCaptionBottom(const Value:TpsBarcodeCaption);
begin
  FBarcodeObject.CaptionBottom.Assign(Value);
end;


function TpsRBBarcode.GetDefaultPropHint: String;
begin
  Result := 'Bar code types';
end;

function TpsRBBarcode.GetErrorInfo: TpsBarcodeError;
begin
    Result := FBarcodeObject.ErrorInfo;
end;

{------------------------------------------------------------------------------}
procedure TpsRBBarcode.GetDefaultPropEnumNames(aList: TStrings);
begin
  aList.Clear;
//  FBarcodeObject.AddTypesToList(aList, btSymbol);
end;



function TpsRBBarcode.BarcodeComponent: TpsBarcodeComponent;
begin
    Result := FBarcodeObject;
end;

procedure TpsRBBarcode.ChangeBarcode;
begin
  {notify report designer}
  PropertyChange;
  {notify report engine}
  Reset;
  {redraw design control}
  InvalidateDesignControl;
end;

procedure TpsRBBarcode.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var lDrawImage : TppDrawImage;
    WMF          : TMetaFile;
    WMF_CANVAS   : TMetaFileCanvas;
    R          : TRect;
//    dpix, dpiy : Integer;
begin
  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawImage) then Exit;

{  if Assigned(FOnBeforePrint) then
     FOnBeforePrint(Self);
}
  lDrawImage := TppDrawImage(aDrawCommand);

  WMF := TMetafile.Create;
  try
    WMF_CANVAS := TMetafileCanvas.Create(WMF, 0);
    try
         lDrawImage.Left         := PrintPosRect.Left;
         lDrawImage.Top          := PrintPosRect.Top;
         lDrawImage.Height       := (PrintPosRect.Bottom - PrintPosRect.Top);
         lDrawImage.Width        := (PrintPosRect.Right - PrintPosRect.Left);
         lDrawImage.DirectDraw   := False;
         lDrawImage.Stretch      := False;

         R.Left   := 0;
         R.Top    := 0;
         R.Right  := spWidth;
         R.Bottom := spHeight;
//         R.Right  := 1000;
//         R.Bottom := 1000;

         if IsDataAware and Assigned(DataPipeline) then
               FBarcodeObject.Barcode := DataPipeline.GetFieldAsString(DataField);

         PaintBarCode(WMF_CANVAS, R, FBarcodeObject);
    finally
         WMF_CANVAS.Free;
    end;

//    lDrawImage.Stretch  := True;
//    lDrawImage.DataType := dtGraphic;
    lDrawImage.Picture.Graphic := WMF;
  finally
    WMF.Free;
  end;
{  if Assigned(FOnAfterPrint) then
     FOnAfterPrint(Self);
}

end;


procedure TpsRBBarcode.SettingsMenuClick(Sender: TObject);
begin
  {$ifdef PSOFT_PROF}
     // ActiveSetupWindow(FEan, [epMain], True);
  {$else}
     // NeedProfessionalVersion;
  {$endif}
end;

procedure TpsRBBarcode.UpdateDesignBarcode;
begin
  {notify report designer}
  PropertyChange;
  {notify report engine}
  Reset;
  {redraw design control}
  InvalidateDesignControl;
end;

function  TpsRbDBBarcode.IsDataAware:Boolean;
begin
    Result := True;
end;

procedure TpsRbDBBarcode.DataChange(Sender: TObject);
begin
    BarCode:= DataPipeline.GetFieldAsString(DataField);
    ChangeBarcode;
end;

{  function  TRbDBBarcodePopupMenu.ParentBarcode : TpsBarcodeComponent;
  begin
    GetPropValue('BarcodeObject',Result);
  end;

  procedure TRbDBBarcodePopupMenu.SettingsMenuClick(Sender:TObject);
  begin
      ParentBarcode.Edit;
  end;

  procedure TRbDBBarcodePopupMenu.CreateMenuItems;
  begin
    inherited;
    AddItem(30,'Settings','Settings ...',1000);
    ItemByName('Settings').OnClick := SettingsMenuClick;
  end;

}

// ************************************************************************
// **** RTTI for TpsRBBarcode
// ************************************************************************

class function  TraTpsRBBarcodeRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin
  Result := True;

  if (CompareText(aPropName, psReportBuilderComponentName) = 0) then
    PropToRec(psReportBuilderComponentName,daClass,True, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);
end;

class function  TraTpsRBBarcodeRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin
  Result := True;
  if (CompareText(aPropName, psReportBuilderComponentName) = 0) then
    TpsBarcodeComponent(aValue) := TpsRBBarcode(aObject).BarcodeComponent
  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);
end;

class function  TraTpsRBBarcodeRTTI.RefClass: TClass;
begin
  Result := TpsRBBarcode;
end;


// ****************************************************************************
// **** Report Builder property editors, PopupMenu,
// **** Categories for object inspector, etc ...
// ****************************************************************************
function  TpsRBBarcodePopupMenu.ParentBarcode : TpsBarcodeComponent;
begin
    GetPropValue(psReportBuilderComponentName,Result);
end;

procedure TpsRBBarcodePopupMenu.SettingsMenuClick(Sender:TObject);
var bc: TpsBarcodeComponent;
begin
    bc := TpsRBBarcode(Component).BarcodeComponent;
    EditBarcode(bc);
    TpsRBBarcode(Component).ChangeBarcode;
end;

procedure TpsRBBarcodePopupMenu.AboutMenuClick(Sender: TObject);
begin

    psShowAboutDlg(False);
    // TpsRBBarcode(Component).ChangeBarcode;
end;

procedure TpsRBBarcodePopupMenu.CreateMenuItems;
const mnuBase=10000;
      settings='psSettings';
var MI: TppTBXItem;
begin
    inherited;

    AddSeparator(mnuBase, '');
    MI:=AddItem(mnuBase+1, 'psAbout', 'About...',     1000);
    MI.OnClick := AboutMenuClick;

    AddSeparator(mnuBase+2, '');
    MI:=AddItem(mnuBase+3, 'psSettings', 'Settings ...', 1001);
    MI.OnClick := SettingsMenuClick;
end;


// *******************************************************************
// *** Initialization editors for Report Builder
// *******************************************************************


procedure PSOFT_ReportBuilderInitialization;
const BarcodeSheetName  = 'PSOFT Barcode';
      rbBarcodeCaterory = 'Barcode';
      bp                = 'LinesColor,CaptionUpper,CaptionHuman,CaptionBottom,'
        +'Options,Barcode,BarcodeSymbology,HorzLines,QuietZone,BgColor,Params,Angle,';
      bcName            = 'psRBBarcode';
      bcDbName          = 'psRBDBBarcode';

var i:Integer;
    s:String;
begin
  RegisterClasses([TpsRBBarcode, TpsRBDBBarcode]);
  raRegisterRTTI(TraTpsRBBarcodeRTTI);

  ppRegisterComponent(TpsRBBarcode,   BarcodeSheetName, 1, 0, bcName,   HInstance);
  ppRegisterComponent(TpsRbDBBarcode, BarcodeSheetName, 2, 0, bcDbName, HInstance);

  TppDesignControlFactory.RegisterDesignControlClass(TpsRBBarcode, TpsRBBarcodeControl);

  TppPopupMenuManager.RegisterMenuClass(TpsRBBarcode,  TpsRBBarcodePopupMenu);
  TppPopupMenuManager.RegisterMenuClass(TpsRbDBBarcode,TpsRBBarcodePopupMenu);

  // add to Report Builder Object inspector
  TppPropertyCategoryManager.PropertyCategories.Add(rbBarcodeCaterory);
  s:=bp;
  i:=Pos(',',s);
  // with TppPropertyCategoryManager.PropertyCategories.ItemByName[rbBarcodeCaterory] do
  while i>0 do begin
     TppPropertyCategoryManager.PropertyCategories.ItemByName[rbBarcodeCaterory].PropertyNames.Add(Copy(s,1,i-1));
     s:=Copy(s,i+1,Length(s)-i);
     i:=Pos(',',s);
  end;
end;

procedure PSOFT_ReportBuilderFinalization;
begin
  TppPopupMenuManager.UnRegisterMenuClass(TpsRbBarcodePopupMenu);
  TppDesignControlFactory.UnRegisterDesignControlClass(TpsRBBarcode);
  TppPopupMenuManager.UnRegisterMenuClass(TpsRBBarcodePopupMenu);

  ppUnRegisterComponent(TpsRbDBBarcode);

  ppUnRegisterComponent(TpsRBBarcode);
  raUnRegisterRTTI(TraTpsRBBarcodeRTTI);

  UnRegisterClasses([TpsRBBarcode, TpsRBDBBarcode]);
end;


function  TpsRBBarcodeControl.ParentBarcode : TpsBarcodeComponent;
begin
  GetPropValue(psReportBuilderComponentName,Result);
end;

procedure TpsRBBarcodeControl.PaintDesignControl(aCanvas: TCanvas);
var lClientRect   : TRect;
begin
    if not (pppcDesigning in Component.DesignState) or (Component.Printing) then Exit;

    lClientRect := ClientRect;
    PaintBarCode(aCanvas,lClientRect, ParentBarcode);
end;


function TpsRBBarcode.HasFont: Boolean;
begin
  Result:=False;
end;


procedure TpsRBBarcode.Edit;
begin
  EditBarcode(FBarcodeObject);
  UpdateDesignBarcode;
end;

procedure TpsRBBarcode.Copyright;
begin
  psShowAboutDlg(True);
end;

procedure Register;
begin
  RegisterNoIcon([TpsRBBarcode, TpsRBDBBarcode] );
end;

initialization

  PSOFT_ReportBuilderInitialization;


finalization

  PSOFT_ReportBuilderFinalization;

end.

