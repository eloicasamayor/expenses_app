# Personal expenses app

Weekly spendings administration app.

## Following the Flutter Course on Udemy

This app was developed following the second lection of the ["Flutter & Dart - The Complete Guide [2021 Edition]"](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)

Al the code is commented with the theory explained by the teacher.

## What I've learned
- When to use StatefulWidger or StatelessWidget
- using public or private functions
- Manage user inputs: textFields, textEditingController, DatePicker.
- Format Datetime: DateFormat.yMd().format(_date)
- iterate lists to build widgets
- Connect widgets and share the State
- Listview and Listview.builder()
- Using the Future() class and the .then() method.
- Build adaptatives UI thanks to MediaQuery
- LayoutBuilder() to pass constraints so we can know the size of a widget
- Build diferent widgets depending on a condition. (condition) ? do this : else do that.
- Using different mothods of the List() class: .map(), .where(), .reversed().
- Importing and using images and different fonts
- Using FittedBox() to prevent a widget to grow if the content grows.

## Core Flutter Widgets
### App / Page Setup
- MaterialApp / CuppertinoApp: It sets up the app
- Scaffold / CuppertinoPageScaffold: It gives the background, it allow to use an appBar

### Layout
#### Container
- A versatile widget that gives us a lot of styling and alignment options.
- It takes exacly **one child** widget.
- We can configure for example margin and padding (with an EdgeInsets object), decoration (with the BoxDecoration object where we can configure the border), child...
#### Row
- It allow us to position child widgets horizontally
- It takes **unlimited child** widgets.
- No styling options.
- Always **takes full available width**.
- Alignment: for Row, vertical is the crossAxis and hotizontal is the mainAxis. We can configure aligmnet with crossAxisAlignment and mainAxisAligment.
#### Column
- It allow us to position child widgets vertically
- It takes **unlimited child** widgets.
- No styling options.
- Always **takes full available height**.
- It takes as much width as its children needs.
- Alignment: for column, vertical is the mainAxis and hotizontal is the crossAxis. We can configure aligmnet with crossAxisAlignment and mainAxisAligment.

### Row / Colum Children
They allow us to configure how children they should use the space.
#### Flexible
#### Expanded

### Content Containers
#### Stack
It allow us to have widgets on top of each other
#### Card 
A pre-styled container with drop-shadow, padding, background color...
- By default, it depends on the size of its child, unless it has a parent with a clearly defined width.

### Repeat Elements
#### ListView
A scrollable column
#### GridView
A scrollable widget where items can be next to each other.
#### ListTile
A widget that comes with a default styling and layout, used a lot with ListView

### Content types
#### Text
We can style it with the style argument that takes a TextStyle object. This object provides us a lot of ways to style a text: fontSize, fontWeight, color...
#### Image
#### Icon

### User Input
#### TextFied
#### Buttons
#### GestureDetector: invisible widget 
#### InkWell
It allow us to register a broad variety of user input listeners

## Formating DateTime
We can use the [intl package](https://pub.dev/packages/intl) to format dates with the DateFormat method
```dart
DateFormat('yyyy/MM/dd').format(dateVariable);  // --> 2021/05/11
DateFormat.yMMMd.format(dateVariable);          // --> May 11, 2021
```
## Mapping Data into Widgets
- Goal: take a list of data and map it into a list of widgets
- We use the "map" method, that is a method from any list object. we call it by typing the list followed by ".map()".
- .map() gives us an iterable, so we have to call the .toList() method after .map()
- .map() takes a function that automatically gets executed on every element on the list
  - that function obtains the element as an argument
  - we need to return a widget that represents that element in the list.
```dart
Column(
    children: transactions.map((tx){
        return Card( 
            child: Text(tx.title),
        );
    }).toList()
)
```

## String interpolation
We can interpolate strings using the **"$" sign** followed by any variable inside a text between cuotes.
```dart
print('my name is $name');
```
If we want to use a more **complex expression** (more than a variable name), we use the $ followed by the expression between {curly braces}.
```dart
print('my name is $person.name');
```
To output special characters like 'cuotes' or $, we use the \ before using the character, to **scape** it, so to tell dart that this should not be treated as a language feature but as a character.
```dart
print('this \$ is a dolar sign.');
```
