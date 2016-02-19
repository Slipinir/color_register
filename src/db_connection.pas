unit db_connection;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDbcIntfs;

var
 ZDbConnection: IZConnection;

implementation

uses
  ZURL, ZDbcPostgreSql;

var
  AnUrl: TZURL;

initialization
  try
    AnUrl:=TZURL.Create(
      'zdbc:postgresql-9://localhost:5432/color_register?' +
      'username=color_register_user;password=masterkey;AutoEncodeStrings=;' +
      'LibLocation=./libpq.dll',
      'localhost',
      5432,
      'color_register',
      'postgres',
      'masterkey',
      nil);

      DriverManager.RegisterDriver(PostgreSQLDriver);

      ZDbConnection:=DriverManager.GetDriver(
        'zdbc:postgresql-9:'
      ).Connect(
        AnUrl
      );
  finally
    AnUrl.Free;
  end;

finalization
  ZDbConnection:=nil;

end.

