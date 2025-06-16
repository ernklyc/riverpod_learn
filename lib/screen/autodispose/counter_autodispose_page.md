# Counter Autodispose Page - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu sayfa, **Autodispose pattern**'ini gösteren basit bir counter uygulamasıdır. Widget'ın yaşam döngüsüne bağlı olarak provider'ların otomatik olarak nasıl temizlendiğini (dispose) öğretir. Memory leak'leri önlemek için kritik bir pattern'dir.

---

## 🧠 Counter Autodispose Page Nedir? (Çok Basit Anlatım)

Düşünün ki **oda ışığınız** var. Odadan çıktığınızda ışığı kapatıyorsunuz, değil mi? AutoDispose de aynı mantıktır:
- **Widget görüntülenir** → Provider aktif olur
- **Widget kapanır** → Provider otomatik temizlenir
- **Bellek tasarrufu** → Gereksiz kaynaklar serbest bırakılır

### Bu Sayfanın Özellikleri:
1. **Automatic cleanup** (otomatik temizlik)
2. **Memory efficiency** (bellek verimliliği)
3. **Resource management** (kaynak yönetimi)
4. **Lifecycle awareness** (yaşam döngüsü farkındalığı)
5. **Memory leak prevention** (bellek sızıntısı önleme)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### Kod Analizi:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/state_provider_dispose.dart';

class CounterAutodisposePage extends ConsumerWidget {
  const CounterAutodisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateDisposeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Autodispose Page')),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterStateDisposeProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**Kelime kelime açıklama:**

### 1. Autodispose Provider'ı İzleme:
```dart
final counter = ref.watch(counterStateDisposeProvider);
```

**Ne yapar?**
- `ref.watch()`: AutoDispose provider'ı dinler
- `counterStateDisposeProvider`: Otomatik temizlenen provider
- Widget dispose olduğunda provider da temizlenir

### 2. Provider Definition (muhtemelen):
```dart
// state_provider_dispose.dart dosyasında:
final counterStateDisposeProvider = StateProvider.autoDispose<int>((ref) => 0);
```

**Açıklama:**
- `StateProvider.autoDispose`: Otomatik temizlenen StateProvider
- Widget kapandığında state sıfırlanır ve bellek temizlenir

---

## 🔄 Autodispose Pattern'i Derinlemesine

### Normal Provider vs AutoDispose Provider:

#### Normal Provider:
```dart
// Normal provider - sürekli bellekte kalır
final counterProvider = StateProvider<int>((ref) => 0);

// App kapatılana kadar bellekte kalır
// Memory kullanımı sürekli artar
```

#### AutoDispose Provider:
```dart
// AutoDispose provider - widget kapatılınca temizlenir
final counterAutoDisposeProvider = StateProvider.autoDispose<int>((ref) => 0);

// Widget dispose olunca:
// 1. Provider dispose edilir
// 2. State temizlenir  
// 3. Memory serbest bırakılır
```

### Lifecycle Örneği:
```dart
class AutoDisposeLifecycleDemo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Widget build - Provider aktif');
    
    final counter = ref.watch(counterAutoDisposeProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('AutoDispose Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $counter'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Bu sayfa kapatıldığında
              child: Text('Go Back'), // Provider otomatik dispose olur
            ),
          ],
        ),
      ),
    );
  }
}
```

Bu sayfa, Riverpod'un en önemli optimizasyon özelliği olan AutoDispose pattern'ini öğretir! 