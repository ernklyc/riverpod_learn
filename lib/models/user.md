# User Model - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, uygulamanızda **kullanıcı verilerinin yapısını tanımlar**. Yani API'den gelen JSON verilerini nasıl bir Dart nesnesine dönüştüreceğinizi ve bu verileri nasıl kullanacağınızı belirler. Bu model sınıfı özellikle **veri tiplerini garantiler**, **null safety sağlar** ve **JSON serialization** işlemlerini kolaylaştırır.

---

## 🧠 User Model Nedir? (Çok Basit Anlatım)

Düşünün ki bir **kimlik kartı formu** var. Bu formda "Ad", "Soyad", "Fotoğraf", "E-posta" gibi alanlar bulunuyor. İşte `User Model` de böyle bir form şablonu gibidir. API'den gelen dağınık veriler bu şablona göre düzenlenir ve kullanılabilir hale gelir.

### User Model'in Özellikleri:
1. **Veri yapısını tanımlar** (id, email, firstName, vb.)
2. **Type safety sağlar** (String, int, bool gibi tipler)
3. **JSON dönüştürme** işlemlerini yönetir
4. **Null safety** garantisi verir
5. **Code completion** desteği sağlar

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### Kod Analizi:
```dart
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }
}
```

**Ne yapar bu kod?**

### 1. Class Tanımı:
```dart
class User {
```
Dart dilinde `User` adında yeni bir sınıf oluşturur.

### 2. Sınıf Alanları (Properties):
```dart
final int id;
final String email;
final String firstName;
final String lastName;
final String avatar;
```

**Her alan ne anlama gelir?**
- `final`: Bu alanlar sadece constructor'da bir kez atanabilir, sonra değiştirilemez
- `int id`: Kullanıcının benzersiz kimlik numarası (sayı)
- `String email`: E-posta adresi (metin)
- `String firstName`: Adı (metin)
- `String lastName`: Soyadı (metin)  
- `String avatar`: Profil fotoğrafının URL'i (metin)

### 3. Constructor (Yapıcı Fonksiyon):
```dart
User({
  required this.id,
  required this.email,
  required this.firstName,
  required this.lastName,
  required this.avatar,
});
```

**Kelime kelime açıklama:**
- `User({...})`: Named constructor (isimli parametreler)
- `required`: Bu parametreler zorunlu, verilmeli
- `this.id`: Bu instance'ın id alanına parametre değerini ata

### 4. fromJson Factory Constructor:
```dart
factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'],
    email: json['email'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    avatar: json['avatar'],
  );
}
```

**Ne işe yarar?**
- API'den gelen JSON verisini User nesnesine dönüştürür
- `Map<String, dynamic>` tipindeki JSON'ı User class'ına çevirir
- Field mapping yapar (JSON key'leri → Dart property'leri)

**Field Mapping Örnekleri:**
- `json['id']` → `id`
- `json['email']` → `email`
- `json['first_name']` → `firstName` (snake_case → camelCase)
- `json['last_name']` → `lastName`
- `json['avatar']` → `avatar`

### 5. toJson Method:
```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'avatar': avatar,
  };
}
```

**Ne işe yarar?**
- User nesnesini JSON formatına dönüştürür
- API'ye veri gönderirken kullanılır
- Local storage'a kaydetmek için kullanılır

---

## 🌐 API ile Veri Akışı

### Gelen JSON Örneği (Reqres.in):
```json
{
  "id": 7,
  "email": "michael.lawson@reqres.in",
  "first_name": "Michael",
  "last_name": "Lawson",
  "avatar": "https://reqres.in/img/faces/7-image.jpg"
}
```

### Dönüştürme İşlemi:
```dart
// 1. JSON'dan User oluştur
final json = {
  "id": 7,
  "email": "michael.lawson@reqres.in",
  "first_name": "Michael",
  "last_name": "Lawson",
  "avatar": "https://reqres.in/img/faces/7-image.jpg"
};

// 2. fromJson ile dönüştür
final user = User.fromJson(json);

// 3. Artık user nesnesini kullanabilirsiniz
print(user.firstName); // Michael
print(user.lastName);  // Lawson
print(user.email);     // michael.lawson@reqres.in
```

---

## 🎮 Widget'ta Nasıl Kullanılır?

### Kullanıcı Profil Kartı:
```dart
class UserCard extends StatelessWidget {
  final User user;
  
  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar),
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email),
        trailing: Text('ID: ${user.id}'),
      ),
    );
  }
}
```

### Kullanıcı Listesi:
```dart
class UserList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsyncValue = ref.watch(userFutureProvider);
    
    return usersAsyncValue.when(
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Hata: $error'),
      data: (users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserCard(user: user);
        },
      ),
    );
  }
}
```

---

## ⚡ Gelişmiş User Model Örnekleri

### 1. Computed Properties ile:
```dart
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({...}); // Constructor

  // Computed property - tam isim
  String get fullName => '$firstName $lastName';
  
  // Computed property - isim kısaltması
  String get initials => '${firstName[0]}${lastName[0]}';
  
  // Computed property - email domain
  String get emailDomain => email.split('@')[1];

  factory User.fromJson(Map<String, dynamic> json) {...}
  Map<String, dynamic> toJson() {...}
}

// Kullanım:
final user = User.fromJson(jsonData);
print(user.fullName);    // Michael Lawson
print(user.initials);    // ML
print(user.emailDomain); // reqres.in
```

### 2. CopyWith Method ile:
```dart
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({...}); // Constructor

  // Nesnenin kopyasını oluştur ve bazı alanları değiştir
  User copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {...}
  Map<String, dynamic> toJson() {...}
}

// Kullanım:
final user = User.fromJson(jsonData);
final updatedUser = user.copyWith(
  firstName: 'Yeni İsim',
  email: 'yeni@email.com',
);
```

---

## 🎯 Ne Zaman User Model Kullanmalısınız?

### ✅ Kullanın:
1. **API entegrasyonu** yaparken
2. **Type safety** istediğinizde
3. **JSON serialization** gerektiğinde
4. **Complex data structures** yönetirken
5. **Code completion** desteği istediğinizde

### ❌ Kullanmayın:
1. **Çok basit veriler** için (tek string, int vb.)
2. **Tek kullanımlık veriler** için

---

## 🧪 Test Örnekleri

```dart
test('User.fromJson should create valid user', () {
  // Arrange
  final json = {
    'id': 1,
    'email': 'test@example.com',
    'first_name': 'Test',
    'last_name': 'User',
    'avatar': 'https://example.com/avatar.jpg',
  };

  // Act
  final user = User.fromJson(json);

  // Assert
  expect(user.id, 1);
  expect(user.email, 'test@example.com');
  expect(user.firstName, 'Test');
  expect(user.lastName, 'User');
});

test('User.toJson should create valid JSON', () {
  // Arrange
  final user = User(
    id: 1,
    email: 'test@example.com',
    firstName: 'Test',
    lastName: 'User',
    avatar: 'https://example.com/avatar.jpg',
  );

  // Act
  final json = user.toJson();

  // Assert
  expect(json['id'], 1);
  expect(json['email'], 'test@example.com');
  expect(json['first_name'], 'Test');
});
```

---

## 🚀 Avantajları

1. **Type Safety**: Compile-time'da hata yakalama
2. **Code Completion**: IDE desteği
3. **Maintainability**: Kolay bakım ve değişiklik
4. **Null Safety**: Null pointer exception'ları önler
5. **Serialization**: JSON ↔ Object dönüştürme

---

## ⚠️ Dikkat Edilmesi Gerekenler

1. **Immutability**: final alanlar değiştirilemez
2. **JSON Keys**: API ile model alanları eşleşmeli
3. **Null Safety**: Nullable alanları doğru handle edin

---

## 🎓 Sonuç

User Model, Flutter uygulamalarında **güvenli ve organize veri yönetimi** için vazgeçilmezdir. Doğru kullanıldığında:
- **Type safety** sağlar
- **Code quality** artırır
- **Maintenance** kolaylaştırır
- **Bug'ları** minimize eder

Bu model pattern'ini kullanarak professional veri yapıları oluşturabilirsiniz!
