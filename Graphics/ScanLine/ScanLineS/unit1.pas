unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    FLineTriple : array of PRGBTriple;
    FLineQuad   : array of PRGBAQUAD;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  n : integer;
  srcTriple : PRGBTriple;
  srcQuad   : PRGBQUAD;
begin
  case Image1.Picture.Bitmap.PixelFormat of
    pf24bit :
      begin
        srcTriple := Image1.Picture.Bitmap.ScanLine[y];
        Label1.Caption := 'R' + IntToStr(srcTriple[x].rgbtRed);
        Label2.Caption := 'G' + IntToStr(srcTriple[x].rgbtGreen);
        Label3.Caption := 'B' + IntToStr(srcTriple[x].rgbtBlue);
        Label4.Caption := ''; //IntToStr(255);
      end;
    pf32bit :
      begin
        srcQuad := Image1.Picture.Bitmap.ScanLine[y];
        Label1.Caption := 'R' + IntToStr(srcQuad[x].rgbRed);
        Label2.Caption := 'G' + IntToStr(srcQuad[x].rgbGreen);
        Label3.Caption := 'B' + IntToStr(srcQuad[x].rgbBlue);
        Label4.Caption := 'A' + IntToStr(srcQuad[x].rgbReserved);
      end;
  end; // case
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  iy : integer;
begin
  case Image2.Picture.Bitmap.PixelFormat of
    pf24bit :
      begin
        SetLength(FLineTriple,Image2.Picture.Bitmap.Height-1);
        for iy := 0 to Image2.Picture.Bitmap.Height-1 do
          FLineTriple[iy] := Image2.Picture.Bitmap.ScanLine[iy];
      end;
    pf32bit :
      begin
        SetLength(FLineQuad,Image2.Picture.Bitmap.Height-1);
        for iy := 0 to Image2.Picture.Bitmap.Height-1 do
          FLineQuad[iy] := Image2.Picture.Bitmap.ScanLine[iy];
      end;
  end; // case
end;

procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  srcTriple : PRGBTriple;
  srcQuad   : PRGBAQUAD;
begin
  case Image2.Picture.Bitmap.PixelFormat of
    pf24bit :
      begin
        srcTriple := FLineTriple[y];
        Label5.Caption := 'R' + IntToStr(srcTriple[x].rgbtRed);
        Label6.Caption := 'G' + IntToStr(srcTriple[x].rgbtGreen);
        Label7.Caption := 'B' + IntToStr(srcTriple[x].rgbtBlue);
        Label8.Caption := 'A'; //IntToStr(255);
      end;
    pf32bit :
      begin
        srcQuad := FLineQuad[y];
        Label5.Caption := 'R' + IntToStr(srcQuad[x].Red);
        Label6.Caption := 'G' + IntToStr(srcQuad[x].Green);
        Label7.Caption := 'B' + IntToStr(srcQuad[x].Blue);
        Label8.Caption := 'A' + IntToStr(srcQuad[x].Alpha);
      end;
  end; // case

end;

end.

