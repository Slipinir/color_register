unit db_field_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  IDbField = interface ['{9BDFEBE2-8A0E-4882-AC6A-36EDB96F74CF}']
  function Name: string;
  function IsPrimaryKey: Boolean;
  function IsForeignKey: Boolean;
  end;

implementation

end.

