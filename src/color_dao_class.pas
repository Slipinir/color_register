unit color_dao_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, result_int, result_class, color_dao_int,
  result_status_enum, color_int, ZConnection, ZDataset, db_table_int,
  db_field_int, ZDbcIntfs;

type

  { TColorDAO }

  TColorDAO = class (TInterfacedObject, IColorDAO)
  private
    FConnection: TZConnection;
    FQuery: TZQuery;
    FTable: IDbTable;
  public
    constructor Create(const AConnection: IZConnection; const ATable: IDbTable);
    function Save(const AColor: IColor): IResult;
  end;

implementation

{ TColorDAO }

constructor TColorDAO.Create(const AConnection: IZConnection;
  const ATable: IDbTable);
var
  TestConnection: IZConnection;
begin
  TestConnection:=TZConnection.Create(nil);
//  FConnection:=AConnection;
  FTable:=ATable;
  FQuery:=TZQuery.Create(nil);
  FQuery.Connection:=FConnection;
end;

function TColorDAO.Save(const AColor: IColor): IResult;
var
  I: Integer;
begin
  for I:=0 to FTable.FieldList.Count do
  begin
    FTable.FieldList.Get(I).Name;
    Writeln(Format('Still has work to do %s', [AColor.Name]));
    Result:=TResult.Create(rsOk, '');
  end;
end;

end.

