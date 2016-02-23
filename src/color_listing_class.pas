unit color_listing_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_listing_int, color_model_list_int, result_int;

type

  { TColorListing }

  TColorListing = class (TInterfacedObject, IColorListing)
  public
    class function New: IColorListing;
    function Execute(var AColorModelList: IColorModelList): IResult; overload;
  end;

implementation

uses
  color_model_class, color_class, result_class, result_status_enum,
  messages_res, db_connection;

{ TColorListing }

class function TColorListing.New: IColorListing;
begin
  Result:=TColorListing.Create;
end;

function TColorListing.Execute(var AColorModelList: IColorModelList): IResult;
begin
  try
    with ZDbConnection.CreateStatement.ExecuteQuery(
        'SELECT id, name FROM color;'
      ) do
    begin
      First;
      if GetIntByName('id') > 0 then
      begin
        repeat
          AColorModelList.Add(
            TColorModel.New(
              TColor.Create(
                GetStringByName('name')
              ),
              GetIntByName('id')
            )
          );
          Next;
        until(IsAfterLast);
        Result:=TResult.Create(
          rsOk,
          MesColorListingSuccessWithColors
        );
      end;
    end;
  except
    on E: Exception do
  end;
end;

end.

