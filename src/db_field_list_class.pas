unit db_field_list_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, db_field_int, db_field_list_int;

type

  { TDbFieldList }

  TDbFieldList = class (TInterfacedPersistent, IDbFieldList)
  private
    FList: array of IDbField;
  published
    class function New(Fields: array of IDbField): IDbFieldList;
    function Add(AColor: IDbField): Integer;
    function Count: Integer;
    function Get(Index: Integer): IDbField;
    procedure Assign(Source: IDbFieldList);
    procedure Put(Index: Integer; AValue: IDbField);
  end;

implementation

{ TDbFieldList }

class function TDbFieldList.New(Fields: array of IDbField): IDbFieldList;
var
  I: Integer;
begin
  for I:=Low(Fields) to High(Fields) do
    Result.Add(Fields[I]);
end;

function TDbFieldList.Add(AColor: IDbField): Integer;
begin
  SetLength(FList, Length(FList)+1);
  Result:=Count-1;
  FList[Result]:=AColor;
end;

function TDbFieldList.Count: Integer;
begin
  Result:=Length(FList)-1;
end;

function TDbFieldList.Get(Index: Integer): IDbField;
begin
  Result:=FList[Index];
end;

procedure TDbFieldList.Assign(Source: IDbFieldList);
var
  I: Integer;
begin
  for I:=0 to Source.Count-1 do
    Add(Source.Get(I));
end;

procedure TDbFieldList.Put(Index: Integer; AValue: IDbField);
begin
  FList[Index]:=AValue;
end;

end.
