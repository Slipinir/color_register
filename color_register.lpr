program color_register;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, color_int, color_class, color_list_class,
  result_int, result_status_enum, result_class, color_model_class,
  color_menu_view_class, color_alter_int, messages_res, color_insert_class,
  color_alter_class, color_alter_view_class, color_listing_int,
  color_model_list_int, color_model_list_class, color_list_int,
  integer_list_int, integer_list_class, color_listing_class, color_model_int,
  color_listing_view_class, db_connection, color_delete_int, color_delete_class,
  color_delete_view_class;

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

  TColorMenuView.New.Show;

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

