unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
const
  dbname = 'test.s3db';
var
  conn : TSQLite3Connection;
  tran : TSQLTransaction;
  query : TSQLQuery;
begin
  // delete old db-file
  if FileExists(dbname) then DeleteFile(dbname);
  // set nil
  conn := nil;
  tran := nil;
  query := nil;
  try
    // create components
    conn := TSQLite3Connection.Create(nil);
    tran := TSQLTransaction.Create(nil);
    query := TSQLQuery.Create(nil);
    // set components property
    conn.DatabaseName := dbname;
    conn.Connected := True;
    tran.SQLConnection := conn;
    query.DataBase := conn;
    query.Transaction := tran;
    //
    query.SQL.Add(
      'CREATE TABLE SAMPLE (' +
      ' id INTEGER PRIMARY KEY,' +
      ' Name VARCHAR(50)'+
      ')');
    query.ExecSQL;
    //Use CommitRetainig to commit/save data on transaction and maintain connection open
    tran.CommitRetaining;
    conn.Connected := False;
  finally
    FreeAndNil(query);
    FreeAndNil(tran);
    FreeAndNil(conn);
  end;
end;

end.

