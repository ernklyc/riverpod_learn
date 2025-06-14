# StateProvider.autoDispose & keepAlive - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, Flutter uygulamanızda **otomatik bellek yönetimi** yapmak için kullanılır. Yani provider'ları ne zaman temizleyeceğinizi, ne zaman bellekte tutacağınızı kontrol etmek için bu dosyayı kullanırsınız. Bu dosya özellikle **memory leak'leri önlemek** ve **performansı optimize etmek** için tasarlanmıştır.

---

## 🧠 AutoDispose & keepAlive Nedir? (Çok Basit Anlatım)

Düşünün ki evinizde bir bulaşık makinesi var. Bulaşıkları yıkadıktan sonra makineyi kapatırsınız, elektrik tasarrufu için. Ama bazen misafir gelecek, tekrar bulaşık yıkayacaksınız, o zaman makineyi açık bırakırsınız. İşte `autoDispose` ve `keepAlive` de böyle çalışır:

- **autoDispose**: "Kullanılmadığında otomatik kapat" (bulaşık makinesi gibi)
- **keepAlive**: "Biraz daha açık tut" (misafir gelecek diye beklemek gibi)

### AutoDispose & keepAlive'ın Özellikleri:
1. **Otomatik bellek yönetimi** (automatic memory management)
2. **Memory leak önleme** (prevent memory leaks)
3. **Performans optimizasyonu** (performance optimization)
4. **Esnek kontrol** (flexible control)
5. **Timer tabanlı yönetim** (timer-based management)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### 1. Import Satırları
```dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

**Ne yapar?**
- **`dart:async`**: Timer ve async işlemler için gerekli
- **`flutter_riverpod`**: Provider'lar için gerekli paket

**Neden gerekli?**
- Timer kullanabilmek için dart:async şart
- autoDispose ve keepAlive için riverpod gerekli

**Gerçek hayat örneği:**
Zamanlayıcılı fırın kullanmak için önce fırının düğmelerini öğrenmeniz gerekir. Burada da Timer kullanmak için önce dart:async'i "import" etmeniz gerekir.

---

### 2. Yorum Satırı (Basit Versiyon)
```dart
//final counterStateDisposeProvider = StateProvider.autoDispose<int>((ref) => 0);
```

**Ne anlama gelir?**
- Bu basit autoDispose örneği (yorum satırında)
- Kullanılmadığında otomatik temizlenir
- En basit kullanım şekli

---

### 3. Gelişmiş AutoDispose Provider Tanımı

```dart
final counterStateDisposeProvider = StateProvider.autoDispose<int>((ref) {
  //ref.keepAlive();
  final cache = ref.keepAlive();
  final timer = Timer.periodic(const Duration(seconds: 10), (timer) => cache.close());
  ref.onDispose(() => timer.cancel());
  return 0;
});
```

Bu kod çok önemli! Kelime kelime açıklayalım:

#### `final counterStateDisposeProvider =`
- **`final`**: Bu değişken sadece bir kez atanır
- **`counterStateDisposeProvider`**: Provider'ımızın adı

#### `StateProvider.autoDispose<int>`
- **`StateProvider`**: Değiştirilebilir state provider'ı
- **`.autoDispose`**: Otomatik temizlik özelliği
- **`<int>`**: Integer tipinde veri tutar

#### `((ref) {`
- **`(ref)`**: Provider referansı
- **`{`**: Fonksiyon gövdesi başlar

#### `//ref.keepAlive();`
- **Yorum satırı**: Basit keepAlive kullanımı
- Eğer bu satır aktif olsaydı, provider hiç temizlenmezdi

#### `final cache = ref.keepAlive();`
- **`cache`**: keepAlive kontrolcüsü
- **`ref.keepAlive()`**: Provider'ı bellekte tut
- **Döndürülen değer**: Cache kontrolü için kullanılır

#### `final timer = Timer.periodic(`
- **`timer`**: Zamanlayıcı değişkeni
- **`Timer.periodic`**: Belirli aralıklarla çalışan zamanlayıcı

#### `const Duration(seconds: 10),`
- **`Duration(seconds: 10)`**: 10 saniye aralık
- **`const`**: Bu süre sabittir

#### `(timer) => cache.close()`
- **`(timer)`**: Timer parametresi
- **`cache.close()`**: Cache'i kapat, provider'ı temizle

#### `ref.onDispose(() => timer.cancel());`
- **`ref.onDispose`**: Provider temizlenirken çalışır
- **`timer.cancel()`**: Timer'ı iptal et

#### `return 0;`
- **`return 0`**: Başlangıç değeri 0

**Tüm kod ne anlama gelir?**
"counterStateDisposeProvider adında bir autoDispose StateProvider oluştur. Bu provider başlangıçta bellekte kalsın (keepAlive). Ama 10 saniye sonra otomatik olarak temizlensin. Provider tamamen temizlenirken timer'ı da iptal et."

---

## 🔄 AutoDispose Yaşam Döngüsü (Detaylı Anlatım)

### Normal Provider vs AutoDispose Provider:

#### Normal Provider (Hiç Temizlenmez):
```
Provider Oluşturulur
        ↓
Widget Kullanır
        ↓
Widget Kapanır
        ↓
Provider Hala Bellekte (Memory Leak!)
        ↓
Uygulama Kapanana Kadar Bellekte Kalır
```

#### AutoDispose Provider (Otomatik Temizlik):
```
Provider Oluşturulur
        ↓
Widget Kullanır
        ↓
Widget Kapanır
        ↓
Provider Otomatik Temizlenir
        ↓
Bellek Serbest Bırakılır ✅
```

### keepAlive ile Kontrollü Yönetim:
```
Provider Oluşturulur
        ↓
ref.keepAlive() Çağrılır
        ↓
Widget Kapanır (Ama Provider Bellekte Kalır)
        ↓
10 Saniye Geçer
        ↓
cache.close() Çağrılır
        ↓
Provider Temizlenir
        ↓
Bellek Serbest Bırakılır ✅
```

---

## 🏗️ Widget İçinde Nasıl Kullanılır? (Adım Adım)

### 1. Widget'ı Hazırlama
```dart
class AutoDisposeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Buraya kod gelecek
  }
}
```

### 2. AutoDispose Provider'ı Kullanma
```dart
final counter = ref.watch(counterStateDisposeProvider);
```

### 3. Tam Örnek Widget
```dart
class AutoDisposeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateDisposeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('AutoDispose & KeepAlive Demo'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[50]!, Colors.teal[100]!],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ana başlık kartı
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.teal[400]!, Colors.teal[600]!],
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.memory,
                        size: 48,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Bellek Yönetimi Demo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'AutoDispose & KeepAlive',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              
              // Sayaç göstergesi
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(
                        'Mevcut Değer',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [Colors.teal[300]!, Colors.teal[600]!],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '$counter',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ref.read(counterStateDisposeProvider.notifier).state--;
                            },
                            icon: Icon(Icons.remove),
                            label: Text('Azalt'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              ref.read(counterStateDisposeProvider.notifier).state++;
                            },
                            icon: Icon(Icons.add),
                            label: Text('Artır'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[400],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Bilgi kartları
              _buildInfoCard(
                'AutoDispose Nedir?',
                'Provider kullanılmadığında otomatik olarak bellekten temizlenir',
                Icons.auto_delete,
                Colors.blue,
              ),
              SizedBox(height: 15),
              
              _buildInfoCard(
                'KeepAlive Nedir?',
                'Provider\'ı bellekte tutmak için kullanılır, manuel kontrol sağlar',
                Icons.keep,
                Colors.orange,
              ),
              SizedBox(height: 15),
              
              _buildInfoCard(
                'Timer Kontrolü',
                '10 saniye sonra otomatik olarak cache kapatılır ve provider temizlenir',
                Icons.timer,
                Colors.purple,
              ),
              SizedBox(height: 30),
              
              // Durum göstergesi
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.teal[600],
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Bellek Durumu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatusIndicator(
                            Icons.memory,
                            'Aktif',
                            Colors.green,
                          ),
                          _buildStatusIndicator(
                            Icons.schedule,
                            '10s Timer',
                            Colors.orange,
                          ),
                          _buildStatusIndicator(
                            Icons.cleaning_services,
                            'Auto Clean',
                            Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Uyarı kartı
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: Colors.amber[700],
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Önemli Not',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[800],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Bu sayfadan çıktığınızda provider 10 saniye sonra otomatik olarak temizlenecek',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String description, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
```

---

## 🎮 Farklı AutoDispose Kullanım Örnekleri

### 1. Basit AutoDispose (En Sık Kullanılan)
```dart
final simpleAutoDisposeProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

// Kullanım:
// Widget kapandığında otomatik temizlenir
```

### 2. KeepAlive ile Sürekli Aktif
```dart
final alwaysAliveProvider = StateProvider.autoDispose<int>((ref) {
  ref.keepAlive(); // Hiç temizlenmez
  return 0;
});
```

### 3. Zamanlayıcılı KeepAlive (Örnekteki Gibi)
```dart
final timedKeepAliveProvider = StateProvider.autoDispose<int>((ref) {
  final cache = ref.keepAlive();
  
  // 5 dakika sonra temizle
  Timer(Duration(minutes: 5), () {
    cache.close();
  });
  
  return 0;
});
```

### 4. Koşullu KeepAlive
```dart
final conditionalKeepAliveProvider = StateProvider.autoDispose<int>((ref) {
  final shouldKeepAlive = ref.watch(settingsProvider).keepProvidersAlive;
  
  if (shouldKeepAlive) {
    ref.keepAlive();
  }
  
  return 0;
});
```

### 5. FutureProvider ile AutoDispose
```dart
final userDataAutoDisposeProvider = FutureProvider.autoDispose.family<User, String>((ref, userId) async {
  // API çağrısı
  final response = await http.get(Uri.parse('https://api.example.com/users/$userId'));
  
  // 2 dakika cache'de tut
  final cache = ref.keepAlive();
  Timer(Duration(minutes: 2), () => cache.close());
  
  return User.fromJson(json.decode(response.body));
});
```

### 6. StreamProvider ile AutoDispose
```dart
final chatStreamAutoDisposeProvider = StreamProvider.autoDispose.family<List<Message>, String>((ref, chatId) {
  final cache = ref.keepAlive();
  
  // Chat aktifken bellekte tut
  ref.listen(chatActiveProvider(chatId), (previous, next) {
    if (!next) {
      // Chat pasif olunca 30 saniye sonra temizle
      Timer(Duration(seconds: 30), () => cache.close());
    }
  });
  
  return FirebaseFirestore.instance
    .collection('chats')
    .doc(chatId)
    .collection('messages')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => Message.fromDoc(doc)).toList());
});
```

---

## ⚡ AutoDispose Türleri ve Kullanım Alanları

### 1. **StateProvider.autoDispose** (Basit State)
```dart
final counterAutoDispose = StateProvider.autoDispose<int>((ref) => 0);
```
**Kullanım alanları:**
- Form verileri
- Geçici sayaçlar
- UI state'leri

### 2. **FutureProvider.autoDispose** (API Çağrıları)
```dart
final apiDataAutoDispose = FutureProvider.autoDispose<Data>((ref) async {
  return await apiService.getData();
});
```
**Kullanım alanları:**
- Tek seferlik API çağrıları
- Geçici veri yükleme
- Cache'lenmeyen veriler

### 3. **StreamProvider.autoDispose** (Gerçek Zamanlı)
```dart
final liveDataAutoDispose = StreamProvider.autoDispose<LiveData>((ref) {
  return webSocketService.getLiveData();
});
```
**Kullanım alanları:**
- WebSocket bağlantıları
- Geçici stream'ler
- Sayfa bazlı canlı veriler

### 4. **StateNotifierProvider.autoDispose** (Karmaşık State)
```dart
final formNotifierAutoDispose = StateNotifierProvider.autoDispose<FormNotifier, FormState>((ref) {
  return FormNotifier();
});
```
**Kullanım alanları:**
- Form yönetimi
- Geçici iş mantığı
- Sayfa bazlı state'ler

### 5. **Provider.autoDispose.family** (Parametreli)
```dart
final userProfileAutoDispose = Provider.autoDispose.family<UserProfile, String>((ref, userId) {
  final cache = ref.keepAlive();
  Timer(Duration(minutes: 1), () => cache.close());
  
  return UserProfile(id: userId);
});
```
**Kullanım alanları:**
- Kullanıcı profilleri
- Geçici parametreli veriler
- Cache'li hesaplamalar

---

## 🎯 Ne Zaman AutoDispose Kullanmalısınız?

### ✅ Kullanın:
1. **Geçici veriler** (form data, temporary state)
2. **Sayfa bazlı state'ler** (page-specific data)
3. **API çağrıları** (tek seferlik data fetching)
4. **WebSocket bağlantıları** (temporary connections)
5. **Mobile uygulamalar** (memory optimization)
6. **Çok sayıda provider** (many providers)

### ❌ Kullanmayın:
1. **Global state'ler** (app theme, user session)
2. **Sürekli kullanılan veriler** (user preferences)
3. **Pahalı hesaplamalar** (expensive computations)
4. **Cache'lenecek veriler** (cached data)

### Karar Verme Rehberi:
```
Provider sürekli kullanılacak mı?
├─ Hayır → autoDispose kullanın
└─ Evet
   ├─ Bazen temizlenmeli mi? → autoDispose + keepAlive
   ├─ Hiç temizlenmemeli mi? → Normal Provider
   └─ Koşullu mu? → Conditional keepAlive
```

---

## 🔧 KeepAlive İpuçları ve En İyi Uygulamalar

### 1. **Timer ile Kontrollü Temizlik**
```dart
// ✅ İyi - Belirli süre sonra temizle
final controlledProvider = StateProvider.autoDispose<int>((ref) {
  final cache = ref.keepAlive();
  
  Timer(Duration(minutes: 5), () {
    cache.close();
  });
  
  return 0;
});
```

### 2. **Koşullu KeepAlive**
```dart
// ✅ İyi - Duruma göre karar ver
final smartProvider = StateProvider.autoDispose<int>((ref) {
  final isImportant = ref.watch(importanceProvider);
  
  if (isImportant) {
    ref.keepAlive();
  }
  
  return 0;
});
```

### 3. **onDispose ile Cleanup**
```dart
// ✅ İyi - Temizlik işlemleri yap
final resourceProvider = StateProvider.autoDispose<Resource>((ref) {
  final resource = Resource();
  
  ref.onDispose(() {
    resource.dispose(); // Kaynakları temizle
  });
  
  return resource;
});
```

### 4. **Listen ile Dinamik Kontrol**
```dart
// ✅ İyi - Dinamik keepAlive kontrolü
final dynamicProvider = StateProvider.autoDispose<int>((ref) {
  final cache = ref.keepAlive();
  
  ref.listen(userActivityProvider, (previous, next) {
    if (!next.isActive) {
      // Kullanıcı pasif olunca 1 dakika sonra temizle
      Timer(Duration(minutes: 1), () => cache.close());
    }
  });
  
  return 0;
});
```

### 5. **Family ile AutoDispose**
```dart
// ✅ İyi - Parametreli autoDispose
final userCacheProvider = StateProvider.autoDispose.family<User?, String>((ref, userId) {
  final cache = ref.keepAlive();
  
  // Her kullanıcı için 10 dakika cache
  Timer(Duration(minutes: 10), () => cache.close());
  
  ref.onDispose(() {
    print('User $userId cache temizlendi');
  });
  
  return null;
});
```

---

## 🧪 Test Nasıl Yazılır?

### 1. AutoDispose Test Örneği:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('AutoDispose provider test', () async {
    final container = ProviderContainer();
    
    // Provider'ı kullan
    expect(container.read(counterStateDisposeProvider), 0);
    
    // Değeri değiştir
    container.read(counterStateDisposeProvider.notifier).state = 5;
    expect(container.read(counterStateDisposeProvider), 5);
    
    // Container'ı dispose et
    container.dispose();
    
    // Yeni container oluştur
    final newContainer = ProviderContainer();
    
    // Provider temizlenmiş olmalı (başlangıç değeri)
    expect(newContainer.read(counterStateDisposeProvider), 0);
    
    newContainer.dispose();
  });
  
  test('KeepAlive test', () async {
    final container = ProviderContainer();
    
    // Provider'ı kullan
    final value1 = container.read(counterStateDisposeProvider);
    expect(value1, 0);
    
    // Değeri değiştir
    container.read(counterStateDisposeProvider.notifier).state = 10;
    
    // KeepAlive aktif olduğu için değer korunmalı
    final value2 = container.read(counterStateDisposeProvider);
    expect(value2, 10);
    
    // 11 saniye bekle (timer'dan fazla)
    await Future.delayed(Duration(seconds: 11));
    
    // Provider temizlenmiş olmalı
    // (Gerçek testte mock timer kullanılmalı)
    
    container.dispose();
  });
}
```

### 2. Widget Test Örneği:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('AutoDispose widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AutoDisposeScreen(),
        ),
      ),
    );
    
    // İlk değer 0 olmalı
    expect(find.text('0'), findsOneWidget);
    
    // Artır butonuna bas
    await tester.tap(find.text('Artır'));
    await tester.pump();
    
    // Değer 1 olmalı
    expect(find.text('1'), findsOneWidget);
    
    // Azalt butonuna bas
    await tester.tap(find.text('Azalt'));
    await tester.pump();
    
    // Değer tekrar 0 olmalı
    expect(find.text('0'), findsOneWidget);
  });
}
```

---

## 🚀 Avantajları (Neden Kullanmalısınız?)

### 1. **Memory Management** (Bellek Yönetimi)
- Otomatik bellek temizliği
- Memory leak'leri önler
- Performans artışı sağlar

### 2. **Flexible Control** (Esnek Kontrol)
- keepAlive ile manuel kontrol
- Timer ile zamanlayıcılı temizlik
- Koşullu bellek yönetimi

### 3. **Better Performance** (Daha İyi Performans)
- Gereksiz provider'lar temizlenir
- RAM kullanımı azalır
- Uygulama daha hızlı çalışır

### 4. **Automatic Cleanup** (Otomatik Temizlik)
- Manuel dispose gerekmez
- Widget lifecycle'a bağlı
- Hata yapma riski az

### 5. **Resource Management** (Kaynak Yönetimi)
- Timer'lar otomatik iptal edilir
- Stream'ler otomatik kapanır
- HTTP bağlantıları temizlenir

---

## ⚠️ Dezavantajları (Dikkat Edilmesi Gerekenler)

### 1. **Data Loss Risk** (Veri Kaybı Riski)
- Provider temizlenince veri kaybolur
- Önemli veriler için dikkatli kullanın
- keepAlive ile koruma gerekebilir

### 2. **Complexity** (Karmaşıklık)
- Normal provider'dan daha karmaşık
- Timer yönetimi gerekebilir
- Lifecycle'ı anlamak önemli

### 3. **Debugging Difficulty** (Debug Zorluğu)
- Ne zaman temizlendiğini takip etmek zor
- Provider inspector'da görünmeyebilir
- Log'lama gerekebilir

### 4. **Performance Overhead** (Performans Maliyeti)
- AutoDispose kontrolü CPU kullanır
- Timer'lar ek kaynak tüketir
- Çok fazla autoDispose provider performansı etkileyebilir

---

## 🎓 Sonuç ve Öneriler

AutoDispose ve keepAlive, Flutter'da **bellek yönetimi** için vazgeçilmez araçlardır. Eğer:

- Memory leak'leri önlemek istiyorsanız
- Geçici verilerle çalışıyorsanız
- Mobile uygulama geliştiriyorsanız
- Performansı optimize etmek istiyorsanız

O zaman autoDispose'u kesinlikle kullanmalısınız.

### Öğrenme Sırası:
1. **Provider** → Sabit değerler
2. **StateProvider** → Basit state
3. **StateNotifierProvider** → Karmaşık state
4. **FutureProvider** → API çağrıları
5. **StreamProvider** → Gerçek zamanlı veriler
6. **Provider.family** → Parametreli provider'lar
7. **AutoDispose & keepAlive** → Bellek yönetimi ⭐

### Gerçek Projede Kullanım:
- **Form Management**: Form verileri için autoDispose
- **API Caching**: Geçici API cache'leri için
- **Page State**: Sayfa bazlı state'ler için
- **WebSocket**: Geçici bağlantılar için
- **Mobile Apps**: Memory optimization için

---

## 📚 Ek Kaynaklar ve İleri Seviye Örnekler

### 1. Complex KeepAlive Strategy:
```dart
final smartCacheProvider = StateProvider.autoDispose<Data>((ref) {
  final cache = ref.keepAlive();
  final data = Data();
  
  // Kullanım sıklığına göre cache süresi
  ref.listen(usageFrequencyProvider, (previous, next) {
    final duration = next.isHighUsage 
      ? Duration(hours: 1)  // Sık kullanılıyorsa 1 saat
      : Duration(minutes: 5); // Az kullanılıyorsa 5 dakika
    
    Timer(duration, () => cache.close());
  });
  
  return data;
});
```

### 2. Memory Pressure Handling:
```dart
final memoryAwareProvider = StateProvider.autoDispose<LargeData>((ref) {
  final cache = ref.keepAlive();
  final data = LargeData();
  
  // Memory pressure dinle
  ref.listen(memoryPressureProvider, (previous, next) {
    if (next.isHigh) {
      // Memory baskısı yüksekse hemen temizle
      cache.close();
    }
  });
  
  return data;
});
```

### 3. User Activity Based Cleanup:
```dart
final activityBasedProvider = StateProvider.autoDispose<UserData>((ref) {
  final cache = ref.keepAlive();
  final userData = UserData();
  
  // Kullanıcı aktivitesini dinle
  ref.listen(userActivityProvider, (previous, next) {
    if (next.isIdle) {
      // Kullanıcı pasifse 2 dakika sonra temizle
      Timer(Duration(minutes: 2), () => cache.close());
    }
  });
  
  return userData;
});
```

Bu rehberi okuduktan sonra AutoDispose ve keepAlive'ı rahatlıkla kullanabilir ve memory-efficient uygulamalar geliştirebilirsiniz! 🚀