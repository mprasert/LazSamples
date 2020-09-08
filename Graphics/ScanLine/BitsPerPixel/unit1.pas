unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
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
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PaintBox1: TPaintBox;
    PaintBox10: TPaintBox;
    PaintBox11: TPaintBox;
    PaintBox12: TPaintBox;
    PaintBox13: TPaintBox;
    PaintBox14: TPaintBox;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    PaintBox4: TPaintBox;
    PaintBox5: TPaintBox;
    PaintBox6: TPaintBox;
    PaintBox7: TPaintBox;
    PaintBox8: TPaintBox;
    PaintBox9: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox10Paint(Sender: TObject);
    procedure PaintBox11Paint(Sender: TObject);
    procedure PaintBox12Paint(Sender: TObject);
    procedure PaintBox13Paint(Sender: TObject);
    procedure PaintBox14Paint(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure PaintBox3Paint(Sender: TObject);
    procedure PaintBox4Paint(Sender: TObject);
    procedure PaintBox5Paint(Sender: TObject);
    procedure PaintBox6Paint(Sender: TObject);
    procedure PaintBox7Paint(Sender: TObject);
    procedure PaintBox8Paint(Sender: TObject);
    procedure PaintBox9Paint(Sender: TObject);
  private
    procedure Draw(cv:TCanvas; img:TImage; x,y:Integer);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

type
  // 24 bit image types
  Trgb24 = packed record
    b,g,r : byte;
  end;
  Trgb24scanline = array [word] of Trgb24;
  Prgb24scanline = ^Trgb24scanline;

  // 32 bit image types
  Trgb32 = packed record
    b,g,r,a: byte;
  end;
  Trgb32scanline = packed array[word] of Trgb32;
  Prgb32scanline = ^Trgb32scanline;


{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  n : integer;
begin
  Image1.Picture.LoadFromFile('.\img\pic_4.gif');
  n := Image1.Picture.Bitmap.RawImage.Description.BitsPerPixel;
  Label2.Caption := n.ToString + ' Bit per Pixel';

  Image2.Picture.LoadFromFile('.\img\pic_8.gif');
  n := Image2.Picture.Bitmap.RawImage.Description.BitsPerPixel;
  Label5.Caption := n.ToString + ' Bit per Pixel';

  Image3.Picture.LoadFromFile('.\img\pic_24.bmp');
  n := Image3.Picture.Bitmap.RawImage.Description.BitsPerPixel;
  Label8.Caption := n.ToString + ' Bit per Pixel';

  Image4.Picture.LoadFromFile('.\img\pic_24.jpg');
  n := Image4.Picture.Bitmap.RawImage.Description.BitsPerPixel;
  Label11.Caption := n.ToString + ' Bit per Pixel';

  Image5.Picture.LoadFromFile('.\img\pic_24.png');
  n := Image5.Picture.Bitmap.RawImage.Description.BitsPerPixel;
  Label14.Caption := n.ToString + ' Bit per Pixel';

  Image6.Picture.LoadFromFile('.\img\pic_32.bmp');
  n := Image6.Picture.Bitmap.RawImage.Description.BitsPerPixel;
  Label17.Caption := n.ToString + ' Bit per Pixel';

  Image7.Picture.LoadFromFile('.\img\pic_32.png');
  n := Image7.Picture.Bitmap.RawImage.Description.BitsPerPixel;
  Label20.Caption := n.ToString + ' Bit per Pixel';

end;

procedure TForm1.PaintBox10Paint(Sender: TObject);
begin
  Draw(TPaintBox(Sender).Canvas,Image3,0,0);
end;

procedure TForm1.PaintBox11Paint(Sender: TObject);
begin
  Draw(TPaintBox(Sender).Canvas,Image4,0,0);
end;

procedure TForm1.PaintBox12Paint(Sender: TObject);
begin
  Draw(TPaintBox(Sender).Canvas,Image5,0,0);
end;

procedure TForm1.PaintBox13Paint(Sender: TObject);
begin
  Draw(TPaintBox(Sender).Canvas,Image6,0,0);
end;

procedure TForm1.PaintBox14Paint(Sender: TObject);
begin
  Draw(TPaintBox(Sender).Canvas,Image7,0,0);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  TPaintBox(Sender).Canvas.Draw(0,0,Image1.Picture.Bitmap);
end;

procedure TForm1.PaintBox2Paint(Sender: TObject);
begin
  TPaintBox(Sender).Canvas.Draw(0,0,Image2.Picture.Bitmap);
end;

procedure TForm1.PaintBox3Paint(Sender: TObject);
begin
  TPaintBox(Sender).Canvas.Draw(0,0,Image3.Picture.Bitmap);
end;

procedure TForm1.PaintBox4Paint(Sender: TObject);
begin
  TPaintBox(Sender).Canvas.Draw(0,0,Image4.Picture.Bitmap);
end;

procedure TForm1.PaintBox5Paint(Sender: TObject);
begin
  TPaintBox(Sender).Canvas.Draw(0,0,Image5.Picture.Bitmap);
end;

procedure TForm1.PaintBox6Paint(Sender: TObject);
begin
  TPaintBox(Sender).Canvas.Draw(0,0,Image6.Picture.Bitmap);
end;

procedure TForm1.PaintBox7Paint(Sender: TObject);
begin
  TPaintBox(Sender).Canvas.Draw(0,0,Image7.Picture.Bitmap);
end;

procedure TForm1.PaintBox8Paint(Sender: TObject);
begin
  Draw(TPaintBox(Sender).Canvas,Image1,0,0);
end;

procedure TForm1.PaintBox9Paint(Sender: TObject);
begin
  Draw(TPaintBox(Sender).Canvas,Image2,0,0);
end;

procedure TForm1.Draw(cv: TCanvas; img: TImage; x, y: Integer);
var
  bmp : TBitmap;
  bpp : integer;
  source24bit : Prgb24scanline;
  source32bit : Prgb32scanline;
  dest24bit   : Prgb24scanline;
  nx, ny : integer;
begin
  bmp := nil;
  try
    bmp := TBitmap.Create;
    bmp.PixelFormat := pf24bit;
    bmp.Width := img.Picture.Bitmap.Width;
    bmp.Height := img.Picture.Bitmap.Height;
    bpp := img.Picture.Bitmap.RawImage.Description.BitsPerPixel;
    if bpp = 24 then
      begin
        for ny := 0 to bmp.Height - 1 do
          begin
            dest24bit := bmp.ScanLine[ny];
            source24bit := img.Picture.Bitmap.ScanLine[ny];
            for nx := 0 to bmp.Width - 1 do
              begin
                dest24bit^[nx] := source24bit^[nx];
              end;
          end;
      end
    else if bpp = 32 then
      begin
        for ny := 0 to bmp.Height - 1 do
          begin
            dest24bit := bmp.ScanLine[ny];
            source32bit := img.Picture.Bitmap.ScanLine[ny];
            for nx := 0 to bmp.Width - 1 do
              begin
                dest24bit^[nx].b := source32bit^[nx].b;
                dest24bit^[nx].g := source32bit^[nx].g;
                dest24bit^[nx].r := source32bit^[nx].r;
              end;
          end;
      end;
    cv.Draw(x,y,bmp);
  finally
    FreeAndNil(bmp);
  end;
end;

end.

