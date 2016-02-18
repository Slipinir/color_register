unit color_alter_view_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, view_int;

type

  { TColorAlterView }

  TColorAlterView = class (TInterfacedObject, IView)
  private
    function AskAColorName: string;
  public
    class function New: IView;
    procedure Show;
  end;

implementation

uses
  db_connection_class, color_alter_class;

{ TColorAlterView }

function TColorAlterView.AskAColorName: string;
begin
  Writeln('Little one, what is the name of the color you want to alter?');
  Readln(Result);
end;

class function TColorAlterView.New: IView;
begin
  Result:=TColorAlterView.Create;
end;

procedure TColorAlterView.Show;
begin

end;

end.

