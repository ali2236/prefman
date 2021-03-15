# prefman

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
  await settings.initialize();
  // ...
}
```

```dart
 var username = settings.username.get();
  settings.username.setValue('new username');
```