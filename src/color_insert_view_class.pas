unit color_insert_view_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, view_int;

type

  { TColorInsertView }

  TColorInsertView = class (TInterfacedObject, IView)
  public
    class function New: IView;
    procedure Show;
  end;

implementation

uses
  color_insert_class, color_class, messages_res;

{ TColorInsertView }

class function TColorInsertView.New: IView;
begin
  Result := TColorInsertView.Create;
end;

procedure TColorInsertView.Show;
var
  AnAnswer: string;
  AName: string;
begin
  WriteLn(MesColorInsertViewTitle);
  AnAnswer:=YES;
  while (AnAnswer=YES) do
  begin
    Writeln(MesColorInsertViewLoopQuestion);
    ReadLn(AnAnswer);
    AnAnswer:=UpperCase(AnAnswer[1]);

    if (AnAnswer = YES) then
    begin
      Writeln(MesColorInsertViewQuestion);
      Readln(AName);
      Writeln(
        TColorInsert.New.Execute(
          TColor.Create(
            AName
          )
        ).Message
      );
    end else Writeln(MesColorInsertViewExit);
  end;
end;

end.

