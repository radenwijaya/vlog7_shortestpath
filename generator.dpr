program generator;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  tsize = 1200;

var
  i, j: integer;
  tbl: array [1..tsize, 1..tsize] of integer;
begin
  AssignFile(output, 'input.txt');
  rewrite(output);
  randomize();
  writeln(tsize);
  writeln(1, ' ', tsize);
  for i:=1 to tsize do
    for j:=1 to i do
      begin
        if i<>j then
        begin
          if random(1000)<10 then
            begin
              tbl[i, j]:=random(10)+1;
              tbl[j, i]:=tbl[i, j];
            end
          else
            begin
              tbl[i, j]:=maxint;
              tbl[j, i]:=tbl[i, j];
            end;
        end
        else
          tbl[i, j]:=0;
      end;
  { TODO -oUser -cConsole Main : Insert code here }

  for i:=1 to tsize do
    begin
      for j:=1 to tsize do
        write(tbl[i, j], ' ');
      writeln;
    end;

  close(output);
end.
