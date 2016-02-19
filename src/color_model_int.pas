unit color_model_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_int;

type

  { IColorModel }

  IColorModel = interface ['{CB6A8E20-F7E7-4BDD-B983-5B855517C332}']
  function GetId: Integer;
  procedure SetId(AValue: Integer);
  property Id: Integer read GetId write SetId;
  function Color: IColor;
  end;

implementation

end.

