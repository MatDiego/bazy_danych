Zad1
A # Przekopiuj jeszcze raz z bazy wikingowie rekordy z tabeli kreatura, przekopiuj dodatkowo
tabele: uczestnicy, etapy_wyprawy, sektor, wyprawa, wraz z danymi. 

create table uczestnicy select * from wikingowie.uczestnicy;
create table etapy_wyprawy select * from wikingowie.etapy_wyprawy;
create table sektor select * from wikingowie.sektor;
create table wyprawa select * from wikingowie.wyprawa;

B # Wypisz nazwy kreatur, które nie uczestniczyły w żadnej wyprawie.

select k.nazwa, u.id_uczestnika from kreatura k left join uczestnicy u on k.idKreatury=u.id_uczestnika  where u.id_uczestnika is null;

C # Dla każdej wyprawy wypisać jej nazwę oraz sumę ilości ekwipunku, jaka została zabrana przez
uczestników tej wyprawy.

select k.nazwa, u.id_uczestnika from kreatura k left join uczestnicy u on k.idKreatury=u.id_uczestnika  where u.id_uczestnika is null;

Zad2
A # Dla każdej wyprawy wypisz jej nazwę, liczbę uczestników, oraz nazwy tych uczestników w
jednej linii.

select w.nazwa, count(u.id_uczestnika) liczba_uczestnikow, group_concat(k.nazwa) członkowie from wyprawa  w 
join uczestnicy u on w.id_wyprawy=u.id_wyprawy 
join  kreatura k  on k.idKreatury=u.id_uczestnika group by w.nazwa; 
 
 
B # Wypisz kolejne etapy wszystkich wypraw wraz z nazwami sektorów, sortując najpierw według
daty początku wyprawy, a następnie według kolejności występowania etapów. W każdym
etapie określ nazwę kierownika danej wyprawy

select w.nazwa nazwa_wyprawy, ew.idEtapu, s.nazwa sektor, w.data_rozpoczecia, w.kierownik, k.nazwa from wyprawa w 
join etapy_wyprawy ew on w.id_wyprawy=ew.idWyprawy 
join sektor s on ew.sektor=s.id_sektora 
join kreatura k on k.idKreatury=w.kierownik order by w.data_rozpoczecia, ew.idEtapu;

Zad3 
A # Wypisać ile razy dany sektor był odwiedzany podczas wszystkich wypraw (nazwa sektora,
ilość odwiedzin). Jeśli nie był odwiedzony ani razu, wpisz zero. 

select s.nazwa, count(ew.sektor) ilosc_odwiedzin from sektor s  
left join etapy_wyprawy ew on ew.sektor=s.id_sektora group by s.nazwa; 

B # W zależności od ilości wypraw, w jakich brała udział dana kreatura wypisz: nazwa kreatury,
'brał udział w wyprawie' - gdy liczba > 0, 'nie brał udziału w wyprawie', gdy równa zero.

select k.nazwa, if(count(u.id_wyprawy) =0 ," nie brał udział w wyprawie "," brał udział w wyprawie ") udzial_w_wyprawie from kreatura k 
left join uczestnicy u on k.idKreatury=u.id_uczestnika group by k.nazwa; 

Zad4
A # Dla każdej wyprawy wypisz jej nazwę oraz sumę liczby znaków, które zostały użyte przy
pisaniu dziennika, jeśli ta liczba znaków jest mniejsza od 400.


select w.nazwa, sum(length(ew.dziennik)) liczba_znakow from wyprawa w 
join etapy_wyprawy ew on w.id_wyprawy=ew.idWyprawy group by w.nazwa having liczba_znakow<400;

B # Dla każdej wyprawy podaj średnią wagę zasobów, jakie były niesione przez uczestników tej
wyprawy.

select distinct w.nazwa, count(distinct u.id_uczestnika) liczba_uczestnikow , sum(z.waga*e.ilosc)/count(distinct u.id_uczestnika) srednia_waga from wyprawa w  
left join uczestnicy u on w.id_wyprawy=u.id_wyprawy  
left join kreatura k on u.id_uczestnika=k.idKreatury  
left join ekwipunek e on k.idKreatury=e.idKreatury  
left join zasob z on e.idZasobu=z.idZasobu group by w.nazwa;


Zad5 
A # Wypisać nazwę kreatury oraz ile miała dni (wiek w dniach) w momencie rozpoczęcia wyprawy, dla wypraw, które przechodziły przez chatkę dziadka.

select  k.nazwa, datediff(w.data_rozpoczecia, k.dataUr) "rozpoczecie wyprawy(wiek w dniach)" from kreatura k
join uczestnicy u  on k.idKreatury=u.id_uczestnika 
join wyprawa w on u.id_wyprawy=w.id_wyprawy
join etapy_wyprawy ew on w.id_wyprawy=ew.idWyprawy
join sektor s on ew.sektor=s.id_sektora
where s.nazwa="Chatka dziadka";

