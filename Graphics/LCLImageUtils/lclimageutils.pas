{---------------------------------------------------------------------}
{ LCLImageUtils for FreePascal Lazarus                                }
{---------------------------------------------------------------------}
{ base from VCLImageUtils by めもニャンだむ                           }
{ web : http://blog.livedoor.jp/junki560/                             }
{---------------------------------------------------------------------}
{ Adapt by Prasert Mongkolsuparut                                     }
{ 10 September 2020                                                   }
{---------------------------------------------------------------------}


unit LCLImageUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, LCLType;

type

  { TBitmapData32 }

  TBitmapData32 = class
  private
    sl : array of Pointer;
    FWidth, FHeight : integer;
    function GetData(x, y: integer):PRGBAQuad;
  protected
  public
    constructor Create(bmp: TBitmap);
    destructor Destroy; override;
    property Data[x, y: integer]: PRGBAQuad read GetData; default;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
  end;


  { TBitmapData24 }

  TBitmapData24 = class
  private
    sl : array of Pointer;
    FWidth, FHeight : integer;
    function GetData(x, y: integer):PRGBTriple;
  protected
  public
    constructor Create(bmp: TBitmap);
    destructor Destroy; override;
    property Data[x, y: integer]: PRGBTriple read GetData; default;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
  end;


  { TBitmapData8 }

  TBitmapData8 = class
  private
    sl : array of Pointer;
    FWidth, FHeight : integer;
    function GetData(x, y: integer):PByte;
  protected
  public
    constructor Create(bmp: TBitmap);
    destructor Destroy; override;
    property Data[x, y: integer]: PByte read GetData; default;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
  end;


  { TBitmapData1 }

  TBitmapData1 = class
  private
    sl : array of Pointer;
    FWidth, FHeight : integer;
    function GetData(x, y: integer):Boolean;
    procedure SetData(x, y: integer; value: Boolean);
  protected
  public
    constructor Create(bmp: TBitmap);
    destructor Destroy; override;
    property Data[x, y: integer]: Boolean read GetData write SetData; default;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
  end;


{ Functions }

function Emboss(srcbmp, dstbmp: TBitmap): Boolean;
function FlipHorz(srcbmp, dstbmp: TBitmap): Boolean;
function FlipVert(srcbmp, dstbmp: TBitmap): Boolean;
function GrayScale(srcbmp, dstbmp: TBitmap): Boolean;
function Invert(srcbmp, dstbmp: TBitmap): Boolean;
function Rotate90(srcbmp, dstbmp: TBitmap): Boolean;
function Rotate180(srcbmp, dstbmp: TBitmap): Boolean;
function Rotate270(srcbmp, dstbmp: TBitmap): Boolean;


implementation


{ TBitmapData32 }

function TBitmapData32.GetData(x, y: integer): PRGBAQuad;
begin
  result := sl[y];
  Inc(result, x);
end;

constructor TBitmapData32.Create(bmp: TBitmap);
var
  i: integer;
begin
  SetLength(sl, bmp.Height);
  for i := 0 to bmp.Height-1 do sl[i] := bmp.ScanLine[i];
  FWidth := bmp.Width;
  FHeight := bmp.Height;
end;

destructor TBitmapData32.Destroy;
begin
  inherited Destroy;
end;


{ TBitmapData24 }

function TBitmapData24.GetData(x, y: integer): PRGBTriple;
begin
  result := sl[y];
  Inc(result, x);
end;

constructor TBitmapData24.Create(bmp: TBitmap);
var
  i: integer;
begin
  SetLength(sl, bmp.Height);
  for i := 0 to bmp.Height-1 do sl[i] := bmp.ScanLine[i];
  FWidth := bmp.Width;
  FHeight := bmp.Height;
end;

destructor TBitmapData24.Destroy;
begin
  inherited Destroy;
end;


{ TBitmapData8 }

function TBitmapData8.GetData(x, y: integer): PByte;
begin
  result := sl[y];
  Inc(result, x);
end;

constructor TBitmapData8.Create(bmp: TBitmap);
var
  i: integer;
begin
  SetLength(sl, bmp.Height);
  for i := 0 to bmp.Height-1 do sl[i] := bmp.ScanLine[i];
  FWidth := bmp.Width;
  FHeight := bmp.Height;
end;

destructor TBitmapData8.Destroy;
begin
  inherited Destroy;
end;


{ TBitmapData1 }

function TBitmapData1.GetData(x, y: integer): Boolean;
var
  p: PByte;
begin
  p := sl[y];
  Inc(p, x div 8);
  result := (p^ shr (7-(x mod 8)) and 1) = 1;
end;

procedure TBitmapData1.SetData(x, y: integer; value: Boolean);
var
  p: PByte;
begin
  p := sl[y];
  Inc(p, x div 8);
  if value then
    p^ := p^ or (1 shl (7-(x mod 8)))
  else
    p^ := p^ and not (1 shl (7-(x mod 8)));
end;

constructor TBitmapData1.Create(bmp: TBitmap);
var
  i: integer;
begin
  SetLength(sl, bmp.Height);
  for i := 0 to bmp.Height-1 do sl[i] := bmp.ScanLine[i];
  FWidth := bmp.Width;
  FHeight := bmp.Height;
end;

destructor TBitmapData1.Destroy;
begin
  inherited Destroy;
end;



{ Functions }

function AdjustByte(value: integer): Byte;
begin
  if value < 0 then
    result := 0
  else if value > 255 then
    result := 255
  else
    result := value;
end;

function Emboss(srcbmp, dstbmp: TBitmap): Boolean;
var
  ix, iy, d, x, y : integer;
  srcTriple, dstTriple : array of PRGBTriple;
  srcQuad, dstQuad : array of PRGBQuad;
  tmpbmp : TBitmap;
begin
  Result := False;
  //case bmp.PixelFormat of
  case srcbmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            if not GrayScale(srcbmp,tmpbmp) then Exit;
            //
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf24bit;
            dstbmp.Width := tmpbmp.Width;
            dstbmp.Height := tmpbmp.Height;
            //
            for iy := 0 to tmpbmp.Height - 1 do
              begin
                srcTriple[iy] := tmpbmp.ScanLine[iy];
                dstTriple[iy] := dstbmp.ScanLine[iy];
              end;
            //
            for iy := 0 to tmpbmp.Height - 1 do
              begin
                for ix := 0 to tmpbmp.Width - 1 do
                  begin
                    d := - srcTriple[iy,ix].rgbtRed;
                    //
                    x := ix + 1;  y := iy + 1;
                    if (x > tmpbmp.Width - 1) then x := ix;
                    if (y > tmpbmp.Height - 1) then y := iy;
                    d := d + (2 * srcTriple[y,x].rgbtRed);
                    //
                    x := ix - 1;  y := iy - 1;
                    if (x < 0) then x := ix;
                    if (y < 0) then y := iy;
                    d := d + (2 * srcTriple[y,x].rgbtRed);
                    //
                    dstTriple[iy,ix].rgbtRed := AdjustByte(d+127);
                    dstTriple[iy,ix].rgbtGreen := AdjustByte(d+127);
                    dstTriple[iy,ix].rgbtBlue := AdjustByte(d+127);
                  end;
              end;
            dstbmp.EndUpdate;
            if Assigned(tmpbmp) then tmpbmp.Free;
            Result := True;
         end;
    32 : begin  {pf32bit}
            if not GrayScale(srcbmp,tmpbmp) then Exit;
            //
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf32bit;
            dstbmp.Width := srcbmp.Width;
            dstbmp.Height := srcbmp.Height;
            //
            for iy := 0 to tmpbmp.Height - 1 do
              begin
                srcQuad[iy] := tmpbmp.ScanLine[iy];
                dstQuad[iy] := dstbmp.ScanLine[iy];
              end;
            for iy := 0 to tmpbmp.Height - 1 do
              begin
                for ix := 0 to tmpbmp.Width - 1 do
                  begin
                    d := -srcQuad[iy,ix].rgbRed;
                    //
                    x := ix + 1;  y := iy + 1;
                    if (x > tmpbmp.Width - 1) then x := ix;
                    if (y > tmpbmp.Height - 1) then y := iy;
                    d := d + (2 * srcQuad[y,x].rgbRed);
                    //
                    x := ix - 1;  y := iy - 1;
                    if (x < 0) then x := ix;
                    if (y < 0) then y := iy;
                    d := d + (2 * srcQuad[y,x].rgbRed);
                    //
                    dstQuad[iy,ix].rgbRed := AdjustByte(d+127);
                    dstQuad[iy,ix].rgbGreen := AdjustByte(d+127);
                    dstQuad[iy,ix].rgbBlue := AdjustByte(d+127);
                    dstQuad[iy,ix].rgbReserved := srcQuad[iy,ix].rgbReserved;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    else
      Result := False;
  end;
end;


function FlipHorz(srcbmp, dstbmp: TBitmap): Boolean;
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
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcTriple := srcbmp.ScanLine[iy];
                dstTriple := dstbmp.ScanLine[iy];
                for ix := 0 to srcbmp.Width - 1 do
                  begin
                    dstTriple[srcbmp.Width - 1 - ix].rgbtRed   := srcTriple[ix].rgbtRed;
                    dstTriple[srcbmp.Width - 1 - ix].rgbtGreen := srcTriple[ix].rgbtGreen;
                    dstTriple[srcbmp.Width - 1 - ix].rgbtBlue  := srcTriple[ix].rgbtBlue;
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
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcQuad := srcbmp.ScanLine[iy];
                dstQuad := dstbmp.ScanLine[iy];
                for ix := 0 to srcbmp.Width - 1 do
                  begin
                    dstQuad[srcbmp.Width - 1 - ix].rgbRed      := srcQuad[ix].rgbRed;
                    dstQuad[srcbmp.Width - 1 - ix].rgbGreen    := srcQuad[ix].rgbGreen;
                    dstQuad[srcbmp.Width - 1 - ix].rgbBlue     := srcQuad[ix].rgbBlue;
                    dstQuad[srcbmp.Width - 1 - ix].rgbReserved := srcQuad[ix].rgbReserved;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function FlipVert(srcbmp, dstbmp: TBitmap): Boolean;
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
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcTriple := srcbmp.ScanLine[iy];
                dstTriple := dstbmp.ScanLine[srcbmp.Height - 1 - iy];
                for ix := 0 to srcbmp.Width - 1 do
                  begin
                    dstTriple[ix].rgbtRed   := srcTriple[ix].rgbtRed;
                    dstTriple[ix].rgbtGreen := srcTriple[ix].rgbtGreen;
                    dstTriple[ix].rgbtBlue  := srcTriple[ix].rgbtBlue;
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
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcQuad := srcbmp.ScanLine[iy];
                dstQuad := dstbmp.ScanLine[srcbmp.Height - 1 - iy];
                for ix := 0 to srcbmp.Width - 1 do
                  begin
                    dstQuad[ix].rgbRed      := srcQuad[ix].rgbRed;
                    dstQuad[ix].rgbGreen    := srcQuad[ix].rgbGreen;
                    dstQuad[ix].rgbBlue     := srcQuad[ix].rgbBlue;
                    dstQuad[ix].rgbReserved := srcQuad[ix].rgbReserved;
                  end;
              end;
            dstbmp.EndUpdate;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function GrayScale(srcbmp, dstbmp: TBitmap): Boolean;
var
  ix, iy : integer;
  srcTriple, dstTriple : PRGBTriple;
  srcQuad, dstQuad : PRGBQuad;
  n : byte;
begin
  //case bmp.PixelFormat of
  case srcbmp.RawImage.Description.BitsPerPixel of
    24 : begin  {pf24bit}
            if not Assigned(dstbmp) then dstbmp := TBitmap.Create;
            dstbmp.BeginUpdate;
            dstbmp.PixelFormat := pf24bit;
            dstbmp.Width := srcbmp.Width;
            dstbmp.Height := srcbmp.Height;
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcTriple := srcbmp.ScanLine[iy];
                dstTriple := dstbmp.ScanLine[iy];
                for ix := 0 to srcbmp.Width - 1 do
                  begin
                    n := trunc((srcTriple[ix].rgbtRed * 0.299) +
                               (srcTriple[ix].rgbtGreen * 0.587) +
                               (srcTriple[ix].rgbtBlue * 0.114));
                    dstTriple[ix].rgbtRed   := n;
                    dstTriple[ix].rgbtGreen := n;
                    dstTriple[ix].rgbtBlue  := n;
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
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcQuad := srcbmp.ScanLine[iy];
                dstQuad := dstbmp.ScanLine[iy];
                for ix := 0 to srcbmp.Width - 1 do
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
            dstbmp.EndUpdate;
            Result := True;
         end;
    else
      Result := False;
  end;
end;

function Invert(srcbmp, dstbmp: TBitmap): Boolean;
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
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcTriple := srcbmp.ScanLine[iy];
                dstTriple := dstbmp.ScanLine[iy];
                for ix := 0 to srcbmp.Width - 1 do
                  begin
                    dstTriple[ix].rgbtRed   := 255 - srcTriple[ix].rgbtRed;
                    dstTriple[ix].rgbtGreen := 255 - srcTriple[ix].rgbtGreen;
                    dstTriple[ix].rgbtBlue  := 255 - srcTriple[ix].rgbtBlue;
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
            for iy := 0 to srcbmp.Height - 1 do
              begin
                srcQuad := srcbmp.ScanLine[iy];
                dstQuad := dstbmp.ScanLine[iy];
                for ix := 0 to srcbmp.Width - 1 do
                  begin
                    dstQuad[ix].rgbRed      := 255 - srcQuad[ix].rgbRed;
                    dstQuad[ix].rgbGreen    := 255 - srcQuad[ix].rgbGreen;
                    dstQuad[ix].rgbBlue     := 255 - srcQuad[ix].rgbBlue;
                    dstQuad[ix].rgbReserved := srcQuad[ix].rgbReserved;
                  end;
              end;
            dstbmp.EndUpdate;
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

