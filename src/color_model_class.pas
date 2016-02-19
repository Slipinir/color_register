unit color_model_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_model_int, color_int;

type

  { TColorModel }

  TColorModel = class (TInterfacedObject, IColorModel)
  private
    FId: Integer;
    FColor: IColor;
    function GetId: Integer;
    procedure SetId(AValue: Integer);
  public
    constructor Create(AColor: IColor; AnId: Integer = 0);
    constructor Create;
    class function New(AColor: IColor; AnId: Integer = 0): IColorModel;
    function Color: IColor;
    property Id: Integer read GetId write SetId;
  end;

implementation

{ TColorModel }

procedure TColorModel.SetId(AValue: Integer);
begin
  if FId=AValue then Exit;
  FId:=AValue;
end;

function TColorModel.GetId: Integer;
begin
  Result:=FId;
end;

constructor TColorModel.Create(AColor: IColor; AnId: Integer);
begin
  FColor:=AColor;
  FId:=AnId;
end;

constructor TColorModel.Create;
begin

end;

class function TColorModel.New(AColor: IColor; AnId: Integer): IColorModel;
begin
  Result:=TColorModel.Create(AColor, AnId);
end;

function TColorModel.Color: IColor;
begin
  Result:=FColor;
end;

end.

