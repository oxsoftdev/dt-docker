use Master


; create database Bitso
;
GO


use Bitso
GO


if (schema_id(N'ws') is null) exec(N'create schema [ws]');
GO


; create table [ws].[StreamUpdate]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    --
    , type nvarchar(32)
    , book nvarchar(32)
    , sequence_no bigint
    --
    , constraint PK_ws_StreamUpdate primary key (_id)
)
;


; create table [ws].[OrderUpdate]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    , _StreamUpdate_id bigint not null
    --
    , book nvarchar(32)
    , rate decimal(18,8)
    , amount decimal(18,8)
    , value decimal(18,8)
    , type nvarchar(4)
    , [timestamp] decimal(20,8)
    , [datetime] datetime
    --
    , constraint PK_ws_OrderUpdate primary key (_id)
    , constraint FK_ws_OrderUpdate_StreamUpdate_id foreign key (_StreamUpdate_id) references [ws].[StreamUpdate] (_id)
)
;


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
    , maker_order_id nvarchar(256)
    , taker_order_id nvarchar(256)
    --
    , constraint PK_ws_TradeUpdate primary key (_id)
    , constraint FK_ws_TradeUpdate_StreamUpdate_id foreign key (_StreamUpdate_id) references [ws].[StreamUpdate] (_id)
    , constraint UQ_ws_TradeUpdate_tid unique (tid)
)
;
GO

