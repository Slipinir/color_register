unit color_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_int;

type

  { TColor }

  TColor = class(TInterfacedObject, IColor)
  private
    FName: string;
    function GetName: string;
    procedure SetName(AValue: string);
  public
    constructor Create(AName: string);
    property Name: string read GetName write SetName;
  end;

implementation

{ TColor }

function TColor.GetName: string;
begin
  Result:=FName;
end;

procedure TColor.SetName(AValue: string);
begin
  if FName=AValue then Exit;
  FName:=AValue;
end;

constructor TColor.Create(AName: string);
begin
  FName:=AName;
end;

end.

