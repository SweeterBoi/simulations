# Klassen Und Objekt Orientierte Programmierung (OOP)

## Verzeichnis
- [Klassen Und Objekt Orientierte Programmierung (OOP)](#klassen-und-objekt-orientierte-programmierung-oop)
  - [Verzeichnis](#verzeichnis)
  - [1. Klassen & Interfaces](#1-klassen--interfaces)
    - [1.1 Was sind Klassen](#11-was-sind-klassen)
    - [1.2 Keywords (static, abstract, final, public, private)](#12-keywords-static-abstract-final-public-private)
      - [**final**](#final)
      - [**static**](#static)
      - [**public & private**](#public--private)
      - [**abstract**](#abstract)
    - [1.3 Konstruktoren](#13-konstruktoren)
    - [1.4 Methoden](#14-methoden)
    - [1.5 Interfaces](#15-interfaces)
    - [1.5 Konventionen](#15-konventionen)
  - [Es gibt noch viele weitere Konventionen die hier nicht erwähnt werden. Eine ausführliche Beschreibung der Konventionen für Java Quellcode auf Englisch lässt sich hier finden.](#es-gibt-noch-viele-weitere-konventionen-die-hier-nicht-erwähnt-werden-eine-ausführliche-beschreibung-der-konventionen-für-java-quellcode-auf-englisch-lässt-sich-hier-finden)
  - [2. for & while](#2-for--while)
    - [2.1 for](#21-for)
    - [2.2 while](#22-while)
  - [3. Weitere Datenstrukturen](#3-weitere-datenstrukturen)
    - [3.1 Arrays & Listen](#31-arrays--listen)
    - [3.2 PVector](#32-pvector)

---

## 1. Klassen & Interfaces

### 1.1 Was sind Klassen
Java ist eine objektorientierte Programmiersprache. Das bedeutet, dass die Datenverwaltung hauptsächlich durch Klassen erfolgt.
Klassen sind Blaupausen für Objekte im Programm. In unserem Beispiel sind das die Bälle.
Allgemein können diese Objekte aber auch wesentlich abstrakter sein.

Klassen können allgemein als Datenstrukturen aufgefasst werden. Des Weiteren beinhalten sie Methoden zur manipulation dieser Daten.

***
Klassen müssen auch immer, mit einer ungewissen Implementierung im Hinterkopf, so programmiert werden, dass es für andere Programmierer:innen nicht möglich ist die Klasse falsch zu verwenden. Dies ist im Ramen dieser Simulationen nicht zwingend nötig aber gerade wenn Code in Form von Librarys öffentlich wird ist es neben guter Dokumentation wichtig eine Sinnvolle Struktur in den Klassen zu haben, sodass bei Implementation nur korrekte Benutzereingaben gemacht werden können. Letztlich ist dies auch eine Frage der Sicherheit und Integrität.
***

Im Folgenden werden Variablen einer Klasse Felder und Funktionen einer Klasse Methoden genannt.

```Java
public class TestKlasse {

  private int _var1;
  private final float VAR2 = 0.1;
  public AndereKlasse _var3;

  //Konstruktor
  TestKlasse(int var1, AndereKlasse var3) {
    _var1 = var1;
    _var3 = var3;
  }

  void Methode1() {
    // Code
  }

  float Methode2(int param1, float param2) {
    // Mehr Code
    return someFloat;
  }
}
```
> Die Klasse Testklasse verwaltet drei Variablen, eine Vom Typ int, eine Konstante vom Typ float und ein Objekt des Typs AndereKlasse.

---

### 1.2 Keywords (static, abstract, final, public, private)
Methoden, Felder und Klassen selbst können unterschiedliche Eigenschaften haben.
Diese Eigenschaften werden durch die Keywords static, abstract, final, public und private festgelegt.

#### **final**
Das Keyword final wird benutzt um Felder unveränderlich zu machen. Diese Felder müssen auch direkt mit einem Wert initialisiert werden und können nicht zur Laufzeit zugewiesen werden.

#### **static**

Dieses Keyword verwendet um Klassen, Methoden und Felder ohne Initialisierung des Objektes zugänglich zu machen. Hierbei muss eine Methode oder ein Feld einer statischen Klasse ebenfalls statisch sein. Aufgerufen werden Methoden dann nicht über den Namen der Methode oder des Feldes sondern über den Klassennamen.
Statische Methoden haben keinen [Konstruktor](###13-Konstruktoren).

```Java
static class Umrechner(){
  static final int LICHTGESCHWINDIGKEIT_IN_SI = 300000000

  static int summe(int a, int b){
    return a + b;
  }
}
```
> Die Klasse Umrechner muss nun nicht initialisiert werden um auf die Methode summe(a,b) oder die Konstante LICHTGESCHWINDIGKEIT zuzugreifen.

```Java
print(Umrechner.LICHTGESCHWINDIGKEIT);
>> 3e8

print(Umrechner.summe(3, 4));
>> 7
```

#### **public & private**

Die Keywords public und private geben den Zugriff auf die jeweilige Methode oder das jeweilige Feld an. Felder und Methoden mit dem Keyword können nur von der Klasse selbst benutzt werden. Gleiches gilt für Konstruktoren, allerdings muss eine Klasse mindestens einen public Konstruktor haben. Methoden und Felder ohne diese Keywords sind inherent public.

```Java
class Konto {
  private int KontostandInCent = 100000;

  public void gibKontostand(){
    return KontostandInCent;
  }
}
```
> Diese simple Klasse verwaltet einen Kontostand. Da es möglich ist den Kontostand über KundenKonto.KontostandInCent = 1e10; umzuschreiben macht es Sinn diesen unzugänglich zu machen und stattdessen eine Methode zu implementieren, die den Saldo wiedergibt.
> Bei einer Methode die den Kontostand ändert können so auch Sicherheitschecks implementiert werden, über die der/die Programmierer:in der Klasse sonst keine Kontrolle hat. Eine falsche Implementierung auf der Benutzerseite könnte also leere Konten oder Milliardäre zur Folge haben und beides ist höchstwahrscheinlich nicht der Sinn dieser Klasse :)

#### **abstract**

Abstrakte Klassen sind wie ein Schema für unterschiedliche Objekte mit Gemeinsamkeiten zu verstehen.
Betrachten wir als Beispiel ein Schachspiel:
Es gibt sechs unterschiedliche Figuren: den Bauern, den Springer, den Läufer, den Turm, die Dame und den König.
All diese Figuren haben Gemeinsamkeiten, sie müssten zum Beispiel ein Feld zum speichern ihrer Position auf dem Brett haben. Außerdem müssen sie diese position ändern können und all diese Funktionen können geschlagen werden.
Allerdings bewegen sich all diese Figuren auf unterschiedliche Weise und der König kann as einziges ins Schach gesetzt werden.
Eine Abstrakte Klasse namens Figur würde also alle Gemeinsamkeiten der Figuren bereitstellen und die Unterschiede der Implementierung den erbenden Subklassen.
Diese Subklassen übernehmen dann den Bauplan der abstrakten Superklasse und Implementieren alle abstrakten Methoden konkret.
Die Subklassen verweisen mit dem **extends** Keyword auf die Abstrakte Superklasse.

```Java
//Diese Klasse dient als Bauplan für die sechs Figuren
abstract class Figur(){
  // Position auf dem Feld (bspw. H4, D5, etc.)
  public String _pos;
  // Speichert ob die Figur weiß ist oder nicht
  private boolean _istWeiß;
  // Initialisiert die Figur, das Funktioniert für alle Figuren gleich
  Figur(String startPosition, boolean istWeiß) {
    _pos = startPosition;
    _istWeiß = istWeiß;
  }
  // Bewegt die Figur, aber das unterscheidet sich von Figur zu Figur
  public abstract void bewegeZu(String Ziel);
}

class Dame extends Figur {
  public void bewegeZu(String Ziel){
    // Prüft, ob das Ziel gerade oder diagonal erreichbar ist, und keine andere Figur blockt
    // Bewegt Dame dorthin
  }

class Koenig extends Figur {
  public void bewegeZu(String Ziel) {
    // Prüft ob sich der König zum Ziel bewegen kann und tut dies
  }
  public boolean() {
    //Die genaue Implementierung wird hier nicht thematisiert ;)
    if(stehtImSchach){
      return true;
    }
    return false;
  }
}

class Schachbrett(){
  ArrayList<Figur> weisseFiguren = new ArrayList<Figur>();
  ArrayList<Figur> schwarzeFiguren = new ArrayList<Figur>();
  // Implementierung des restlichen Schachbrettes
}

}
```
> Die abstrakte Klasse Figur stellt den Bauplan einer Typischen Figur bereit. So hat jede Figur ein Feld auf dem es steht und ist entweder schwarz oder weiß.
> Jede Figur kann mit zwei Parametern initialisiert werden. Daher müssen die Subklassen den Konstruktor nicht selbst implementieren
> Die Methode bewegeZu() ist allerdings für jede Figur unterschiedlich da sich keine zwei Figuren gleich bewegen können.
> Des Weiteren implementiert die Figur Koenig eine neue Methode, die keine Andere Figur hat, denn nur der König kann im Schach stehen.
> In der Klasse Schachbrett finden wir jetzt den Vorteil der abstrakten Klasse Figur. Da alle Figuren die Klasse Figur erweitern, können all diese Figuren in **einer** Liste gespeichert werden. (Zu infos bgl. der ArrayList Klasse siehe [3.1 Arrays & Listen](#21-arrays--listen).
> Der Compiler weiß also beispielsweise, dass alle Figuren die Methode bewegeZu()und die Felder _pos ud istWeiss

---

### 1.3 Konstruktoren
Konstruktoren sind Methoden, die das Objekt initialisieren. Sie reservieren den Speicher der für das Objekt können genutzt werden die Felder der Klasse zu initialisieren.
Konstruktoren zeichnen sich dadurch aus, dass sie den Gleichen Namen wie die Klasse selbst-, und keinen Rückgabetypen haben.

```Java
public class Test {
  int _var1;
  float _var2;
  Test(int param1, float param2){
    _var1 = param1;
    _var2 = param2;
  }
  Test(int param1){
    this(param1, 10.0);
  }
  Test(){
    this(1, 5.0)
  }
}
```
> Klassen können mehrere Konstruktoren haben. Genau wie bei Funktionen und Methoden müssen sich diese nur durch ihre Signatur
> (Anzahl, Typen der Parameter) unterscheiden.
> Durch die Funktion this() lassen sich andere Konstruktoren der Klasse aufrufen. Dadurch kann Codeduplizierung vermieden werden!
> Nicht alle Felder müssen im Konstruktor initialisiert werden. Vor allem bei Konstanten is das nicht notwendig.

---

### 1.4 Methoden

Methoden sind klassenspezifische Funktionen. Sie werden verwendet um Felder der Klasse zu manipulieren, zurück zu geben und häufig genutzte Funktionalität zu bündeln (bspw. das Zeichnen des Objektes auf den Bildschirm). Methoden werden genau wie Funktionen definiert, mit dem Unterschied, dass diese nun public oder private sind und static oder abstract sein können.

---

### 1.5 Interfaces

Interfaces bieten ähnlich wie abstrakte Klassen einen Bauplan für Klassen. Allerding haben Interfaces keine konkret umgesetzten Methoden oder Konstruktoren. Klassen, die den Bauplean des Interfaces benutzen tun dies mit dem **implements** Keyword. Des Weiteren muss jede Klasse, die das Interface implenmentiert die Methoden des Interfaces selbst implementieren. Weitere Methoden können allerdings trotzdem hinzugefügt werden.

Der Vorteil von Interfaces gegenüber abstrakten Klassen ist, dass eine Klasse nur eine astrakte Klasse "erweitern" kann aber viele Interfaces implementieren kann.

Als praktisches Beispiel betrachten wir eine Sammlung von Klassen die Tiere Repräsentieren. Ein Tier kann so zum Beispiel von Interfaces zu Scharmtiere erben alsauch vom Interface der Vögel.

```Java
/**
* Definiert ein Interface das als Blaupause für Schwarmtiere
*/
interface SchwarmTiere {
  public void Formation();
}
/**
* Defieniert ein Interface als Blaupause für Vögel
*/
interface Voegel {
  public void Fliegen();
}
/**
* Defeieniert eine Abstrakte Klasse die Schwarmvögel repräsentiert. Die KLasse implementiert die Interfaces SchwarmTiere und Voegel.
*/
abstract class Schwarmvoegel implements SchwarmTiere, Voegel {
  public void Formation() {
    // Formation bilden
  }
  public void Fliegen() {
    // Fliegen
  }
}
/**
* Die Klasse stellt eine Schwalbe dar. Sie erbt von der Klasse der Schwarmvögel.
*/
class Schwalbe extends Schwarmvoegel {
  // Die Klasse implementiert die Funktionen Formation() und Fliegen() wie in der abstrakten Klasse Schwarmvoegel vorgegeben.
  public void Mueckenjagd() {
    // Jagt muecken, fliegt tief bei gutem Wetter
  }
}

class Gans extends Schwarmvoegel {
  // Auch diese Klasse implementiert die Funktionen Formation() und Fliegen() wie in der abstrakten Klasse Schwarmvoegel vorgegeben.
  public void nachSuedenZiehen() {
    // Zieht nach Süden
  }
}
```
> Sowohl die Schwalbe als auch die Gans haben die Methoden Formation() und FLiegen() von der abstrakten Klasse der Schwarmfoegel geerbt.
> Die beiden Klassen können selbst weitere Methoden einbinden. Nun können aber Gänse und Schwalben in einer Liste vom Typ Schwarmvoegel gespeichert werden (mehr dazu in Arrays & Listen).

---

### 1.5 Konventionen

Um Programmcode leichter lesbar zu machen vereinbaren wir einige Konventionen bezüglich der Benennung von Variabeln und Kommentaren und der Struktur der Programme selbst.

- Dateien sollten nicht mehr als 2000 Zeilen umfassen.
- Zeilen sollten nicht länger als 80 Zeichen sein. Ist eine Zeile zu lang werden Zeilenumbrüche nach Kommas oder vor Operatoren gemacht.
- Jede Datei sollte nur eine Klasse oder ein Interface beinhalten. (Aufgrund der Struktur von Processing ist die Hauptdatei von dieser Regel ausgenommen, Klassen haben aber nichts in dieser Datei zu suchen)

Dateien beginnen immer mit einer **Beschreibung des Dateiinhalts**, der **Version** und des **Autors**.
```Java
/**
* Hier steht die Beschreibung der unten definierten Klasse.
* Diese sollte so ausführlich wie nötig sein - ein:e Programmierer:in, der/die diese Klasse Implementiert hat im Normalfall keine Ahnung was diese Klasse repräsentiert.
*
* @version 22.02.2022
*
* @author Max Janik, Benjamin Blümchen, Jim Knopf
*/
class Klasse{
  // Code
}
```
> Die Version kann eine Fortlaufende Versionsnummer (z.B. 1.2.5) beinhalten ansonsten bietet sich das Datum der letzten Bearbeitung an.

Namen werden immer im CamelCase geschrieben: 
DieserMachtDasLesenLangerBezeichnungenEinfacher

Für Klassen benutzen wir folgende Konventionen:

- Klassennamen beginnen mit einem Großbuchstaben:
  - SehrWichtigeKlasse
- Methoden beginnen mit kleinen Buchstaben:
  - methodeDieWichtigeAufgabenErledigt()
- Felder einer Klasse beginnen mit einem Unterstrich, gefolgt von einem kleinen Buchstaben
  - _wichtigesFeldDasWerteSpeichert
- Felder mit dem **final** keyword werden komplett in Großbuchstaben geschrieben
  - KONSTANTEDIESICHNICHTAENDERT

```Java
public class SehrWichtigeKlasse {
  private String _name;
  private final int KONSTANTE = 10;

  SehrWichtigeKlasse(String name){
    _name = name;
  }

  public void methodeDieWichtigeAufgabenErledigt() {
    // Code
  }
}
```

Es gibt zwei Arten von Kommentaren:

```Java
// EInzeiliger Kommentar

/*
* Mehrzeiliger
* Kommentar
* <3
*/
```
> Diese Kommentare werden genutzt um den Quellcode selbs zu kommentieren. Sollte sich also ein:e andere:r Programmierer:in mit dem Quellcode befassen (z.B. Wartung, Erwiterung, Optimierung) Helfen die Kommentare den Quellcode zu verstehen.

```Java
/**
* Java Doc Kommentare werden durch die zwei Sternchen in der ersten Zeile Deklariert
*
* @author Pipi Langstrumpf
* @param parameter parameter tut was parameter tun
*/
```
> Java Doc Kommentare sind für Entwickler:innen gedacht, die die KLasse in ihren eigenen Code implementieren wollen. Sie stehen (wie oben gezeigt) am Anfang jeder Datei und erklären die enthaltene Klasse. Außerdem stehen sie vor jeder Methode und erklären die Methode wie nachstehend gezeigt.

```Java
/**
* Kurze beschreibung der Methode und 
*
* @param parameter1 hier wird erklärt was für eine Art von parameter erwartet wird
*                   und Außerdem die möglichen Werte des Parameters
* @param parameter2 Dies wird für jeden Parameter gemacht
*
*@return hier wird beschrieben was die Methode zurück gibt und außerdem die Möglichen
*        Werte bei Zahlenausgaben
*/
public boolean methode(int parameter1, String parameter2){
  // Code
  return einBoolean;
}
```
Es gibt noch viele weitere Konventionen die hier nicht erwähnt werden. Eine ausführliche Beschreibung der Konventionen für Java Quellcode auf Englisch lässt sich [hier](https://www.oracle.com/technetwork/java/codeconventions-150003.pdf) finden.
---

## 2. for & while

Ein wichtiges Hilfsmittel ist das Iterieren über Datenmengen. Da wir in diesem Beispiel nicht nur einen Ball simulieren sondern 10 oder 42 oder 129 brauchen wir eine Möglichkeit alle Bälle effizient ansprechen zu können ohne 10 oder 42 oder 129 Variablen der Klasse Ball zu haben. Hierzu benutzen wir for- bzw. while Schleifen.
Im Kapitel [3.1 Arrays & Listen](#31-arrays--listen) lernen wir dann konkret wie wir viele Instanzen eines Objektes speichern und über diesen Speicher iterieren.

### 2.1 for
for-Schleifen werden folgendermaßen benutzt:

```Java
int num = 5
for(int i = 0; i < num; i++) {
  print(i);
}
>> 0
>> 1
>> 2
>> 3
>> 4
```
> Der erste Parameter legt den Startwert der Variablen i fest, in diesem Fall 0.
> Der zweite Parameter legt die Bedingung fest für die die Schleife ausgeführt wird. Solange i < num (< 5) ist wird die Schleife ausgeführt.
> Der dritte Parameter legt die Änderung von i am **ende** der Schleife fest.
> Wie im Beispiel zu sehen ist wird die Schleife fünf mal ausgeführt wobei i beim ersten Mal den Wert 0 und beim letzten mal den Wert 4 hat. Anschließend ist die Bedingung i 
>  5 nicht mehr erfüllt und die Schleife endet.

---

### 2.2 while
while-schleifen sind dagegen wesentlich kompakter als for-Schleifen:

```Java
int num = 5;
int i = 0;
while(i < num) {
  print(i);
  i++;
}
>> 0
>> 1
>> 2
>> 3
>> 4
```
> Die while-Schleife kontrolliert nur ob das Statement wahr oder falsch ist und übernimmt die Deklaration und das Inkrementieren nicht.
> Es ist leicht möglich die while-Schleife in einen unendlichen loop zu bringen, einfach indem man das Inkrementieren der Iterationsvariable vergisst.

---

## 3. Weitere Datenstrukturen

### 3.1 Arrays & Listen

Da wir in diesem Beispiel - wie auch in den Kommenden -  eine größere Zahl der selben Objekte brauchen (immerhin it das die Idee der OOP), brauche wir auch eine Möglichkeit diese effizient zu speichern.
Bisher haben wir Instanzen einer Klasse immer in einer Variablen gespeichert und anhand dieser aufgerufen:

```Java
Klasse objekt1 = new Klasse(param1, param2);

objekt1.Methode();
```

Da wir aber nicht von Anfang an wissen, wie viele Instanzen eines Objektes wir brauchen und das ggf zur Laufzeit ändern wollen, brauchen wir eine Alternative.

Hier kommen die Arrays und Listen ins Spiel. Sie dienen als erweiterbare, iterierbare Datenspeicher.

Arrays werden wie folgt verwendet:

```Java
String[] namen = {"Iman","Alex","Oury","Anne","Shion","Kim"}
Int[] zahlen = {12, -26, 33}

print(namen[0]);
>> Iman
print(zahlen[2]);
>> 33
zahlen[1] = -3;
print(zahlen[1]);
>> -3
print(namen.length);
>> 6
```
Leere Arrays werden so erzeugt:
```Java
Int[] ints = new Int[5];
```
> Das Array ints hat die Länge 5. Beachte, dass die Einträge vor der Ersten Belegung mit einer Zahl vom Typ null sind (also nicht den Wert 0 haben, sondern explizit **keinen Wert** haben).
Wir können nun auch über ein Array Iterieren, ganz einfach mit einer for Schleife:

```Java
for(int i = 0; i < zahlen.lenght; i++) {
  print(zahlen[i]);
}
>> 12
>> -3
>> 33

//Alternativ geht auch das:
for(String n : namen) {
  print(n);
}
>> Iman
>> Alex
>> Oury
>> Anne
>> Shion
>> Kim
```

Arrays können auch weitere Array Beinhalten und so mehrdimensional werden. Eine Matrix sähe bspw. so aus:

```Java
Int[][] matrix = {{ 0, 1,  5},
                  {-2, 3, -4},
                  { 2, 0,  1}};

print(matrix[1][0]);
>> -2
```

Das dynamische erweitern von Array ist leider etwas kompliziert. Deshalb bedienen wir uns einer Weiteren Praktischen Klasse, den Array-Listen.

Array-Listen sind analog zu Array aber haben einige Vorteile: Sie lassen sich zur Laufzeit erweitern, verkleinern und leeren ohne viel Code aufwenden zu müssen. In den folgenden Einheiten werden wir ausschließlich Array-Listen benutzen.

```Java
// Definiert neue ArrayList, in der Objekte des Typs TestKlasse gespeichert werden.
ArrayList<TestKlasse> testListe = new ArrayList<>();
int num = 10;

// Generiert 10 Instanzen der TestKlasse und fügt sie an die Liste an.
for(int i = 0; i < num; i++) {
  // Erstellt das neue Objekt mit den Paramtetern
  TestKlasse temp = new Testklasse(param1, param2, param3);
  // Fügt temp zur Liste hinzu
  testListe.add(temp);
}

print(testList.size());
>> 10

TestKlasse neueInstanz = new TestKlasse(param1, param2, param3);
// setze neueInstanz an die 3. Stelle in der Liste
testListe.set(2, neueInstanz);

print(testListe.indexOf(neueInstanz));
>> 2

// Liest das erste Element aus der Liste aus
TestKlasse erstesElement = testListe.get(0);

//Löscht das erste Element aus der Liste. Das zweite ELement ist jetzt das Erste und so weiter
testListe.remove(0);

// Iteriert über die verbleibenden 9 Objekte der Liste und führt an jdedem Objekt die Methode testMethode() aus.
for(TestKlasse t : testListe) {
  t.testMethode();
}

// Löscht die Liste -> Die neue Länge der Liste ist also 0
testListe.clear();
print(testListe.size());
>> 0
```

> abstract classes

---

### 3.2 PVector

Der Datentyp PVector ist sehr Praktisch um zueinander gehörende Daten zu bündeln. Der PVector is wie ein Vektor in der Mathematik bzw Physik eine Größe, mit einem Betrag und einer Richtung. In diesem Programm werden sowohl die Position, als auch die Geschwindigkeit des Balls als 2-Dimensionale Vektoren gespeichert.
PVectoren gehören zu den, von Processing bereitgestellten Hilfsmitteln und sind nicht nativ in Java.

---
**Einschub:**

Vektoren werden in der Physik benutzt um Größen mit einer Richtung darzustellen (bspw. Ort, Kraft, Drehmoment, Impuls). Im Gegensatz dazu gibt es Größen ohne Richtung, sog. Skalare (Zeit, Temperatur, Masse).

Vektoren werden so aufgeschrieben:

$$ \vec{v} = \begin{pmatrix}
           v_{x} \\
           v_{y} \\
           v_{z}
         \end{pmatrix}
         $$

Dabei ist 
$$ v_{x} $$
zum Beispiel die Geschwindigkeit in x-Richtung.

Die Länge des Vektors stellt den Betrag der Größe dar, die der Vektor repräsentiert. Diese berechnet sich nach dem Satz des Pythagoras:

$$ \left| \vec{v} \right| = \sqrt{x^2+y^2+z^2} $$

In unserem Beispiel werden die Geschwindigkeiten der Bälle zu Beginn normalisiert; Der Betrag dieser Vektoren ist also 1. Dies wird erreicht in dem alle Komponenten durch den Betrag des Vektors geteilt werden.

$$ \frac{\vec{v}}{\left| \vec{v} \right|} $$

Wir Teilen dabei jeden einzelnen Eintrag des Vektors durch den Betrag des Vektors.

---

Benutzt wir ein Vektor wie Folgt:

```Java
PVector position = new PVector(3, 4);

print(position.x);
>> 3

print(position.y);
>> 4

position = position.normalize(); //setzt den Betrag des Vektors auf 1, behält aber die Richtung bei

print(position.x);
>> 0.6

print(position.y);
>> 0.8

position = position.mult(2);     // Strekt den Vektor auf die doppelte Länge.

print(position.x);
>> 1.2

print(position.y);
>> 1.6
```
> In diesem Beispiel wird ein Vektor mit zwei Einträgen definiert (3 Einträge sind natürlich auch möglich, dieser aknn auch später noch angefügt werden).
> Die Komponenten des Vektors werden über die Name.Eintrag Schreibweise aufgerufen, die wir schon von anderen Klassen kennen.
> PVektoren haben einige praktische Methoden um den Umgang effizienter zu gestalten. Anstatt den Betreag des Vektors zu bestimmen und jeden Eintrag durch diesen zu teilen, rufen wir einfach die Methode Normalize auf.
> Die Methode mult() erlaubt es uns jeden Eintrag mit einem Skalar (einer Zahl) zu multiplizieren, ohne jede Komponente einzelnd aufzurufen.