unit color_menu_view_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, view_int;

type

  { TColorMenuView }

  TColorMenuView = class (TInterfacedObject, IView)
  private
    type
      TOption = (opExit, opInsert, opAlter, opDelete);
    function ChosenOption(AChosenOption: TOption): IView;
    function ReadOption: TOption;
  public
    class function New: IView;
    procedure Show;
  end;

implementation

uses
  color_insert_view_class, messages_res;

{ TColorMenuView }

function TColorMenuView.ChosenOption(AChosenOption: TOption) : IView;
begin
  case AChosenOption of
    opInsert: Result:=TColorInsertView.New;
    //opAlter: Result:=TColorAlterView.New;
    //opDelete: TColorDeleteView.New;
  end;
end;

function TColorMenuView.ReadOption: TOption;
var
  AChosenOption: Integer;
begin
  Writeln('1-Insert;');
  Writeln('2-Alter;');
  Writeln('3-Delete;');
  Writeln('4-List;');
  Writeln('0-Exit.');
  Writeln('Type the desired option: ');
  Readln(AChosenOption);

  Result:=TOption(AChosenOption);
end;

class function TColorMenuView.New: IView;
begin
  Result:=TColorMenuView.Create;
end;

procedure TColorMenuView.Show;
var
  AChosenOption: TOption;
begin
  AChosenOption:=ReadOption;
  while (AChosenOption<>opExit) do
  begin
    Writeln(MesColorMenuViewTitle);
    ChosenOption(AChosenOption).Show;
  end;
end;

end.

