unit color_listing_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, color_listing_int, integer_list_int, color_model_list_int,
  result_int, color_model_int, ZDbcIntfs;

type

  { TColorListing }

  TColorListing = class (TInterfacedObject, IColorListing)
  private
    FConnection: IZConnection;
    function QueryToColorModel(AQuery: IZResultSet): IColorModel;
  public
    constructor Create(AConnection: IZConnection);
    class function New(AConnection: IZConnection): IColorListing;
    function Execute(var AColorModelList: IColorModelList): IResult; overload;
    function Execute(const AnIdList: IIntegerList;
      var AColorModelList: IColorModelList): IResult; overload;
    function Execute(const AnId: Integer; var AColorModel: IColorModel):
        IResult; overload;
  end;

implementation

uses
  color_model_class, color_class, result_class, result_status_enum,
  messages_res;

{ TColorListing }

function TColorListing.QueryToColorModel(AQuery: IZResultSet): IColorModel;
begin
  Result:=TColorModel.New(
    TColor.Create(
      AQuery.GetStringByName('name')
    ),
    AQuery.GetIntByName('id')
  );
end;

constructor TColorListing.Create(AConnection: IZConnection);
begin
  FConnection:=AConnection;
end;

class function TColorListing.New(AConnection: IZConnection): IColorListing;
begin
  Result:=TColorListing.Create(AConnection);
end;

function TColorListing.Execute(var AColorModelList: IColorModelList): IResult;
var
  AQuery: IZResultSet;
begin
  try
    AQuery:=FConnection.CreateStatement.ExecuteQuery(
      'SELECT id, name FROM color;'
    );
    AQuery.First;
    if AQuery.GetIntByName('id') > 0 then
    begin
      repeat
        AColorModelList.Add(
          QueryToColorModel(AQuery)
        );
        AQuery.Next;
      until(AQuery.IsLast);
      AColorModelList.Add(
        QueryToColorModel(AQuery)
      );
      Result:=TResult.Create(
        rsOk,
        MesColorListingSuccessWithColors
      );
    end;
  except
    on E: Exception do
  end;

end;

function TColorListing.Execute(const AnIdList: IIntegerList;
  var AColorModelList: IColorModelList): IResult;
begin

end;

function TColorListing.Execute(const AnId: Integer; var AColorModel: IColorModel):
  IResult;
begin

end;

end.

