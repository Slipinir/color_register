unit color_insert_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, result_int, color_insert_int, color_int;

type

  { TColorInsert }

  TColorInsert = class (TInterfacedObject, IColorInsert)
  public
    class function New: IColorInsert;
    function Execute(AColor: IColor): IResult;
  end;

implementation

uses
  messages_res, result_class, result_status_enum, db_connection;

{ TColorInsert }

class function TColorInsert.New: IColorInsert;
begin
  Result:=TColorInsert.Create;
end;

function TColorInsert.Execute(AColor: IColor): IResult;
var
  Id: Integer;
begin
  with ZDbConnection.CreateStatement.ExecuteQuery(
    Format(
      'SELECT id FROM color WHERE name = %s',
      [QuotedStr(AColor.Name)]
    )
  ) do
  begin
    First;
    Id:=GetIntByName(
      'id'
    );
  end;

  if (Id > 0) then
    Result:=TResult.Create(
      rsOk, Format(
        MesColorInsertAlreadyExists,
        [AColor.Name]
      )
    )
  else begin
    try
      ZDbConnection.CreateStatement.Execute(
        Format(
          'INSERT INTO color (name) VALUES (%s);',
          [QuotedStr(AColor.Name)]
        )
      );
      Result:=TResult.Create(
        rsOk,
        Format(
          MesColorInsertSuccess,
          [AColor.Name]
        )
      );
    except
      on AnException: Exception do
        Result:=TResult.Create(
          rsError,
          Format(
            MesColorInsertError,
            [AColor.Name,
             AnException.Message]
          )
        );
    end;
  end;
end;

end.

