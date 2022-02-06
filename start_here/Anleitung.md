# Einführung in die Programmierung mit Java

## Verzeichnis
- [Einführung in die Programmierung mit Java](#einführung-in-die-programmierung-mit-java)
  - [Verzeichnis](#verzeichnis)
  - [1. Vorwort](#1-vorwort)
    - [1.1 Die Entwicklungsumgebung](#11-die-entwicklungsumgebung)
    - [1.2 Code](#12-code)
    - [1.3 Kommentare](#13-kommentare)
  - [2. Variabeln](#2-variabeln)
    - [2.1 Was sind Variabeln](#21-was-sind-variabeln)
    - [2.2 Variabeln Typen](#22-variabeln-typen)
  - [3. if & else Bedingungen](#3-if--else-bedingungen)
  - [4. Funktionen](#4-funktionen)
    - [4.1 Wie Funktionen funktionieren](#41-wie-funktionen-funktionieren)
    - [4.2 Warum Funktionen?](#42-warum-funktionen)
    - [4.3 Beispiele](#43-beispiele)
  - [x. Das Fenster](#x-das-fenster)


## 1. Vorwort

### 1.1 Die Entwicklungsumgebung

Die Programmiersprache, die für diesen Kurs benutzt wird, heißt Processing und basiert auf der Programmiersprache Java.
Processing erleichtert einige Prozesse, die in Java unnötig umständlich sind (bspw. das erstellen des Fensters).
Herunterladen kannst du die Entwicklungsumgebung auf [processing.org](https://processing.org/download)

### 1.2 Code

Der von mir bereitgestellte Code findet sich immer im selben Ordner wie die Anleitung.md des Entsprechenden Programms.
Für die ersten Beispiele werden Programm-Konzepte Erklärt. So wird es in dieser Anleitung um Variablen, if & else und später um Funktionen gehen. Parallel werden diese Konzepte im Programmcode benutzt. Es bietet sich also an den Code parallel offen zu haben :)

Hinweis: Je komplexer der Code wird desto sinnvoller ist es Teile davon auf extra Dateien auszulagern.
hier wird es dann bei Gelegenheit einen [link zur Datei](start_here.pde) geben.

### 1.3 Kommentare

Code wird in diesen Boxen dargestellt:

```Java
//Ich bin ein Kommentar

/**
* Ich bin ein
* Kommentar, der über
*
* mehrere Zeilen geht
*/

// int i = 10;
// i = i + 1;
// print(i);
// selbst valider Programmcode, der auskommentiert wurde wird nicht ausgeführt!
```

> Erklärungen findest du hier; Kommentare werden nicht ausgeführt und sind zur Dokumentation
> des Programmcode gedacht

OK. Let's begin!

## 2. Variabeln

### 2.1 Was sind Variabeln

Die Aufgabe eines Programms ist das Verwalten- oder Manipulieren von Daten.
Um diese Daten im Blick zu behalten und bei bedarf ändern zu können benutzen wir sog. Variabeln.
Bspw. Werden position und Geschwindigkeit des Balls in [start-here.pde](start_here.pde) auf diese Weise gespeichert und fortlaufend verändert.

> Eine Variable ist ein Datenspeicher den wir zur Laufzeit des Programms manipulieren können

### 2.2 Variabeln Typen

Computer speichern daten in Form von Bits (0 oder 1). So kann die Zahl 27 bspw. in der Form 00011011 dargestellt werden.
Alle Daten, die der Computer verwaltet werden auf diese Weise gespeichert, doch nicht alle Arten von Daten sind gleich.
Die Information von Text unterscheidet sich deutlich von der einer Zahl und selbst da gibt es weitere unterschiede.

Die Folgenden Datentypen nennt man auch primitive Typen.


| Typ-Bezeichnung                 | Abkürzung | Inhalt                                               |
| ------------------------------- | --------- | ---------------------------------------------------- |
| Integer                         | int       | ganze Zahlen (1, 5, -22874, etc)                     |
| Floating point                  | float     | Gleitkommazahlen (0.1, 3.22, -6.0, etc)              |
| Double-precision floating point | double    | genauere Gleitkommazahlen (0.1, 0.0001, -6.001, etc) |
| String                          | String    | Text ("Hallo" "123" "; ")                            |
| Boolean                         | boolean   | wahr oder falsch (true/false)                        |
| Character                       | char      | Einzelne Zeichen ('a', 'F', etc)                     |


In Java werden variabeln wie folgt zugewiesen:

Typ Name = Wert;

Bsp:

```Java
- int zahl = 12;
- float kommaZahl = 0.5;
- double andereKommaZahl = 0.001;
- String gruss = "Hallo Welt";
- boolean foo = True;
- char buchstabe = 'A';
```

> VariablenNamen dürfen Buchstaben, Zahlen und sowohl - alsauch _ beinhalten, dürfen aber nur mit Buchstaben oder _ beginnen!
> Eine häufige Konvention ist es mit einem kleinen Buchstaben Anzufangen und neue Wörter mit einem Großbuchstaben zu beginnen (sehrGutBeschreibenderVariabelnNameDerRechtLeichtZuLesenIst)

```Java
final int KONSTANTE2 = 255;
```

> Wir können auch konstanten definieren, welche im verlauf der Programms nicht verändert werden können
> in diesem Fall ist der Name per Konvention komplett in Großbuchstaben zu schreiben

## 3. if & else Bedingungen

Um den Fluss unseres Programms zu kontrollieren können wir aussagen auf ihren Wahrheitsgehalt prüfen.
Dazu benutzen wir if-Statements.

Bsp:

```Java
int x = 5;

if(x > 10) {
    // [A] *Hier passiert etwas!*
}
else if(x > 100) {
    // [B] *Hier passiert etwas anderes!*
}
else {
    // [C] *Hier kann auch etas passieren!*
}
// Hier geht es weiter sobald einer der Codeblöcke [A], [B] oder [C] ausgeführt wurden!
```

> In dieser if-else Kette wird jedes der Statements in den runden Klammern evaluiert und solte der Ausdruck wahr sein, wird der folgende Codeblock ausgeführt. Die anderen Ausdrücke werden nicht mehr betrachtet
> Da x den Wert 5 hat wird in der Codeblock [A] nicht ausgeführt
> Analog wird auch der Codeblock [B] nicht ausgeführt
> Weil alle oberen 

```Java
boolean foo = true;

if(foo) {
    // *Dieser Code wird ***immer*** ausgeführt!*
}
else {
    // *Und dieser ***nie***!*
}

if(false) {
    // *Dieser Code wird auch ***nie*** ausgeführt*
}
```

> Das Argument eines if-Statements hat immer den Wert true oder false, dieser kann auch in einem
> Boolean gespeichert werden.


## 4. Funktionen

### 4.1 Wie Funktionen funktionieren

Funktionen sind Code-Blöcke die durch ein Alias immer wieder ausgeführt werden. Sie können Parameter beim Aufruf beziehen und Datenwerte zurückgeben.
Funktionen folgen folgendem Schema:

```Java
Rückgabetyp Alias(Parametertyp param1, Parametertyp param2, ...) {
    // Code
    // Code
    // Mehr Code
    return Rückgabewert;
    // Dieser Code wird nicht mehr ausgeführt
}
```

> Der Rückgabetyp kann jeder der vorher angesprochenen Primitiven Typen oder selbst definierte Datentypen (nächster Ordner) annehmen. Soll die Funktion keine Werte zurückgeben wird der Rückgabetyp **void** benutzt.
> Nach dem **return** keyword wird dieFunktion nicht länger ausgeführt. Code der in den darauffolgenden Zeilen steht wird nicht ausgeführt.

Aufgerufen wird die Funktion über den Alias:

Alias(parameter_1, parameter_2, parameter_3);

> Mehrere Funktionen können den selben Alias haben, sofern sich die Funktionen in der Zahl oder dem Typen der Parameter unterscheiden.

### 4.2 Warum Funktionen?

Oft wird Code öfter gebraucht. Beispielsweise müssen objekte öfter auf den Bildschirm gezeichnet werden oder Werte immer wieder berechnet werden.
Da es wesentlich aufwendiger ist, Code zu ändern der an vielen Stellen vorkommt und dabei keine Stelle zu vergessen ist es üblich Code-Duplikate zu vermeiden. Nur eine einzige Stelle im Code modifizieren zu müssen macht den Code nicht nur einfacher zu verbessern sondern auch wesentlich lesbarer.
Ein beschreibender Funktions-Name (Alias) ist wesentlich einfacher zu verstehen als eine Reihe Kommentare an jeder Implementation

### 4.3 Beispiele

```Java
/**
* Diese Funktion nimmt zwei Integer und gibt ihre Summe zurück
*
* @param a erster Summand
* @param b zweiter Summand
*
* @return Summe der beiden Summanden
*/
int summe(int a, int b) {
    return a + b;
}

/**
* Diese Funktion implementiert die Euklidische Norm l² = x² + y² in 2D
*
* @param x      x-Länge
* @param y      y-Länge
*
* @return Wurzel der Summe der Quadrate der Eingabewerte
*/
float euklidischeNorm(float x, float y) {
    return sqrt(pow(x, 2) + pow(y, 2));
}

/**
* Diese Funktion implementiert die Euklidische Norm l² = x² + y² + z² in 3D
* Diese Funktion unterscheidet sich von der oberen in der Anzahl von Parametern
*
* @param x      x-Länge
* @param y      y-Länge
* @param z      z-Länge
*
* @return Wurzel der Summe der Quadrate der Eingabewerte
*/
float euklidischeNorm(float x, float y, float z) {
    //sqrt(x) gibt die Wurzel von x aus
    //pow(x, n) gibt x^n aus
    return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
}

/**
* Diese Funktion nimmt keine Parameter an und gibt keine Werte zurück
* Manchmal muss man einfach etwas sweetes sagen u.u
*/
void saySomethingNice() {
    print("You are awesome <3");
}
```
> Vor jede Funktion schreiben wir einen mehrzeilligen Kommentar, wie im Beispiel gezeigt. Dieser beinhaltet
> eine kurze Beschreibung der Funktion sowie die keywords @param und @return.
>
> @param wird für jeden Parameter der Funktion aufgeführt und gibt an was für ein Parameter erwartet wird und was dieser repräsentiert.
> @return gibt an was die Funktion zurück gibt.


Wenn wir die Funktionen aufrufen wollen benutzen wir einfach die entsprechende Funktionsbezeichnung:

```Java
summe(3, 5);
>> 8

euklidischeNorm(3, 4);
>> 5.0

euklidischeNorm(2, 8, 10);
>> 12.9614

saySomethingNice();
>> "You are awesome <3"
```


## x. Das Fenster
