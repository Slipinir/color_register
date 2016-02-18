unit color_listing_int;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_model_int, color_int, integer_list_int,
  color_model_list_int, result_int;

type
  IColorListing = interface ['{EA3F6AFA-D891-485C-8EB1-95C6D612BBFD}']
  function Execute(var AColorModelList: IColorModelList): IResult; overload;
  function Execute(const AnIdList: IIntegerList; var AColorModelList: IColorModelList): IResult; overload;
  function Execute(const AnId: Integer; var AColorModel: IColorModel): IResult; overload;
  end;

implementation

end.

