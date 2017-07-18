use Master


; create database Poloniex
;
GO


use Poloniex
GO


if (schema_id(N'ws') is null) exec(N'create schema [ws]');
GO


; create table [ws].[Ticker]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    --
    , book nvarchar(16)
    , last decimal(18,8)
    , lowest_ask decimal(18,8)
    , highest_bid decimal(18,8)
    , percent_change decimal(18,8)
    , base_volume decimal(18,8)
    , quote_volume decimal(18,8)
    , is_frozen bit
    , twentyfour_hour_high decimal(18,8)
    , twentyfour_hour_low decimal(18,8)
    --
    , constraint PK_ws_Ticker primary key (_id)
)
;


; create table [ws].[StreamUpdate]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    --
    , sequence_no bigint
    , type nvarchar(32)
    --
    , constraint PK_ws_Update primary key (_id)
)


; create table [ws].[TradeUpdate]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    , _StreamUpdate_id bigint not null
    --
    , book nvarchar(32)
    , tid bigint
    , rate decimal(18,8)
    , amount decimal(18,8)
    , value decimal(18,8)
    , type nvarchar(4)
    , [timestamp] decimal(20,8)
    , [datetime] datetime
    --
    --
    , constraint PK_ws_TradeUpdate primary key (_id)
    , constraint FK_ws_TradeUpdate_StreamUpdate_id foreign key (_StreamUpdate_id) references [ws].[StreamUpdate] (_id)
    , constraint UQ_ws_TradeUpdate_tid unique (tid)
)
;
GO

