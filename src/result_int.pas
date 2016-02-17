unit result_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, result_status_enum;

type

  { IResult }

  IResult = interface ['{053274F8-5B32-49B8-85B7-75FE9BB4086F}']
  function Status: TResultStatus;
  function Message: string;
  end;

implementation

end.

