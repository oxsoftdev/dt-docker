use Bitso
GO


; CREATE PROCEDURE api_public.usp_InsertBook
      @_timestamp decimal(20,8)
    , @_datetime datetime
    --
    , @book nvarchar(32)
    , @minimum_amount decimal(18,8)
    , @maximum_amount decimal(18,8)
    , @minimum_price decimal(18,8)
    , @maximum_price decimal(18,8)
    , @minimum_value decimal(18,8)
    , @maximum_value decimal(18,8)
    --
    , @id bigint OUTPUT
AS
SET NOCOUNT ON
BEGIN TRANSACTION
    INSERT INTO [api_public].[Book]
        ( [_timestamp]
        , [_datetime]
        --
        , [book]
        , [minimum_amount]
        , [maximum_amount]
        , [minimum_price]
        , [maximum_price]
        , [minimum_value]
        , [maximum_value]
        )
    VALUES
        ( @_timestamp
        , @_datetime
        --
        , @book
        , @minimum_amount
        , @maximum_amount
        , @minimum_price
        , @maximum_price
        , @minimum_value
        , @maximum_value
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO


; CREATE PROCEDURE api_public.usp_InsertTicker
      @_timestamp decimal(20,8)
    , @_datetime datetime
    --
    , @book nvarchar(32)
    , @volume decimal(18,8)
    , @high decimal(18,8)
    , @last decimal(18,8)
    , @low decimal(18,8)
    , @vwap decimal(18,8)
    , @ask decimal(18,8)
    , @bid decimal(18,8)
    , @created_at datetime
    --
    , @id bigint OUTPUT
AS
SET NOCOUNT ON
BEGIN TRANSACTION
    INSERT INTO [api_public].[Ticker]
        ( [_timestamp]
        , [_datetime]
        --
        , [book]
        , [volume]
        , [high]
        , [last]
        , [low]
        , [vwap]
        , [ask]
        , [bid]
        , [created_at]
        )
    VALUES
        ( @_timestamp
        , @_datetime
        --
        , @book
        , @volume
        , @high
        , @last
        , @low
        , @vwap
        , @ask
        , @bid
        , @created_at
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO


; CREATE PROCEDURE api_public.usp_InsertOrder
      @_timestamp decimal(20,8)
    , @_datetime datetime
    --
    , @book nvarchar(32)
    , @price decimal(18,8)
    , @amount decimal(18,8)
    , @oid nvarchar(256)
    , @updated_at datetime
    , @sequence bigint
    --
    , @id bigint OUTPUT
AS
SET NOCOUNT ON
BEGIN TRANSACTION
    INSERT INTO [api_public].[Order]
        ( [_timestamp]
        , [_datetime]
        , [book]
        , [price]
        , [amount]
        , [oid]
        , [updated_at]
        , [sequence]
        --
        )
    VALUES
        ( @_timestamp
        , @_datetime
        --
        , @book
        , @price
        , @amount
        , @oid
        , @updated_at
        , @sequence
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO


; CREATE PROCEDURE api_public.usp_InsertTrade
      @_timestamp decimal(20,8)
    , @_datetime datetime
    --
    , @book nvarchar(32)
    , @created_at datetime
    , @amount decimal(18,8)
    , @maker_side nvarchar(16)
    , @price decimal(18,8)
    , @tid bigint
    --
    , @id bigint OUTPUT
AS
SET NOCOUNT ON
BEGIN TRANSACTION
    INSERT INTO [api_public].[Trade]
        ( [_timestamp]
        , [_datetime]
        --
        , [book]
        , [created_at]
        , [amount]
        , [maker_side]
        , [price]
        , [tid]
        )
    VALUES
        ( @_timestamp
        , @_datetime
        --
        , @book
        , @created_at
        , @amount
        , @maker_side
        , @price
        , @tid
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO


; CREATE PROCEDURE ws.usp_InsertStreamUpdate
      @_timestamp decimal(20,8)
    , @_datetime datetime
    --
    , @type nvarchar(32)
    , @book nvarchar(32)
    , @sequence_no bigint
    --
    , @id bigint OUTPUT
AS
SET NOCOUNT ON
BEGIN TRANSACTION
    INSERT INTO [Bitso].[ws].[StreamUpdate]
        ( [_timestamp]
        , [_datetime]
        --
        , [type]
        , [book]
        , [sequence_no]
        )
    VALUES
        ( @_timestamp
        , @_datetime
        --
        , @type
        , @book
        , @sequence_no
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO



; CREATE PROCEDURE ws.usp_InsertOrderUpdate
      @_timestamp decimal(20,8)
    , @_datetime datetime
    , @_StreamUpdate_id bigint
    --
    , @book nvarchar(32)
    , @rate decimal(18,8)
    , @amount decimal(18,8)
    , @value decimal(18,8)
    , @type nvarchar(32)
    , @timestamp decimal(20,8)
    , @datetime datetime
    --
    , @id bigint OUTPUT
AS
SET NOCOUNT ON
BEGIN TRANSACTION
    INSERT INTO [Bitso].[ws].[OrderUpdate]
        ( [_timestamp]
        , [_datetime]
        , [_StreamUpdate_id]
        --
        , [book]
        , [rate]
        , [amount]
        , [value]
        , [type]
        , [timestamp]
        , [datetime]
        )
    VALUES
        ( @_timestamp
        , @_datetime
        , @_StreamUpdate_id
        --
        , @book
        , @rate
        , @amount
        , @value
        , @type
        , @timestamp
        , @datetime
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO



; CREATE PROCEDURE ws.usp_InsertTradeUpdate
      @_timestamp decimal(20,8)
    , @_datetime datetime
    , @_StreamUpdate_id bigint
    --
    , @book nvarchar(32)
    , @tid bigint
    , @amount decimal(18,8)
    , @rate decimal(18,8)
    , @value decimal(18,8)
    , @type nvarchar(32)
    , @maker_order_id nvarchar(256)
    , @taker_order_id nvarchar(256)
    --
    , @id bigint OUTPUT
AS
SET NOCOUNT ON
BEGIN TRANSACTION
    INSERT INTO [Bitso].[ws].[TradeUpdate]
        ( [_timestamp]
        , [_datetime]
        , [_StreamUpdate_id]
        --
        , [book]
        , [tid]
        , [amount]
        , [rate]
        , [value]
        , [type]
        , [maker_order_id]
        , [taker_order_id]
        )
    VALUES
        ( @_timestamp
        , @_datetime
        , @_StreamUpdate_id
        --
        , @book
        , @tid
        , @amount
        , @rate
        , @value
        , @type
        , @maker_order_id
        , @taker_order_id
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO
