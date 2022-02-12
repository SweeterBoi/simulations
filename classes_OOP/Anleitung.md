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
  - [2. Weitere Datenstrukturen](#2-weitere-datenstrukturen)
    - [2.1 Arrays & Listen](#21-arrays--listen)
    - [2.2 PVectoren](#22-pvectoren)
  - [3. for & while](#3-for--while)
    - [3.1 for](#31-for)
    - [3.2 while](#32-while)
    - [3.3 Beispiele](#33-beispiele)
  - [4. Explizite Euler Methode](#4-explizite-euler-methode)

## 1. Klassen & Interfaces

### 1.1 Was sind Klassen
Java ist eine Objekt orientierte Programmiersprache. Das bedeutet, dass die Datenverwaltung hauptsächlich durch Klassen erfolgt.
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

### 1.2 Keywords (static, abstract, final, public, private)
Methoden, Felder und Klassen selbst können unterschiedliche Eigenschaften haben.
Diese Eigenschaften werden durch die Keywords static, abstract, final, public und private festgelegt.

#### **final**
Das Keyword final wird benutzt um Felder unveränderlich zu machen. Diese Felder müssen auch direkt mit einem Wert initialisiert werden und können nicht zur Laufzeit zugewiesen werden.

#### **static**

Dieses Keyword verwendet um Klassen, Methoden Und Felder ohne Initialisierung des Objektes zugänglich zu machen. Hierbei muss eine Methode oder ein Feld einer statischen Klasse ebenfalls statisch sein. Aufgerufen werden Methoden dann nicht über den Namen der Methode oder des Feldes sondern über den Klassennamen.
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

### 1.4 Methoden

### 1.5 Interfaces

### 1.5 Konventionen

## 2. Weitere Datenstrukturen

### 2.1 Arrays & Listen

### 2.2 PVectoren


## 3. for & while

Ein weiteres Hilfsmittel ist das Iterieren über Datenmengen. Da wir in diesem Beispiel nicht nur einen Ball simulieren sondern 10 oder 42 oder 129 brauchen wir eine Möglichkeit alle Bälle effizient ansprechen zu können ohne 10 oder 42 oder 129 Variablen der Klasse Ball zu haben. Hierzu benutzen wir for- bzw. while Schleifen.

### 3.1 for
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
> Wie im Beispiel zu sehen ist wird die Schleife fünf mal ausgeführt wobei i beim ersten Mal den Wert 0 und beim letzten mal den Wert 4 hat. Anschließend ist die Bedingung i < 5 nicht mehr erfüllt und die Schleife endet.
### 3.2 while
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
### 3.3 Beispiele

## 4. Explizite Euler Methode