# Pomôcky pre určovanie flagov

Zoradené podľa slovných druhov. Slúži len na rýchlu orientáciu, po doplnení flagu je nutné vygenerované tvary slov skontrolovať.

## Predpony:
  * F - predpona naj- pre 3. stupeň prídavných mien
  * N - predpona ne- pre zápor

## Prípony:

## Podstatné mená:
### Mužský rod:
    c - vz. chlap a kuli, živ. podstatné mená, ak N plurálu končí na -ia
    C - vz. chlap, živ. podstatné mená, ak N plurálu končí na -i (+hosť)
    H - vz. hrdina
    B - vz. dub
    b - vz. dub, genitív s -u, lokál s -e (napr. kultivátor, mak, prebal)
    O - vz. dub, končiaci na -ok, -el, -ol, -en, -jem, -ietor, -ov, -on (napr. úpadok, vietor, uhol)
    J - vz. stroj
    L - životné i neživotné skloňovateľné podľa vz. chlap (niekedy iba v singulári) i dub/stroj,
    niektoré zvieratá (had, vôl, medveď), nerobí dvojtvary -y/-ovia

### Ženský rod:
    z - vz. žena jednotné číslo
    Z - vz. žena množné číslo
    U - vz. ulica
    K - vz. gazdiná
        vz. kosť
    D - dlaň a idea

### Stredný rod:
    M - vz. mesto
    V - vz. vysvedčenie
    S - vz. srdce
    A - vz. dievča 

## Prídavné mená:
    I - vz. cudzí/páví
    Y - všetky vzory
    P - príd. mená muž. rodu končiace na í, ktorým sa pri prechode na ženský/stredný rod zmení -í na -ia, -ie (napr. novší, neskorší) [stupňovanie prídavných mien – 2. stupeň]


## Príslovky
    P -  príslovky končiace na -e, ktoré v 2. stupni pridávajú -jšie (obyčajne, otvorene)

## Slovesá:
    E - vz. chytať (chyt-á, chytaj-ú)
        vz. robiť (rob-í, rob-ia)
    R - vz. brať (ber-ie, ber-ú)
        vz. kričať (krič-í, krič-ia)
        vz. niesť (nes-ie, nes-ú)
        vz. piecť (peč-ie, peč-ú)
        vz. dychčať (dychč-í, dychč-ia)
    W - vz. chudnúť (chudn-e, chudn-ú)
        vz. hynúť (hyn-ie, hyn-ú)
        vz. pracovať (pracuj-e, pracuj-ú)
        vz. žuť (žuj-e, žuj-ú)
    T - vz. česať (češ-e, češ-ú)
        vz. žať (žn-e, žn-ú)
    V - vz. vidieť (vid-í, vid-ia)
    X - vz. rozumieť (rozum-ie, rozumej-ú)
        vz. trieť (tr-ie, tr-ú)

## Číslovky: 
    č - v testovaní - pre číslovky - -násobný (stonásobný, dvojnásobný..)

# Tipy

## aspell funkcie

Keďže slovenský slovník pre aspell používa rovnakú affix kompresiu (flagy), je môžné ho využiť pri identifikovaní vhodného flagu, čo je efektívne hlavne pri slovesách:

    $ echo testovaci_tvar_slova | aspell --lang=sk --encoding=utf-8 munch | tr " " "\n" | grep zakladny_tvar_slova

Ako `testovaci_tvar_slova` odporúčam použiť genitív množného čísla:

    $ echo kľačíte | aspell --lang=sk --encoding=utf-8 munch | tr " " "\n" | grep kľačať

Jeho výstupom bude jeden riadok:

    kľačať/R

Ak by ich bolo viac, je potrebné ako `testovaci_tvar_slova` iný pád.

Z vyššie uvedeného príkladu vyplýva, že najvhodnejší flag pre kompresiu slova `kľačať` je `R`. Do slovníka je potrebné ho vložiť aj so záporom (flag `N`). Ak si chcete overiť, ktoré slová flag bude rozoznávať, môžete použiť nasledovný príkaz:

    $ echo kľačať/RN | aspell --lang=sk --encoding=utf-8 expand | tr " " "\n"

Výstup bude nasledovný:
    kľačať
    nekľačať
    kľačali
    kľačalo
    kľačala
    kľačal
    kľačte
    kľačme
    kľačiac
    kľačia
    kľačíte
    kľačíme
    kľačí
    kľačíš
    kľačím
    nekľačali
    nekľačalo
    nekľačala
    nekľačal
    nekľačte
    nekľačme
    nekľačiac
    nekľačia
    nekľačíte
    nekľačíme
    nekľačí
    nekľačíš
    nekľačím

V prípade, že flag generuje nesprávne slovo, je potrebné to reportovať na [hunspell-sk/issues](https://github.com/sk-spell/hunspell-sk/issues).

V prípade, že flag nejakú formu slova negeneruje, je potrebné ho zadať chýbajúci tvar do slovníka (t.j. bude tam bez flagu).
