# FutureProvider - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, Flutter uygulamanızda **API'den veri çekmek** için kullanılır. Yani internetten kullanıcı bilgilerini almak, göstermek ve yönetmek istediğinizde bu dosyayı kullanırsınız. Bu dosya özellikle **asenkron (async) işlemler** için tasarlanmıştır.

---

## 🧠 FutureProvider Nedir? (Çok Basit Anlatım)

Düşünün ki arkadaşınızdan telefonda bir bilgi istiyorsunuz. Telefonu açıp arıyorsunuz, ama arkadaşınız hemen cevap veremiyor, "5 dakika sonra seni ararım" diyor. Siz de telefonu kapatıp beklemeye başlıyorsunuz. İşte `FutureProvider` da böyle çalışır. API'ye "bana kullanıcı bilgilerini gönder" diyorsunuz, API de "tamam, biraz bekle, hazırlıyorum" diyor.

### FutureProvider'ın Özellikleri:
1. **Asenkron veri getirir** (API çağrıları için)
2. **Bekleme durumunu yönetir** (loading state)
3. **Hata durumunu yönetir** (error state)
4. **Başarılı veriyi yönetir** (data state)
5. **Otomatik yenileme** (refresh) destekler

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### 1. Import Satırları
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/models/user.dart';
import 'package:riverpod_learn/services/user_service.dart';
```

**Her satır ne yapar?**
1. **`flutter_riverpod`**: FutureProvider'ı kullanabilmek için gerekli
2. **`models/user.dart`**: Kullanıcı verilerinin yapısını tanımlayan sınıf
3. **`services/user_service.dart`**: API çağrısı yapan servis sınıfı

**Neden gerekli?**
- Dart dilinde başka dosyalardan sınıf kullanmak için import gereklidir
- Her import, kodumuzun bir parçasını sağlar

**Gerçek hayat örneği:**
Yemek yapmak için mutfağa gittiğinizde, malzemeleri buzdolabından, dolabından ve raflardan alırsınız. Import'lar da kodunuz için gerekli "malzemeleri" getirir.

---

### 2. FutureProvider Tanımı

```dart
final userFutureProvider = FutureProvider<List<User>>((ref) async {
  final userService = UserService();
  return userService.fetchUsers();
});
```

Bu kod çok önemli! Kelime kelime açıklayalım:

#### `final userFutureProvider =`
- **`final`**: Bu değişken sadece bir kez atanır, sonra değiştirilemez
- **`userFutureProvider`**: Provider'ımızın adı (user = kullanıcı, future = gelecek)

#### `FutureProvider<List<User>>`
- **`FutureProvider`**: Asenkron veri getiren özel provider türü
- **`<List<User>>`**: Bu provider'ın User listesi döndüreceğini belirtir
  - `List`: Bir liste (array) döndürür
  - `User`: User tipinde nesneler içerir

#### `((ref) async {`
- **`(ref)`**: Provider'ın aldığı referans parametresi
- **`async`**: Bu fonksiyon asenkron çalışır (bekleme yapar)
- **`{`**: Fonksiyon gövdesi başlar

#### `final userService = UserService();`
- **`UserService()`**: API çağrısı yapan servis sınıfından yeni bir nesne oluşturur
- **`userService`**: Bu nesneyi tutacak değişken

#### `return userService.fetchUsers();`
- **`fetchUsers()`**: API'den kullanıcıları getiren fonksiyon
- **`return`**: Sonucu geri döndür

**Tüm kod ne anlama gelir?**
"userFutureProvider adında bir FutureProvider oluştur. Bu provider User listesi döndürsün. API'den veri getirmek için UserService kullan ve fetchUsers() fonksiyonunu çağır."

---

## 🌐 Kullanılan API: Reqres.in

### Reqres.in Nedir?
[Reqres.in](https://reqres.in/), geliştiriciler için **ücretsiz test API**'sidir. Gerçek bir backend kurmadan frontend uygulamanızı test edebilirsiniz.

### Özellikler:
- **24/7 çalışır** (her zaman erişilebilir)
- **Gerçek HTTP yanıtları** verir (200, 404, 500 vb.)
- **CORS desteği** var (tarayıcıdan direkt çağırabilirsiniz)
- **Ücretsiz** (günde 100 istek limit)

### API Endpoint'i:
```
https://reqres.in/api/users?page=2
```

**Bu URL ne anlama gelir?**
- `https://reqres.in/api/`: Ana API adresi
- `users`: Kullanıcı verilerini getir
- `?page=2`: 2. sayfadaki kullanıcıları getir

### API Yanıtı Örneği:
```json
{
  "page": 2,
  "per_page": 6,
  "total": 12,
  "total_pages": 2,
  "data": [
    {
      "id": 7,
      "email": "michael.lawson@reqres.in",
      "first_name": "Michael",
      "last_name": "Lawson",
      "avatar": "https://reqres.in/img/faces/7-image.jpg"
    },
    {
      "id": 8,
      "email": "lindsay.ferguson@reqres.in",
      "first_name": "Lindsay",
      "last_name": "Ferguson",
      "avatar": "https://reqres.in/img/faces/8-image.jpg"
    }
  ]
}
```

---

## 🛠️ User Model Yapısı

### User.dart Dosyası Açıklaması:

```dart
class User {
    int id;           // Kullanıcı ID'si
    String email;     // E-posta adresi
    String firstName; // Ad
    String lastName;  // Soyad
    String avatar;    // Profil resmi URL'i

    User({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.avatar,
    });
}
```

### JSON'dan User Nesnesine Dönüşüm:

```dart
factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],    // API'de "first_name", modelde "firstName"
    lastName: json["last_name"],      // API'de "last_name", modelde "lastName"
    avatar: json["avatar"],
);
```

**Neden böyle bir yapı gerekli?**
1. **API'den gelen veri** JSON formatında (text halinde)
2. **Flutter'da kullanmak** için Dart nesnesi gerekli
3. **fromJson** fonksiyonu bu dönüşümü yapar

### QuickType.io Kullanımı:

Bu User modeli muhtemelen [QuickType.io](https://app.quicktype.io/) kullanılarak oluşturulmuş. QuickType.io, JSON verisini alıp otomatik olarak Dart sınıfı oluşturan harika bir araçtır.

**QuickType.io Nasıl Kullanılır?**
1. [QuickType.io](https://app.quicktype.io/) sitesine gidin
2. Sol tarafa JSON verinizi yapıştırın
3. Sağ üstten "Dart" dilini seçin
4. Otomatik oluşan kodu kopyalayın

---

## 🔧 UserService Yapısı

### UserService.dart Dosyası Açıklaması:

```dart
import 'package:dio/dio.dart';
import 'package:riverpod_learn/models/user.dart';

class UserService {
  final Dio _dio = Dio();
  
  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('https://reqres.in/api/users?page=2');
    final List<dynamic> data = response.data['data'];
    return data.map((json) => User.fromJson(json)).toList();
  }
}
```

### Satır Satır Açıklama:

#### `final Dio _dio = Dio();`
- **`Dio`**: HTTP istekleri yapmak için kullanılan paket
- **`_dio`**: Private değişken (sadece bu sınıf içinde kullanılır)

#### `Future<List<User>> fetchUsers() async {`
- **`Future<List<User>>`**: Bu fonksiyon gelecekte User listesi döndürecek
- **`async`**: Bu fonksiyon asenkron çalışır

#### `final response = await _dio.get('...');`
- **`_dio.get()`**: GET isteği yapar
- **`await`**: İstek tamamlanana kadar bekler
- **`response`**: API'den gelen yanıtı tutar

#### `final List<dynamic> data = response.data['data'];`
- **`response.data`**: API yanıtının içeriği
- **`['data']`**: JSON içindeki "data" alanını alır
- **`List<dynamic>`**: Herhangi tipte liste

#### `return data.map((json) => User.fromJson(json)).toList();`
- **`data.map()`**: Listedeki her elemanı dönüştürür
- **`User.fromJson(json)`**: Her JSON nesnesini User nesnesine çevirir
- **`.toList()`**: Sonucu listeye çevirir

---

## 🏗️ Widget İçinde Nasıl Kullanılır? (Adım Adım)

### 1. Widget'ı Hazırlama
```dart
class UsersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Buraya kod gelecek
  }
}
```

**Önemli:** `ConsumerWidget` kullanmalısınız!

### 2. FutureProvider'ı İzleme
```dart
final userAsyncValue = ref.watch(userFutureProvider);
```

**Ne yapar?**
- `userAsyncValue` API durumunu tutar (loading, error, data)
- `AsyncValue` türünde bir değer döndürür

### 3. AsyncValue Durumlarını Kontrol Etme

FutureProvider üç farklı durum döndürür:

#### A) Loading (Yükleniyor)
```dart
userAsyncValue.when(
  loading: () => CircularProgressIndicator(),
  // ...
)
```

#### B) Error (Hata)
```dart
userAsyncValue.when(
  error: (error, stack) => Text('Hata: $error'),
  // ...
)
```

#### C) Data (Veri)
```dart
userAsyncValue.when(
  data: (users) => ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];
      return ListTile(title: Text(user.firstName));
    },
  ),
)
```

### 4. Tam Örnek Widget
```dart
class UsersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcılar'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Provider'ı yenile
              ref.refresh(userFutureProvider);
            },
          ),
        ],
      ),
      body: userAsyncValue.when(
        // Veri yüklenirken
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 20),
              Text(
                'Kullanıcılar yükleniyor...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        
        // Hata durumunda
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'Bir hata oluştu!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10),
              Text(
                error.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(userFutureProvider);
                },
                child: Text('Tekrar Dene'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        // Veri geldiğinde
        data: (users) => RefreshIndicator(
          onRefresh: () async {
            ref.refresh(userFutureProvider);
            // Yenileme işleminin tamamlanmasını bekle
            await ref.read(userFutureProvider.future);
          },
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  
                  // Profil resmi
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user.avatar),
                    backgroundColor: Colors.grey[200],
                  ),
                  
                  // İsim ve soyisim
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  // E-posta
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[600],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ID: ${user.id}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  
                  // Detay ikonu
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                  
                  // Tıklama olayı
                  onTap: () {
                    // Kullanıcı detay sayfasına git
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(user: user),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

---

## 🔄 Veri Akışı Nasıl Çalışır?

### Adım Adım Süreç:

1. **Widget oluşturulur** (UsersScreen)
2. **ref.watch() çağrılır** (userFutureProvider izlenir)
3. **FutureProvider tetiklenir** (ilk kez çağrılırsa)
4. **UserService oluşturulur** (API servis sınıfı)
5. **API isteği yapılır** (https://reqres.in/api/users?page=2)
6. **API yanıt döndürür** (JSON formatında)
7. **JSON parse edilir** (User nesnelerine dönüştürülür)
8. **AsyncValue.data oluşur** (başarılı veri)
9. **Widget yeniden çizilir** (kullanıcı listesi gösterilir)

### Görsel Anlatım:
```
Widget Oluşturulur
        ↓
ref.watch() Çağrılır
        ↓
FutureProvider Tetiklenir
        ↓
UserService.fetchUsers() Çalışır
        ↓
Dio API İsteği Yapar (Loading)
        ↓
API Yanıt Döndürür
        ↓
JSON → User Nesnelerine Dönüştürülür
        ↓
AsyncValue.data Oluşur
        ↓
Widget Yeniden Çizilir (Data)
```

### Hata Durumunda:
```
API İsteği Yapar
        ↓
Network Hatası / Server Hatası
        ↓
AsyncValue.error Oluşur
        ↓
Error Widget'ı Gösterilir
```

---

## ⚡ AsyncValue Durumları (Çok Detaylı)

### 1. AsyncValue.loading
**Ne zaman oluşur?**
- İlk API çağrısında
- Refresh yapıldığında
- Bağlantı yavaşsa

**Nasıl kontrol edilir?**
```dart
if (userAsyncValue.isLoading) {
  return CircularProgressIndicator();
}
```

### 2. AsyncValue.error
**Ne zaman oluşur?**
- İnternet bağlantısı yoksa
- API server'ı çalışmıyorsa
- Yanlış URL kullanılırsa
- JSON parse hatası olursa

**Nasıl kontrol edilir?**
```dart
if (userAsyncValue.hasError) {
  return Text('Hata: ${userAsyncValue.error}');
}
```

### 3. AsyncValue.data
**Ne zaman oluşur?**
- API başarılı yanıt döndürdüğünde
- Veri başarıyla parse edildiğinde

**Nasıl kontrol edilir?**
```dart
if (userAsyncValue.hasValue) {
  final users = userAsyncValue.value!;
  return ListView.builder(...);
}
```

### 4. when() Metodunu Kullanma (Önerilen)
```dart
userAsyncValue.when(
  loading: () => LoadingWidget(),
  error: (err, stack) => ErrorWidget(err),
  data: (users) => UserListWidget(users),
)
```

---

## 🔄 Provider Yenileme (Refresh) İşlemleri

### 1. Manual Refresh
```dart
ElevatedButton(
  onPressed: () {
    ref.refresh(userFutureProvider);
  },
  child: Text('Yenile'),
)
```

### 2. Pull-to-Refresh
```dart
RefreshIndicator(
  onRefresh: () async {
    ref.refresh(userFutureProvider);
    await ref.read(userFutureProvider.future);
  },
  child: ListView(...),
)
```

### 3. Otomatik Refresh (Timer ile)
```dart
class AutoRefreshUsersScreen extends ConsumerStatefulWidget {
  @override
  _AutoRefreshUsersScreenState createState() => _AutoRefreshUsersScreenState();
}

class _AutoRefreshUsersScreenState extends ConsumerState<AutoRefreshUsersScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      ref.refresh(userFutureProvider);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget build kodu...
  }
}
```

---

## 🎯 Ne Zaman FutureProvider Kullanmalısınız?

### ✅ Kullanın:
1. **API'den veri çekerken**
2. **Dosya okuma işlemlerinde**
3. **Database sorguları için**
4. **Tek seferlik asenkron işlemler için**
5. **Cache edilebilir veriler için**

### ❌ Kullanmayın:
1. **Stream veriler için** (StreamProvider kullanın)
2. **Sürekli değişen veriler için**
3. **Kullanıcı inputları için** (StateProvider kullanın)
4. **Sabit değerler için** (Provider kullanın)

### Karar Verme Rehberi:
```
Veri nereden geliyor?
├─ API/Internet → FutureProvider
├─ Stream → StreamProvider
├─ Kullanıcı Input → StateProvider
└─ Sabit Değer → Provider
```

---

## 🧪 Test Nasıl Yazılır?

### 1. Unit Test Örneği:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  test('FutureProvider başarılı veri testi', () async {
    final mockService = MockUserService();
    final testUsers = [
      User(id: 1, email: 'test@test.com', firstName: 'Test', lastName: 'User', avatar: 'avatar.jpg'),
    ];
    
    when(mockService.fetchUsers()).thenAnswer((_) async => testUsers);
    
    final container = ProviderContainer(
      overrides: [
        userServiceProvider.overrideWithValue(mockService),
      ],
    );
    
    final result = await container.read(userFutureProvider.future);
    expect(result.length, 1);
    expect(result.first.firstName, 'Test');
    
    container.dispose();
  });
  
  test('FutureProvider hata testi', () async {
    final mockService = MockUserService();
    
    when(mockService.fetchUsers()).thenThrow(Exception('Network error'));
    
    final container = ProviderContainer(
      overrides: [
        userServiceProvider.overrideWithValue(mockService),
      ],
    );
    
    expect(
      () => container.read(userFutureProvider.future),
      throwsException,
    );
    
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
  testWidgets('Users screen test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: UsersScreen(),
        ),
      ),
    );
    
    // Loading indicator'ı kontrol et
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // API yanıtını bekle
    await tester.pumpAndSettle();
    
    // Kullanıcı listesinin göründüğünü kontrol et
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);
  });
}
```

---

## 🚀 Avantajları (Neden Kullanmalısınız?)

### 1. **Otomatik State Yönetimi**
- Loading, error, data durumlarını otomatik yönetir
- Manuel state yönetimi gerekmez

### 2. **Cache Desteği**
- Veri otomatik cache'lenir
- Aynı provider tekrar çağrıldığında cache'den döner

### 3. **Hata Yönetimi**
- Hataları otomatik yakalar
- Kullanıcı dostu hata mesajları

### 4. **Yenileme Desteği**
- Kolay refresh işlemleri
- Pull-to-refresh desteği

### 5. **Test Edilebilirlik**
- Mock'lama kolay
- Unit test ve widget test destekler

---

## ⚠️ Dezavantajları (Dikkat Edilmesi Gerekenler)

### 1. **Tek Seferlik İşlemler**
- Sürekli güncellenen veriler için uygun değil
- Stream veriler için StreamProvider kullanın

### 2. **Memory Usage**
- Büyük veriler memory'de tutulur
- Çok büyük listelerde dikkatli olun

### 3. **Network Dependency**
- İnternet bağlantısına bağımlı
- Offline durumları düşünün

### 4. **Error Handling**
- Tüm hata durumlarını handle etmek gerekir
- Timeout, network error vb.

---

## 🔧 İpuçları ve En İyi Uygulamalar

### 1. **Loading States**
```dart
// ✅ İyi - Meaningful loading message
loading: () => Column(
  children: [
    CircularProgressIndicator(),
    Text('Kullanıcılar yükleniyor...'),
  ],
)

// ❌ Kötü - Sadece indicator
loading: () => CircularProgressIndicator()
```

### 2. **Error Handling**
```dart
// ✅ İyi - Actionable error
error: (error, stack) => Column(
  children: [
    Text('Bir hata oluştu!'),
    Text(error.toString()),
    ElevatedButton(
      onPressed: () => ref.refresh(userFutureProvider),
      child: Text('Tekrar Dene'),
    ),
  ],
)

// ❌ Kötü - Sadece hata mesajı
error: (error, stack) => Text(error.toString())
```

### 3. **Performance Optimization**
```dart
// ✅ İyi - ListView.builder kullan
ListView.builder(
  itemCount: users.length,
  itemBuilder: (context, index) => UserTile(users[index]),
)

// ❌ Kötü - Column ile tüm listeyi oluştur
Column(
  children: users.map((user) => UserTile(user)).toList(),
)
```

### 4. **Dosya Organizasyonu**
```
lib/
  providers/
    user_future_provider.dart
  services/
    user_service.dart
  models/
    user.dart
  screens/
    users_screen.dart
```

---

## 🎓 Sonuç ve Öneriler

FutureProvider, Flutter'da **API veri çekme** işlemleri için mükemmel bir araçtır. Eğer:

- API'den veri çekiyorsanız
- Asenkron işlemler yapıyorsanız
- Loading/Error state yönetimi istiyorsanız
- Cache desteği istiyorsanız

O zaman FutureProvider'ı kesinlikle kullanmalısınız.

### Öğrenme Sırası:
1. **Provider** → Sabit değerler
2. **StateProvider** → Basit state
3. **StateNotifierProvider** → Karmaşık state
4. **FutureProvider** → API çağrıları
5. **StreamProvider** → Stream veriler

### Gerçek Projede Kullanım:
- **E-ticaret**: Ürün listesi çekme
- **Sosyal Medya**: Post listesi çekme
- **Haber**: Haber listesi çekme
- **Finansal**: Borsa verileri çekme

---

## 📚 Ek Kaynaklar ve Örnekler

### Faydalı Araçlar:
- **[Reqres.in](https://reqres.in/)**: Ücretsiz test API'si
- **[QuickType.io](https://app.quicktype.io/)**: JSON'dan Dart model oluşturucu
- **[Dio](https://pub.dev/packages/dio)**: HTTP client paketi
- **[Riverpod](https://riverpod.dev)**: State management

### Dio Konfigürasyonu:
```dart
class UserService {
  late final Dio _dio;
  
  UserService() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://reqres.in/api/',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    
    // Interceptor ekle (log, auth vb.)
    _dio.interceptors.add(LogInterceptor());
  }
}
```

### Offline Cache Desteği:
```dart
final userCacheProvider = FutureProvider<List<User>>((ref) async {
  try {
    // Online'dan veri çek
    final users = await ref.read(userServiceProvider).fetchUsers();
    // Cache'e kaydet
    await CacheService.saveUsers(users);
    return users;
  } catch (e) {
    // Offline ise cache'den oku
    final cachedUsers = await CacheService.getCachedUsers();
    if (cachedUsers.isNotEmpty) {
      return cachedUsers;
    }
    rethrow;
  }
});
```

Bu rehberi okuduktan sonra FutureProvider'ı, API çağrılarını, Reqres.in'i ve QuickType.io'yu rahatlıkla kullanabilir ve profesyonel Flutter uygulamaları geliştirebilirsiniz! 