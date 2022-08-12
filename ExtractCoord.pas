procedure TFExtracao.SimpleName;
var nome,aux:string;
    index,x,c,area:integer;
    ok_nome:boolean;
    conteudo:widestring;
begin
try
   texto.add(HTTPTexto.Get(ComboURL.text));
   RawContent.lines.add(HTTPTexto.Get(ComboURL.text));
   ListaAreas.items.clear; ListaCoord.items.clear;
   index:=0; ok_nome:=false; area:=0;
   while (index<length(texto.text)) do
   begin
     if (copy(texto.text,index,length('<name>'))='<name>') then
     begin
       nome:=''; index:=index+length('<name>');
       while (copy(texto.text,index,length('</name>'))<>'</name>') do
       begin
         nome:=nome+texto.text[index];
         index:=index+1;
       end;
       ListaAreas.Items.add(nome);
       coord.Clear;
       while (copy(texto.text,index,length('<coordinates>'))<>'<coordinates>') do
         index:=index+1;
       conteudo:=''; index:=index+length('<coordinates>')-1;
       while (copy(texto.text,index,length('</coordinates>'))<>'</coordinates>') do
       begin
         index:=index+1;
         conteudo:=conteudo+texto.text[index];
       end;
       aux:='';
       for c:=1 to length(conteudo) do
        if (conteudo[c]<>' ') then
          aux:=aux+conteudo[c]
        else
        begin
          aux:=aux+conteudo[c];
          coord.add(trim(aux));
          aux:='';
        end;
        coord.SaveToFile('c:\pd\'+nome+'.txt');
       end;
     index:=index+1;
   end;
   ListaAreas.ItemIndex:=0;
   ListaAreasClick(nil);
  except
    showmessage('Erro');
  end;
end;