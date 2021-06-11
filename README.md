# Personal expenses app: learning Flutter

This is a spendings administration app done following the ["Flutter & Dart - The Complete Guide [2021 Edition]"](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)

# Core Flutter Widgets

## Scaffold / CuppertinoPageScaffold
It gives the background, it allow to use define:
- appBar: it takes an AppBar object to define how the appbar should look like. We can define
  - title: a text for the title
  - actions: [] a list of widgets, tipically we add **IconButton()**
- body: the body of the page
- floatingActionButton: it takes a widget and it will float when we scroll. 
- floatingActionButtonLocation: to define where the actionButton should be in the screen.
```dart
Scaffold(
    appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
            IconButton(
                icon: Icon(Icons.add), 
                onPressed: () {},
                )
            ]
    ),
    body: //all the body...
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
    ),
)
```

## Container
- A versatile widget that gives us a lot of styling and alignment options.
- It takes exacly **one child** widget.
- We can configure for example margin and padding (with an EdgeInsets object), decoration (with the BoxDecoration object where we can configure the border), child...
## Row
- It allow us to position child widgets horizontally
- It takes **unlimited child** widgets.
- No styling options.
- Always **takes full available width**.
- Alignment: for Row, vertical is the crossAxis and hotizontal is the mainAxis. We can configure aligmnet with crossAxisAlignment and mainAxisAligment.
- Every child has as width as it needs or as we asign it to have
## Column
- It allow us to position child widgets vertically
- It takes **unlimited child** widgets.
- No styling options.
- Always **takes full available height**.
- It takes as much width as its children needs.
- Alignment: for column, vertical is the mainAxis and hotizontal is the crossAxis. We can configure aligmnet with crossAxisAlignment and mainAxisAligment.
- Every child has as height as it needs or as we asign it to have
## SingleChildScrollView
- It gives its children scrolling funcionality
## SizedBox
Like a Container but you can define no child. It's commonly used as a separator, providing space between elements.
## FittedBox
A widget To prevent a widget to grow if the content grows.

## Flexible
It forces its childs to expand. We can configure it with with:
- fit: 
  - FlexFit.tight -> to fill all the available space. If there were multiple Flexible widgets, they would share the space in equal parts.
  - FlexFit.loose -> to fill only the space needed for the content to fit inside.
- flex: it tells the flexible widget how much space to get relative to other flexible widgets. By default is 1.
```dart
// The available width is 3, so "A" takes 2/3 and B takes 1/3.
Flexible(
    flex: 2, 
    fit: FlexFit.tight,
    chld: Container(Text('A')),
),
Flexible(
    flex: 1,
    fit: FlexFit.tight,
    chld: Container(Text('B')),
),
```
## Expanded
Is the same as Flexible but with the fit: FlexFit.tight. So it has no fit argument, it only accept the flex argumet.

## Stack
It allow us to have widgets on top of each other. 
## Card 
A pre-styled container with drop-shadow, padding, background color...
- By default, it depends on the size of its child, unless it has a parent with a clearly defined width.

## ListView
A scrollable column
- By default it has an infinite hight. So we need a wrapper (a parent) that defined a height.
There are 2 ways of using it:
- ListView(children[]): all widgets that are part of the listview are rendered. Bad performance for very long lists.
- ListView.builder(): it only renders the widgets that are visible in the screen. It takes 2 arguments:
  - itemBuilder: A function that will execute for every item in the list. It receives a context and an index of the item (int). The function must return the widget we want to build for each listView item.
  - itemCount: how many items we want to have in the listView (list lenght)
```dart
ListView.builder(
    itemBuilder: (ctx, index) {
        return Card(child: Text(transactions[index].title));
    },
)
```
## GridView
A scrollable widget where items can be next to each other.

## ListTile
A widget that comes with a default styling and layout, used a lot with ListView. It has some predefined arguments:
- leading: a widget that is positioned at the beginning of the tile. In here is it often used the CircleAvatar() widget that provides a rounded element.
- title
- subtitle

## Text
We can style it with the style argument that takes a **TextStyle** object. This object provides us a lot of ways to style a text: fontSize, fontWeight, color...

## Image
The image class has many constructors depending on the source of the image
- Image.asset() -> when the source is an asset in the project folder. For using an asset in the project it needs to be referenced in the pubspec.yaml under "assets"
- Image.network() -> when the source is in a url (internet)
- Image.file() -> when the source is a file in the device, for example.

fit is a useful argument in the Image widget for formatting the image. BoxFit.cover tells the image to respect the boundaries of the container and fit the image in there. For using it we need a container with defined width and height.
```dart
fit: BoxFit.cover
```
## TextFied
It has the keyboardType arguemnt, that takes a TextInputType object to define how the keyboard should look like.
We could save the input value in every key stroke
```dart
String titleInput 
// and in the build() method:
TextField(
    onChanged: (val){ // onChanged runs on every key stroke
        titleInput = val; // we asign the value in the inputText to a variable
    },
)
```
We can use a TextEditingController and it does it automatically. We can access the saved text as a property in the controller.
```dart
final titleController = TextEditingController();
// and in the build() method:
TextField(
    controller: titleController,
)
print(titleController.text);
```
## DatePicker
showDatePicker is a function provided by Flutter that presents a Date Picker in the screen. I has some arguments:
- context: the context
- initialDate: the default DateTime
- firstDate: the minimum DateTime the user will be able to choose
- lastDate: the maximum DateTime the user will be able to choose
This function returns a Future<DateTime> so we can use the .then() to catch the date picked by the user
```dart
void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((pickedDate){
        if(pickedDate == null){
            return null;
        }
        setState((){
            _selectedDate = pickedDate;
        });
    });
}
```
## Other concepts learned
### Formating DateTime
We can use the [intl package](https://pub.dev/packages/intl) to format dates with the DateFormat method
```dart
DateFormat('yyyy/MM/dd').format(dateVariable);  // --> 2021/05/11
DateFormat.yMMMd.format(dateVariable);          // --> May 11, 2021
```
### Mapping Data into Widgets
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
### String interpolation
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

### Showing a Model Bottom Sheet
showModalBottomSheet() is a function provided by Flutter that allow us to show a modal in the bottom of the screen. It takes 2 arguments
- context: the context
- builder: a function that
    - takes the context as argument (flutter provides it internally)
    - returns the widget that will be inside the sheet
```dart
void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
        return WidgetInsideTheModal();
    },);
}
```
To close the modal bottom sheet, we can call **Navigator.of(context).pop()**

### Accessing widget properties from the State class
with "widget." we can access the properties of the connected widget class from inside the State class. So we use the keyword widget followed by a dot and the name of the property we want to access.

## Themes
In the MaterialApp we can define a Theme with the theme argument. In the Theme we can define different colors, fonts and styles that can be accessed by any widget in the app.
<br>It takes a ThemeData object, and in here we can define many things:
- primarySwatch: we define a color and it automatically different tones of that color
- accentColor: a secundary color 

```dart
MaterialApp(
    title: 'My title',
    theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
    ),
    home: MyHomePage(),
)
```
In a widget, we can access a theme config that way:
```dart
Theme.of(context).primaryColor
```
We can also define a theme for all the appbars with the AppBarTheme object and a textTheme to affect all texts.

### Using Custom Fonts
- The fonts assets must be in a folder in the project
- We define the font in the pubspec.yaml file by setting the family and every asset with the path.
```yaml
    fonts:
      - family: Schyler
        fonts:
          - asset: fonts/Schyler-Regular.ttf
          - asset: fonts/Schyler-Italic.ttf
            style: italic
```
- Then, we can use the imported font in the Theme by using the fontFamily argument and setting the family name assigned in the pubspec.yaml. Or we could also use the fontFamily argument in any TextStyle object.


# Other things I've learnt in this section:
- When to use StatefulWidger or StatelessWidget
- using public or private functions
- Connect widgets and share the State
- Build adaptatives UI thanks to MediaQuery
- LayoutBuilder() to pass constraints so we can know the size of a widget
- Build diferent widgets depending on a condition. (condition) ? do this : else do that.
- Using different mothods of the List() class: .map(), .where(), .reversed().