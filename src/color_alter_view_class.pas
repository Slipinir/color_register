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

uses
  color_alter_class, db_connection, color_class;

{ TColorAlterView }

class function TColorAlterView.New: IView;
begin
  Result:=TColorAlterView.Create;
end;

procedure TColorAlterView.Show;
var
  AColorName: string;
  AColorNewName: string;
begin
  Writeln('Alter color:');
  Writeln('What is the name of the color you want to alter?');
  Readln(AColorName);
  Writeln('What is its new name?');
  Readln(AColorNewName);
  Writeln(
    TColorAlter.New.Execute(
      AColorName,
      TColor.Create(
        AColorNewName
      )
    ).Message
  );
end;

end.

