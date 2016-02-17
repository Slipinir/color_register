unit color_save_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, color_model_int, result_int, color_save_int, ZDbcIntfs,
  result_class, result_status_enum;

type

  { TColorSave }

  TColorSave = class (TInterfacedObject, IColorSave)
  private
    FConnection: IZConnection;
    function Update(AColor: IColorModel): IResult;
    function Insert(AColor: IColorModel): IResult;
  published
    constructor Create(AConnection: IZConnection);
    class function New(AConnection: IZConnection): IColorSave;
    function Execute(AColor: IColorModel): IResult;
  end;

implementation

{ TColorSave }

function TColorSave.Update(AColor: IColorModel): IResult;
var
  Params: TStringList;
begin
  try
    Params:=TStringList.Create;
    Params.Add(IntToStr(AColor.Id));
    Params.Add(AColor.Color.Name);
    if (FConnection.CreateStatementWithParams(Params).Execute('UPDATE color (id, name) VALUES ($1, $2);')) then
      Result:=TResult.Create(rsOk,'')
    else Result:=TResult.Create(rsError, '');
  finally
    Params.Free;
  end;
end;

function TColorSave.Insert(AColor: IColorModel): IResult;
var
  Params: TStringList;
begin
  try
    Params:=TStringList.Create;
    //Teste com 1
    Params.Add(IntToStr(1));
    Params.Add(AColor.Color.Name);
    if (FConnection.CreateStatementWithParams(Params).Execute('INSERT INTO color (id, name) VALUES ($1, $2);')) then
      Result:=TResult.Create(rsOk,'')
    else Result:=TResult.Create(rsError,Format('Ocurred an error inserting %s color', [AColor.Color.Name]));
  finally
    Params.Free;
  end;
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
begin
  try
    Params:=TStringList.Create;
    Params.Add(AColor.Color.Name);
    Id:=FConnection.CreateStatementWithParams(Params).ExecuteQuery('SELECT id FROM color WHERE name = $1').GetInt(1);

    if (Id > 0) then
      Result:=TResult.Create(rsOk, Format('Cor %s ja existe', [AColor.Color.Name]))
    else Result:=Insert(AColor);
  finally
    Params.Free;
  end;
end;

end.

