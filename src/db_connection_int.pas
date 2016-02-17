unit db_connection_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDbcIntfs;

type

  { IDbConnection }

  IDbConnection = interface ['{209F01C7-5364-4C84-9343-045C91CBFA77}']
  function ZDbConnection: IZConnection;
  end;

implementation

end.

