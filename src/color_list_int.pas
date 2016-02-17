unit color_list_int;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, color_int;

type

  { IColorList }

  IColorList = interface ['{F943850C-61D5-47FB-81C3-C629EC3CDE06}']
  function Add(AColor: IColor): Integer;
  function Count: Integer;
  function Get(Index: Integer): IColor;
  procedure Assign(Source: IColorList);
  procedure Put(Index: Integer; AValue: IColor);
  end;

implementation

end.

