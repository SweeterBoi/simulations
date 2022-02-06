# Einführung in die Programmierung mit Java

## 1. Variabeln

### 1.1 Was sind Variabeln

Die Aufgabe eines Programms ist das Verwalten- oder Manipulieren von Daten.
Um diese Daten im Blick zu behalten und bei bedarf ändern zu können benutzen wir sog. Variabeln

>Eine Variable ist ein Datenspeicher den wir zur Laufzeit des Programms manipulieren können

### 1.2 Variablen Typen

Computer speichern daten in Form von Bits (0 oder 1). So kann die Zahl 27 bspw. in der Form 00011011 dargestellt werden.
Alle Daten, die der Computer verwaltet werden auf diese Weise gespeichert, doch nicht alle Arten von Daten sind gleich.
Die Information von Text unterscheidet sich deutlich von der einer Zahl und selbst da gibt es weitere unterschiede.

Die Folgenden Datentypen nennt man auch primitive Typen.


| Typ-Bezeichnung               | Abkürzung | Inhalt                                                   |
| ----------------------------- | --------- | -------------------------------------------------------- |
| Integer                       | int       | ganze Zahlen (1, 5, -22874, etc)                         |
| Floatingpoint                 | float     | Gleitkommazahlen (0.1, 3.22, -6.0, etc)                  |
| Doubleprecision FLoatingpoint | double    | Gleitkommazahlen aber genauer (0.1, 0.0001, -6.001, etc) |
| String                        | String    | Text ("Hallo" "123" "; ")                                |
| Boolean                       | boolean   | wahr oder falsch (true/false)                            |
| Character                     | char      | Einzelne Zeichen ('a', 'F', etc)                         |


In Java werden variabeln wie folgt zugewiesen:

Typ Name = Wert;

Bsp:

int zahl = 12;
float kommaZahl = 0.5;
double andereKommaZahl = 0.001;
String Gruss = "Hallo Welt";
boolean foo = True;
char Buchstabe = 'A';

## 2. Schleifen und Bedingungen

### 2.1 if & else

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
```

// Hier geht es weiter sobald einer der Codeblöcke [A], [B] oder [C] ausgeführt wurden!

> In dieser if-else Kette wird jedes der Statements in den runden Klammern evaluiert und solte der Ausdruck wahr sein, wird der folgende Codeblock ausgeführt. Die anderen Ausdrücke werden nicht mehr betrachtet
> Da x den Wert 5 hat wird in der Codeblock [A] nicht ausgeführt
> Analog wird auch der Codeblock [B] nicht ausgeführt
> Weil alle oberen 

---

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


## 3. Funktionen

### 3.1 Wie Funktionen funktionieren

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

> Der Rückgabetyp kann jeder der vorher angesprochenen Primitiven Typen oder selbst definierte Datentypen (nächster Ordner) annehmen. Soll die Funktion keine Werte zurückgeben wirde der Rückgabetyp **void** benutzt.
> Nach dem **return** keyword wird dieFunktion nicht länger ausgeführt. Code der in den darauffolgenden Zeilen steht wird nicht ausgeführt.

Aufgerufen wird die Funktion über den Alias:

Alias(parameter_1, parameter_2, parameter_3);

> Mehrere Funktionen können den selben Alias haben, sofern sich die Funktionen in der Zahl oder dem Typen der Parameter unterscheiden.

### 3.2 Warum Funktionen?

Oft wird Code öfter gebraucht. Beispielsweise müssen objekte öfter auf den Bildschirm gezeichnet werden oder Werte immer wieder berechnet werden.
Da es wesentlich aufwendiger ist, Code zu ändern der an vielen Stellen vorkommt und dabei keine Stelle zu vergessen ist es üblich Code-Duplikate zu vermeiden. Nur eine einzige Stelle im Code modifizieren zu müssen macht den Code nicht nur einfacher zu verbessern sondern auch wesentlich lesbarer.
Ein beschreibender Funktions-Name (Alias) ist wesentlich einfacher zu verstehen als eine Reihe Kommentare an jeder Implementation

### 3.3 Beispiele:

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

----------------> x
|
|
|
|
|
|
v
y