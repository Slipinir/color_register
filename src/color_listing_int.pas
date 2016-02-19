unit color_listing_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_model_list_int, result_int;

type
  IColorListing = interface ['{EA3F6AFA-D891-485C-8EB1-95C6D612BBFD}']
  function Execute(var AColorModelList: IColorModelList): IResult;
  end;

implementation

end.

