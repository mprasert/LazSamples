unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    PopupMenu1: TPopupMenu;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Timer1StartTimer(Sender: TObject);
    procedure Timer1StopTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Fhour, FMinute, FSecond : Integer;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Show;
end;

procedure TForm1.FormWindowStateChange(Sender: TObject);
begin
  if WindowState = wsMinimized then
    begin
      WindowState := wsNormal;
      Hide;
      ShowInTaskBar := stNever;
      TrayIcon1.Show;
    end
  else if WindowState = wsNormal then
    begin
      WindowState := wsMinimized;
      Show;
      ShowInTaskBar := stNever;
      TrayIcon1.Hide;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Height := 164;
  Panel1.Font.Color := clRed;
  Fhour := 0;  FMinute := 0;  FSecond := 0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // start
  Timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // stop
  Timer1.Enabled := False;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  // Reset
  Timer1.Enabled := False;
  Fhour := 0;  FMinute := 0;  FSecond := 0;
  Panel1.Caption := '00 : 00 : 00';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  // Hide
  WindowState := wsMinimized;
  FormWindowStateChange(Self);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  // Exit
  Close;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  // hour - plus
  if not(Timer1.Enabled) and (Fhour < 24) then
    begin
      Inc(Fhour);
      Panel1.Caption := Format('%0.2d : %0.2d : %0.2d',[Fhour,FMinute,FSecond]);
    end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  // hour - minus
  if not(Timer1.Enabled) and (Fhour > 0) then
    begin
      Dec(Fhour);
      Panel1.Caption := Format('%0.2d : %0.2d : %0.2d',[Fhour,FMinute,FSecond]);
    end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  // minute - plus
  if not(Timer1.Enabled) and (FMinute < 59) then
    begin
      Inc(FMinute);
      Panel1.Caption := Format('%0.2d : %0.2d : %0.2d',[Fhour,FMinute,FSecond]);
    end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  // minute - minus
  if not(Timer1.Enabled) and (FMinute > 0) then
    begin
      Dec(FMinute);
      Panel1.Caption := Format('%0.2d : %0.2d : %0.2d',[Fhour,FMinute,FSecond]);
    end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  // second - plus
  if not(Timer1.Enabled) and (FSecond < 59) then
    begin
      Inc(FSecond);
      Panel1.Caption := Format('%0.2d : %0.2d : %0.2d',[Fhour,FMinute,FSecond]);
    end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  // second - minus
  if not(Timer1.Enabled) and (FSecond > 0) then
    begin
      Dec(FSecond);
      Panel1.Caption := Format('%0.2d : %0.2d : %0.2d',[Fhour,FMinute,FSecond]);
    end;
end;

procedure TForm1.Timer1StartTimer(Sender: TObject);
begin
  Panel1.Font.Color := clBlue;
end;

procedure TForm1.Timer1StopTimer(Sender: TObject);
begin
  Panel1.Font.Color := clRed;
  if (Self.Visible = False)and(Fhour = 0)and(FMinute = 0)and(FSecond = 0) then
    begin
      Sleep(5000);
      Application.ProcessMessages;
      Self.Show;
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Dec(FSecond);
  if (FSecond < 0) then
    begin
      Dec(FMinute);
      if (FMinute < 0) then
        begin
          Dec(Fhour);
          if (Fhour < 0) then
            begin
              Fhour := 0;  FMinute := 0;  FSecond := 0;
              Panel1.Caption  := '00 : 00 : 00';
              TrayIcon1.ShowBalloonHint;
              Application.ProcessMessages;
              Timer1.Enabled := False;
              Exit;
            end;
          FMinute := 59;
        end;
      FSecond := 59;
    end;
  Panel1.Caption := Format('%0.2d : %0.2d : %0.2d',[Fhour,FMinute,FSecond]);
end;

end.

