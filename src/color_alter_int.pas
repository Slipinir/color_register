unit color_alter_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, result_int, color_int;

type
  IColorAlter = interface ['{FFC4C586-5229-4E90-AFB3-33D94D91BA50}']
  function Execute(const AnId: Integer; const AColor: IColor): IResult;
  function Execute(const AName: string; const AColor: IColor): IResult;
  end;

implementation

end.

