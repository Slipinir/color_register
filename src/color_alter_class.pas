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
      with ZDbConnection.CreateStatement.ExecuteQuery(
        Format(
          'UPDATE color SET name = %s WHERE id = %d RETURNING ' +
          '(SELECT name FROM color WHERE id = %d);',
          [QuotedStr(AColor.Name), AnId, AnId]
        )
      ) do
      begin
        First;
        Result:=TResult.Create(
          rsOk,
          Format(
            MesColorAlterSuccess,
            [GetStringByName('name'),AColor.Name]
          )
        );
        ZDbConnection.Commit;
      end;
    end else
      Result:=TResult.Create(
        rsError,
        Format(
          'The color with the Id %d wasn''t found!' + #13#10 +
          'Maybe you typed it wrong, check if it''s the case.',
          [AnId]
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
          Format(
            'No color that has %s in the name was found!',
            [AName]
          )
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
            Format(
              'The color %s (%s) was successfully changed to %s!',
              [AQuery.GetString(1), AName, AColor.Name]
            )
          )
        else
          Result:=TResult.Create(
            rsOk,
            Format(
              'The color %s was successfully changed to %s!',
              [AName, AColor.Name]
            )
          );
        ZDbConnection.Commit;
      end
      else begin
        Colors:='';
        Colors:=
          Format(
            'More than a color was found with the %s in their name, they are:',
            [AName]
          ) + #13#10 +
          'Id Name';
        with ZDbConnection.CreateStatement.ExecuteQuery(
          Format(
            'SELECT id, name FROM color WHERE name LIKE %s',
            [QuotedStr('%' + AName + '%')]
          )
        ) do
        begin
          First;
          repeat
            Colors:=Colors+#13#10+
              Format(
                '%2d %s',
                [GetIntByName('id'), GetStringByName('name')]
              );
            Next;
          until (IsAfterLast);
        end;
        Result:=TResult.Create(
          rsError,
          Colors
        );
      end;
    end;
  except
    on AnException: Exception do
      Result:=TResult.Create(
        rsError,
        Format(
          'An error ocurred trying to alter a color!' + #13#10 +
          'Error message: %s',
          [AnException.Message]
        )
      );
  end;
end;

end.

