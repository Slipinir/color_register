unit color_listing_view_class;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, view_int, color_model_list_int;

type

  { TColorListingView }

  TColorListingView = class (TInterfacedObject, IView)
  private
    type
      TOption = (opCancel, opAll, opById, opByMultipleIds);
    procedure ShowColorModelList(AColorModelList: IColorModelList);
    function GetOption: TOption;
  public
    class function New: IView;
    procedure Show;
  end;

implementation

uses
  messages_res, color_listing_class, color_model_int, integer_list_int,
  integer_list_class, color_model_class, color_model_list_class;

{ TColorListingView }

function TColorListingView.GetOption: TOption;
var
  AnOption: Integer;
begin
  Readln(AnOption);
  Result:=TOption(AnOption);
end;

procedure TColorListingView.ShowColorModelList(AColorModelList: IColorModelList
  );
var
  I: Integer;
begin
  Writeln(
    Format(
      '%2s %2s - %s',
      [
        '#',
        'Id',
        'Name'
      ]
    )
  );
  for I:=0 to AColorModelList.Count-1 do
    Writeln(
      Format(
        '%2d %2d - %s',
        [
          I+1,
          AColorModelList.Get(I).Id,
          AColorModelList.Get(I).Color.Name
        ]
      )
    );
end;

class function TColorListingView.New: IView;
begin
  Result:=TColorListingView.Create;
end;

procedure TColorListingView.Show;
var
  AnAnswer: string;
  AColorModelList: IColorModelList;
  AColorModel: IColorModel;
  AnOption: TOption;
  AnId: Integer;
  AnIdList: IIntegerList;
begin
  AnAnswer:='Y';
  while (AnAnswer[1]=YES) do
  begin
    AColorModelList:=TColorModelList.Create;
    AColorModel:=TColorModel.Create;
    Writeln('Color list options:');
    Writeln('1-All;');
    Writeln('2-Per Id;');
    Writeln('3-Per multiple Ids;');
    Writeln('0-Cancel.');
    Writeln('What is your chosen option?');
    AnOption:=GetOption;
    if (AnOption <> opCancel) then
    begin
      case AnOption of
        opAll: TColorListing.New.Execute(AColorModelList);
        opById: begin
          Writeln('Type an id:');
          Readln(AnId);
          TColorListing.New.Execute(
            AnId,
            AColorModel
          );
        end;
        opByMultipleIds: ;
      end;
      Writeln('Here they are:');
      ShowColorModelList(AColorModelList);
      Writeln('Do you want to list it again(Y/N)?');
      Readln(AnAnswer);
    end;
  end;
end;

end.

