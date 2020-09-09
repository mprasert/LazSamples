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
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

uses
  LCLImageUtils;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  //
  if Rotate90(Image1.Picture.Bitmap,Image2.Picture.Bitmap) then
    Image2.Invalidate;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Rotate180(Image1.Picture.Bitmap,Image2.Picture.Bitmap) then
    Image2.Invalidate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //
  if Rotate270(Image1.Picture.Bitmap,Image2.Picture.Bitmap) then
    Image2.Invalidate;
end;

end.

