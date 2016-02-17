unit color_save_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, color_model_int, result_int, color_save_int, ZDbcIntfs,
  result_class, result_status_enum, color_int;

type

  { TColorSave }

  TColorSave = class (TInterfacedObject, IColorSave)
  private
    FConnection: IZConnection;
    function Update(const AColor: IColorModel): IResult;
    function Insert(const AColor: IColor): IResult;
    function RaisedException(const AnException: Exception; const AColor: IColor): string;
  published
    constructor Create(AConnection: IZConnection);
    class function New(AConnection: IZConnection): IColorSave;
    function Execute(AColor: IColorModel): IResult;
  end;

implementation

{ TColorSave }

function TColorSave.Update(const AColor: IColorModel): IResult;
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

function TColorSave.Insert(const AColor: IColor): IResult;
var
  Params: TStringList;
begin
  try
    Params:=TStringList.Create;
    Params.Add(AColor.Name);
    try
      FConnection.CreateStatement.Execute(
        'INSERT INTO color (name) VALUES (' + QuotedStr(AColor.Name) + ');');
      Result:=TResult.Create(
        rsOk,
        Format(
          '%s color was successfuly saved!',
          [AColor.Name]
        )
      );
    except
      on E: Exception do
        Result:=TResult.Create(
          rsError,
          RaisedException(
            E,
            AColor
          )
        );
    end;
  finally
    Params.Free;
  end;
end;

function TColorSave.RaisedException(const AnException: Exception;
  const AColor: IColor): string;
begin
  Result:=Format(
    'Ocurred an error saving Color %s.' + #13#10 +
    'Message: %s',
    [AColor.Name,
     AnException.Message]
  );
end;

constructor TColorSave.Create(AConnection: IZConnection);
begin
  FConnection:=AConnection;
end;

class function TColorSave.New(AConnection: IZConnection): IColorSave;
begin
  Result:=TColorSave.Create(AConnection);
end;

function TColorSave.Execute(AColor: IColorModel): IResult;
var
  Id: Integer;
  Params: TStringList;
  Query: IZResultSet;
begin
  try
    Params:=TStringList.Create;
    Query:=FConnection.CreateStatement.ExecuteQuery(
      'SELECT id FROM color WHERE name = ' + QuotedStr(AColor.Color.Name)
    );
    Query.First;
    Id:= Query.GetIntByName(
      'id'
    );

    if (Id > 0) then
      Result:=TResult.Create(rsOk, Format('Cor %s already exists', [AColor.Color.Name]))
    else Result:=Insert(AColor.Color);
  finally
    Params.Free;
  end;
end;

end.

