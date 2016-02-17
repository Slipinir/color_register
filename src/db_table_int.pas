unit db_table_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db_field_list_int;

type

  { IDbTable }

  IDbTable = interface ['{855689DA-5A55-4EF6-A5AB-808E88583EDC}']
  function Name: string;
  function FieldList: IDbFieldList;
  end;

implementation

end.

