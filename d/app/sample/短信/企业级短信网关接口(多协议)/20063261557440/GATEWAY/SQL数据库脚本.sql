if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OUTMT]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OUTMT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OUTMTLOG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OUTMTLOG]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ProtocolView]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ProtocolView]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceCodeConvertView]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceCodeConvertView]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SmcMo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SmcMo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sendsms]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[sendsms]
GO

CREATE TABLE [dbo].[OUTMT] (
	[MT_SEND_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[MtMsgFmt] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtMsgLenth] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtMsgContent] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[L2CMtMsgType] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoOutMsgId] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoInMsgId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtGateId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoLinkId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtSpAddr] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtUserAddr] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtFeeAddr] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[L2CMtServiceId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtValidTime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtAtTime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtReserve] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtInMsgId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtLogicId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PrePrcResult] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutMsgType] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutServiceID] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutFeeType] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutFixedFee] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutFeeCode] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[RealFeeCode] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[C2GRecTime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OUTStatus] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutMtMsgid] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutPrced] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutPrcTimes] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutLastprctime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OUTMTLOG] (
	[L2CMtMsgType] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoOutMsgId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoInMsgId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtGateId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoLinkId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtSpAddr] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtUserAddr] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtFeeAddr] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[L2CMtServiceId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtMsgFmt] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtValidTime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtAtTime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtMsgLenth] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtMsgContent] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtReserve] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtInMsgId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MtLogicId] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[PrePrcResult] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutMsgType] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutServiceID] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutFeeType] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutFixedFee] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutFeeCode] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[RealFeeCode] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[C2GRecTime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OUTStatus] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutMtMsgid] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutPrced] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutPrcTimes] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutLastprctime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutRptSubDate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutRptDonDate] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutRptStat] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutRptErr] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutRptRecTime] [char] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ProtocolView] (
	[gateid] [int] NOT NULL ,
	[Serviceid] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[msgtype] [int] NULL ,
	[gatefeetype] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gatefeecode] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[gatemsgtype] [int] NULL ,
	[gatefixfee] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[realfeecode] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ServiceCodeConvertView] (
	[LogicId] [int] IDENTITY (1, 1) NOT NULL ,
	[LogicCode] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[ServiceId] [char] (20) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SmcMo] (
	[MO_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[MoOutMsgId] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoInMsgId] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoSpAddr] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoUserAddr] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoReserve] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoMsgFmt] [int] NULL ,
	[MoMsgLenth] [float] NULL ,
	[MoMsgContent] [char] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[user_sms_id] [char] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[mosend_time] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[OutRecTime] [char] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[G2CED] [int] NULL ,
	[G2CPrcTimes] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[G2CLastPrcTime] [char] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[MoGateId] [int] NULL ,
	[smc_tag] [int] NULL ,
	[fenfa_tag] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sendsms] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[code_id] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[sms_sumbit] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[sms_id] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[sms_ywcode] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[sms_mob] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[sms_text] [nvarchar] (225) COLLATE Chinese_PRC_CI_AS NULL ,
	[send_tag] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[sp_id] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[sp_date] [datetime] NULL ,
	[user_code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[smc_tag] [int] NULL ,
	[source_num] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[port_tag] [int] NULL ,
	[msg_src] [char] (20) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

