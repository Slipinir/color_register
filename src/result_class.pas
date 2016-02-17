unit result_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, result_int, result_status_enum;

type

  { TResult }

  TResult = class(TInterfacedObject, IResult)
  private
    FStatus: TResultStatus;
    FMessage: string;
  published
    constructor Create(const AStatus: TResultStatus; const AMessage: string);
    function Status: TResultStatus;
    function Message: string;
  end;

implementation

{ TResult }

constructor TResult.Create(const AStatus: TResultStatus; const AMessage: string);
begin
  FStatus:=AStatus;
  FMessage:=AMessage;
end;

function TResult.Status: TResultStatus;
begin
  Result:=FStatus;
end;

function TResult.Message: string;
begin
  Result:=FMessage;
end;

end.

