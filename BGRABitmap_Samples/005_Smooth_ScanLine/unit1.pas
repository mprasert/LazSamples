unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

uses
  BGRABitmap, BGRABitmapTypes;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);   // smooth vertical
var
  bmpSrc, bmpDst : TBGRABitmap;
  pasrc, padst : array of PBGRAPixel;
  psrc1, psrc2, psrc3, pdst : PBGRAPixel;
  ix, iy : Integer;
begin
  bmpSrc := nil;
  bmpDst := nil;
  try
    bmpSrc := TBGRABitmap.Create(Image1.Picture.Bitmap);
    bmpDst := TBGRABitmap.Create(Image1.Width,Image1.Height);
    SetLength(pasrc,Image1.Height);
    SetLength(padst,Image1.Height);
    for iy := 0 to Image1.Height - 1 do
      begin
        pasrc[iy] := bmpSrc.ScanLine[iy];
        padst[iy] := bmpDst.ScanLine[iy];
      end;
    for iy := 0 to Image1.Height - 1 do
      begin
        if (iy > 0) then psrc1 := pasrc[iy-1];
        psrc2 := pasrc[iy];
        if (iy < Image1.Height - 1) then psrc3 := pasrc[iy+1];
        pdst := padst[iy];
        for ix := 0 to Image1.Width - 1 do
          begin
            if (iy = 0) then
              begin
                pdst^.red   := (psrc2^.red + psrc3^.red) div 2;
                pdst^.green := (psrc2^.green + psrc3^.green) div 2;
                pdst^.blue  := (psrc2^.blue + psrc3^.blue) div 2;
                Inc(pdst);
                Inc(psrc2);
                Inc(psrc3);
              end
            else if (iy = Image1.Height - 1) then
              begin
                pdst^.red   := (psrc1^.red + psrc2^.red) div 2;
                pdst^.green := (psrc1^.green + psrc2^.green) div 2;
                pdst^.blue  := (psrc1^.blue + psrc2^.blue) div 2;
                Inc(pdst);
                Inc(psrc1);
                Inc(psrc2);
              end
            else
              begin
                pdst^.red   := (psrc1^.red + psrc2^.red + psrc3^.red) div 3;
                pdst^.green := (psrc1^.green + psrc2^.green + psrc3^.green) div 3;
                pdst^.blue  := (psrc1^.blue + psrc2^.blue + psrc3^.blue) div 3;
                Inc(pdst);
                Inc(psrc1);
                Inc(psrc2);
                Inc(psrc3);
              end;
          end;
      end;
    bmpDst.InvalidateBitmap;
    bmpDst.Draw(PaintBox1.Canvas,0,0);
  finally
    FreeAndNil(bmpSrc);
    FreeAndNil(bmpDst);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);  // smooth horizontal
var
  bmpSrc, bmpDst : TBGRABitmap;
  psrc, pdst : PBGRAPixel;
  ix, iy : Integer;
  r, g, b : word;
begin
  bmpSrc := nil;
  bmpDst := nil;
  try
    bmpSrc := TBGRABitmap.Create(Image1.Picture.Bitmap);
    bmpDst := TBGRABitmap.Create(Image1.Width,Image1.Height);
    for iy := 0 to Image1.Height - 1 do
      begin
        psrc := bmpSrc.ScanLine[iy];
        pdst := bmpDst.ScanLine[iy];
        for ix := 0 to Image1.Width - 1 do
          begin
            if (ix = 0) then
              begin
                r := psrc^.red;  g := psrc^.green;  b := psrc^.blue;
                Inc(psrc);
                r := r + psrc^.red;  g := g + psrc^.green;  b := b + psrc^.blue;
                //Dec(psrc);
                pdst^.red := r div 2;  pdst^.green := g div 2;  pdst^.blue := b div 2;
                //Inc(psrc);
                Inc(pdst);
              end
            else if (ix = Image1.Width - 1) then
              begin
                r := psrc^.red;  g := psrc^.green;  b := psrc^.blue;
                Dec(psrc);
                r := r + psrc^.red;  g := g + psrc^.green;  b := b + psrc^.blue;
                pdst^.red := r div 2;  pdst^.green := g div 2;  pdst^.blue := b div 2;
              end
            else
              begin
                Dec(psrc);
                r := psrc^.red;  g := psrc^.green;  b := psrc^.blue;
                Inc(psrc);
                r := r + psrc^.red;  g := g + psrc^.green;  b := b + psrc^.blue;
                Inc(psrc);
                r := r + psrc^.red;  g := g + psrc^.green;  b := b + psrc^.blue;
                //Dec(psrc);
                pdst^.red := r div 3;  pdst^.green := g div 3;  pdst^.blue := b div 3;
                //Inc(psrc);
                Inc(pdst);
              end;
          end;
      end;
    bmpDst.InvalidateBitmap;
    bmpDst.Draw(PaintBox1.Canvas,0,0);
  finally
    FreeAndNil(bmpSrc);
    FreeAndNil(bmpDst);
  end;
end;

end.

