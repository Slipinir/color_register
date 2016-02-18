unit integer_list_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  IIntegerList = interface ['{203D34D9-F6A4-4A5C-8E46-EBE66B83686B}']
  function Add(AnInteger: Integer): Integer;
  function Get(Index: Integer): Integer;
  function Count: Integer;
  end;

implementation

end.

