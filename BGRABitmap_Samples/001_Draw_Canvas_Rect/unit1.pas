unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  BGRABitmap, BGRABitmapTypes;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    PaintBox1: TPaintBox;
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
  bgra : TBGRABitmap;
begin
  bgra := nil;
  try
    bgra := TBGRABitmap.create(Image1.Picture.Bitmap);
    //bgra.AntialiasingDrawMode := dmLinearBlend;
    bgra.Draw(PaintBox1.Canvas,PaintBox1.ClientRect);
  finally
    FreeAndNil(bgra);
  end;
end;

end.

