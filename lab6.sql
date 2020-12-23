Zadanie 1 
A # wyświetl średnią wagę wszystkich wikingów 
select rodzaj, avg(waga) from kreatura where rodzaj ="wiking";

B # Wyświetl średnią wagę oraz liczbę kreatur dla każdego rodzaju 
select rodzaj, count(*), avg(waga) from kreatura group by rodzaj;

C # wyświetl średni wiek dla każdego rodzaju kreatury
select rodzaj, avg(2020-year(dataUr)) from kreatura group by rodzaj;

Zadanie 2 
A # Dla każdego rodzaju zasobu wyświetlić sumę wag tego zasobu
select rodzaj, sum(waga) as suma_wag from zasob group by rodzaj;

B # Dla każdej nazwy zasobu wyświetlić średnią wagę, jeśli ilość jest równa co najmniej 4 oraz jeśli ta średnia waga jest większa od 10.
select  nazwa, avg(waga) as srednia_waga from zasob where ilosc>=4 group by nazwa having srednia_waga>10;

# Wyświetlenie ilość nazw pogrupowane rodzajem 
select count(nazwa) as iloscRoznychNazw, rodzaj from zasob group by rodzaj;

C # Wyświetlić ile jest różnych nazw dla każdego rodzaju zasobu, jeśli minimalna liczba zasobu jest większa od 1.
select count(nazwa) as rozne_nazwy, rodzaj from zasob group by rodzaj having MIN(ilosc)>1;

Zadanie 3 
A # Wyświetlić dla każdej kreatury ilości zasobów jakie niesie
select k.nazwa, k.idKreatury, sum(e.ilosc) suma from kreatura k join ekwipunek e on k.idKreatury=e.idKreatury group by e.idKreatury;

B # Wyświetlić dla każdej kreatury nazwy zasobów jakie posiada
select k.nazwa, e.ilosc, z.nazwa from kreatura  k, ekwipunek  e, zasob  z where k.idKreatury = e.idKreatury and e.idZasobu = z.idZasobu;

C # Wyświetlić kreatury, które nie posiadają żadnego ekwipunku
select k.nazwa, k.idKreatury from kreatura k left join ekwipunek e on  k.idKreatury=e.idKreatury where e.idKreatury is NULL;

Zadanie 4
A # Wyświetlić nazwy wikingów, którzy urodzili się w latach 70-tych XVII wieku oraz nazwy zasobów, które posiadają (użyj natural joina jeśli się da).
select kreatura.nazwa, zasob.nazwa from kreatura natural join ekwipunek inner join zasob on zasob.idZasobu = ekwipunek.idZasobu  
where year(kreatura.dataUr) between 1670 and 1679 and kreatura.rodzaj='wiking';

B # Wyświetlić nazwy 5 najmłodszych kreatur, które w ekwipunku posiadają jedzenie.
select k.nazwa, e.idZasobu, z.nazwa, k.dataUr from kreatura k  natural join ekwipunek e join zasob z on e.idZasobu=z.idZasobu 
where z.rodzaj='jedzenie' order by dataUr desc limit 5;

C # Wypisz obok siebie nazwy kreatur, których numer idKreatury różni się o 5 (np. Bjorn - Astrid, Brutal - Ibra itd.)
select concat(k.nazwa, '-', k2.nazwa) nazwy_kreatur from kreatura k, kreatura k2 where k.idKreatury - k2.idKreatury=5;

Zadanie 5
A # Dla każdego rodzaju kreatury wyświetlić średnią wagę zasobów, jaką posiadają w ekwipunku, jeśli kreatura nie jest małpą ani wężem i ilość ekwipunku jest poniżej 30.
select avg(z.waga * e.ilosc), k.rodzaj ,sum(e.ilosc) from kreatura k join ekwipunek e  on k.idKreatury=e.idKreatury join zasob z on e.idZasobu=z.idZasobu
group by k.rodzaj  having sum(e.ilosc)<30 and k.rodzaj!="małpa" and k.rodzaj!="wąż";
                             
B # Dla każdego rodzaju kreatury wyświetlić nazwę, datę urodzenia i rodzaj najmłodszej i najstarszej kreatury.
select a.nazwa, a.rodzaj, a.dataUr from kreatura a, (SELECT min(dataUr) min, max(dataUr) max from kreatura group by rodzaj) b WHERE b.min = a.dataUr OR b.max=a.dataUr;

# 2. opcja
select "najmłodsza", a.dataMax,  b.nazwa, a.rodzaj 
from (select max(dataUr) dataMax, rodzaj from kreatura group by rodzaj) a,
(select nazwa, dataUr from kreatura) b where a.dataMax = b.dataUr
union
select "najstarsza", a.dataMin, b.nazwa, a.rodzaj
from (select min(dataUr) dataMin, rodzaj from kreatura group by rodzaj) a,
(select nazwa, dataUr from kreatura) b where a.dataMin = b.dataUr
