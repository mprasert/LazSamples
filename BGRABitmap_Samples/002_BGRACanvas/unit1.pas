unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  BGRABitmap, BGRABitmapTypes, BGRACanvas;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    procedure DrawShape(cv : TBGRACanvas);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

const
  kHorzBorder = 10;
  kVertBorder = 10;
  kWidth      = 420;
  kHeight     = 320;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  ControlStyle := ControlStyle + [csOpaque];
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  bgrabmp : TBGRABitmap;
begin
  bgrabmp := nil;
  try
    bgrabmp := TBGRABitmap.Create(kWidth,kHeight,ColorToBGRA(clBtnFace));
    //bgrabmp := TBGRABitmap.Create(kWidth,kHeight,BGRAWhite); // or BGRABlack
    //bgrabmp := TBGRABitmap.Create(kWidth,kHeight,BGRA(255,255,255));
    DrawShape(bgrabmp.CanvasBGRA);
    bgrabmp.Draw(Canvas,ClientRect);
  finally
    FreeAndNil(bgrabmp);
  end;
end;

procedure TForm1.DrawShape(cv: TBGRACanvas);
var
  x1, y1, x2, y2 : Integer;
begin
  // red rectangle
  x1 := kHorzBorder;
  y1 := kVertBorder;
  x2 := x1 + 90;
  y2 := y1 + 90;
  cv.Brush.Color := clRed;
  cv.Pen.Color := clRed;
  cv.Pen.Width := 3;
  cv.Rectangle(x1,y1,x2,y2);
  // yellow filled rectangle
  x1 := x1 + 100;
  x2 := x2 + 100;
  cv.Brush.Color := clYellow;
  cv.Rectangle(x1,y1,x2,y2);
  // green circle
  x1 := x1 + 100;
  x2 := x2 + 100;
  cv.Brush.Color := clGreen;
  cv.Pen.Color := clGreen;
  cv.Ellipse(x1,y1,x2,y2);
  // blue ellipse
  x1 := x1 + 100;
  x2 := x2 + 100;
  cv.Brush.Color := clBlue;
  cv.Pen.Color := clBlue;
  cv.Ellipse(x1,y1+10,x2,y2-10);
end;

end.

