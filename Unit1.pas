unit Unit1;

// id3-Tag Demo
// http://www.swissdelphicenter.ch

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  shellapi, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    titel: TLabel;
    artist: TLabel;
    album: TLabel;
    year: TLabel;
    comment: TLabel;
    genre: TLabel;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Label7: TLabel;
    procedure Label7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

Type
TID3Tag = record
ID:string[3];
Titel:string[30];
Artist:string[30];
Album:string[30];
Year:string[4];
Comment:string[30];
Genre:byte;
end;
var
ID3Tag:TID3Tag;

procedure Lese_ID3Tag(Filename:string);
var Buffer:array[1..128] of char;
F:File;
begin
AssignFile(F, Filename);
Reset(F,1);
Seek(F,FileSize(F)-128);
BlockRead(F, Buffer, SizeOf(Buffer));
CloseFile(F);
with ID3Tag do begin
ID:=copy(Buffer,1,3);
Titel:=copy(Buffer,4,30);
Artist:=copy(Buffer,34,30);
Album:=copy(Buffer,64,30);
Year:=copy(Buffer,94,4);
Comment:=copy(Buffer,98,30);
Genre:=ord(Buffer[128]);
end;
end;

{$R *.DFM}



procedure TForm1.Label7Click(Sender: TObject);
begin
 shellexecute(handle,'open','http://www.swissdelphicenter.ch','','',1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if OpenDialog1.Execute then begin
 Lese_ID3Tag(OpenDialog1.FileName);
 titel.Caption:=ID3Tag.Titel;
 artist.Caption:=ID3Tag.Artist;
 album.Caption:=ID3Tag.Album;
 year.Caption:=ID3Tag.Year;
 comment.Caption:=ID3Tag.Comment;
 genre.Caption:=IntToStr(ID3Tag.Genre);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
end;

end.
