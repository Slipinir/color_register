unit color_model_list_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_model_list_int, color_model_int;

type

  { TColorModelList }

  TColorModelList = class (TInterfacedPersistent, IColorModelList)
  private
    FList: array of IColorModel;
  public
    function Add(AColor: IColorModel): Integer;
    function Count: Integer;
    function Get(Index: Integer): IColorModel;
    procedure Assign(Source: IColorModelList); reintroduce;
    procedure Put(Index: Integer; AValue: IColorModel);
  end;

implementation

{ TColorModelList }

function TColorModelList.Add(AColor: IColorModel): Integer;
begin
  SetLength(FList, Count+1);
  Result:=Count-1;
  FList[Result]:=AColor;
end;

function TColorModelList.Count: Integer;
begin
  Result:=Length(FList);
end;

function TColorModelList.Get(Index: Integer): IColorModel;
begin
  Result:=FList[Index];
end;

procedure TColorModelList.Assign(Source: IColorModelList);
var
  I: Integer;
begin
  for I:=0 to Count-1 do
    Add(Source.Get(I));
end;

procedure TColorModelList.Put(Index: Integer; AValue: IColorModel);
begin
  FList[Index]:=AValue;
end;

end.

