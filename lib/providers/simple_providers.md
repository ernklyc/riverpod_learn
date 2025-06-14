# Provider (Basit Provider) - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, Flutter uygulamanızda **sabit değerleri** global olarak kullanmak için oluşturulmuştur. Yani değişmeyecek, hep aynı kalacak değerleri (metin, sayı, ayarlar vb.) uygulamanın her yerinden erişilebilir hale getirmek için kullanılır.

---

## 🧠 Provider Nedir? (Çok Basit Anlatım)

Düşünün ki elinizde bir **sözlük** var. Bu sözlükte "merhaba" kelimesinin İngilizce karşılığı "hello" yazıyor. Bu bilgi değişmez, hep aynı kalır. İşte `Provider` da böyle bir sözlük gibidir. İçinde sabit bilgiler tutar ve bu bilgileri uygulamanın her yerinden okuyabilirsiniz.

### Provider'ın Özellikleri:
1. **Sabit değerler tutar** (değişmez)
2. **Global erişim sağlar** (uygulamanın her yerinden erişilebilir)
3. **Performanslıdır** (state tutmadığı için hızlı)
4. **Basittir** (sadece değer döndürür)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### 1. Import Satırı
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

**Ne yapar?**
- Flutter Riverpod paketini projenize dahil eder
- Bu satır olmadan Provider sınıfını kullanamazsınız
- Riverpod = River (nehir) + Pod (kapsül) = Veri akışını yöneten kapsül

**Neden gerekli?**
- Dart dilinde başka dosyalardan sınıf kullanmak için import gereklidir
- Bu satır olmadan kod çalışmaz, "Provider bulunamadı" hatası verir

**Gerçek hayat örneği:**
Bir kütüphaneden kitap almak istiyorsanız, önce kütüphaneye gitmeniz gerekir. Burada da Provider'ı kullanmak için önce Riverpod kütüphanesini "import" etmeniz gerekir.

---

### 2. İlk Provider Tanımı

```dart
final simpleProvider = Provider<String>((ref) {
  return 'Hello, Provider!';
});
```

Bu kod bloğunu kelime kelime açıklayalım:

#### `final` Anahtar Kelimesi
- **Ne yapar?** Bu değişkenin sadece bir kez atanabileceğini belirtir
- **Neden kullanılır?** Provider'lar genellikle değişmez, bu yüzden `final` kullanırız
- **Alternatifi:** `var` veya `const` da kullanılabilir ama `final` en uygunudur

#### `simpleProvider` İsmi
- **Ne yapar?** Provider'ımızın adını belirtir
- **Neden bu isim?** "simple" = basit, "Provider" = sağlayıcı
- **Değiştirebilir miyiz?** Evet! İstediğiniz ismi verebilirsiniz:
  - `welcomeMessageProvider` (hoş geldin mesajı için)
  - `appNameProvider` (uygulama adı için)
  - `versionProvider` (versiyon için)

#### `Provider<String>` Kısmı
- **Provider:** Riverpod'dan gelen özel sınıf
- **`<String>`:** Bu provider'ın String (metin) tipinde veri döndüreceğini belirtir
- **Diğer tipler:**
  - `Provider<int>` → Tam sayı için
  - `Provider<bool>` → true/false için
  - `Provider<double>` → Ondalıklı sayı için
  - `Provider<List<String>>` → Metin listesi için

#### `((ref) { return 'Hello, Provider!'; })` Kısmı
Bu kısım biraz karmaşık görünebilir, parçalayalım:

- **`(ref)`:** Provider'ın aldığı parametre (şimdilik önemli değil)
- **`{}`:** Fonksiyon gövdesi
- **`return`:** "şunu döndür" anlamında
- **`'Hello, Provider!'`:** Döndürülecek değer

**Tüm kod ne anlama gelir?**
"simpleProvider adında bir Provider oluştur. Bu provider String tipinde veri döndürsün ve değeri 'Hello, Provider!' olsun."

---

### 3. İkinci Provider Tanımı (Kısa Yazım)

```dart
final atackOnTitan = Provider<String>((ref) => 'Attack on Titan');
```

**Bu yazım şekli neden farklı?**
- `=>` işareti tek satırlık fonksiyon yazma yöntemidir
- `{ return 'Attack on Titan'; }` ile aynı anlama gelir
- Daha kısa ve okunabilir

**Kelime kelime açıklama:**
- `final atackOnTitan`: Provider'ın adı
- `Provider<String>`: String tipinde veri döndürür
- `(ref) =>`: Parametre alır ve şunu döndür
- `'Attack on Titan'`: Döndürülecek değer

---

### 4. Üçüncü Provider Tanımı (Sayı)

```dart
final yearProvider = Provider<int>((ref) => 2025);
```

**Bu provider'ın özelliği:**
- Integer (tam sayı) tipinde veri döndürür
- Değeri 2025'tir
- Yıl bilgisi için kullanılabilir

**Kullanım alanları:**
- Mevcut yıl
- Uygulama sürümü
- Maksimum değer
- Varsayılan sayı

---

### 5. Dördüncü Provider Tanımı (Uygulama Başlığı)

```dart
final appBarTitle = Provider<String>((ref) => 'Providers Learning');
```

**Bu provider'ın amacı:**
- Uygulama başlığını tutar
- AppBar'da kullanılabilir
- Sabit bir metin döndürür

**Neden böyle bir provider oluştururuz?**
- Başlığı tek yerden yönetmek için
- Başlığı değiştirmek istediğimizde sadece burayı değiştiririz
- Uygulamanın her yerinde aynı başlık kullanılır

---

## 🎮 Gerçek Hayat Örnekleri

### Örnek 1: Uygulama Ayarları
```dart
final appNameProvider = Provider<String>((ref) => 'Süper Uygulama');
final appVersionProvider = Provider<String>((ref) => '1.0.0');
final maxFileSize = Provider<int>((ref) => 10); // MB cinsinden
```

### Örnek 2: Sabit Metinler
```dart
final welcomeMessageProvider = Provider<String>((ref) => 'Hoş Geldiniz!');
final errorMessageProvider = Provider<String>((ref) => 'Bir hata oluştu');
final successMessageProvider = Provider<String>((ref) => 'İşlem başarılı');
```

### Örnek 3: Renkler ve Temalar
```dart
final primaryColorProvider = Provider<Color>((ref) => Colors.blue);
final secondaryColorProvider = Provider<Color>((ref) => Colors.orange);
final backgroundColorProvider = Provider<Color>((ref) => Colors.white);
```

### Örnek 4: API Ayarları
```dart
final baseUrlProvider = Provider<String>((ref) => 'https://api.example.com');
final apiVersionProvider = Provider<String>((ref) => 'v1');
final timeoutProvider = Provider<int>((ref) => 30); // saniye
```

### Örnek 5: Oyun Ayarları
```dart
final maxLevelProvider = Provider<int>((ref) => 100);
final defaultLivesProvider = Provider<int>((ref) => 3);
final gameNameProvider = Provider<String>((ref) => 'Süper Oyun');
```

---

## 🏗️ Widget İçinde Nasıl Kullanılır? (Adım Adım)

### 1. Widget'ı Hazırlama
```dart
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Buraya kod gelecek
  }
}
```

**Önemli:** `ConsumerWidget` kullanmalısınız, normal `StatelessWidget` değil!

### 2. Provider'dan Değer Alma
```dart
final message = ref.watch(simpleProvider);
final anime = ref.watch(atackOnTitan);
final year = ref.watch(yearProvider);
final title = ref.watch(appBarTitle);
```

**Ne yapar?**
- Her provider'dan değeri alır
- `message` değişkeni "Hello, Provider!" değerini tutar
- `anime` değişkeni "Attack on Titan" değerini tutar
- `year` değişkeni 2025 değerini tutar
- `title` değişkeni "Providers Learning" değerini tutar

### 3. Tam Örnek Widget
```dart
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider'lardan değerleri al
    final message = ref.watch(simpleProvider);
    final anime = ref.watch(atackOnTitan);
    final year = ref.watch(yearProvider);
    final title = ref.watch(appBarTitle);

    return Scaffold(
      appBar: AppBar(
        title: Text(title), // "Providers Learning"
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık
            Text(
              'Provider Örnekleri',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 30),
            
            // Basit mesaj
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basit Mesaj:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    message, // "Hello, Provider!"
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Anime adı
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Favori Anime:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    anime, // "Attack on Titan"
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Yıl bilgisi
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mevcut Yıl:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '$year', // "2025"
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            
            // Bilgi kutusu
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.blue[800],
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bu değerler Provider\'lardan geliyor!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Sabit değerler olduğu için değişmezler.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🔄 Veri Akışı Nasıl Çalışır?

### Adım Adım Süreç:

1. **Uygulama başlar**
2. **Provider'lar tanımlanır** (simpleProvider, atackOnTitan vb.)
3. **Widget oluşturulur** (HomeScreen)
4. **ref.watch() çağrılır** (Provider'dan değer istenir)
5. **Provider değeri döndürür** ("Hello, Provider!" vb.)
6. **Widget değeri alır ve ekranda gösterir**

### Görsel Anlatım:
```
Uygulama Başlar
        ↓
Provider'lar Hazır Bekler
        ↓
Widget ref.watch() Çağırır
        ↓
Provider Değeri Döndürür
        ↓
Widget Değeri Ekranda Gösterir
```

### Detaylı Açıklama:
- **Provider'lar** birer fabrika gibidir
- **Her fabrika** belirli bir ürün üretir (metin, sayı vb.)
- **Widget'lar** fabrikadan ürün ister
- **Fabrika** hep aynı ürünü verir (sabit değer)
- **Widget** ürünü alır ve kullanır

---

## ⚡ ref.watch() vs ref.read() Farkı (Provider İçin)

### ref.watch() - İzleyici
```dart
final message = ref.watch(simpleProvider);
```

**Provider için ne yapar?**
- Provider'dan değeri alır
- Provider değişmediği için widget yeniden çizilmez
- Sadece değeri okur

### ref.read() - Okuyucu
```dart
final message = ref.read(simpleProvider);
```

**Provider için ne yapar?**
- Provider'dan değeri alır
- ref.watch() ile aynı sonucu verir
- Provider sabit olduğu için fark yoktur

### Provider İçin Hangi Kullanılmalı?
**Cevap:** İkisi de kullanılabilir! Çünkü Provider sabit değer döndürür.

**Genel kural:**
- Widget'ta göstermek için → `ref.watch()`
- Fonksiyonlarda kullanmak için → `ref.read()`

---

## 🎯 Ne Zaman Provider Kullanmalısınız?

### ✅ Kullanın:
1. **Sabit değerler için** (değişmeyen veriler)
2. **Uygulama ayarları için** (isim, versiyon vb.)
3. **Sabit metinler için** (başlıklar, mesajlar)
4. **Renk ve tema ayarları için**
5. **API URL'leri için**
6. **Maksimum/minimum değerler için**

### ❌ Kullanmayın:
1. **Değişken veriler için** (StateProvider kullanın)
2. **Kullanıcı girdileri için**
3. **API'den gelen veriler için**
4. **Sayaçlar için**
5. **Form verileri için**

### Karar Verme Rehberi:
```
Veri değişecek mi?
├─ Hayır (sabit) → Provider kullanın
└─ Evet (değişken)
   ├─ Basit değer mi? → StateProvider kullanın
   └─ Karmaşık mı? → StateNotifierProvider kullanın
```

---

## 🧪 Test Nasıl Yazılır?

### Basit Test Örneği:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('Provider değer testi', () {
    // Test container'ı oluştur
    final container = ProviderContainer();
    
    // Provider değerlerini kontrol et
    expect(container.read(simpleProvider), 'Hello, Provider!');
    expect(container.read(atackOnTitan), 'Attack on Titan');
    expect(container.read(yearProvider), 2025);
    expect(container.read(appBarTitle), 'Providers Learning');
    
    // Container'ı temizle
    container.dispose();
  });
  
  test('Provider tip testi', () {
    final container = ProviderContainer();
    
    // Tip kontrolü
    expect(container.read(simpleProvider), isA<String>());
    expect(container.read(yearProvider), isA<int>());
    
    container.dispose();
  });
}
```

### Widget Test Örneği:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Provider widget testi', (WidgetTester tester) async {
    // Widget'ı ProviderScope ile sar
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    
    // Provider değerlerinin ekranda göründüğünü kontrol et
    expect(find.text('Hello, Provider!'), findsOneWidget);
    expect(find.text('Attack on Titan'), findsOneWidget);
    expect(find.text('2025'), findsOneWidget);
    expect(find.text('Providers Learning'), findsOneWidget);
  });
}
```

---

## 🚀 Avantajları (Neden Kullanmalısınız?)

### 1. **Basitlik**
- Çok az kod yazmanız gerekir
- Anlaması çok kolaydır
- Hızlıca öğrenebilirsiniz

### 2. **Performans**
- Çok hızlıdır
- Bellek kullanımı minimumdur
- State tutmadığı için verimlidir

### 3. **Global Erişim**
- Uygulamanın her yerinden erişilebilir
- Widget ağacında geçirme gerekmez
- Prop drilling problemi yoktur

### 4. **Merkezi Yönetim**
- Tüm sabit değerler tek yerde
- Değiştirmek istediğinizde tek yerden değiştirirsiniz
- Tutarlılık sağlar

### 5. **Test Edilebilirlik**
- Test yazmak çok kolaydır
- Mock'lamak basittir
- Güvenilir testler yazabilirsiniz

---

## ⚠️ Dezavantajları (Dikkat Edilmesi Gerekenler)

### 1. **Sadece Sabit Değerler**
- Değişken veriler için kullanılamaz
- State yönetimi yapmaz
- Dinamik içerik için uygun değil

### 2. **Sınırlı Fonksiyonalite**
- Sadece değer döndürür
- İş mantığı içeremez
- Karmaşık işlemler yapamaz

### 3. **Öğrenme Eğrisi**
- Riverpod öğrenmek gerekir
- Provider türlerini ayırt etmek gerekir

---

## 🔧 İpuçları ve En İyi Uygulamalar

### 1. **İsimlendirme**
```dart
// ✅ İyi - Açıklayıcı isimler
final appNameProvider = Provider<String>((ref) => 'Süper Uygulama');
final maxFileSizeProvider = Provider<int>((ref) => 10);

// ❌ Kötü - Belirsiz isimler
final provider1 = Provider<String>((ref) => 'Süper Uygulama');
final x = Provider<int>((ref) => 10);
```

### 2. **Tip Belirtme**
```dart
// ✅ İyi - Tip açık
final messageProvider = Provider<String>((ref) => 'Merhaba');

// ❌ Kötü - Tip belirsiz
final messageProvider = Provider((ref) => 'Merhaba');
```

### 3. **Gruplama**
```dart
// ✅ İyi - İlgili provider'ları grupla
// Uygulama ayarları
final appNameProvider = Provider<String>((ref) => 'Uygulama');
final appVersionProvider = Provider<String>((ref) => '1.0.0');

// Renk ayarları
final primaryColorProvider = Provider<Color>((ref) => Colors.blue);
final secondaryColorProvider = Provider<Color>((ref) => Colors.orange);
```

### 4. **Dosya Organizasyonu**
```
lib/
  providers/
    app_providers.dart       // Uygulama ayarları
    theme_providers.dart     // Renk ve tema
    text_providers.dart      // Sabit metinler
    config_providers.dart    // Konfigürasyon
```

### 5. **Yorumlama**
```dart
// ✅ İyi - Açıklayıcı yorumlar
/// Uygulamanın ana başlığı
final appTitleProvider = Provider<String>((ref) => 'Süper Uygulama');

/// Maksimum dosya boyutu (MB cinsinden)
final maxFileSizeProvider = Provider<int>((ref) => 10);
```

---

## 🎓 Sonuç ve Öneriler

Provider, Flutter'da **sabit değerleri yönetmek** için mükemmel bir araçtır. Eğer:

- Sabit değerleriniz varsa
- Bu değerleri global olarak kullanmak istiyorsanız
- Basit ve performanslı bir çözüm arıyorsanız
- Flutter'a yeni başlıyorsanız

O zaman Provider'ı kesinlikle kullanmalısınız.

### Öğrenme Sırası:
1. **İlk önce Provider'ı öğrenin** (sabit değerler için)
2. Sonra StateProvider'ı öğrenin (değişken değerler için)
3. En son StateNotifierProvider'ı öğrenin (karmaşık durumlar için)

### Ne Zaman Geçiş Yapmalısınız?
Provider'dan diğer provider türlerine ne zaman geçmelisiniz?
- **Değer değişecekse** → StateProvider'a geçin
- **Birden fazla fonksiyon gerekiyorsa** → StateNotifierProvider'a geçin
- **API çağrısı yapacaksanız** → FutureProvider'a geçin

---

## 📚 Ek Kaynaklar ve Örnekler

### Daha Fazla Örnek:

#### Uygulama Konfigürasyonu:
```dart
final appConfigProvider = Provider<Map<String, dynamic>>((ref) => {
  'name': 'Süper Uygulama',
  'version': '1.0.0',
  'author': 'Geliştirici',
  'email': 'info@example.com',
});

// Kullanımı:
final config = ref.watch(appConfigProvider);
Text('Uygulama: ${config['name']}')
```

#### Tema Ayarları:
```dart
final lightThemeProvider = Provider<ThemeData>((ref) => ThemeData.light());
final darkThemeProvider = Provider<ThemeData>((ref) => ThemeData.dark());

// Kullanımı:
MaterialApp(
  theme: ref.watch(lightThemeProvider),
  // ...
)
```

#### Sabit Listeler:
```dart
final countriesProvider = Provider<List<String>>((ref) => [
  'Türkiye',
  'Amerika',
  'Almanya',
  'Fransa',
]);

// Kullanımı:
final countries = ref.watch(countriesProvider);
DropdownButton<String>(
  items: countries.map((country) => 
    DropdownMenuItem(value: country, child: Text(country))
  ).toList(),
)
```

### Faydalı Linkler:
- [Riverpod Resmi Dokümantasyonu](https://riverpod.dev)
- [Flutter State Management Rehberi](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- StateProvider ile karşılaştırma için `state_provider.md` dosyasını okuyun
- StateNotifierProvider için `state_notifier_provider.md` dosyasını okuyun

Bu rehberi okuduktan sonra Provider'ı rahatlıkla kullanabilir ve ne zaman hangi provider türünü kullanacağınızı bilebilirsiniz! 