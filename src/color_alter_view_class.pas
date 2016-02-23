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
  AnOption: Integer;
  AColorId: Integer;
begin
  Writeln('Alter color:');
  AnOption:=-1;
  while (AnOption <> 0) do
  begin
    Writeln('Alter by:');
    Writeln('1-Id;');
    Writeln('2-Name;');
    Writeln('0-Cancel.');
    Readln(AnOption);
    case AnOption of
      1: begin
        Writeln('What is the id of the color you want to alter?');
        Readln(AColorId);
        Writeln('What is its new name?');
        Readln(AColorNewName);
        Writeln(
          TColorAlter.New.Execute(
            AColorId,
            TColor.Create(
              AColorNewName
            )
          ).Message
        );
      end;
      2: begin
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
    end;
  end;
end;

end.

