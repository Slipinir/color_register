unit messages_res;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  YES: string = 'Y';
  NO: string = 'N';

  MesColorInsertViewTitle: string = 'Color save:';
  MesColorInsertViewLoopQuestion: string = 'Do you want to insert a color (Y/N)';
  MesColorInsertViewQuestion: string = 'What is its name?';
  MesColorInsertViewExit: string =
    'Good bye little user! Farewell and travel safely!';

  MesColorMenuViewTitle: string = 'Color register menu:';

  MesColorInsertError: string =
    'Ocurred an error while inserting color %s.' + #13#10 +
    'Error Message: %s';
  MesColorInsertSuccess: string = '%s color was successfuly saved!';
  MesColorInsertAlreadyExists: string =
    'Color %s was not inserted because it already exists!';

  MesColorAlterSuccess: string = 'The color %s was successfully altered to %s!';
  MesColorAlterError: string =
    'Color %s was not altered because ocurred an error related to ' +
    'the database!' + #13#10 +
    'Error message: %s';
  MesColorAlterNameNotFound: string =
    'No color that has %s in the name was found!';
  MesColorMoreThanOneFound: string =
    'More than a color was found with the %s in their name, they are:';
  MesColorAlterIdNotFound: string =
    'The color with the Id %d wasn''t found!' + #13#10 +
    'Maybe you typed it wrong, check if it''s the case.';

  MesColorListingSuccessWithColors: string =
    'Hi-ho me bucko, all th'' colors were listed successfully!' + #13#10 +
    '(Hi my friend, all the colors were listed successfully!)';

implementation

end.

