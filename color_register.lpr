program color_register;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, color_int, color_class, color_register_view_int,
  color_register_view_class, color_list_class, result_int, result_status_enum,
  result_class, db_table_int, db_field_list_class, db_table_class,
  db_field_list_int, color_save_int, color_save_class, color_model_class,
  db_connection_int, db_connection_class;

type

  { TColorRegister }

  TColorRegister = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TColorRegister }

procedure TColorRegister.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  TColorRegisterView.New.Show;

  // stop program loop
  Terminate;
end;

constructor TColorRegister.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TColorRegister.Destroy;
begin
  inherited Destroy;
end;

procedure TColorRegister.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TColorRegister;
begin
  Application:=TColorRegister.Create(nil);
  Application.Title:='Color Register';
  Application.Run;
  Application.Free;
end.

