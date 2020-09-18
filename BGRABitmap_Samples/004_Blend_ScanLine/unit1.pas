unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    PaintBox1: TPaintBox;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp1, bmp2, bmp3 : TBGRABitmap;
  p1, p2, p3 : PBGRAPixel;
  ix, iy : integer;
begin
  bmp1 := TBGRABitmap.Create(Image1.Picture.Bitmap);
  bmp2 := TBGRABitmap.Create(Image2.Picture.Bitmap);
  bmp3 := TBGRABitmap.Create(Image1.Width,Image1.Height);
  for iy := 0 to Image1.Height - 1 do
    begin
      p1 := bmp1.ScanLine[iy];
      p2 := bmp2.ScanLine[iy];
      p3 := bmp3.ScanLine[iy];
      for ix := 0 to Image1.Width - 1 do
        begin
          p3^.red   := round(p1^.red - ((p1^.red-p2^.red)/100*TrackBar1.Position));
          p3^.green := round(p1^.green - ((p1^.green-p2^.green)/100*TrackBar1.Position));
          p3^.blue  := round(p1^.blue - ((p1^.blue-p2^.blue)/100*TrackBar1.Position));
          p3^.alpha := round(p1^.alpha - ((p1^.alpha-p2^.alpha)/100*TrackBar1.Position));
          Inc(p1);
          Inc(p2);
          Inc(p3);
        end;
    end;
  bmp3.InvalidateBitmap;
  bmp3.Draw(PaintBox1.Canvas,0,0);
  //
  bmp1.Free;
  bmp2.Free;
  bmp3.Free;
end;

end.

