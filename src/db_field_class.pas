unit db_field_class;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils, db_field_int;

type

  { TDbField }

  TDbField = class (TInterfacedObject, IDbField)
  private
    FName: string;
    FIsPrimaryKey: Boolean;
    FIsForeignKey: Boolean;
  published
    constructor Create(const AName: string; const IsPrimaryKey: Boolean = False;
      const IsForeignKey: Boolean = False);
    function Name: string;
    function IsPrimaryKey: Boolean;
    function IsForeignKey: Boolean;
  end;

implementation

{ TDbField }

constructor TDbField.Create(const AName: string; const IsPrimaryKey: Boolean = False;
 const IsForeignKey: Boolean = False);
begin
  FName:=AName;
  Self.FIsPrimaryKey:=IsPrimaryKey;
  Self.FIsForeignKey:=IsForeignKey;
end;

function TDbField.Name: string;
begin
  Result:=FName;
end;

function TDbField.IsPrimaryKey: Boolean;
begin
  Result:=FIsPrimaryKey;
end;

function TDbField.IsForeignKey: Boolean;
begin
  Result:=FIsForeignKey;
end;

end.

