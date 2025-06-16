# ThemeChangeProvider - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, Flutter uygulamanızda **karanlık mod ve aydınlık mod** arasında geçiş yapmak için kullanılır. Yani kullanıcı istedığinde uygulamanın temasını değiştirmek, gece/gündüz modu seçmek istediğinizde bu dosyayı kullanırsınız. Bu dosya özellikle **kullanıcı tercihleri** ve **görsel deneyim** için tasarlanmıştır.

---

## 🧠 ThemeChangeProvider Nedir? (Çok Basit Anlatım)

Düşünün ki odanızda bir **lamba anahtarı** var. Bu anahtarı açınca oda aydınlanıyor, kapatınca karanlık oluyor. İşte `ThemeChangeProvider` da böyle bir anahtar gibidir. Uygulamanızda "aydınlık mod" ile "karanlık mod" arasında geçiş yapmanızı sağlar.

### ThemeChangeProvider'ın Özellikleri:
1. **Boolean değer tutar** (true/false - açık/kapalı)
2. **Tema durumunu kontrol eder** (aydınlık/karanlık)
3. **Kullanıcı tercihi saklar** (geçici olarak)
4. **Tüm uygulamayı etkiler** (global tema değişimi)
5. **Anlık değişim** (switch yapınca hemen değişir)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### Kod Analizi:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeChangeProvider = StateProvider<bool>((ref) => true);
```

**Ne yapar bu kod?**
- `StateProvider<bool>`: Boolean tipinde state tutar
- `true`: Başlangıç değeri (aydınlık mod aktif)
- Kullanıcı bu değeri değiştirebilir

---

## 🎮 Widget'ta Nasıl Kullanılır?

### 1. Ana Uygulamada Tema Kontrolü:
```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChange = ref.watch(themeChangeProvider);
    
    return MaterialApp(
      theme: themeChange ? ThemeData.light() : ThemeData.dark(),
      home: HomePage(),
    );
  }
}
```

### 2. Tema Değiştirme Switch'i:
```dart
class ThemeSwitch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChange = ref.watch(themeChangeProvider);
    
    return Switch(
      value: themeChange,
      onChanged: (newValue) {
        ref.read(themeChangeProvider.notifier).state = newValue;
      },
      activeColor: Colors.blue,
      inactiveThumbColor: Colors.grey,
    );
  }
}
```

### 3. Tema Değiştirme Butonu:
```dart
class ThemeToggleButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChange = ref.watch(themeChangeProvider);
    
    return IconButton(
      icon: Icon(
        themeChange ? Icons.light_mode : Icons.dark_mode,
        color: themeChange ? Colors.orange : Colors.blue,
      ),
      onPressed: () {
        ref.read(themeChangeProvider.notifier).state = !themeChange;
      },
      tooltip: themeChange ? 'Karanlık Moda Geç' : 'Aydınlık Moda Geç',
    );
  }
}
```

### 4. Animasyonlu Tema Değiştirici:
```dart
class AnimatedThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeChangeProvider);
    
    return GestureDetector(
      onTap: () {
        ref.read(themeChangeProvider.notifier).state = !isDarkTheme;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isDarkTheme ? Colors.grey[800] : Colors.orange[300],
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 300),
          alignment: isDarkTheme ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              isDarkTheme ? Icons.nights_stay : Icons.wb_sunny,
              size: 16,
              color: isDarkTheme ? Colors.grey[800] : Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 🎨 Özel Tema Oluşturma

### 1. Özel Renklerle Tema:
```dart
class CustomThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );
  
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple[800],
      foregroundColor: Colors.white,
    ),
  );
}

// Kullanım:
MaterialApp(
  theme: themeChange ? CustomThemes.lightTheme : CustomThemes.darkTheme,
  home: HomePage(),
)
```

### 2. Sistem Temasını Takip Etme:
```dart
class SystemThemeProvider extends StateNotifier<bool> {
  SystemThemeProvider() : super(true) {
    _getSystemTheme();
  }
  
  void _getSystemTheme() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    state = brightness == Brightness.light;
  }
  
  void toggleTheme() {
    state = !state;
  }
}
```

---

## ⚡ ref.watch() ve ref.read() Farkı

### ref.watch() - İzleme Modu:
```dart
final themeChange = ref.watch(themeChangeProvider);
```
- Provider'ı sürekli izler
- Değer değiştiğinde widget yeniden çizilir
- UI güncellemeleri için kullanılır

### ref.read() - Değiştirme Modu:
```dart
ref.read(themeChangeProvider.notifier).state = !themeChange;
```
- Provider'ı sadece değiştirmek için kullanılır
- Event handler'larda kullanılır
- Widget yeniden çizilmez

---

## 🔄 Kalıcı Tema Saklama

### SharedPreferences ile Tema Kaydetme:
```dart
import 'package:shared_preferences/shared_preferences.dart';

class PersistentThemeProvider extends StateNotifier<bool> {
  PersistentThemeProvider() : super(true) {
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isDarkTheme') ?? true;
  }
  
  Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    state = isDark;
    await prefs.setBool('isDarkTheme', isDark);
  }
}
```

---

## 🎯 Ne Zaman Kullanmalısınız?

### ✅ Kullanın:
1. **Kullanıcı tema seçimi** sunacağınızda
2. **Karanlık/aydınlık mod** gerektiğinde
3. **Modern app design** istediğinizde
4. **Accessibility** özellikleri için
5. **Kullanıcı deneyimi** iyileştirmek için

### ❌ Kullanmayın:
1. **Tek tema yeterli** olduğunda
2. **Çok basit uygulamalar** için
3. **Tema önemli değil** ise

---

## 🧪 Test Örnekleri

```dart
test('Tema değiştirme testi', () {
  final container = ProviderContainer();
  
  // Başlangıç: true (aydınlık)
  expect(container.read(themeChangeProvider), true);
  
  // Değiştir: false (karanlık)
  container.read(themeChangeProvider.notifier).state = false;
  expect(container.read(themeChangeProvider), false);
});

testWidgets('Tema butonu testi', (WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(home: ThemeToggleButton()),
    ),
  );
  
  // Butona tıkla
  await tester.tap(find.byType(IconButton));
  await tester.pump();
  
  // Tema değişmiş olmalı
  // Widget test kodları...
});
```

---

## 🚀 Avantajları

1. **Kullanıcı Deneyimi**: Kişisel tercih imkanı
2. **Modern Design**: Güncel uygulama standartları
3. **Accessibility**: Görme zorluğu olan kullanıcılar için
4. **Pil Tasarrufu**: OLED ekranlarda karanlık mod
5. **Kolay Implementasyon**: Tek satır kod ile çalışır

---

## ⚠️ Dikkat Edilmesi Gerekenler

1. **Geçici Saklama**: Uygulama kapanınca sıfırlanır
2. **Basit Yapı**: Sadece iki seçenek (light/dark)
3. **Kalıcı saklama** için SharedPreferences gerekir

---

## 🔧 İpuçları

### 1. Animasyonlu Geçiş:
```dart
AnimatedTheme(
  duration: Duration(milliseconds: 300),
  data: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
  child: MyApp(),
)
```

### 2. Tema Durumuna Göre Renkler:
```dart
Container(
  color: isDarkTheme ? Colors.grey[900] : Colors.white,
  child: Text(
    'Merhaba',
    style: TextStyle(
      color: isDarkTheme ? Colors.white : Colors.black,
    ),
  ),
)
```

---

## 🎓 Sonuç

ThemeChangeProvider, **basit tema yönetimi** için mükemmel bir araçtır. Modern uygulamalarda kullanıcı deneyimini artırmak için kesinlikle kullanmalısınız.

Bu basit ama güçlü provider'ı kullanarak harika tema deneyimleri oluşturabilirsiniz! 