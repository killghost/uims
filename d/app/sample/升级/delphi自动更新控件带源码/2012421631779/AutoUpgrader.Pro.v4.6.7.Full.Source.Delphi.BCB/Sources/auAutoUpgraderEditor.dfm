�
 TAUAUTOUPGRADEREDITOR 0(  TPF0TauAutoUpgraderEditorauAutoUpgraderEditorLeft� TopwBorderIconsbiSystemMenubiHelp BorderStylebsDialogCaption$Current Version: Upgrade informationClientHeightFClientWidthp
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnClose	FormCloseOnShowFormShowPixelsPerInch`
TextHeight 	TGroupBox	GroupBox1LeftTop WidthkHeightACaption Version info TabOrder  TLabelLabel1LeftTopWidthHeightCaptionDate:   TLabelLabel2LeftTop*Width+HeightCaptionNumber:   TLabelLabel3Left� Top
WidthIHeightCaptionVersion control:  TEditDateEditLeft6TopWidth� HeightTabOrder OnExitDateEditExit  TEdit
NumberEditLeft6Top&Width� HeightTabOrder  TRadioButtonByDateRadioLeft� TopWidth[HeightCaptionBy DateChecked	TabOrderTabStop	OnClickByDateRadioClick  TRadioButtonByNumberRadioLeft� Top*Width[HeightCaption	By NumberTabOrderOnClickByDateRadioClick   	TGroupBox	GroupBox2LeftTopBWidthkHeight}Caption' URLs to files which should be updated TabOrder TButtonAddBtnLeftTopWidthIHeightCaption&Add...TabOrder OnClickAddBtnClick  TButton	DeleteBtnLeftTop)WidthIHeightCaption&DeleteEnabledTabOrderOnClickDeleteBtnClick  TButtonCheckURLBtnLeftTopOWidthIHeightCaption
&Check URLEnabledTabOrderOnClickCheckURLBtnClick  TPanelPanel1LeftTophWidthgHeightAlignalBottom
BevelOuterbvNoneTabOrder TLabelLabel6LeftTopWidthRHeightCaptionUpgrade method:  TRadioButtonReplaceRadioLeftVTopWidthSHeightHint  |[B]Self-upgrade
[]Check this box if you want to automatically upgrade your software using just AutoUpgrader without any external programs. When this option is turned on, the AutoUpgrader will download all required files from the Web and replace the old ones with newer.CaptionSelf-upgradeTabOrder   TRadioButton
SetupRadioLeft� TopWidthIHeightHint�|[B]Use Setup
[]Check this box if you would like to use AutoUpgrader for downlading the "external"  setup-file which will locally extract all requrired files.Caption	Use SetupTabOrder  TRadioButtonRedirectRadioLeft TopWidtheHeightHint�|[B]Redirect to URL
[]Check this box if you do NOT want to perform automatic upgrade and just redirect user to the first URL listed here.CaptionRedirect to URLTabOrder   	TListViewListViewLeftTopWidthHeightYAlignalLeft
OnDblClickListViewDblClickColumnsCaptionFiles  ReadOnlyHideSelectionMultiSelect	OnChangeListViewChange	PopupMenu	PopupMenuShowColumnHeadersTabOrder	ViewStylevsReportSmallImages	ImageList   	TGroupBox	GroupBox3LeftTop� WidthkHeightaCaption Release Notes Message TabOrder TMemoMemo1LeftTopWidthHeightPAlignalLeftTabOrder   TButtonTestBtnLeftTopWidthIHeightCaptionTestTabOrderOnClickTestBtnClick   TButtonOKBtnLeft� Top)WidthKHeightCaptionOKDefault	ModalResultTabOrderOnClick
OKBtnClick  TButton	CancelBtnLeft Top)WidthKHeightCancel	CaptionCancelModalResultTabOrderOnClickCancelBtnClick  TButton	ExportBtnLeftTop)Width� HeightCaption&Export to Info-File...
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickExportBtnClick  TSaveDialog
SaveDialog
DefaultExtinfFileEditStylefsEditFilterHInfo files (*.inf, *.info, *.nfo)|*.inf;*.info;*.nfo|All files (*.*)|*.*OptionsofOverwritePromptofCreatePromptofNoReadOnlyReturn LeftTopb  
TImageList	ImageListLeft*Topb  
TPopupMenu	PopupMenuLeftFTopb 	TMenuItemAddItemCaption&Add...ShortCut OnClickAddBtnClick  	TMenuItem
RenameItemCaption&RenameShortCut OnClickRenameItemClick  	TMenuItem
DeleteItemCaption&DeleteShortCut OnClickDeleteBtnClick  	TMenuItemN2Caption-ShortCut   	TMenuItemCheckURLItemCaption
&Check URLShortCut OnClickCheckURLBtnClick    