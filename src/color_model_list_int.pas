unit color_model_list_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_model_int;

type

  { IColorModelList }

  IColorModelList = interface ['{C1FBB185-4E47-4B38-8094-FBBE8D0ED4AD}']
  function Add(AColor: IColorModel): Integer;
  function Get(Index: Integer): IColorModel;
  function Count: Integer;
  procedure Assign(Source: IColorModelList);
  procedure Put(Index: Integer; AValue: IColorModel);
  end;

implementation

end.

