unit db_connection_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db_connection_int;

var
  DbConnection: IDbConnection;

implementation

uses
  ZDbcIntfs, ZURL, ZDbcPostgreSql;

type

  { TDbConnection }

  TDbConnection = class (TInterfacedObject, IDbConnection)
  private
    FZConnection: IZConnection;
  public
    constructor Create;
    function ZDbConnection: IZConnection;
  end;

{ TDbConnection }

constructor TDbConnection.Create;
var
  Url: TZURL;
begin
  try
    Url:=TZURL.Create(
      'zdbc:postgresql-9://localhost:5432/color_register?' +
      'username=color_register_user;password=masterkey;AutoEncodeStrings=;' +
      'LibLocation=C:\Users\luizcarlos\Documents\color_register\libpq.dll',
      'localhost',
      5432,
      'color_register',
      'postgres',
      'masterkey',
      nil);

      FZConnection:=DriverManager.GetDriver(
        'zdbc:postgresql-9:'
      ).Connect(
        Url
      );
  finally
    Url.Free;
  end;
end;

function TDbConnection.ZDbConnection: IZConnection;
begin
  Result:=FZConnection;
end;

initialization
  DbConnection:=TDbConnection.Create;

finalization
  DbConnection:=nil;

end.

