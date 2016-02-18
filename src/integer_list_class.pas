unit integer_list_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, integer_list_int;

type

  { TIntegerList }

  TIntegerList = class (TInterfacedPersistent, IIntegerList)
  private
    FList: array of Integer;
  public
    class function New(AIntegerList: array of Integer): IIntegerList;
    function Add(AnInteger: Integer): Integer;
    function Get(Index: Integer): Integer;
    function Count: Integer;
  end;

implementation

{ TIntegerList }

class function TIntegerList.New(AIntegerList: array of Integer): IIntegerList;
var
  I: Integer;
begin
  Result:=TIntegerList.Create;
  for I:=Low(AIntegerList) to High(AIntegerList) do
    Result.Add(AIntegerList[I]);
end;

function TIntegerList.Add(AnInteger: Integer): Integer;
begin
  SetLength(FList, Count+1);
  Result:=Count-1;
  FList[Result]:=AnInteger;
end;

function TIntegerList.Get(Index: Integer): Integer;
begin
  Result:=FList[Index];
end;

function TIntegerList.Count: Integer;
begin
  Result:=Length(FList);
end;

end.

