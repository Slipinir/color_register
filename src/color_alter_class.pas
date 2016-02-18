unit color_alter_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_alter_int, result_class, result_int, color_int,
  result_status_enum, ZDbcIntfs;

type

  { TColorAlter }

  TColorAlter = class (TInterfacedObject, IColorAlter)
  private
    FConnection: IZConnection;
  public
    constructor Create(AConnection: IZConnection);
    class function New(AConnection: IZConnection): IColorAlter;
    function Execute(AnId: Integer; AColor: IColor): IResult;
  end;

implementation

uses
  messages_res;

{ TColorAlter }

constructor TColorAlter.Create(AConnection: IZConnection);
begin
  FConnection:=AConnection;
end;

class function TColorAlter.New(AConnection: IZConnection): IColorAlter;
begin
  Result:=TColorAlter.Create(AConnection);
end;

function TColorAlter.Execute(AnId: Integer; AColor: IColor): IResult;
var
  AQuery: IZResultSet;
begin
  try
    AQuery:=FConnection.CreateStatement.ExecuteQuery(
      Format(
        'UPDATE color SET name = %s WHERE id = %d RETURNING ' +
        '(SELECT name FROM color WHERE id = %d);',
        [QuotedStr(AColor.Name),
         AnId,
         AnId]
      )
    );
    AQuery.First;
    Result:=TResult.Create(
      rsOk,
      Format(
        MesColorAlterSuccess,
        [
          AQuery.GetStringByName(
            'name'
          ),
          AColor.Name
        ]
      )
    );
  except
    on AnException: Exception do
      Result:=TResult.Create(
        rsError,
        Format(
          MesColorAlterError,
          [
            AColor.Name,
            AnId,
            AnException.Message
          ]
        )
      );
  end;

end;

end.

