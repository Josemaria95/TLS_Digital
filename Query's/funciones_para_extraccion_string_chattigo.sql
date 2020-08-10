-- Author: Igor Nikiforov, Montreal, EMail: udfs@sympatico.ca
-- GETWORDCOUNT() User-Defined Function Counts the words in a string.
-- GETWORDCOUNT(@cString[, @cDelimiters])
-- Parameters
-- @cString nvarchar(4000) - Specifies the string whose words will be counted.
-- @cDelimiters nvarchar(256) - Optional. Specifies one or more optional characters used to separate words in @cString.
-- The default delimiters are space, tab, carriage return, and line feed. Note that GETWORDCOUNT( ) uses each of the characters in @cDelimiters as individual delimiters, not the entire string as a single delimiter.
-- Return Value smallint
-- Remarks GETWORDCOUNT() by default assumes that words are delimited by spaces or tabs. If you specify another character as delimiter, this function ignores spaces and tabs and uses only the specified character.
-- If you use 'AAA aaa, BBB bbb, CCC ccc.' as the target string for dbo.GETWORDCOUNT(), you can get all the following results.
-- declare @cString nvarchar(4000)
-- set @cString = 'AAA aaa, BBB bbb, CCC ccc.'
-- select dbo.GETWORDCOUNT(@cString, default) -- 6 - character groups, delimited by ' '
-- select dbo.GETWORDCOUNT(@cString, ',') -- 3 - character groups, delimited by ','
-- select dbo.GETWORDCOUNT(@cString, '.') -- 1 - character group, delimited by '.'
-- See Also GETWORDNUM() User-Defined Function
-- UDF the name and functionality of which correspond to the same built-in function of Visual FoxPro
CREATE function GETWORDCOUNT (@cSrting nvarchar(4000), @cDelimiters nvarchar(256) )
returns smallint
as
begin
-- if no break string is specified, the function uses spaces, tabs and line feed to delimit words.
set @cDelimiters = isnull(@cDelimiters, space(1)+char(9)+char(10))
declare @p smallint, @end_of_string smallint, @wordcount smallint
select @p = 1, @wordcount = 0
select @end_of_string = 1 + datalength(@cSrting)/(case SQL_VARIANT_PROPERTY(@cSrting,'BaseType') when 'nvarchar' then 2 else 1 end) -- for unicode

while dbo.CHARINDEX_BIN(substring(@cSrting, @p, 1), @cDelimiters, 1) > 0 and @end_of_string > @p -- skip opening break characters, if any
set @p = @p + 1

if @p < @end_of_string
begin
set @wordcount = 1 -- count the one we are in now count transitions from 'not in word' to 'in word'
-- if the current character is a break char, but the next one is not, we have entered a new word
while @p < @end_of_string
begin
if @p +1 < @end_of_string and dbo.CHARINDEX_BIN(substring(@cSrting, @p, 1), @cDelimiters, 1) > 0 and dbo.CHARINDEX_BIN(substring(@cSrting, @p+1, 1), @cDelimiters, 1) = 0
select @wordcount = @wordcount + 1, @p = @p + 1 -- Skip over the first character in the word. We know it cannot be a break character.
set @p = @p + 1
end
end

return @wordcount
end
GO

-- Author: Igor Nikiforov, Montreal, EMail: udfs@sympatico.ca
-- GETWORDNUM() User-Defined Function
-- Returns a specified word from a string.
-- GETWORDNUM(@cString, @nIndex[, @cDelimiters])
-- Parameters @cString nvarchar(4000) - Specifies the string to be evaluated
-- @nIndex smallint - Specifies the index position of the word to be returned. For example, if @nIndex is 3, GETWORDNUM( ) returns the third word (if @cString contains three or more words).
-- @cDelimiters nvarchar(256) - Optional. Specifies one or more optional characters used to separate words in @cString.
-- The default delimiters are space, tab, carriage return, and line feed. Note that GetWordNum( ) uses each of the characters in @cDelimiters as individual delimiters, not the entire string as a single delimiter.
-- Return Value nvarchar(4000)
-- Remarks Returns the word at the position specified by @nIndex in the target string, @cString. If @cString contains fewer than @nIndex words, GETWORDNUM( ) returns an empty string.
-- See Also
-- GETWORDCOUNT() User-Defined Function
-- UDF the name and functionality of which correspond to the same built-in function of Visual FoxPro
CREATE function GETWORDNUM (@cSrting nvarchar(4000), @nIndex smallint, @cDelimiters nvarchar(256) )
returns nvarchar(4000)
as
begin
-- if no break string is specified, the function uses spaces, tabs and line feed to delimit words.
set @cDelimiters = isnull(@cDelimiters, space(1)+char(9)+char(10))
declare @i smallint, @j smallint, @p smallint, @q smallint, @qmin smallint, @end_of_string smallint, @LenDelimiters smallint, @outstr nvarchar(4000)
select @i = 1, @p = 1, @q = 0, @outstr = ''
select @end_of_string = 1 + datalength(@cSrting)/(case SQL_VARIANT_PROPERTY(@cSrting,'BaseType') when 'nvarchar' then 2 else 1 end) -- for unicode
select @LenDelimiters = datalength(@cDelimiters)/(case SQL_VARIANT_PROPERTY(@cDelimiters,'BaseType') when 'nvarchar' then 2 else 1 end) -- for unicode

while @i <= @nIndex
begin
while dbo.CHARINDEX_BIN(substring(@cSrting, @p, 1), @cDelimiters, 1) > 0 and @end_of_string > @p -- skip opening break characters, if any
set @p = @p + 1

if @p >= @end_of_string
break

select @j = 1, @qmin = @end_of_string -- find next break character it marks the end of this word
while @j <= @LenDelimiters
begin
set @q = dbo.CHARINDEX_BIN(substring(@cDelimiters, @j, 1), @cSrting, @p)
set @j = @j + 1
if @q > 0 and @qmin > @q
set @qmin = @q
end

if @i = @nIndex -- this is the actual word we are looking for
begin
set @outstr = substring(@cSrting, @p, @qmin-@p)
break
end
set @p = @qmin + 1

if (@p >= @end_of_string)
break
set @i = @i + 1
end

return @outstr
end
GO


-- Is similar to the built-in function Transact-SQL charindex, but regardless of collation settings,
-- executes case-sensitive search
-- Author: Igor Nikiforov, Montreal, EMail: udfs@sympatico.ca
CREATE function CHARINDEX_BIN(@expression1 nvarchar(4000), @expression2 nvarchar(4000), @start_location smallint = 1)
returns nvarchar(4000)
as
begin
return charindex( cast(@expression1 as nvarchar(4000)) COLLATE Latin1_General_BIN, cast(@expression2 as nvarchar(4000)) COLLATE Latin1_General_BIN, @start_location )
end
GO

CREATE FUNCTION [dbo].[AddPrefixSufix] 
(
	-- Add the parameters for the function here
	@palabra nvarchar(100)
	, @prefix nvarchar(100)
	, @sufix nvarchar(100)
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(100)
	SET @Result = ''

	-- Add the T-SQL statements to compute the return value here
	if (@palabra <> '')
		set @Result = @prefix + ' ' +  @palabra

	if (@Result <> '')
		set @Result  = @Result + ' ' + @sufix



	-- Return the result of the function
	RETURN rtrim(@Result)

END