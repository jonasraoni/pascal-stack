{*
 * Pascal Stack: Simple stack class to be used in Delphi (Pascal) with automatic memory growth
 * Jonas Raoni Soares da Silva <http://raoni.org>
 * https://github.com/jonasraoni/pascal-stack
 *}

unit Stack;

interface

uses
  SysUtils, Classes;

type
  TStack = class
  private
    FList: PPointerList;
    FCapacity, FCount: Cardinal;
    procedure Grow;
  public
    destructor Destroy; override;
    procedure Push(const Data: Pointer);
    function Pop: Pointer;
  end;

implementation

{ TStack }

destructor TStack.Destroy;
begin
  FreeMem(FList);
  inherited;
end;

procedure TStack.Grow;
begin
  if FCapacity > 64 then
    Inc(FCapacity, FCapacity div 4)
  else
    if FCapacity > 8 then
      Inc(FCapacity, 16)
    else
      Inc(FCapacity, 4);
  ReallocMem(FList, FCapacity * SizeOf(Pointer));
end;

function TStack.Pop: Pointer;
begin
  if FCount > 0 then
  begin
    Dec(FCount);
    Result := FList^[FCount];
  end
  else
    Result := nil;
end;

procedure TStack.Push(const Data: Pointer);
begin
  if FCapacity = FCount then
    Grow;
  FList^[FCount] := Data;
  Inc(FCount);
end;

end.
