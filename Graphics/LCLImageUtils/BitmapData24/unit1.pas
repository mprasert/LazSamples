unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, LCLType,
  LCLImageUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
  private
    FBmp24 : TBitmapData24;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FBmp24 := TBitmapData24.Create(Image1.Picture.Bitmap);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FBmp24.Free;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  prgb : PRGBTriple;
begin
  prgb := FBmp24.Data[x,y];
  Label1.Caption := Format('R=%0.3d  G=%0.3d  B=%0.3d',[prgb^.rgbtRed,prgb^.rgbtGreen,prgb^.rgbtBlue]);
end;

end.

