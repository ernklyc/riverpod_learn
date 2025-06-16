# TeamStateProvider - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, Flutter uygulamanızda **futbol takımı oyuncularını listelemek ve filtrelemek** için kullanılır. Yani bir takımın oyuncularını göstermek, oyuncu aramak ve gerçek zamanlı filtreleme yapmak istediğinizde bu dosyayı kullanırsınız. Bu dosya özellikle **arama fonksiyonları** ve **liste yönetimi** için tasarlanmıştır.

---

## 🧠 TeamStateProvider Nedir? (Çok Basit Anlatım)

Düşünün ki elinizde **futbol kartları** var. Bu kartlarda oyuncuların isimleri ve pozisyonları yazıyor. Bu kartları bir kutuya koyuyorsunuz. Sonra "Uğurcan" diye arama yaptığınızda kutunun içinden sadece Uğurcan'ın kartını çıkarıyorsunuz. İşte `TeamStateProvider` da böyle bir kutu gibidir. İçinde oyuncu bilgileri tutar ve istediğiniz oyuncuyu bulmanızı sağlar.

### TeamStateProvider'ın Özellikleri:
1. **Oyuncu listesi tutar** (isim ve pozisyon bilgileri)
2. **Arama yapar** (oyuncu adına göre filtreler)
3. **Gerçek zamanlı güncelleme** (yazdıkça sonuçlar değişir)
4. **Orijinal listeyi korur** (arama temizlenince tüm liste geri gelir)
5. **Case-insensitive arama** (büyük/küçük harf farketmez)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

Bu dosyada Trabzonspor futbol takımının oyuncuları bulunuyor. Her oyuncunun adı ve pozisyonu kayıtlı.

### 1. Import Satırı
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

**Ne yapar?**
- Flutter Riverpod paketini projenize dahil eder
- Bu satır olmadan StateNotifier sınıfını kullanamazsınız

### 2. TeamStateProvider Sınıfı
```dart
class TeamStateProvider extends StateNotifier<List<Map<String, String>>> {
```
Bu sınıf, oyuncu listesini yönetir ve arama işlevselliği sağlar.

### 3. Oyuncu Listesi
```dart
final _originalList = [
  {'name': 'Uğurcan Çakır', 'position': 'Kaleci'},
  {'name': 'Pedro Malheiro', 'position': 'Sağ Bek'},
  // ... diğer oyuncular
];
```

**Trabzonspor 2024-2025 Kadrosu:**
- **Kaleci**: Uğurcan Çakır
- **Defans**: Pedro Malheiro, Stefan Savić, Arseniy Batagov, Mustafa Eskihellaç
- **Orta Saha**: John Lundstram, Okay Yokuşlu, Edin Višća, Muhammed Cham
- **Hücum**: Anthony Nwakaeme, Simon Banza

### 4. Arama Fonksiyonu
```dart
void filteredPlayer(String name) {
  if (name.isEmpty) {
    state = _originalList;
  } else {
    state = _originalList
        .where((element) =>
            element['name']!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}
```

**Nasıl Çalışır?**
1. Arama kutusu boşsa → Tüm oyuncular görünür
2. Arama yapılırsa → Sadece eşleşen oyuncular görünür
3. Büyük/küçük harf duyarlı değil

---

## 🎮 Widget'ta Nasıl Kullanılır?

### Arama Sayfası Örneği:
```dart
class TeamSearchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(teamStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Trabzonspor Oyuncu Arama'),
        backgroundColor: Colors.red[600],
      ),
      body: Column(
        children: [
          // Arama kutusu
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                ref.read(teamStateProvider.notifier).filteredPlayer(value);
              },
              decoration: InputDecoration(
                hintText: 'Oyuncu ara (örn: Uğurcan)...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          
          // Oyuncu listesi
          Expanded(
            child: ListView.builder(
              itemCount: teamList.length,
              itemBuilder: (context, index) {
                final player = teamList[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red[600],
                      child: Text(
                        player['name']![0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(player['name']!),
                    subtitle: Text(player['position']!),
                    trailing: Icon(Icons.sports_soccer),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🔍 Arama Örnekleri

### Örnek Aramalar:
- **"Uğurcan"** yazarsanız → Uğurcan Çakır görünür
- **"Pedro"** yazarsanız → Pedro Malheiro görünür
- **"ok"** yazarsanız → Okay Yokuşlu görünür (kısmi eşleşme)
- **""** (boş) yazarsanız → Tüm oyuncular görünür

### Pozisyona Göre Arama:
```dart
void filterByPosition(String position) {
  if (position.isEmpty) {
    state = _originalList;
  } else {
    state = _originalList
        .where((element) =>
            element['position']!.toLowerCase().contains(position.toLowerCase()))
        .toList();
  }
}
```

---

## 🎯 Ne Zaman Kullanmalısınız?

### ✅ Kullanın:
1. **Liste arama** özelliği gerektiğinde
2. **Gerçek zamanlı filtreleme** istediğinizde
3. **Spor uygulamaları** geliştirirken
4. **Telefon rehberi** tarzı uygulamalarda
5. **Ürün katalogu** uygulamalarında

### ❌ Kullanmayın:
1. **Çok büyük listeler** için (performance)
2. **API'den gelen veriler** için (server-side search)
3. **Basit gösterim** yeterli ise

---

## 🧪 Test Örnekleri

```dart
test('Oyuncu arama testi', () {
  final container = ProviderContainer();
  
  // Uğurcan ara
  container.read(teamStateProvider.notifier).filteredPlayer('Uğurcan');
  final result = container.read(teamStateProvider);
  
  expect(result.length, 1);
  expect(result[0]['name'], 'Uğurcan Çakır');
});
```

---

## 🚀 Avantajları

1. **Hızlı arama** - Local veri, anında sonuç
2. **Kullanıcı dostu** - Yazdıkça sonuç
3. **Esnek filtreleme** - İsim veya pozisyon
4. **Memory efficient** - Sadece referanslar tutulur

---

## 🎓 Sonuç

TeamStateProvider, **arama özellikli liste yönetimi** için mükemmel bir örnektir. Futbol takımı, çalışan listesi, ürün katalogu gibi pek çok senaryoda kullanabilirsiniz.

Bu yaklaşımı kendi projelerinizde kullanarak harika arama özellikleri geliştirebilirsiniz!
