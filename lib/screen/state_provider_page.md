# State Provider Page - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu sayfa, **StateProvider**'ın nasıl kullanıldığını gösteren basit bir demo ekranıdır. En temel counter uygulamasını StateProvider ile nasıl yapacağınızı öğretir. Artırma ve azaltma işlemleri ile simple state management sağlar.

---

## 🧠 State Provider Page Nedir? (Çok Basit Anlatım)

Düşünün ki **basit bir sayaç** var. Bu sayacın sadece 2 özelliği var:
- `+` butonu → Sayıyı artırır
- `-` butonu → Sayıyı azaltır

StateProvider de en basit haliyle böyle çalışır! Tek bir değeri yönetir ve değiştirir.

### Bu Sayfanın Özellikleri:
1. **Simple state management** (basit state yönetimi)
2. **Direct state mutation** (direkt state değişikliği)
3. **Minimal boilerplate** (en az kod)
4. **Easy to understand** (anlaması kolay)
5. **Quick prototyping** (hızlı prototipleme)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### Kod Analizi:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/state_provider.dart';

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('State Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $counter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(onPressed: () {
            ref.read(counterProvider.notifier).state++;
          }, child: Icon(Icons.add)),
          FloatingActionButton(onPressed: () {
            ref.read(counterProvider.notifier).state--;
          }, child: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
```

**Kelime kelime açıklama:**

### 1. State'i İzleme:
```dart
final counter = ref.watch(counterProvider);
```

**Ne yapar?**
- `ref.watch()`: StateProvider'ı dinler
- `counterProvider`: Integer tutan basit state provider
- `counter`: Mevcut counter değerini tutar

### 2. State'i Değiştirme:
```dart
ref.read(counterProvider.notifier).state++;
```

**Kelime kelime açıklama:**
- `ref.read()`: Provider'ı bir kez okur (action için)
- `.notifier`: StateNotifier instance'ına erişir
- `.state++`: State değerini 1 artırır

### 3. StateProvider Definition:
```dart
// state_provider.dart dosyasında muhtemelen:
final counterProvider = StateProvider<int>((ref) => 0);
```

**Açıklama:**
- `StateProvider<int>`: Integer tipinde basit state
- `(ref) => 0`: Initial value (başlangıç değeri) 0

---

## 🌊 StateProvider vs StateNotifier

### StateProvider:
```dart
// Tanım
final counterProvider = StateProvider<int>((ref) => 0);

// Kullanım
ref.read(counterProvider.notifier).state++; // Direct assignment
```

### StateNotifier:
```dart
// Tanım
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() => state++;
}

// Kullanım  
ref.read(counterNotifierProvider.notifier).increment(); // Method call
```

---

## 🎮 Gelişmiş StateProvider Örnekleri

### 1. Multiple State Providers:
```dart
// Different state providers
final counterProvider = StateProvider<int>((ref) => 0);
final nameProvider = StateProvider<String>((ref) => '');
final isLoadingProvider = StateProvider<bool>((ref) => false);
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class MultipleStateProvidersPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final name = ref.watch(nameProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final themeMode = ref.watch(themeProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Multiple State Providers')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Counter Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Counter: $counter', style: TextStyle(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.notifier).state++;
                          },
                          child: Text('+'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.notifier).state--;
                          },
                          child: Text('-'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.notifier).state = 0;
                          },
                          child: Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Name Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Name: ${name.isEmpty ? "No name" : name}'),
                    SizedBox(height: 8),
                    TextField(
                      onChanged: (value) {
                        ref.read(nameProvider.notifier).state = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Loading Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Loading: ${isLoading ? "Yes" : "No"}'),
                    SizedBox(height: 8),
                    if (isLoading) CircularProgressIndicator(),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(isLoadingProvider.notifier).state = !isLoading;
                      },
                      child: Text(isLoading ? 'Stop Loading' : 'Start Loading'),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Theme Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Theme: ${themeMode.name}'),
                    SizedBox(height: 8),
                    ToggleButtons(
                      isSelected: [
                        themeMode == ThemeMode.light,
                        themeMode == ThemeMode.dark,
                        themeMode == ThemeMode.system,
                      ],
                      onPressed: (index) {
                        final themes = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
                        ref.read(themeProvider.notifier).state = themes[index];
                      },
                      children: [
                        Icon(Icons.light_mode),
                        Icon(Icons.dark_mode),
                        Icon(Icons.auto_mode),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Form State Management:
```dart
// Form state providers
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final rememberMeProvider = StateProvider<bool>((ref) => false);
final formValidationProvider = StateProvider<Map<String, String?>>((ref) => {});

// Computed provider for form validity
final isFormValidProvider = Provider<bool>((ref) {
  final email = ref.watch(emailProvider);
  final password = ref.watch(passwordProvider);
  final errors = ref.watch(formValidationProvider);
  
  return email.isNotEmpty && 
         password.isNotEmpty && 
         errors.isEmpty &&
         email.contains('@');
});

class FormWithStateProviders extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    final rememberMe = ref.watch(rememberMeProvider);
    final isFormValid = ref.watch(isFormValidProvider);
    final errors = ref.watch(formValidationProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Form Example')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Email Field
            TextField(
              onChanged: (value) {
                ref.read(emailProvider.notifier).state = value;
                _validateForm(ref);
              },
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: errors['email'],
                border: OutlineInputBorder(),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Password Field
            TextField(
              obscureText: true,
              onChanged: (value) {
                ref.read(passwordProvider.notifier).state = value;
                _validateForm(ref);
              },
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: errors['password'],
                border: OutlineInputBorder(),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Remember Me
            CheckboxListTile(
              title: Text('Remember Me'),
              value: rememberMe,
              onChanged: (value) {
                ref.read(rememberMeProvider.notifier).state = value ?? false;
              },
            ),
            
            SizedBox(height: 24),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFormValid ? () => _submitForm(ref) : null,
                child: Text('Login'),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Form State Debug Info
            Card(
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Form State:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Email: $email'),
                    Text('Password: ${"*" * password.length}'),
                    Text('Remember Me: $rememberMe'),
                    Text('Is Valid: $isFormValid'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _validateForm(WidgetRef ref) {
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    final errors = <String, String?>{};
    
    if (email.isNotEmpty && !email.contains('@')) {
      errors['email'] = 'Invalid email format';
    }
    
    if (password.isNotEmpty && password.length < 6) {
      errors['password'] = 'Password must be at least 6 characters';
    }
    
    ref.read(formValidationProvider.notifier).state = errors;
  }
  
  void _submitForm(WidgetRef ref) {
    print('Form submitted!');
    // Clear form
    ref.read(emailProvider.notifier).state = '';
    ref.read(passwordProvider.notifier).state = '';
    ref.read(rememberMeProvider.notifier).state = false;
  }
}
```

### 3. Settings Management:
```dart
// Settings providers
final usernameProvider = StateProvider<String>((ref) => 'User');
final notificationsEnabledProvider = StateProvider<bool>((ref) => true);
final volumeProvider = StateProvider<double>((ref) => 0.5);
final selectedLanguageProvider = StateProvider<String>((ref) => 'Turkish');

class SettingsPage extends ConsumerWidget {
  final List<String> languages = ['Turkish', 'English', 'German', 'French'];
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);
    final volume = ref.watch(volumeProvider);
    final selectedLanguage = ref.watch(selectedLanguageProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Profile Section
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      ref.read(usernameProvider.notifier).state = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: username,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Preferences Section
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  
                  // Notifications
                  SwitchListTile(
                    title: Text('Enable Notifications'),
                    subtitle: Text('Receive push notifications'),
                    value: notificationsEnabled,
                    onChanged: (value) {
                      ref.read(notificationsEnabledProvider.notifier).state = value;
                    },
                  ),
                  
                  // Volume
                  ListTile(
                    title: Text('Volume'),
                    subtitle: Slider(
                      value: volume,
                      onChanged: (value) {
                        ref.read(volumeProvider.notifier).state = value;
                      },
                      divisions: 10,
                      label: '${(volume * 100).round()}%',
                    ),
                  ),
                  
                  // Language
                  ListTile(
                    title: Text('Language'),
                    subtitle: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedLanguage,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(selectedLanguageProvider.notifier).state = value;
                        }
                      },
                      items: languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Actions
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _saveSettings(ref),
                      child: Text('Save Settings'),
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _resetSettings(ref),
                      child: Text('Reset to Defaults'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _saveSettings(WidgetRef ref) {
    // Save to persistent storage
    print('Settings saved!');
  }
  
  void _resetSettings(WidgetRef ref) {
    ref.read(usernameProvider.notifier).state = 'User';
    ref.read(notificationsEnabledProvider.notifier).state = true;
    ref.read(volumeProvider.notifier).state = 0.5;
    ref.read(selectedLanguageProvider.notifier).state = 'Turkish';
  }
}
```

---

## 🧪 Test Örnekleri

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('StateProvider Tests', () {
    test('should increment counter', () {
      final container = ProviderContainer();
      
      expect(container.read(counterProvider), 0);
      
      container.read(counterProvider.notifier).state++;
      expect(container.read(counterProvider), 1);
      
      container.dispose();
    });
    
    test('should decrement counter', () {
      final container = ProviderContainer();
      
      container.read(counterProvider.notifier).state = 5;
      container.read(counterProvider.notifier).state--;
      
      expect(container.read(counterProvider), 4);
      
      container.dispose();
    });
    
    test('should reset counter', () {
      final container = ProviderContainer();
      
      container.read(counterProvider.notifier).state = 10;
      container.read(counterProvider.notifier).state = 0;
      
      expect(container.read(counterProvider), 0);
      
      container.dispose();
    });

    testWidgets('should update UI when state changes', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: StateProviderPage(),
          ),
        ),
      );

      expect(find.text('Counter: 0'), findsOneWidget);
      
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      expect(find.text('Counter: 1'), findsOneWidget);
    });
  });
}
```

---

## 🎯 StateProvider vs Diğer Provider'lar

### StateProvider Kullanın:
1. **Simple values** (int, String, bool)
2. **Quick prototyping** 
3. **Form inputs**
4. **UI state** (loading, selected items)
5. **Settings/preferences**

### StateNotifier Kullanın:
1. **Complex logic**
2. **Multiple related actions**
3. **Business rules**
4. **Immutable updates**

### FutureProvider Kullanın:
1. **API calls**
2. **Async operations**
3. **Loading states**

---

## 🚀 Avantajları

1. **Simplicity**: En basit state management
2. **Direct access**: State'e direkt erişim
3. **Minimal boilerplate**: Az kod
4. **Easy debugging**: Kolay debug
5. **Fast development**: Hızlı geliştirme

---

## ⚠️ Dikkat Edilmesi Gerekenler

1. **Scalability**: Büyük uygulamalar için uygun değil
2. **Complex logic**: Karmaşık mantık için StateNotifier kullanın
3. **Testing**: State mutations'ları dikkatli test edin
4. **Type safety**: Doğru tipleri kullanın

---

## 🎓 Sonuç

StateProvider, **simple state management** için mükemmeldir. Bu pattern'i kullanarak:
- **Quick prototypes** oluşturabilirsiniz
- **Simple form states** yönetebilirsiniz
- **UI preferences** kaydedebilirsiniz
- **Basic counters/toggles** yapabilirsiniz

Bu sayfa, Riverpod'un en basit ama etkili özelliği olan StateProvider'ı öğretir!