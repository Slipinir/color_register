unit color_delete_view_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, view_int;

type

  { TColorDeleteView }

  TColorDeleteView = class (TInterfacedObject, IView)
  public
    class function New: IView;
    procedure Show;
  end;

implementation

uses
  db_connection, color_delete_class;

{ TColorDeleteView }

class function TColorDeleteView.New: IView;
begin
  Result:=TColorDeleteView.Create;
end;

procedure TColorDeleteView.Show;
var
  AChosenOption: Integer;
  AName: string;
  AnId: Integer;
begin
  AChosenOption:=-1;
  while (AChosenOption <> 0) do
  begin
    Writeln('Color delete:');
    Writeln('Options:');
    Writeln('1-Id;');
    Writeln('2-Name;');
    Writeln('0-Cancel.');
    Writeln('Chosen option:');
    Readln(AChosenOption);
    case AChosenOption of
      1: begin
        Writeln('What is the color id?');
        Readln(AnId);
        Writeln(TColorDelete.New.Execute(AnId).Message);
      end;
      2: begin
        Writeln('What is the color name?');
        Readln(AName);
        Writeln(TColorDelete.New.Execute(AName).Message);
      end;
    end;
  end;
end;

end.

