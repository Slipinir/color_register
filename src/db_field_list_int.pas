unit db_field_list_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db_field_int;

type
  IDbFieldList = interface ['{C8D6A081-6449-46E1-8640-1EA085DAF7C2}']
  function Add(AColor: IDbField): Integer;
  function Count: Integer;
  function Get(Index: Integer): IDbField;
  procedure Assign(Source: IDbFieldList);
  procedure Put(Index: Integer; AValue: IDbField);
  end;

implementation

end.

