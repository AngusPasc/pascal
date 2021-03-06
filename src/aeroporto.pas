program aeroporto;
uses sysutils;

const percorso='voli.dat';

type
	t_data=record
		giorno: integer;
		mese: integer;
		anno: integer;
		ora: integer;
		minuto: integer;
	end;
	t_volo=record
		id: integer;
		citta_par: string[30];
		citta_arr: string[30];
		data_par: t_data;
		data_arr: t_data;
		posti_tot: integer;
		posti_occ: integer;
	end;
	t_file_voli=file of t_volo;

var
	file_voli: t_file_voli;
	scelta: byte;

procedure inizializza(var file_voli: t_file_voli);
begin
	assign(file_voli, percorso);
	if not FileExists(percorso)
		then rewrite(file_voli);
end;

function menu():byte;
begin
	writeln('Cosa vuoi fare? ');
	writeln('1- Carica i voli');
	writeln('2- Visualizza i voli');
	writeln('3- Cerca un volo');
	writeln('4- Cancella un volo');
	writeln('5- Prenota un volo');
	writeln('0- Esci');
	write('-> ');
	readln(menu);
end;

function leggi_data():t_data;
var data: string[16]; 
begin
	readln(data);
	leggi_data.giorno:=StrToInt(data[1]+data[2]);
	leggi_data.mese:=StrToInt(data[4]+data[5]);
	leggi_data.anno:=StrToInt(data[7]+data[8]+data[9]+data[10]);
	leggi_data.ora:=StrToInt(data[12]+data[13]);
	leggi_data.minuto:=StrToInt(data[15]+data[16]);
end;

procedure carica(var file_voli: t_file_voli);
var n, i:integer;
	volo: t_volo;
begin
	reset(file_voli);
	write('Inserisci il numero dei voli: ');
	readln(n);
	for i:=1 to n do
		begin
		volo.id:=i;
		write('Inserisci la città di partenza del ', i, ' volo: ');
		readln(volo.citta_par);
		write('Inserisci la città di arrivo del ', i ,' volo: ');
		readln(volo.citta_arr);
		write('Inserisci la data e l''ora di partenza("GG-MM-AAAA OO:MM"): ');
		volo.data_par:=leggi_data();
		write('Inserisci la data e l''ora d''arrivo("GG-MM-AAAA OO:MM"): ');
		volo.data_arr:=leggi_data();
		write('Inserisci i posti totali del volo: ');
		readln(volo.posti_tot);
		write('Inserisci i posti occupati: ');
		readln(volo.posti_occ);
		write(file_voli, volo);
	end;
	close(file_voli);
end;
	

procedure visualizza(var file_voli: t_file_voli);
var volo: t_volo;
begin
	reset(file_voli);
	while not eof(file_voli) do
		begin
		read(file_voli, volo);
		writeln('Volo n. ', volo.id);
		writeln('	Citta'' di partenza: ', volo.citta_par);
		writeln('	Citta'' d''arrivo: ', volo.citta_arr);
		writeln('	Data di partenza: ', IntToStr(volo.data_par.giorno):2, '-', IntToStr(volo.data_par.mese):2, '-', IntToStr(volo.data_par.anno):4, ' ', IntToStr(volo.data_par.ora):2, ':', IntToStr(volo.data_par.minuto):2);
		writeln('	Data d''arrivo: ', IntToStr(volo.data_arr.giorno):2, '-', IntToStr(volo.data_arr.mese):2, '-', IntToStr(volo.data_arr.anno):4, ' ', IntToStr(volo.data_arr.ora):2, ':', IntToStr(volo.data_arr.minuto):2);
		writeln('	Posti totali: ', volo.posti_tot);
		writeln('	Posti occupati: ', volo.posti_occ);
		end;
	close(file_voli);
end;

procedure ricerca(var file_voli: t_file_voli);
var id: byte;
	volo: t_volo;
	trovato: boolean;
begin
	reset(file_voli);
	write('Inserisci l''ID del volo: ');
	readln(id);
	trovato:=false;
	while (not eof(file_voli) and not trovato) do
		begin
		read(file_voli, volo);
		if volo.id=id
			then trovato:=true;
		end;
	if trovato then
		begin
		writeln('Volo n. ', volo.id);
		writeln('	Citta'' di partenza: ', volo.citta_par);
		writeln('	Citta'' d''arrivo: ', volo.citta_arr);
		writeln('	Data di partenza: ', IntToStr(volo.data_par.giorno):2, '-', IntToStr(volo.data_par.mese):2, '-', IntToStr(volo.data_par.anno):4, ' ', IntToStr(volo.data_par.ora):2, ':', IntToStr(volo.data_par.minuto):2);
		writeln('	Data d''arrivo: ', IntToStr(volo.data_arr.giorno):2, '-', IntToStr(volo.data_arr.mese):2, '-', IntToStr(volo.data_arr.anno):4, ' ', IntToStr(volo.data_arr.ora):2, ':', IntToStr(volo.data_arr.minuto):2);
		writeln('	Posti totali: ', volo.posti_tot);
		writeln('	Posti occupati: ', volo.posti_occ);
		end
	else
		writeln('Il volo ', id, ' non esiste');
	close(file_voli);
end;

procedure 

begin
	inizializza(file_voli);
	repeat
		scelta:=menu();
		case scelta of
			1: carica(file_voli);
			2: visualizza(file_voli);
			3: ricerca(file_voli)
			{4: cancella
			5: prenota}
		end;
	until scelta=0;
end.


