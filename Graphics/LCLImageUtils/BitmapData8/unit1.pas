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
    FBmpData8 : TBitmapData8;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FBmpData8 := TBitmapData8.Create(Image1.Picture.Bitmap);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FBmpData8.Free;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  rgb8 : PByte;
begin
  rgb8 := FBmpData8.Data[x,y];
  Label1.Caption := IntToStr(rgb8^);
end;

end.

