unit color_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { IColor }

  IColor = interface
  ['{2DFB11A6-3F64-4695-8DC9-CB68502EBA86}']
  function GetName: string;
  procedure SetName(AValue: string);
  property Name: string read GetName write SetName;
  end;

implementation

end.

