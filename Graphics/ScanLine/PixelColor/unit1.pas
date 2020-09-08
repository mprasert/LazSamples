unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ExtDlgs;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Button1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private

  public

  end;

var
  Form1: TForm1;

implementation

uses
  LCLType;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    begin
      Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      Image1.Visible := True;
    end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Data24bit: PRGBTriple;
  Data32bit: PRGBQuad;
begin
  case Image1.Picture.Bitmap.PixelFormat of
    pf24bit:
      begin
        Data24bit := Image1.Picture.Bitmap.ScanLine[y];
        Label1.Caption := Format('Red=%0.3d , Green=%0.3d , Blue=%00.3d',
                                 [Data24bit[x].rgbtRed,Data24bit[x].rgbtGreen, Data24bit[x].rgbtBlue]);
      end;
    pf32bit:
      begin
        Data32bit := Image1.Picture.Bitmap.ScanLine[y];
        Label1.Caption := Format('Red=%0.3d , Green=%0.3d , Blue=%0.3d , Alpha=%0.3d',
                                 [Data32bit[x].rgbRed,Data32bit[x].rgbGreen,
                                  Data32bit[x].rgbBlue,Data32bit[x].rgbReserved]);
      end;
  end;

end;

end.

