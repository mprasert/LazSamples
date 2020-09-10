unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  LCLType, LCLImageUtils;

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
    FBmpData32 : TBitmapData32;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FBmpData32 := TBitmapData32.Create(Image1.Picture.Bitmap);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FBmpData32.Free;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  rgb32 : PRGBAQuad;
begin
  rgb32 := FBmpData32.Data[x,y];
  Label1.Caption := Format('R=%0.3d  G=%0.3d  B=%0.3d  A=%0.3d',
                           [rgb32^.Red,rgb32^.Green,rgb32^.Blue,rgb32^.Alpha]);
end;

end.

