unit color_alter_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_alter_int, result_class, result_int, color_int,
  ZDbcIntfs;

type

  { TColorAlter }

  TColorAlter = class (TInterfacedObject, IColorAlter)
  public
    class function New: IColorAlter;
    function Execute(const AnId: Integer; const AColor: IColor): IResult;
    function Execute(const AName: string; const AColor: IColor): IResult;
  end;

implementation

uses
  messages_res, db_connection, result_status_enum;

{ TColorAlter }

class function TColorAlter.New: IColorAlter;
begin
  Result:=TColorAlter.Create;
end;

function TColorAlter.Execute(const AnId: Integer; const AColor: IColor): IResult;
var
  AQuery: IZResultSet;
begin
  try
    AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
      Format(
        'SELECT count(*) FROM color WHERE id = %d;',
        [AnId]
      )
    );
    AQuery.First;
    if (AQuery.GetInt(1) > 0) then
    begin
      AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
        Format(
          'UPDATE color SET name = %s WHERE id = %d RETURNING ' +
          '(SELECT name FROM color WHERE id = %d);',
          [QuotedStr(AColor.Name), AnId, AnId]
        )
      );
      AQuery.First;
      Result:=TResult.Create(
        rsOk,
        MesColorAlterSuccess,
        [AQuery.GetStringByName('name'), AColor.Name]
      );
      ZDbConnection.Commit;
    end else
      Result:=TResult.Create(
        rsError,
        MesColorAlterIdNotFound,
        [AnId]
      );
  except
    on AnException: Exception do
      Result:=TResult.Create(
        rsError,
        Format(
          MesColorAlterError,
          [AColor.Name, AnException.Message]
        )
      );
  end;

end;

function TColorAlter.Execute(const AName: string; const AColor: IColor
  ): IResult;
var
  Colors: string;
  AQuery: IZResultSet;
begin
  try
    AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
      Format(
        'SELECT count(*) FROM color WHERE name LIKE %s',
        [QuotedStr('%' + AName + '%')]
      )
    );
    AQuery.First;
    case AQuery.GetInt(1) of
      0:
        Result:=TResult.Create(
          rsError,
          MesColorAlterNameNotFound,
          [AName]
        );
      1: begin
        AQuery:=ZDbConnection.CreateStatement.ExecuteQuery(
          Format(
            'UPDATE color SET name = %s WHERE name LIKE %s RETURNING' + #13#10 +
            '(SELECT name FROM color WHERE name LIKE %s)',
            [QuotedStr(AColor.Name), QuotedStr('%' + AName + '%'),
             QuotedStr('%' + AName + '%')]
          )
        );
        AQuery.First;
        if (AQuery.GetString(1) <> AName) then
          Result:=TResult.Create(
            rsOk,
            MesColorAlterSuccess,
            [AQuery.GetString(1), AColor.Name]
          )
        else
          Result:=TResult.Create(
            rsOk,
            MesColorAlterSuccess,
            [AName, AColor.Name]
          );
        ZDbConnection.Commit;
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
        repeat
          Colors:=Colors + #13#10 +
            Format(
              '%2d %s',
              [AQuery.GetIntByName('id'), AQuery.GetStringByName('name')]
            );
          AQuery.Next;
        until (AQuery.IsAfterLast);
        end;
        Result:=TResult.Create(
          rsError,
          Colors
        );
      end;
  except
    on AnException: Exception do
      Result:=TResult.Create(
        rsError,
        MesColorAlterError,
        [AColor.Name, AnException.Message]
      );
  end;
end;

end.

