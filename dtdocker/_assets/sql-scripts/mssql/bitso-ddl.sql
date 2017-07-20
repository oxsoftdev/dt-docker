use Master


; create database Bitso
;
GO


use Bitso
GO


if (schema_id(N'api_public') is null) exec(N'create schema [api_public]');
GO


; create table [api_public].[Book]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    --
    , book nvarchar(32)
    , minimum_amount decimal(18,8)
    , maximum_amount decimal(18,8)
    , minimum_price decimal(18,8)
    , maximum_price decimal(18,8)
    , minimum_value decimal(18,8)
    , maximum_value decimal(18,8)
    --
    , constraint PK_api_Book primary key (_id)
)
;


; create table [api_public].[Ticker]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    --
    , book nvarchar(32)
    , volume decimal(18,8)
    , high decimal(18,8)
    , last decimal(18,8)
    , low decimal(18,8)
    , vwap decimal(18,8)
    , ask decimal(18,8)
    , bid decimal(18,8)
    , created_at datetime
    --
    , constraint PK_api_Ticker primary key (_id)
)
;


; create table [api_public].[Order]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    --
    , book nvarchar(32)
    , price decimal(18,8)
    , amount decimal(18,8)
    , oid nvarchar(256)
    , updated_at datetime
    , sequence bigint
    --
    , constraint PK_api_Order primary key (_id)
)
;


; create table [api_public].[Trade]
(
    _id bigint identity(1,1)
    , _timestamp decimal(20,8) not null
    , _datetime datetime not null
    --
    , book nvarchar(32)
    , created_at datetime
    , amount decimal(18,8)
    , maker_side nvarchar(16)
    , price decimal(18,8)
    , tid bigint
    --
    , constraint PK_api_Trade primary key (_id)
)
;
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
    , amount decimal(18,8)
    , rate decimal(18,8)
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
