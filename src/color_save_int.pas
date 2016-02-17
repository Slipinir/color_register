unit color_save_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_model_int, result_int;

type

  { IColorSave }

  IColorSave = interface ['{EBD1089B-0A96-412B-91A6-2C5516DBAF20}']
  function Execute(AColor: IColorModel): IResult;
  end;

implementation

end.

