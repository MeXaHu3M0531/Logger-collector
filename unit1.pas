unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls, Grids, ComObj, LCLProc,LazUtf8 ;

type
  dat = record
    name: string[10];
    shortName:string[8];
    maxTemp: real;
    minTemp: real;
    srTemp: real;
    srKvadTemp: real;
    maxVl: real;
    minVl: real;
    srVl: real;
    porogMin:real;
    porogMax:real;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit1: TEdit;
    Export: TMenuItem;
    Zagruzka: TMenuItem;
    Nazv_zagr: TLabel;
    Persent: TLabel;
    Nazv_per: TLabel;
    Sbros: TMenuItem;
    New_room: TButton;
    Tabl: TStringGrid;
    Vtabl: TButton;
    Datsik: TEdit;
    Label3: TLabel;
    Setik: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Import: TMenuItem;
    New_tabl: TMenuItem;
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImportClick(Sender: TObject);
    procedure New_roomClick(Sender: TObject);
    procedure New_tablClick(Sender: TObject);
    procedure SbrosClick(Sender: TObject);
    procedure SetikClick(Sender: TObject);
    procedure VtablClick(Sender: TObject);
    procedure DatsikChange(Sender: TObject);
    procedure DatsikKeyPress(Sender: TObject; var Key: char);
    procedure Label1Click(Sender: TObject);
    procedure VihodClick(Sender: TObject);
    procedure ZagruzkaClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  mas:array[0..1000] of dat;
  f:file of dat;
  t,t1:textfile;
  name:integer;
  row:integer;
  k:integer;
  Excel: Variant;
  c:array[1..17] of string;
  l:array[1..17] of byte;
  porogMin:string;
  porogMax:string;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.VihodClick(Sender: TObject);
begin

end;

procedure TForm1.ZagruzkaClick(Sender: TObject);
var s:string[6];
  flag:boolean;
  d:dat;
  i,j:integer;
  h,h1:string;
  b:boolean;
begin
  assignfile(t, 'zagr.txt');
  reset(t);
  assignfile(f, 'base.dat');
  reset(t);
  reset(f);
  b:=true;
  Nazv_zagr.Visible:=true;
  Persent.Visible:=true;
  Nazv_per.Visible:=true;
  while not eof(t) do
    begin
      if b then
        begin
          read(t,s);
          b:=false;
        end
      else
        readLn(t,s);
      flag:=true;
     // showmessage(s);
     seek(f,0);
     i:=0;
     if s[1]='!' then
       begin
   tabl.cells[11,row]:=porogMin;
   tabl.cells[12,row]:=porogMax;
   row:=row +1;
   k:=k+1;
   tabl.rowcount:=tabl.rowcount+1;;
   tabl.cells[0,row]:='-';
   tabl.cells[1,row]:=s;
   tabl.cells[2,row]:='-';
   tabl.cells[3,row]:='-';
   tabl.cells[4,row]:='-';
   tabl.cells[5,row]:='-';
   tabl.cells[6,row]:='-';
   tabl.cells[7,row]:='-';
   tabl.cells[8,row]:='-';
   tabl.cells[9,row]:='-';
   tabl.cells[10,row]:='-';
       end
   else
    begin
      while not(eof(f)) do
        begin
          read(f,d);
          h:=d.shortname;
          for j:=0 to 3 do
         // h1:=h1+h[length(h)-j];
          if (((h=s) {or (h1=s))} and flag))  then
            begin
              flag:=false;
              //showmessage(s);
              row:=row +1;
              tabl.rowcount:=tabl.rowcount+1;
              tabl.cells[0,row]:=inttostr(tabl.rowcount-31-k+1);
              tabl.cells[1,row]:=d.name;
              tabl.cells[3,row]:='-';
              tabl.Cells[2,row]:=d.shortname;
              tabl.cells[4,row]:=floattostr(d.maxtemp);
              tabl.cells[5,row]:=floattostr(d.mintemp);
              tabl.cells[6,row]:=floattostr(d.srtemp);
              tabl.cells[7,row]:=floattostr(d.srkvadtemp);
              porogMin:=floattostr(d.porogMin);
              porogMax:=floattostr(d.porogMax);
              if (abs(d.maxVl)>0.1) then
                begin
                  tabl.cells[8,row]:=floattostr(d.MaxVl);
                  tabl.cells[9,row]:=floattostr(d.minVl);
                  tabl.cells[10,row]:=floattostr(d.srVl);
                end
              else
                 begin
                  tabl.cells[8,row]:='-';
                  tabl.cells[9,row]:='-';
                  tabl.cells[10,row]:='-';
                 end;
            end;
          i:=i+1;
          setik.caption:=inttostr(i);
          seek(f,i);
        end;
      if flag then
        begin
        row:=row +1;
        tabl.rowcount:=tabl.rowcount+1;
        tabl.cells[0,row]:=inttostr(tabl.rowcount-31-k);
        tabl.cells[1,row]:='Empty';
        tabl.cells[2,row]:=s;
        tabl.cells[3,row]:='-';
        tabl.cells[4,row]:='-';
        tabl.cells[5,row]:='-';
        tabl.cells[6,row]:='-';
        tabl.Cells[7,row]:='-';
        tabl.cells[8,row]:='-';
        tabl.cells[9,row]:='-';
        tabl.Cells[10,row]:='-'; ;
        persent.caption:=inttostr(strtoint(persent.caption)+1);
      //  showmessage(persent.caption);

    end;
    end;
    end;
  closefile(f);
      closefile(t);
  showmessage('Ok!');
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.VtablClick(Sender: TObject);
var i,j,m,l:integer;
  s:string;
begin
 l:=0;
 assignfile(t,'tabl.txt');
 rewrite(t);
 for j:=0 to (tabl.rowCount-1) do  //i - ??????????????, j - ????????????!!!!
   begin
   for i:=0 to (tabl.colCount-1) do
     begin
     s:=tabl.Cells[i,j];
     Write(t, s);
     Write(t,' ');
     end;
   writeLn(t,'');
   end;
 ShowMessage('Ok!');
 closefile(t);
end;

procedure TForm1.FormCreate(Sender: TObject);
var m:longint;
begin
 row:=1;
 k:=0;
 c[1]:='?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? : ';
 l[1]:=length(c[1]);
 c[2]:='?? ?? ?? ???? ?? ?? ?? ?? ?? ?? ?? ??            ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? : ';
 l[2]:=length(c[2]);
 c[3]:='?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ????             ?? ?? ?? ?? ?? ?? ?? ?? ?? : ';
 l[3]:=length(c[3]);
 c[4]:='C?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??           ?? ?? ?? ?? :';
 l[4]:=length(c[4]);
 c[5]:='?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ???? ?? ??         ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? :';
 l[5]:=length(c[5]);
 c[6]:='???????????????? ??????????: ';
 l[6]:=length(c[6]);
 c[7]:='                                         ??????????????????????';
 l[7]:=length(c[7]);
 c[8]:='                         ????????????????????????';
 l[8]:=length(c[8]);
 c[9]:='?????????????????? ????????????????????                                   ??????????????????????                                          ??????????????????????';                   //
 l[9]:=length(c[9]);
 c[10]:='CKT(???H 83,144):';
 l[10]:=length(c[10]);
 c[11]:='?????????????????????? ??????????????????????: ';
 l[11]:=length(c[11]);
 c[12]:='???????????????????????? ??????????????????????: ';
 l[12]:=length(c[12]);
 c[13]:='?????????????????????? ???????????????????? : ';
 l[13]:=length(c[13]);
 c[14]:='?????????????? ????????????????????????';
 l[14]:=length(c[14]);
 c[15]:='???????????????? ???: ';
 l[15]:=length(c[15]);
 c[16]:='?? ?? ?? ?? ?? ?? ?? ?? ??';
 l[15]:=length(c[15]);
 c[17]:='?? ?? ?? ?? ?? ?? ?? ?? ??';
 l[15]:=length(c[15]);
end;

procedure TForm1.ExportClick(Sender: TObject);
var d:dat;
  i:integer;
begin
  AssignFile(f, 'base.dat');
  AssignFile(t, 'export.txt');
  reset(f);
  rewrite(t);
  i:=0;
  while not(eof(f)) do
    begin
      seek(f,i);
      read(f,d);
      write(t,d.name);
      write(t, ' ');
      write(t,d.shortname);
      write(t, ' ');
      write(t,floattostr(d.maxTemp));
      write(t, ' ');
      write(t,floattostr(d.minTemp));
      write(t, ' ');
      write(t,floattostr(d.srTemp));
      write(t, ' ');
      write(t,floattostr(d.srKvadTemp));
      write(t, ' ');
      if ( abs(d.maxVl) < 0.1 ) then
        begin;
          write(t,'-');
          write(t, ' ');
          write(t,'-');
          write(t, ' ');
          writeln(t,'-');
        end
      else
        begin

          write(t,floattostr(d.maxVl));
          write(t, ' ');
          write(t,floattostr(d.minVl));
          write(t, ' ');
          writeln(t,floattostr(d.srVl));
        end;
      i:=i+1;
    end;
  closefile(f);
  closefile(t);
  showmessage('?????????????? ????????????????!')
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin

end;

procedure TForm1.ImportClick(Sender: TObject);
var i,j:integer;
  m,n,s:string;
  d:dat;
  flag:boolean;
  x:integer;
  b:byte;
  se:integer;
begin
  AssignFile(f, 'base.dat');
  AssignFile(t, 'svalka.txt');
  reset(f);
  reset(t);
  Nazv_zagr.visible:=true;
  Persent.visible:=true;
  Nazv_per.visible:=true;
  setik.visible:=true;
  i:=0;
  j:=0;
  b:=0;
  se:=0;
  flag:=false;
  while not (eof(t)) do
    begin
      readln(t,s);
      setlength(s,255);
      m:='';
      n:='';
      j:=0;
      if b<>0 then
        begin
        //  showmessage('??????????????');
          while s[70+j]=' ' do
            j:=j+1;
          while s[70+j]<>' ' do
            begin
              m:=m+s[70+j];
              j:=j+1;
            end;
          //showmessage(m);
          j:=0;
          while s[90+j]=' ' do
            begin
            j:=j+1;
          //  showmessage(s[135+j]);
            end;
        //  showmessage(s[60+j]);
          while s[90+j]<>' ' do
            begin
              n:=n+s[90+j];
              j:=j+1;
            end;
         // showmessage(n);
          case b of
            7: begin
                // showmessage(inttostr(b));
                 if m<>'' then
                   d.minTemp:=strtofloat(m);
                 if n<>'' then
                   d.minVl:=strtofloat(n);
               end;
            8: begin
                // showmessage(inttostr(b));
                 if m<>'' then
                   d.MaxTemp:=strtofloat(m);
                 if n<>'' then
                   d.MaxVl:=strtofloat(n);
                end;
            9: begin
                 //showmessage(inttostr(b));
                 if m<>'' then
                   d.srTemp:=strtofloat(m);
                 if n<>'' then
                   d.srVl:=strtofloat(n);
                end;
            end;
        end;
      b:=0;
      {if (s[1]='!') then

          begin
            if ( (s[2]='n') and (s[3]='o') and (s[4]='m') and (s[5]='e') and (s[6]='r') ) then     // (s[]='') and
              begin
              d.name:=s[8]+s[9]+s[10]+s[11]+s[12]+s[13]+s[14]+s[15]+s[16]+s[17];
              d.shortName:=strtoint(s[13]+s[14]+s[15]+s[16]);
              end;
            if ( (s[2]='m') and (s[3]='a') and (s[4]='x') ) then
              begin
              i:=6;
              m:='';
                while (s[i]<>' ') do
                  begin
                    m:=m+s[i];
                    i:=i+1;
                  end;
                d.maxTemp:=strtoFloat(m);
              end;
            if ( (s[2]='m') and (s[3]='i') and (s[4]='n') ) then
              begin
              i:=6;
              m:='';
                while (s[i]<>' ') do
                  begin
                    m:=m+s[i];
                    i:=i+1;
                  end;
                d.minTemp:=strtoFloat(m);
              end;
            if ( (s[2]='s') and (s[3]='r') ) then
              //d.srTemp:=strtoFloat((s[6]+s[7]+s[8]+s[9]));
              begin
              i:=6;
              m:='';
                while (s[i]<>' ') do
                  begin
                    m:=m+s[i];
                    i:=i+1;
                  end;
                d.srTemp:=strtoFloat(m);
              end;
            if ( (s[2]='s') and (s[3]='r') and (s[4]='k') ) then
              begin
             // d.srKvadTemp :=strtoFloat((s[5]+s[6]+s[7]+s[8]));
              i:=6;
              m:='';
                while (s[i]<>' ') do
                  begin
                    m:=m+s[i];
                    i:=i+1;
                  end;
                d.srKvadTemp:=strtoFloat(m);
              flag:=true;
              end;
          end;
      if flag then
        begin
          j:=j+1;
          flag:=false;
          seek(f,filesize(f));
          write(f,d);
          persent.caption:=inttostr(j);
        end;     }
      for i:=1 to 17 do
        begin
        x:=Pos(c[i],s);
        if x<>0 then
          begin
            case i of
              1,6,15: begin



                   seek(f,filesize(f));
                   write(f,d);

                   d.maxVl:=0;
                   d.minVl:=0;
                   d.srVl:=0;
                   while s[x+l[i]+j]<>' ' do
                     begin
                       m:=m + s[x+l[i]+j];
                       j:=j+1;
                     end;
                   d.name := m;
              //     if i=15 then
                //   showmessage(m);
                   se:=se+1;
                   Persent.caption:=inttostr(se);
                 //  d.shortName:=strtoint(d.name[6]+d.name[7]+d.name[8]+d.name[9])
                 end;

              2:
                begin

                   while s[x+l[i]+j]<>' ' do
                     begin
                       m:=m + s[x+l[i]+j];
                       j:=j+1;
                     end;
                   d.maxTemp:= strtofloat(m);
                 end;
              3:
                begin

                   while s[x+l[i]+j]<>' ' do
                     begin
                       m:=m + s[x+l[i]+j];
                       j:=j+1;
                     end;
                   d.minTemp:= strtofloat(m);
                 end;
              4:
                begin
                  j:=1;
                   while s[x+l[i]+j]<>' ' do
                     begin
                       m:=m + s[x+l[i]+j];
                       j:=j+1;
                     end;
                   d.srTemp:= strtofloat(m);
                 end;
              5:
                begin
                  j:=1;
                   while s[x+l[i]+j]<>' ' do
                     begin
                       m:=m + s[x+l[i]+j];
                       j:=j+1;
                     end;
                   d.srKvadTemp:= strtofloat(m);
                   d.shortName:=d.name[6]+d.name[7]+d.name[8]+d.name[9]
                 end;
              7,8,9: begin
                       b:=i;
                       //showmessage(c[i]);
                     end;
              10: begin
                j:=1;
                   while s[x+l[i]+j]<>' ' do
                     begin
                       m:=m + s[x+l[i]+j];
                       j:=j+1;
                     end;
                   if m<>'**' then
                     d.srKvadTemp:= strtofloat(m);
                   d.shortName:=d.name[7]+d.name[8]+d.name[9]+d.name[10]
                 end;
              11,12,13: begin
                  j:=90;
                 // showmessage(s);
                  while s[j]<>':' do
                    j:=j+1;
                  j:=j+2;
                  while s[j]<>' ' do
                    begin
                    m:=m+s[j];
                    j:=j+1;
                    end;
                 // showmessage(m);
                   while s[j]<>':' do
                    j:=j+1;
                   j:=j+1;
                   while s[j]<>' ' do
                    begin
                      n:=n+s[j];
                      j:=j+1;
                    end;
                 //  showmessage(n);
                   case i of
                     11: begin
                       d.mintemp:=strtofloat(m);
                       d.minVl:=strtofloat(n);
                     end;
                     12: begin
                       d.maxTemp:=strtofloat(m);
                       d.maxVl:=strtofloat(n);
                     end;
                     13: begin
                       d.srTemp:=strtofloat(m);
                       d.srVl:=strtofloat(n);
                     end;
                     end;
                end;
              14: begin
                   j:=1;
                   while s[x+l[i]+j]<>' ' do
                     begin
                       m:=m + s[x+l[i]+j];
                       j:=j+1;
                     end;
            //       showmessage(m);
                   if m<>'??????????????????????' then
                     d.srKvadTemp:= strtofloat(m);
                   d.shortName:=d.name[7]+d.name[8]+d.name[9]+d.name[10]
                 end;
               16,17:begin
                       if CheckBox1.Checked then begin
                       j:=1;
                       while s[j]=' ' do
                         j:=j+1;
                      // showmessage(s);
                       while s[j]<>' ' do
                         begin
                           m:=m+s[j];
                           j:=j+1;
                         end;
                       showmessage(m);
                       //persent.caption:=m;
                       case i of
                          16: begin
                                d.porogMin:=strtofloat(m);
                              end;
                          17: begin
                                d.porogMax:=strtofloat(m);
                              end;
                       end;
                     end;
                       end;
               end;
              end;
            end;
          end;
  seek(f,filesize(f));
  write(f,d);
  closefile(f);
  closefile(t);
  Persent.caption:=inttostr(se);
  Nazv_per.caption:=Nazv_per.caption+'!';
  //showmessage('?????????????????????????? '+ inttostr(se) +' ????????????????!')
end;

procedure TForm1.New_roomClick(Sender: TObject);
begin
   tabl.cells[11,row]:=porogMin;
   tabl.cells[12,row]:=porogMax;
   row:=row +1;
   k:=k+1;
   tabl.rowcount:=tabl.rowcount+1;;
   tabl.cells[0,row]:='-';
   if edit1.text='' then
     tabl.cells[1,row]:='!'+inttostr(k)
   else
     tabl.cells[1,row]:='!'+edit1.text;
   tabl.cells[2,row]:='-';
   tabl.cells[3,row]:='-';
   tabl.cells[4,row]:='-';
   tabl.cells[5,row]:='-';
   tabl.cells[6,row]:='-';
   tabl.cells[7,row]:='-';
   tabl.cells[8,row]:='-';
   tabl.cells[9,row]:='-';
   tabl.cells[10,row]:='-';
   edit1.text:='';
end;

procedure TForm1.New_tablClick(Sender: TObject);
begin

end;

procedure TForm1.SbrosClick(Sender: TObject);
begin
   AssignFile(f, 'base.dat');
   rewrite(f);
   closefile(f);
   showmessage('????????????????!')
end;

procedure TForm1.SetikClick(Sender: TObject);
begin

end;

procedure TForm1.DatsikChange(Sender: TObject);
begin

end;

procedure TForm1.DatsikKeyPress(Sender: TObject; var Key: char);
var i,j:integer;
  d:dat;
  flag:boolean;
  h,h1:string;
begin
  if Key=#13 then
    begin
      AssignFile(f, 'base.dat');
      reset(f);
      flag:=true;
      showmessage('????????????');
      while not(eof(f)) do
        begin
          read(f,d);
          h:=d.shortname;
          showmessage('??????????');
          for j:=0 to 3 do
         // h1:=h1+h[length(h)-j];
          if (  (h=datsik.text)  and flag and (datsik.text<>'0') )  then
            begin
              flag:=false;
              row:=row +1;
              showmessage('????????????????????');
              tabl.rowcount:=tabl.rowcount+1;
              tabl.cells[0,row]:=inttostr(tabl.rowcount-31-k);
              tabl.cells[1,row]:=d.name;
              tabl.cells[3,row]:='-';
              tabl.Cells[2,row]:=d.shortname;
              tabl.cells[4,row]:=floattostr(d.maxtemp);
              tabl.cells[5,row]:=floattostr(d.mintemp);
              tabl.cells[6,row]:=floattostr(d.srtemp);
              tabl.cells[7,row]:=floattostr(d.srkvadtemp);
              porogMin:=floattostr(d.porogMin);
              porogMax:=floattostr(d.porogMax);
              if (abs(d.maxVl)>0.1) then
                begin
                  tabl.cells[8,row]:=floattostr(d.MaxVl);
                  tabl.cells[9,row]:=floattostr(d.minVl);
                  tabl.cells[10,row]:=floattostr(d.srVl);
                end
              else
                 begin
                  tabl.cells[8,row]:='-';
                  tabl.cells[9,row]:='-';
                  tabl.cells[10,row]:='-';
                 end;
            end;
          i:=i+1;
         // setik.caption:=inttostr(i);
          seek(f,i);
        end;
      showmessage('?????????? ????????????');
      if flag then
        begin
        showmessage('???????????? ???? ??????????');
        row:=row +1;
        tabl.rowcount:=tabl.rowcount+1;
        tabl.cells[0,row]:=inttostr(tabl.rowcount-31-k);
        tabl.cells[1,row]:='Empty';
        tabl.cells[2,row]:=datsik.text;
        tabl.cells[3,row]:='-';
        tabl.cells[4,row]:='-';
        tabl.cells[5,row]:='-';
        tabl.cells[6,row]:='-';
        tabl.Cells[7,row]:='-';
        tabl.cells[8,row]:='-';
        tabl.cells[9,row]:='-';
        tabl.Cells[10,row]:='-';
        end;
      closefile(f);
      datsik.text:='';
    end;

end;

end.







