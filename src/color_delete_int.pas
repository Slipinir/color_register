unit color_delete_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, result_int;

type
  IColorDelete = interface ['{1E9CAA93-E574-472A-8F47-8768D292D559}']
  function Execute(const AnId: Integer): IResult; overload;
  function Execute(const AName: string): IResult; overload;
  end;

implementation

end.

