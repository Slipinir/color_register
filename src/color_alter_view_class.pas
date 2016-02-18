unit color_alter_view_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, view_int;

type

  { TColorAlterView }

  TColorAlterView = class (TInterfacedObject, IView)
  public
    class function New: IView;
    procedure Show;
  end;

implementation

{ TColorAlterView }

class function TColorAlterView.New: IView;
begin
  Result:=TColorAlterView.Create;
end;

procedure TColorAlterView.Show;
var

begin

end;

end.

