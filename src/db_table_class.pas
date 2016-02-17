unit db_table_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, db_table_int, db_field_class, db_field_list_int,
  db_field_list_class;

type

  { TDbTable }

  TDbTable = class (TInterfacedObject, IDbTable)
  private
    FName: string;
    FFieldList: IDbFieldList;
  published
    constructor Create;
    function Name: string;
    function FieldList: IDbFieldList;
  end;

implementation

{ TDbTable }

constructor TDbTable.Create;
begin
  FFieldList:=TDbFieldList.New(
    [TDbField.Create('id', True),
     TDbField.Create('name')]
  );
end;

function TDbTable.Name: string;
begin
  Result:=FName;
end;

function TDbTable.FieldList: IDbFieldList;
begin
  Result:=FFieldList;
end;

end.

