unit color_register_view;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, color_register_view_int;

type

  { TColorRegisterView }

  TColorRegisterView = class (TInterfacedObject, IColorRegisterView)
  published
    class function New: IColorRegisterView;
    procedure Show;
  end;

implementation

{ TColorRegisterView }

class function TColorRegisterView.New: IColorRegisterView;
begin
  Result := TColorRegisterView.Create;
end;

procedure TColorRegisterView.Show;
begin
  WriteLn('Color register view');
end;

end.
