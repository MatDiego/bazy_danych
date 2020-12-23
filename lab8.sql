Zad1
A # Napisz wyzwalacz, który przed wstawieniem lub modyfikacją tabeli kreatura sprawdzi czy waga jest większa od zera.

DELIMITER //
CREATE TRIGGER kreatura_before_insert
BEFORE INSERT ON kreatura
FOR EACH ROW
BEGIN
if NEW.waga< 0
THEN
set NEW.waga  = 0;
END IF;
END
//
DELIMITER ;

Zad2
B #Stwórz tabelę archiwum_wypraw z polami id_wyprawy, nazwa, data_rozpoczecia, data_zakonczenia, kierownik (varchar),
do której będą wstawiane rekordy po usunięciu z tabeli wyprawa. Do kolumny kierownik wstawiane jest nazwa kreatury na podstawie usuwanego id_kreatury.

create table archiwum_wypraw(id_wyprawy int  primary key,nazwa varchar(30), data_rozpoczecia date,
data_zakonczenia date, kierownik varchar(30));

DELIMITER //
CREATE TRIGGER wyprawa_after_delete
AFTER DELETE  ON wyprawa
FOR EACH ROW
BEGIN
	insert into archiwum_wypraw(id_wyprawy,nazwa,data_rozpoczecia,data_zakonczenia,kierownik)
    values(old.id_wyprawy, old.nazwa, old.data_rozpoczecia, old.data_zakonczenia, (select nazwa  from  kreatura where kreatura.idKreatury=old.kierownik));
END
//
DELIMITER ;

Zad3
A # Napisz procedurę o nazwie "eliksir_sily", która będzie podnosiła wartość pola udzwig z tabeli kreatura o 20% na podstawie id_kreatury przekazywanego jako parametr.

DELIMITER $$
CREATE PROCEDURE eliksir_sily(IN id int)
BEGIN
Update kreatura set udzwig = 1.2 * udzwig where id_kreatury = id;
END
$$
DELIMITER ;

B # Napisz funkcję, która będzie pobierała tekst i zwracała go z wielkich liter.

DELIMITER //
CREATE FUNCTION wielkie_litery(tekst varchar(255))
    RETURNS varchar(255)
BEGIN
    DECLARE wielkie VARCHAR(255);
    SELECT UPPER(tekst) INTO @wielkie;
    RETURN @wielkie;
END //


Zad4
A # Stwórz tabelę "system_alarmowy" z polami, id_alarmu, wiadomosc

create table system_alarmowy(id_alarmu int primary key, wiadomosc varchar(255));

B # Dodaj wyzwalacz, który będzie sprawdzał czy w tabeli wyprawy pojawiła się misja, w której bierze udział teściowa oraz czy jednym z sektorów misji jest domek dziadka.
Jeżeli w/w zaistnieje wyzwalacz wstawi rekord do tabeli "system_alarmowy" z treścią "Teściowa nadchodzi !!!".

DELIMITER $$

CREATE TRIGGER uczestnicy_after_insert
AFTER INSERT ON uczestnicy
FOR EACH ROW
BEGIN

if ( select id_uczestnika=14 from uczestnicy where id_wyprawy=new.id_wyprawy) and
(select sektor=7 from etapy_wyprawy where idWyprawy=new.id_wyprawy)

THEN  
	INSERT INTO system_alarmowy VALUES(default,'Tesciowa nadchodzi');
END IF;

END
$$

DELIMITER ;

Zad5
A # Napisz procedurę mającą jako parametry wyjściowe średnią, sumę i maks udźwigu z tabeli kreatura.

DELIMITER $$
CREATE PROCEDURE ssmu(OUT srednia double, OUT suma double, OUT max_udzwig double)
BEGIN
SELECT avg(srednia), sum(suma), max(max_udzwig) INTO srednia, suma, max_udzwig from kreatura where id_pracownika=id;
END
$$
DELIMITER ;
