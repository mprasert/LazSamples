unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DefaultTranslator, LCLTranslator,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

resourcestring
  HelloMessage = 'Hello World!';
  CloseMessage = 'Closing your app... bye bye!';

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
begin
  SetDefaultLang('en');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SetDefaultLang('th');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SetDefaultLang('cn');
end;

end.

