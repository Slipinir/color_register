unit db_connection_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDbcIntfs;

type
  TIConnection = class (TZConnection, IZConnection);

implementation

end.

