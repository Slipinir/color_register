unit color_register_view_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_register_view_int, color_int;

type

  { TColorRegisterView }

  TColorRegisterView = class (TInterfacedObject, IColorRegisterView)
  public
    class function New: IColorRegisterView;
    procedure Show;
    procedure Save(const AColor: IColor);
  end;

implementation

uses
  color_save_class, color_class, color_model_class, db_connection_class;

{ TColorRegisterView }

class function TColorRegisterView.New: IColorRegisterView;
begin
  Result := TColorRegisterView.Create;
end;

procedure TColorRegisterView.Show;
var
  Answer: string;
  Name: string;
begin
  WriteLn('Color register:');
  Answer:='S';
  while (Answer='S') do
  begin
    Writeln('Do you want to register a color (Y/N)');
    ReadLn(Answer);
    Answer:=UpperCase(Answer[1]);

    if (Answer[1]='Y') then
    begin
      Writeln('What is its name?');
      Readln(Name);
      Save(TColor.Create(Name));
    end;
  end;
end;

procedure TColorRegisterView.Save(const AColor: IColor);
begin
  Writeln(
    TColorSave.New(
      DbConnection.ZDbConnection
    ).Execute(
      TColorModel.New(
        AColor
      )
    ).Message
  );
  ReadLn;
end;

end.

