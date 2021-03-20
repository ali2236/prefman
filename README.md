# PrefMan
![Pub Version](https://img.shields.io/pub/v/prefman?color=%2300BFA5&label=PrefMan&style=flat-square)

A structured way to manage Preferences.

### Preference Class
```dart
var settings = AppPreferences();

class AppPreferences extends SettingManifest {
  final theme = Preference<String>.options(
    key: 'theme',
    defaultValue: 'blue',
    options: [
      Option('blue'),
      Option('red'),
      Option('orange'),
    ],
  );

  final username = Preference<String>.any(
    key: 'username',
    defaultValue: 'user',
  );

  final volume = Preference.integer(
    key: 'volume',
    defaultValue: 10,
    min: 0,
    max: 15,
  );

  final askAgain = Preference.boolean(
    key: 'ask_again',
    defaultValue: true,
  );

  List<Preference> get preferences => [theme, username, volume, askAgain];
}
```

### Use

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefMan.initialize();
  // ...
}
```

```dart
 var username = settings.username.get();
  settings.username.setValue('new username');
```

# Persistent Variables

You don't have to declare your preferences in a SettingManifest, you can use them as persistent variables.

```dart
  final count = Preference.integer(key: 'counter', defaultValue: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(count.get().toString()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await count.setValue(count.get() + 1);
          setState(() {});
        },
      ),
    );
  }
```
The count will persist between runs!

## Observability

The `Preference` class implements the `Listenable` interface, so you can use it 
with `AnimatedBuilder` or other means of reacting to its changes.

```dart
  final count = Preference.integer(key: 'counter', defaultValue: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: count,
          builder: (context, _) => Text(count.get().toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => count.setValue(count.get() + 1),
      ),
    );
  }
``` 