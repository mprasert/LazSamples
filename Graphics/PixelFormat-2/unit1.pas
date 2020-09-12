unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function GetPixelFormatString(pf:TPixelFormat):string;
begin
  case pf of
    pf1bit : Result := '1';
    pf24bit : Result := '24';
    pf32bit : Result := '32';
  else
    Result := 'n/a';
  end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
{
  Label1.Caption := Label1.Caption + '  PF = ' + Image1.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label2.Caption := Label2.Caption + '  PF = ' + Image2.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label3.Caption := Label3.Caption + '  PF = ' + Image3.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label4.Caption := Label4.Caption + '  PF = ' + Image4.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label5.Caption := Label5.Caption + '  PF = ' + Image5.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label11.Caption := Label11.Caption + '  PF = ' + Image11.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label12.Caption := Label12.Caption + '  PF = ' + Image12.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label13.Caption := Label13.Caption + '  PF = ' + Image13.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label14.Caption := Label14.Caption + '  PF = ' + Image14.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label15.Caption := Label15.Caption + '  PF = ' + Image15.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label16.Caption := Label16.Caption + '  PF = ' + Image16.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label17.Caption := Label17.Caption + '  PF = ' + Image17.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label18.Caption := Label18.Caption + '  PF = ' + Image18.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
  Label19.Caption := Label19.Caption + '  PF = ' + Image19.Picture.Bitmap.RawImage.Description.BitsPerPixel.ToString;
}

  Label1.Caption := Label1.Caption + '  PF = ' + GetPixelFormatString(Image1.Picture.Bitmap.PixelFormat);
  Label2.Caption := Label2.Caption + '  PF = ' + GetPixelFormatString(Image2.Picture.Bitmap.PixelFormat);
  Label3.Caption := Label3.Caption + '  PF = ' + GetPixelFormatString(Image3.Picture.Bitmap.PixelFormat);
  Label4.Caption := Label4.Caption + '  PF = ' + GetPixelFormatString(Image4.Picture.Bitmap.PixelFormat);
  Label5.Caption := Label5.Caption + '  PF = ' + GetPixelFormatString(Image5.Picture.Bitmap.PixelFormat);
  Label11.Caption := Label11.Caption + '  PF = ' + GetPixelFormatString(Image11.Picture.Bitmap.PixelFormat);
  Label12.Caption := Label12.Caption + '  PF = ' + GetPixelFormatString(Image12.Picture.Bitmap.PixelFormat);
  Label13.Caption := Label13.Caption + '  PF = ' + GetPixelFormatString(Image13.Picture.Bitmap.PixelFormat);
  Label14.Caption := Label14.Caption + '  PF = ' + GetPixelFormatString(Image14.Picture.Bitmap.PixelFormat);
  Label15.Caption := Label15.Caption + '  PF = ' + GetPixelFormatString(Image15.Picture.Bitmap.PixelFormat);
  Label16.Caption := Label16.Caption + '  PF = ' + GetPixelFormatString(Image16.Picture.Bitmap.PixelFormat);
  Label17.Caption := Label17.Caption + '  PF = ' + GetPixelFormatString(Image17.Picture.Bitmap.PixelFormat);
  Label18.Caption := Label18.Caption + '  PF = ' + GetPixelFormatString(Image18.Picture.Bitmap.PixelFormat);
  Label19.Caption := Label19.Caption + '  PF = ' + GetPixelFormatString(Image19.Picture.Bitmap.PixelFormat);
end;

end.

