unit color_model_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_int;

type
  IColorModel = interface ['{CB6A8E20-F7E7-4BDD-B983-5B855517C332}']
  function Id: Integer;
  function Color: IColor;
  end;

implementation

end.

