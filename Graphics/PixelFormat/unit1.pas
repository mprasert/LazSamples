unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  st : string;
begin
  if OpenPictureDialog1.Execute then
    begin
      Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      Label1.Caption := 'File - ' + ExtractFileName(OpenPictureDialog1.FileName);
      case Image1.Picture.Bitmap.PixelFormat of
        pf1bit  : st := '1 bit';
        pf4bit  : st := '4 bit';
        pf8bit  : st := '8 bit';
        pf15bit : st := '15 bit';
        pf16bit : st := '16 bit';
        pf24bit : st := '24 bit';
        pf32bit : st := '32 bit';
        else st := 'unknown';
      end;
      Label2.Caption := 'PixelFormat - ' + st;
    end;
end;

end.

