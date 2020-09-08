unit zunit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  InvertBmp(Image2.Picture.Bitmap);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  InvertBmp(Image1.Picture.Bitmap);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label1.Caption := Integer(Image2.Picture.Bitmap.PixelFormat).ToString;
  Label2.Caption := Integer(Image1.Picture.Bitmap.PixelFormat).ToString;
end;

end.

