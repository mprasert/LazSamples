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
function Rotate90(srcbmp, dstbmp: TBitmap): Boolean;
function Rotate180(srcbmp, dstbmp: TBitmap): Boolean;
function Rotate270(srcbmp, dstbmp: TBitmap): Boolean;


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

function Rotate90(srcbmp, dstbmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
begin
  //case bmp.PixelFormat of
  case srcbmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf24bit;
            dstbmp.Width := srcbmp.Height;
            dstbmp.Height := srcbmp.Width;
            //
            for iy := 0 to dstbmp.Height - 1 do
              begin
                dstTriple := dstbmp.ScanLine[iy];
                for ix := 0 to dstbmp.Width - 1 do
                  begin
                    srcTriple := srcbmp.ScanLine[srcbmp.Height-1-ix];
                    dstTriple[ix].rgbtRed   := srcTriple[iy].rgbtRed;
                    dstTriple[ix].rgbtGreen := srcTriple[iy].rgbtGreen;
                    dstTriple[ix].rgbtBlue  := srcTriple[iy].rgbtBlue;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    32 : begin  {pf32bit}
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf32bit;
            dstbmp.Width := srcbmp.Height;
            dstbmp.Height := srcbmp.Width;
            //
            for iy := 0 to dstbmp.Height - 1 do
              begin
                dstQuad := dstbmp.ScanLine[iy];
                for ix := 0 to dstbmp.Width - 1 do
                  begin
                    srcQuad := srcbmp.ScanLine[srcbmp.Height-1-ix];
                    dstQuad[ix].rgbRed      := srcQuad[iy].rgbRed;
                    dstQuad[ix].rgbGreen    := srcQuad[iy].rgbGreen;
                    dstQuad[ix].rgbBlue     := srcQuad[iy].rgbBlue;
                    dstQuad[ix].rgbReserved := srcQuad[iy].rgbReserved;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function Rotate180(srcbmp, dstbmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
begin
  //case bmp.PixelFormat of
  case srcbmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf24bit;
            dstbmp.Width := srcbmp.Width;
            dstbmp.Height := srcbmp.Height;
            //
            for iy := 0 to dstbmp.Height - 1 do
              begin
                dstTriple := dstbmp.ScanLine[iy];
                srcTriple := srcbmp.ScanLine[srcbmp.Height-1-iy];
                for ix := 0 to dstbmp.Width - 1 do
                  begin
                    dstTriple[ix].rgbtRed   := srcTriple[srcbmp.Width-1-ix].rgbtRed;
                    dstTriple[ix].rgbtGreen := srcTriple[srcbmp.Width-1-ix].rgbtGreen;
                    dstTriple[ix].rgbtBlue  := srcTriple[srcbmp.Width-1-ix].rgbtBlue;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    32 : begin  {pf32bit}
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf32bit;
            dstbmp.Width := srcbmp.Width;
            dstbmp.Height := srcbmp.Height;
            //
            for iy := 0 to dstbmp.Height - 1 do
              begin
                dstQuad := dstbmp.ScanLine[iy];
                srcQuad := srcbmp.ScanLine[srcbmp.Height-1-iy];
                for ix := 0 to dstbmp.Width - 1 do
                  begin
                    dstQuad[ix].rgbRed      := srcQuad[srcbmp.Width-1-ix].rgbRed;
                    dstQuad[ix].rgbGreen    := srcQuad[srcbmp.Width-1-ix].rgbGreen;
                    dstQuad[ix].rgbBlue     := srcQuad[srcbmp.Width-1-ix].rgbBlue;
                    dstQuad[ix].rgbReserved := srcQuad[srcbmp.Width-1-ix].rgbReserved;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function Rotate270(srcbmp, dstbmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
begin
  //case bmp.PixelFormat of
  case srcbmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf24bit;
            dstbmp.Width := srcbmp.Height;
            dstbmp.Height := srcbmp.Width;
            //
            for iy := 0 to dstbmp.Height - 1 do
              begin
                dstTriple := dstbmp.ScanLine[iy];
                for ix := 0 to dstbmp.Width - 1 do
                  begin
                    srcTriple := srcbmp.ScanLine[ix];
                    dstTriple[ix].rgbtRed   := srcTriple[srcbmp.Width-1-iy].rgbtRed;
                    dstTriple[ix].rgbtGreen := srcTriple[srcbmp.Width-1-iy].rgbtGreen;
                    dstTriple[ix].rgbtBlue  := srcTriple[srcbmp.Width-1-iy].rgbtBlue;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    32 : begin  {pf32bit}
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf32bit;
            dstbmp.Width := srcbmp.Height;
            dstbmp.Height := srcbmp.Width;
            //
            for iy := 0 to dstbmp.Height - 1 do
              begin
                dstQuad := dstbmp.ScanLine[iy];
                for ix := 0 to dstbmp.Width - 1 do
                  begin
                    srcQuad := srcbmp.ScanLine[ix];
                    dstQuad[ix].rgbRed      := srcQuad[srcbmp.Width-1-iy].rgbRed;
                    dstQuad[ix].rgbGreen    := srcQuad[srcbmp.Width-1-iy].rgbGreen;
                    dstQuad[ix].rgbBlue     := srcQuad[srcbmp.Width-1-iy].rgbBlue;
                    dstQuad[ix].rgbReserved := srcQuad[srcbmp.Width-1-iy].rgbReserved;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    else
      Result := False;
  end;
end;


end.

