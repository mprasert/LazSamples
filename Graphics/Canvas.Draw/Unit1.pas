unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Bevel1: TBevel;
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
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PaintBox1: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure Image17Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Image17Click(Sender: TObject);
begin
  PaintBox1.Canvas.Draw(0,0,TImage(Sender).Picture.Graphic);
  case TControl(Sender).Tag of
     1 : Label27.Caption := Label1.Caption;
     2 : Label27.Caption := Label2.Caption;
     3 : Label27.Caption := Label3.Caption;
     4 : Label27.Caption := Label4.Caption;
     5 : Label27.Caption := Label5.Caption;
    11 : Label27.Caption := Label11.Caption;
    12 : Label27.Caption := Label12.Caption;
    13 : Label27.Caption := Label13.Caption;
    14 : Label27.Caption := Label14.Caption;
    15 : Label27.Caption := Label15.Caption;
    16 : Label27.Caption := Label16.Caption;
    17 : Label27.Caption := Label17.Caption;
    18 : Label27.Caption := Label18.Caption;
    19 : Label27.Caption := Label19.Caption;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PaintBox1.ControlStyle := PaintBox1.ControlStyle + [csOpaque];
end;

end.

