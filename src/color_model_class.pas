unit color_model_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, color_model_int, color_int;

type

  { TColorModel }

  TColorModel = class (TInterfacedObject, IColorModel)
  private
    FId: Integer;
    FColor: IColor;
  published
    constructor Create(AColor: IColor; AnId: Integer = 0);
    class function New(AColor: IColor; AnId: Integer = 0): IColorModel;
    function Id: Integer;
    function Color: IColor;
  end;

implementation

{ TColorModel }

constructor TColorModel.Create(AColor: IColor; AnId: Integer);
begin
  FColor:=AColor;
  FId:=AnId;
end;

class function TColorModel.New(AColor: IColor; AnId: Integer): IColorModel;
begin
  Result:=TColorModel.Create(AColor, AnId);
end;

function TColorModel.Id: Integer;
begin
  Result:=FId;
end;

function TColorModel.Color: IColor;
begin
  Result:=FColor;
end;

end.

