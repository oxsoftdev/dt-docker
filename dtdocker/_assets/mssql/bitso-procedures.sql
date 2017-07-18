use Bitso
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
    , @rate decimal(18,8)
    , @amount decimal(18,8)
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
        , [rate]
        , [amount]
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
        , @rate
        , @amount
        , @value
        , @type
        , @maker_order_id
        , @taker_order_id
        )
    SET @id = (SELECT SCOPE_IDENTITY())
COMMIT
;
GO

