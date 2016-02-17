unit color_register_view_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, color_register_view_int, color_int;

type

  { TColorRegisterView }

  TColorRegisterView = class (TInterfacedObject, IColorRegisterView)
  published
    class function New: IColorRegisterView;
    procedure Show;
    procedure Save(const AColor: IColor);
  end;

implementation

uses
  color_save_class, color_class, ZDbcIntfs, color_model_class;

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
  Answer:='N';
  while (Answer='N') do
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
      DriverManager.GetConnection(
        'postgresql://color_register_user:masterkey@localhost/color_register'
      )
    ).Execute(
      TColorModel.New(
        AColor
      )
    ).Message
  );
//  AConnection.Database:=';
//  Writeln(TColorSave.New().Execute(AColor).Message);
end;

end.

