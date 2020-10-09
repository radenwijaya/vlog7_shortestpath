program Project3;

{$APPTYPE CONSOLE}

uses
  SysUtils, Diagnostics;

const
  maxnodes = 5000;
  inf = 65536;

type
  intArray = array [0..maxnodes] of integer;

var
  nodes : integer;
  connArray : array [1..maxnodes, 0..maxnodes] of integer; //described original connection
  distanceArray : array [0..maxnodes, 0..maxnodes] of integer;
  src, dest : integer;

  //map [x, 0] is count of element, just like string
  map : array [0..inf] of intArray;

  stopwatch: TStopwatch;

function STP(src, dest : integer) : integer;
var
  loc : integer;
  distanceList : array [1..maxnodes] of integer;
  i, j : integer;
  target : integer;
begin
  for i:=1 to nodes do distanceList[i]:=inf;
  distanceList[src]:=0;

  {
  initialisation
  }
  for i:=1 to nodes do
    if (distanceArray[src, i]<inf) and (distanceArray[src, i]>0) then
        begin
          target:=distanceArray[src, i];
          inc(map[target, 0]);
          map[target, map[target, 0]]:=i;
          distanceList[i]:=target;
        end;

  {
  actual process time
  }
  loc:=0;
  repeat
    for i:=1 to map[loc, 0] do
      for j:=1 to connArray[map[loc, i], 0] do
      begin
        target:=loc+distanceArray[map[loc, i], connArray[map[loc, i], j]];
        if (distanceList[connArray[map[loc, i], j]]>target) then
        begin
          inc(map[target, 0]);
          map[target, map[target, 0]]:=connArray[map[loc, i], j];
          distanceList[connArray[map[loc, i], j]]:=target
        end;
      end;
    inc(loc);
  until distanceList[dest]<=loc;

  writeln(loc);

  STP:=distanceList[dest];
end;

var
  i, j : integer;
begin
  stopwatch:=TStopWatch.StartNew;
  AssignFile(input, 'input.txt');
  reset(input);
  read(nodes);
  read(src, dest);
  for i:=1 to nodes do
  begin
    for j:=1 to nodes do
    begin
      read(distanceArray[i, j]);
      if (distanceArray[i, j]<inf) then
      begin
        inc(connArray[i, 0]); //increment the no of connected node
        connArray[i, connArray[i, 0]]:=j; //enter the connected node
      end;
    end;

  end;
  close(input);
  writeln('input reading time: ', stopwatch.ElapsedMilliseconds);
  stopwatch.Reset;
  stopwatch.Start;
  writeln(STP(src, dest));
  writeln('process time: ', stopwatch.ElapsedMilliseconds);
//  writeln('Shortest Path : ', distanceArray[src, dest]);

  AssignFile(input, '');
  readln;
  { TODO -oUser -cConsole Main : Insert code here }
end.
