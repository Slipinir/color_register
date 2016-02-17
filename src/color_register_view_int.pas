unit color_register_view_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_int;

type

  { IColorRegisterView }

  IColorRegisterView = interface ['{A54632E7-8000-44AF-92BD-2E35636917B2}']
  procedure Show;
  procedure Save(const AColor: IColor);
  end;

implementation

end.

