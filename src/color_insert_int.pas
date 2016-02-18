unit color_insert_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_int, result_int;

type

  { IColorInsert }

  IColorInsert = interface ['{EBD1089B-0A96-412B-91A6-2C5516DBAF20}']
  function Execute(AColor: IColor): IResult;
  end;

implementation

end.

