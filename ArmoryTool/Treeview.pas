unit Treeview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, superobject, superxmlparser,
  Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    VirtualStringTree: TVirtualStringTree;
    Memo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure treeviewGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
{$IFDEF UNICODE}
    procedure treeviewGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
{$ELSE}
    procedure treeviewGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: widestring);
{$ENDIF}
    procedure treeviewFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure treeviewCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
//    procedure treeviewHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure treeviewChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    { Private declarations }
  public
    { Public declarations }
    apiLink: string;
    procedure UpdateRoot(const root: ISuperObject);
  end;

var
  Form2: TForm2;

implementation

uses msxml;
type
  PSuperNode = ^TSuperNode;
  TSuperNode = record
    index: Integer;
    name: string;
    obj: ISuperObject;
  end;

{$R *.dfm}

  function GetPath(treeview: TVirtualStringTree; n: PVirtualNode): string;
  var
    data, parent: PSuperNode;
  label root;
  begin
    Result := '';
    data := treeview.GetNodeData(n);
    if data = nil then exit;
    parent := treeview.GetNodeData(n.Parent);
    if parent = nil then goto root;

    if parent <> nil then
      case ObjectGetType(parent.obj) of
        stObject: Result := GetPath(treeview, n.Parent) + '.' + data.name;
        stArray: Result := GetPath(treeview, n.Parent) + '[' + data.name + ']';
      else
        Assert(false); // unexpected
      end;
    Exit;
  root:
    Result := data.name;
  end;

  function GetSource(treeview: TVirtualStringTree; n: PVirtualNode; format: boolean): string;
  var
    p: PSuperNode;
  begin
    Result := '';
    p := treeview.GetNodeData(n);
    if (p <> nil) then if (p.obj <> nil) then
      Result := p.obj.AsJSon(format, false) else
      Result := 'null';
  end;

procedure TForm2.FormCreate(Sender: TObject);
var
  root, parent: PVirtualNode;
  data, parentData: PSuperNode;
begin

//  parentData.index := 1;
//  //parentData.obj :=  New object(true);
//  parentData.name := 'ROOT';
//
//
//  VirtualStringTree.AddChild(parent);
//  //VirtualStringTree.BeginUpdate;


end;

procedure TForm2.UpdateRoot(const root: ISuperObject);
  procedure ProcessNode(parent: PVirtualNode; const node: ISuperObject; const text: string; id: Integer = -1);
  var
    p: PVirtualNode;
    data: PSuperNode;
    i: Integer;
    iter: TSuperObjectIter;
  begin
    p := VirtualStringTree.AddChild(parent);
    data := VirtualStringTree.GetNodeData(p);
    data.name := text;
    data.obj := node;
    data.index := id;
    include(p.States, vsInitialized);
    case ObjectGetType(node) of
      stObject:
        begin
          include(p.States, vsExpanded);
          if ObjectFindFirst(node, iter) then
          repeat
            ProcessNode(p, iter.val, iter.key, -1);
          until not ObjectFindNext(iter);
          ObjectFindClose(iter);
        end;
      stArray:
        begin
          include(p.States, vsExpanded);
          for i := 0 to node.AsArray.Length - 1 do
            ProcessNode(p, node.AsArray[i], inttostr(i), i);
        end;
    end;
  end;
begin
  Memo.Clear;
  VirtualStringTree.BeginUpdate;
  try
    VirtualStringTree.Clear;
    ProcessNode(nil, root, 'root');
  finally
    VirtualStringTree.EndUpdate;
  end;
end;


procedure TForm2.FormShow(Sender: TObject);
var
  req: IXMLHttpRequest;
begin
    req := {{$IFDEF VER210}CoXMLHTTP{{$ELSECoXMLHTTPRequest{$ENDIF}.Create;
    req.open('GET', apiLink, false, EmptyParam, EmptyParam);
    req.send(EmptyParam);
    UpdateRoot(SO(req.responseText));
    abort;
end;

procedure TForm2.treeviewChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  //StatusBar.SimpleText := GetPath(treeview, Node);
  Memo.Text := GetSource(VirtualStringTree, Node, true);
end;

procedure TForm2.treeviewCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  data1, data2, parent: PSuperNode;
begin
  case Column of
  0: begin
       data1 := VirtualStringTree.GetNodeData(Node1);
       parent := VirtualStringTree.GetNodeData(node1.Parent);
       if (parent <> nil) and ObjectIsType(parent.obj, stArray) then
         Result := node1.Index - node2.Index else
         begin
          data2 := VirtualStringTree.GetNodeData(Node2);
          Result := CompareText(data1.name, data2.name);
         end;
     end;
  end;
end;

procedure TForm2.treeviewFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  p: PSuperNode;
begin
  p := PSuperNode(VirtualStringTree.GetNodeData(Node));
  p.name := '';
  p.obj := nil;
end;

procedure TForm2.treeviewGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TSuperNode);
end;

{$IFDEF UNICODE}
procedure TForm2.treeviewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
{$ELSE}
procedure TForm2.treeviewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: widestring);
{$ENDIF}
var
  data: PSuperNode;
begin
  data := VirtualStringTree.GetNodeData(Node);
  case Column of
    0: CellText := data.name;
    1: case ObjectGetType(data.obj) of
         stObject: CellText := '';
         stArray: CellText := '';
         stNull: CellText := 'null';
       else
         CellText := data.obj.AsString;
       end;
  end;
end;

end.
