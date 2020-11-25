Zadanie 1 
A # Kopiuję tabele kreatura, zasob , ekwipunek
create table kreatura  select * from wikingowie.kreatura;
create table zasob  select * from wikingowie.zasob;
create table ekwipunek  select * from wikingowie.ekwipunek;

#Dodaję klucze główne i obce 
alter table kreatura add primary key(idKretury);
alter table zasob add primary key(idZasobu);
alter table ekwipunek add primary key(idEkwipunku);

alter table ekwipunek add foreign key (idKreatury) references kreatura(idKreatury);
alter table ekwipunek add foreign key (idZasobu) references kreatura(idZasobu);

B #Wyświetlam wszystkie rekordy tabeli 'zasob'
select * from zasob;

C # Wyświetlam wszystkie rekordy tabeli 'zasob' gdzie typ to jedzenie
select * from zasob where rodzaj='jedzenie';

D # Wyświetlam 'idZasobu', 'ilosc', dla kreatur o id 1,3,5
select idZasobu, ilosc from ekwipunek where idKreatury in (1,3,5);

Zadanie 2
A # Wyświetlam kreatury, które nie są wiedźmą i dźwigają co najmniej 50kg
 select * from kreatura where rodzaj!='wiedzma' and udzwig >=50;

B # Wyświetlam zasoby, które ważą pomiędzy 2 a 5 kg
select * from zasob where waga between 2 and 5;

C # Wyświetlam kreatury, których nazwa zawiera 'or' i które dźwigają między 30kg a 70kg
select * from kreatura where nazwa like '%or%' and udzwig  between 30 and 70;

Zadanie 3 
A # Wyświetlam  zasoby, które zostały pozyskane w miesiącach lipcu i sierpniu
select * from zasob where month(dataPozyskania) in (7,8);

B # Wyświetlam zasoby, które mają zdefiniowany rodzaj od najlżejszego do najcięższego
select * from zasob where rodzaj is not null order by waga asc;

C # Wyświetlam 5 najstarszych kreatur
select * from kreatura order by dataUr asc limit 5;

Zadanie 4
A #Wyświetlam unikalne rodzaje zasobów
select distinct(rodzaj) from zasob;

B # Wyświetl jako jedną kolumnę nazwę i rodzaj kreatury (w postaci: nazwa - rodzaj), gdzie rodzaj rozpoczyna się od 'wi'
select concat(nazwa," - ", rodzaj) from kreatura where rodzaj like "wi%"; 

C # Wyświetl zasoby z całkowitą wagą danego zasobu (ilość * waga) dla zasobów pozyskanych w latach 2000-2007.
select waga*ilosc  nazwa from zasob where year(dataPozyskania) between 2000 and 2007;
 
 Zadanie 5
A # wyświetl masę właściwego jedzenia (netto) oraz wagę odpadków
select nazwa, waga*0.7 as masa_netto, waga*0.3 as odpadki from zasob where rodzaj = "jedzenie";


B # Wyświetl zasoby, które nie mają rodzaju
select * from zasob where rodzaj is null;

C # Wyświetl wszystkie unikalne rodzaje zasobów, których nazwa zaczyna się od 'Ba' lub kończy się na 'os'. Dane posortuj alfabetycznie.
select distinct(rodzaj), nazwa from zasob where  nazwa like "Ba%" or nazwa like "%os" order by nazwa asc;
