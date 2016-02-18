unit color_insert_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, result_int, color_insert_int, ZDbcIntfs, result_class,
  result_status_enum, color_int;

type

  { TColorInsert }

  TColorInsert = class (TInterfacedObject, IColorInsert)
  private
    FConnection: IZConnection;
  public
    constructor Create(AConnection: IZConnection);
    class function New(AConnection: IZConnection): IColorInsert;
    function Execute(AColor: IColor): IResult;
  end;

implementation

uses
  messages_res;

{ TColorInsert }

{function TColorInsert.Update(const AColor: IColorModel): IResult;
var
  Params: TStringList;
begin
  try
    Params:=TStringList.Create;
    Params.Add(IntToStr(AColor.Id));
    Params.Add(AColor.Color.Name);
    try
      FConnection.CreateStatement.Execute(
        'UPDATE color (id, name) VALUES (' + QuotedStr(AColor.Color.Name) + ');'
      );
      Result:=TResult.Create(rsOk,'');
    except
      on E: Exception do
        Result:=TResult.Create(
          rsError,
          RaisedException(
            E,
            AColor.Color
          )
        );
    end;
  finally
    Params.Free;
  end;
end;
 }

constructor TColorInsert.Create(AConnection: IZConnection);
begin
  FConnection:=AConnection;
end;

class function TColorInsert.New(AConnection: IZConnection): IColorInsert;
begin
  Result:=TColorInsert.Create(AConnection);
end;

function TColorInsert.Execute(AColor: IColor): IResult;
var
  Id: Integer;
  Query: IZResultSet;
begin
  Query:=FConnection.CreateStatement.ExecuteQuery(
    Format(
      'SELECT id FROM color WHERE name = %s',
      [QuotedStr(AColor.Name)]
    )
  );
  Query.First;
  Id:= Query.GetIntByName(
    'id'
  );

  if (Id > 0) then
    Result:=TResult.Create(
      rsOk, Format(
        MesColorInsertAlreadyExists,
        [AColor.Name]
      )
    )
  else begin
    try
      FConnection.CreateStatement.Execute(
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

