program warshall;

{$APPTYPE CONSOLE}

uses
  SysUtils, Math, Diagnostics;

var
  x, y, z : integer;
  Titik : integer;
  src, dst : integer;
  Matrix : array [1..2000, 1..2000] of integer;
  stopwatch: TStopWatch;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  stopwatch:=TStopWatch.StartNew;
  AssignFile(input, 'input.txt');
  reset(input);
  readln(Titik);
  readln(src, dst);
  for x:=1 to Titik do
  begin
    for y:=1 to Titik do
    begin
      read(Matrix[x, y]);
      if Matrix[x, y]=maxint then
        Matrix[x, y]:=10000;
    end;
    readln;
  end;
  writeln('input reading time: ', stopwatch.ElapsedMilliseconds);
  stopwatch.Reset;
  stopwatch.Start;
  for y:=1 to Titik do
    for x:=1 to Titik do
      for z:=1 to Titik do
        Matrix[x, z]:=min(Matrix[x, z], Matrix[x, y]+Matrix[y, z]);
  for y:=1 to Titik do
    for x:=1 to Titik do
      if Matrix[x, y]=maxint then Matrix[x, y]:=0;
  close(input);
  writeln(Matrix[src, dst]);
  writeln('process time: ', stopwatch.ElapsedMilliseconds);
  AssignFile(input, '');
  readln;
end.
