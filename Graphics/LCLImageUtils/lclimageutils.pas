unit LCLImageUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;


{ Functions }

function FlipHorz(bmp: TBitmap): Boolean;
function FlipVert(bmp: TBitmap): Boolean;
function GrayScale(bmp: TBitmap): Boolean;
function InvertBmp(bmp: TBitmap): Boolean;


implementation

uses
  LCLType;

function FlipHorz(bmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
  bitmap : TBitmap;
begin
  //case bmp.PixelFormat of
  case bmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf24bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcTriple := bmp.ScanLine[iy];
                dstTriple := bitmap.ScanLine[iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    dstTriple[bmp.Width - 1 - ix].rgbtRed   := srcTriple[ix].rgbtRed;
                    dstTriple[bmp.Width - 1 - ix].rgbtGreen := srcTriple[ix].rgbtGreen;
                    dstTriple[bmp.Width - 1 - ix].rgbtBlue  := srcTriple[ix].rgbtBlue;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    32 : begin  {pf32bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf32bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcQuad := bmp.ScanLine[iy];
                dstQuad := bitmap.ScanLine[iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    dstQuad[bmp.Width - 1 - ix].rgbRed      := srcQuad[ix].rgbRed;
                    dstQuad[bmp.Width - 1 - ix].rgbGreen    := srcQuad[ix].rgbGreen;
                    dstQuad[bmp.Width - 1 - ix].rgbBlue     := srcQuad[ix].rgbBlue;
                    dstQuad[bmp.Width - 1 - ix].rgbReserved := srcQuad[ix].rgbReserved;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function FlipVert(bmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
  bitmap : TBitmap;
begin
  //case bmp.PixelFormat of
  case bmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf24bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcTriple := bmp.ScanLine[iy];
                dstTriple := bitmap.ScanLine[bmp.Height - 1 - iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    dstTriple[ix].rgbtRed   := srcTriple[ix].rgbtRed;
                    dstTriple[ix].rgbtGreen := srcTriple[ix].rgbtGreen;
                    dstTriple[ix].rgbtBlue  := srcTriple[ix].rgbtBlue;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    32 : begin  {pf32bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf32bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcQuad := bmp.ScanLine[iy];
                dstQuad := bitmap.ScanLine[bmp.Height - 1 - iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    dstQuad[ix].rgbRed      := srcQuad[ix].rgbRed;
                    dstQuad[ix].rgbGreen    := srcQuad[ix].rgbGreen;
                    dstQuad[ix].rgbBlue     := srcQuad[ix].rgbBlue;
                    dstQuad[ix].rgbReserved := srcQuad[ix].rgbReserved;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function GrayScale(bmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
  bitmap : TBitmap;
  n : byte;
begin
  //case bmp.PixelFormat of
  case bmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf24bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcTriple := bmp.ScanLine[iy];
                dstTriple := bitmap.ScanLine[iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    n := trunc((srcTriple[ix].rgbtRed * 0.299) +
                               (srcTriple[ix].rgbtGreen * 0.587) +
                               (srcTriple[ix].rgbtBlue * 0.114));
                    dstTriple[ix].rgbtRed   := n;
                    dstTriple[ix].rgbtGreen := n;
                    dstTriple[ix].rgbtBlue  := n;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    32 : begin  {pf32bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf32bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcQuad := bmp.ScanLine[iy];
                dstQuad := bitmap.ScanLine[iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    n := trunc((srcQuad[ix].rgbRed * 0.299) +
                               (srcQuad[ix].rgbGreen * 0.587) +
                               (srcQuad[ix].rgbBlue * 0.114));
                    dstQuad[ix].rgbRed      := n;
                    dstQuad[ix].rgbGreen    := n;
                    dstQuad[ix].rgbBlue     := n;
                    dstQuad[ix].rgbReserved := srcQuad[ix].rgbReserved;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function InvertBmp(bmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
  bitmap : TBitmap;
begin
  //case bmp.PixelFormat of
  case bmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf24bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcTriple := bmp.ScanLine[iy];
                dstTriple := bitmap.ScanLine[iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    dstTriple[ix].rgbtRed   := 255 - srcTriple[ix].rgbtRed;
                    dstTriple[ix].rgbtGreen := 255 - srcTriple[ix].rgbtGreen;
                    dstTriple[ix].rgbtBlue  := 255 - srcTriple[ix].rgbtBlue;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    32 : begin  {pf32bit}
            bitmap := TBitmap.Create;
            bitmap.PixelFormat := pf32bit;
            bitmap.Width := bmp.Width;
            bitmap.Height := bmp.Height;
            bitmap.BeginUpdate;
            for iy := 0 to bmp.Height - 1 do
              begin
                srcQuad := bmp.ScanLine[iy];
                dstQuad := bitmap.ScanLine[iy];
                for ix := 0 to bmp.Width - 1 do
                  begin
                    dstQuad[ix].rgbRed      := 255 - srcQuad[ix].rgbRed;
                    dstQuad[ix].rgbGreen    := 255 - srcQuad[ix].rgbGreen;
                    dstQuad[ix].rgbBlue     := 255 - srcQuad[ix].rgbBlue;
                    dstQuad[ix].rgbReserved := srcQuad[ix].rgbReserved;
                  end;
              end;
            bitmap.EndUpdate;
            //bmp.Canvas.Draw(0,0,bitmap);
            bmp.Assign(bitmap);
            bitmap.Free;
            Result := True;
         end;
    else
      Result := False;
  end;
end;




end.

