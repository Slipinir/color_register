unit color_delete_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_delete_int, result_int;

type

  { TColorDelete }

  TColorDelete = class (TInterfacedObject, IColorDelete)
  public
    class function New: IColorDelete;
    function Execute(const AnId: Integer): IResult; overload;
    function Execute(const AName: string): IResult; overload;
  end;

implementation

uses
  result_class, result_status_enum, db_connection, ZDbcIntfs, messages_res;

{ TColorDelete }

class function TColorDelete.New: IColorDelete;
begin
  Result:=TColorDelete.Create;
end;

function TColorDelete.Execute(const AnId: Integer): IResult;
var
  AQuery: IZResultSet;
  AName: string;
begin
  try
    AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
      Format(
        'SELECT count(*) FROM color WHERE id = %d',
        [AnId]
      )
    );
    AQuery.First;
    if (AQuery.GetInt(1) > 0) then
    begin
      AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
        Format(
          'SELECT name FROM color WHERE id = %d',
          [AnId]
        )
      );
      AQuery.First;
      AName:=AQuery.GetStringByName('name');
      ZDbConnection.CreateStatement.Execute(
        Format(
          'DELETE FROM color WHERE id = %d',
          [AnId]
        )
      );
      Result:=TResult.Create(
        rsOk,
        'Color %s deleted successfully!',
        [AName]
      );
      ZDbConnection.Commit;
    end;
  except
  end;
end;

function TColorDelete.Execute(const AName: string): IResult;
var
  AQuery: IZResultSet;
  Colors: string;
begin
  try
    AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
      Format(
        'SELECT count(*) FROM color WHERE name LIKE %s',
        [QuotedStr('%' + AName + '%')]
      )
    );
    AQuery.First;
    case (AQuery.GetInt(1)) of
      0: Result:=TResult.Create(
        rsOk,
        'Color %s not found!',
        [AName]
      );
      1: begin
        ZDbConnection.CreateStatement.Execute(
          Format(
            'DELETE FROM color WHERE name LIKE %s',
            [QuotedStr('%' + AName + '%')]
          )
        );
        ZDbConnection.Commit;
        Result:=TResult.Create(
          rsOk,
          'Color %s deleted successfully!',
          [AName]
        );
      end
      else begin
        Colors:='';
        Colors:=
          Format(
            MesColorMoreThanOneFound,
            [AName]
          ) + #13#10 +
          'Id Name';
        AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
          Format(
            'SELECT id, name FROM color WHERE name LIKE %s',
            [QuotedStr('%' + AName + '%')]
          )
        );
        AQuery.First;
        while (not AQuery.IsAfterLast) do
        begin
          Colors:=Colors + #13#10 +
            Format(
              '%2d %s',
              [AQuery.GetIntByName('id'), AQuery.GetStringByName('name')]
            );
          AQuery.Next;
        end;
        Result:=TResult.Create(
          rsError,
          Colors
        );
      end;
    end;
  except
  end;
end;

end.

