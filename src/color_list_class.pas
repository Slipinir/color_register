unit color_list_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, color_int, color_list_int;

type

  { TColorList }

  TColorList = class (TInterfacedPersistent, IColorList)
  private
    FList: array of IColor;
  published
    class function New(Colors: array of IColor): IColorList;
    function Add(AColor: IColor): Integer;
    function Count: Integer;
    procedure Assign(Source: IColorList); reintroduce;
    function Get(Index: Integer): IColor;
    procedure Put(Index: Integer; AValue: IColor);
  end;

implementation

{ TColorList }

function TColorList.Get(Index: Integer): IColor;
begin
  Result:=FList[Index];
end;

procedure TColorList.Put(Index: Integer; AValue: IColor);
begin
  FList[Index]:=AValue;
end;

class function TColorList.New(Colors: array of IColor): IColorList;
var
  I: Integer;
begin
  Result:=TColorList.Create;
  for I:=Low(Colors) to High(Colors) do
    Result.Add(Colors[I]);
end;

function TColorList.Add(AColor: IColor): Integer;
begin
  SetLength(FList, Length(FList)+1);
  Result:=Count-1;
  Flist[Result]:=AColor;
end;

function TColorList.Count: Integer;
begin
  Result:=Length(FList);
end;

procedure TColorList.Assign(Source: IColorList);
var
  I: Integer;
begin
  for I:=0 to Source.Count-1 do
    Add(Source.Get(I));
end;

end.

