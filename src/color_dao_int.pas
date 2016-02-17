unit color_dao_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_int, result_int;

type
  IColorDAO = interface ['{9E55ED59-F0C4-4A13-918C-9631F96ED21A}']
  function Save(const AColor: IColor): IResult;
  end;

implementation

end.

