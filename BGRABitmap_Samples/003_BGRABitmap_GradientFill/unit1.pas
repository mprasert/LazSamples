unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Spin, StdCtrls,
  BGRAVirtualScreen, BGRABitmap, {BCTypes,} BGRABitmapTypes;

type

  { TForm1 }

  TForm1 = class(TForm)
    BGRAVirtualScreen1: TBGRAVirtualScreen;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    procedure BGRAVirtualScreen1Redraw(Sender: TObject; Bitmap: TBGRABitmap);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BGRAVirtualScreen1Redraw(Sender: TObject; Bitmap: TBGRABitmap);
var
  c1, c2 : TBGRAPixel;
  gt : TGradientType;
  dm : TDrawMode;
  o1, o2 : TPointF;
begin
  c1 := ColorButton1.ButtonColor;
  c2 := ColorButton2.ButtonColor;
  gt := TGradientType(ComboBox1.ItemIndex);
  dm := TDrawMode(ComboBox2.ItemIndex);
  o1 := PointF(SpinEdit1.Value,SpinEdit2.Value);
  o2 := PointF(SpinEdit3.Value,SpinEdit4.Value);
  Bitmap.GradientFill(0,0,Bitmap.Width,Bitmap.Height,
                      c1,c2,
                      gt,
                      o1,o2,
                      dm);
end;

procedure TForm1.ColorButton1ColorChanged(Sender: TObject);
begin
  BGRAVirtualScreen1.DiscardBitmap;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BGRAVirtualScreen1.Caption := String.Empty;
end;

end.

