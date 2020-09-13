unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, odbcconn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DBGrids, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox2: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ODBCConnection1: TODBCConnection;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //connection
  with ODBCConnection1 do
    begin
      Driver := 'Microsoft Access Driver (*.mdb, *.accdb)';
      Transaction := SQLTransaction1;
      Params.Clear;
      Params.Add('DBQ=.\test.mdb');      // or specify full path to mdb file
      Params.Add('Locale Identifier=1031');
      Params.Add('ExtendedAnsiSQL=1');
      Params.Add('CHARSET=ansi');
      //Connected := True;
      //KeepConnection := True;
    end;
  // Transaction
  with SQLTransaction1 do
    begin
      DataBase := ODBCConnection1;
      Action := caCommit;
      Active := True;
    end;
  // Query
  with SQLQuery1 do
    begin
      DataBase := ODBCConnection1;
      UsePrimaryKeyAsKey := False;
      //SQL.Text := 'select * from Customers';
      //Open;
    end;
  //
  Edit1.Text := String.Empty;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    begin
      Edit1.Text := OpenDialog1.FileName;
      SQLQuery1.Close;
      with ODBCConnection1 do
        begin
          Connected := False;
          Params.Clear;
          Params.Add('DBQ=' + Edit1.Text);
          Connected := True;
          KeepConnection := True;
        end;
      ComboBox2.Clear;
      ODBCConnection1.GetTableNames(ComboBox2.Items);
      try ComboBox2.ItemIndex := 0; except end;
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if SQLQuery1.Active then SQLQuery1.Close;
  if ODBCConnection1.Connected then ODBCConnection1.Connected := False;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ODBCConnection1.Connected and (ComboBox2.ItemIndex >= 0) then
    begin
      SQLQuery1.Close;;
      SQLQuery1.SQL.Text := 'select * from ' + ComboBox2.Text;
      SQLQuery1.Open;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if ODBCConnection1.Connected then
    begin
      SQLQuery1.Close;
      ODBCConnection1.Connected := False;
      Edit1.Text := String.Empty;
      ComboBox2.Clear;
    end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  SQLQuery1.Close;
end;

end.

