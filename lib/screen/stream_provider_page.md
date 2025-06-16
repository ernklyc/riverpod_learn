# Stream Provider Page - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu sayfa, **StreamProvider**'ın nasıl kullanıldığını gösteren canlı sayaç (live counter) uygulamasıdır. Real-time veri akışlarını (stream) nasıl yöneteceğinizi, sürekli güncellenen verileri UI'da nasıl göstereceğinizi öğretir.

---

## 🧠 Stream Provider Page Nedir? (Çok Basit Anlatım)

Düşünün ki **sürekli çalan bir saatiniz** var. Bu saat her saniye "tik tak" diyerek zaman geçtiğini söylüyor. StreamProvider da aynı şekilde:
- **Sürekli veri** akışı sağlar
- **Real-time updates** (gerçek zamanlı güncellemeler) yapar
- **Otomatik olarak** yeni veriler geldiğinde UI'ı günceller

### Gerçek Hayat Örnekleri:
1. **Canlı skor** (maç sonuçları)
2. **Hisse senedi fiyatları** (sürekli değişen)
3. **Chat mesajları** (gerçek zamanlı)
4. **Hava durumu** (sürekli güncellenen)
5. **Live counter** (bu örnekteki gibi)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### Kod Analizi:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/stream_provider.dart';

class StreamProviderPage extends ConsumerStatefulWidget {
  const StreamProviderPage({super.key});

  @override
  ConsumerState<StreamProviderPage> createState() => _StreamProviderPageState();
}

class _StreamProviderPageState extends ConsumerState<StreamProviderPage> {
  @override
  Widget build(BuildContext context) {
    final counterStream = ref.watch(counterStreamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Stream Provider Live Counter Page')),
      body: counterStream.when(
        data: (data) {
          return Center(
            child: Text(
              'Live Counter: $data',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
```

**Kelime kelime açıklama:**

### 1. Widget Türü:
```dart
class StreamProviderPage extends ConsumerStatefulWidget
```

**Neden ConsumerStatefulWidget?**
- `ConsumerStatefulWidget`: State management + lifecycle methods
- Stream'ler sürekli veri akışı sağladığı için state'li widget gerekli
- Resource yönetimi için dispose methods kullanabilir

### 2. Stream'i İzleme:
```dart
final counterStream = ref.watch(counterStreamProvider);
```

**Ne yapar?**
- `ref.watch()`: StreamProvider'ı dinler
- `counterStreamProvider`: Stream sağlayan provider
- `counterStream`: AsyncValue<int> tipinde veri

### 3. AsyncValue.when() Metodu:
```dart
counterStream.when(
  data: (data) { /* success state */ },
  error: (error, stackTrace) { /* error state */ },
  loading: () { /* loading state */ },
)
```

**3 farklı durumu yönetir:**
- `data`: Veri geldiğinde
- `error`: Hata olduğunda  
- `loading`: Yükleme sırasında

---

## 🌊 StreamProvider Definition Örneği

```dart
// providers/stream_provider.dart dosyasında muhtemelen:

// Simple counter stream
final counterStreamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
    Duration(seconds: 1),
    (count) => count + 1,
  );
});

// Auto-dispose version
final counterStreamProvider = StreamProvider.autoDispose<int>((ref) {
  return Stream.periodic(
    Duration(seconds: 1),
    (count) => count + 1,
  );
});
```

**Açıklama:**
- `Stream.periodic()`: Belirli aralıklarla veri üretir
- `Duration(seconds: 1)`: Her 1 saniyede bir
- `(count) => count + 1`: Her defasında sayacı artırır

---

## 🎮 Gelişmiş StreamProvider Örnekleri

### 1. Real-time Clock Stream:
```dart
// Clock stream provider
final clockStreamProvider = StreamProvider<DateTime>((ref) {
  return Stream.periodic(
    Duration(seconds: 1),
    (_) => DateTime.now(),
  );
});

class ClockPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clockStream = ref.watch(clockStreamProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Real-time Clock')),
      body: Center(
        child: clockStream.when(
          data: (dateTime) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Time',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  '${dateTime.hour.toString().padLeft(2, '0')}:'
                  '${dateTime.minute.toString().padLeft(2, '0')}:'
                  '${dateTime.second.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            );
          },
          error: (error, stack) => Text('Clock Error: $error'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
```

### 2. Random Number Generator Stream:
```dart
import 'dart:math';

// Random numbers stream
final randomNumberStreamProvider = StreamProvider<int>((ref) {
  final random = Random();
  return Stream.periodic(
    Duration(milliseconds: 500),
    (_) => random.nextInt(100),
  );
});

// Filtered random numbers (only even numbers)
final evenNumberStreamProvider = StreamProvider<int>((ref) {
  return ref.watch(randomNumberStreamProvider.stream).where(
    (number) => number % 2 == 0,
  );
});

class RandomNumberPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomStream = ref.watch(randomNumberStreamProvider);
    final evenStream = ref.watch(evenNumberStreamProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Random Numbers')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // All numbers
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('All Random Numbers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    randomStream.when(
                      data: (number) => Text(
                        '$number',
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      error: (error, stack) => Text('Error: $error'),
                      loading: () => CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Even numbers only
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Even Numbers Only', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    evenStream.when(
                      data: (number) => Text(
                        '$number',
                        style: TextStyle(
                          fontSize: 36, 
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      error: (error, stack) => Text('Error: $error'),
                      loading: () => CircularProgressIndicator(),
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

### 3. WebSocket-like Communication Stream:
```dart
// Message stream provider
class Message {
  final String id;
  final String text;
  final DateTime timestamp;
  
  Message({required this.id, required this.text, required this.timestamp});
}

final messageStreamProvider = StreamProvider<List<Message>>((ref) {
  final messages = <Message>[];
  
  return Stream.periodic(
    Duration(seconds: 2),
    (count) {
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Message ${count + 1}: ${_getRandomMessage()}',
        timestamp: DateTime.now(),
      );
      
      messages.add(newMessage);
      
      // Keep only last 10 messages
      if (messages.length > 10) {
        messages.removeAt(0);
      }
      
      return List<Message>.from(messages);
    },
  );
});

String _getRandomMessage() {
  final messages = [
    'Hello there!',
    'How are you?',
    'Nice weather today',
    'Working on Flutter',
    'Riverpod is awesome',
    'Stream providers are cool',
    'Real-time updates',
    'Learning new things',
  ];
  
  return messages[Random().nextInt(messages.length)];
}

class MessageStreamPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesStream = ref.watch(messageStreamProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Live Messages')),
      body: messagesStream.when(
        data: (messages) {
          return ListView.builder(
            reverse: true, // Show newest at bottom
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[messages.length - 1 - index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(message.text),
                  subtitle: Text(
                    '${message.timestamp.hour}:${message.timestamp.minute}:${message.timestamp.second}',
                  ),
                  leading: CircleAvatar(
                    child: Text(message.id.substring(message.id.length - 2)),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Error: $error'),
            ],
          ),
        ),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Connecting to message stream...'),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 4. Data Analytics Stream:
```dart
// Analytics data
class AnalyticsData {
  final int activeUsers;
  final double revenue;
  final int pageViews;
  final DateTime timestamp;
  
  AnalyticsData({
    required this.activeUsers,
    required this.revenue,
    required this.pageViews,
    required this.timestamp,
  });
}

final analyticsStreamProvider = StreamProvider<AnalyticsData>((ref) {
  final random = Random();
  
  return Stream.periodic(
    Duration(seconds: 3),
    (_) => AnalyticsData(
      activeUsers: 100 + random.nextInt(500),
      revenue: 1000 + (random.nextDouble() * 5000),
      pageViews: 500 + random.nextInt(2000),
      timestamp: DateTime.now(),
    ),
  );
});

class AnalyticsDashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsStream = ref.watch(analyticsStreamProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Live Analytics')),
      body: analyticsStream.when(
        data: (data) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Card(
                  color: Colors.blue[50],
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Live Dashboard',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Updated: ${data.timestamp.hour}:${data.timestamp.minute}:${data.timestamp.second}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Metrics
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      // Active Users
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people, size: 32, color: Colors.blue),
                              SizedBox(height: 8),
                              Text(
                                '${data.activeUsers}',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text('Active Users'),
                            ],
                          ),
                        ),
                      ),
                      
                      // Revenue
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_money, size: 32, color: Colors.green),
                              SizedBox(height: 8),
                              Text(
                                '\$${data.revenue.toStringAsFixed(0)}',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text('Revenue'),
                            ],
                          ),
                        ),
                      ),
                      
                      // Page Views
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.visibility, size: 32, color: Colors.orange),
                              SizedBox(height: 8),
                              Text(
                                '${data.pageViews}',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text('Page Views'),
                            ],
                          ),
                        ),
                      ),
                      
                      // Status
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.circle, size: 32, color: Colors.green),
                              SizedBox(height: 8),
                              Text(
                                'LIVE',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text('System Status'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Dashboard Error'),
              Text('$error', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading dashboard...'),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🔄 Stream Lifecycle Yönetimi

### AutoDispose Pattern:
```dart
// Memory leak'i önlemek için
final counterStreamProvider = StreamProvider.autoDispose<int>((ref) {
  print('Stream başlatıldı');
  
  // Cleanup callback
  ref.onDispose(() {
    print('Stream temizlendi');
  });
  
  return Stream.periodic(
    Duration(seconds: 1),
    (count) => count + 1,
  ).take(10); // 10 saniye sonra otomatik dur
});

// Manual dispose
class StreamManagementPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<StreamManagementPage> createState() => _StreamManagementPageState();
}

class _StreamManagementPageState extends ConsumerState<StreamManagementPage> {
  bool _isStreamActive = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isStreamActive) ...[
              Consumer(
                builder: (context, ref, child) {
                  final stream = ref.watch(counterStreamProvider);
                  return stream.when(
                    data: (data) => Text('Count: $data', style: TextStyle(fontSize: 24)),
                    error: (error, stack) => Text('Error: $error'),
                    loading: () => CircularProgressIndicator(),
                  );
                },
              ),
            ] else ...[
              Text('Stream Stopped', style: TextStyle(fontSize: 24, color: Colors.grey)),
            ],
            
            SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isStreamActive = !_isStreamActive;
                });
                
                if (!_isStreamActive) {
                  // Invalidate provider to stop stream
                  ref.invalidate(counterStreamProvider);
                }
              },
              child: Text(_isStreamActive ? 'Stop Stream' : 'Start Stream'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🧪 Test Örnekleri

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('StreamProvider Tests', () {
    test('should emit increasing numbers', () async {
      final container = ProviderContainer();
      
      final subscription = container.listen(
        counterStreamProvider,
        (previous, next) {
          next.when(
            data: (data) => print('Received: $data'),
            error: (error, stack) => print('Error: $error'),
            loading: () => print('Loading...'),
          );
        },
      );
      
      // Wait for first emission
      await Future.delayed(Duration(milliseconds: 1100));
      
      final value = container.read(counterStreamProvider);
      expect(value.hasValue, true);
      expect(value.value, 1);
      
      subscription.close();
      container.dispose();
    });
    
    test('should handle stream errors', () async {
      final errorStreamProvider = StreamProvider<int>((ref) {
        return Stream.error('Test error');
      });
      
      final container = ProviderContainer();
      
      final value = container.read(errorStreamProvider);
      
      await Future.delayed(Duration(milliseconds: 100));
      
      expect(value.hasError, true);
      expect(value.error, 'Test error');
      
      container.dispose();
    });

    testWidgets('should update UI when stream emits', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: StreamProviderPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      await tester.pump(Duration(seconds: 1));
      
      expect(find.text('Live Counter: 1'), findsOneWidget);
    });
  });
}
```

---

## 🎯 StreamProvider vs Diğer Provider'lar

### StreamProvider Kullanın:
1. **Real-time data** (canlı veriler)
2. **Continuous updates** (sürekli güncellemeler)
3. **Live notifications** (canlı bildirimler)
4. **Timer-based operations** (zamanlayıcı işlemleri)
5. **WebSocket connections** (WebSocket bağlantıları)

### FutureProvider Kullanın:
1. **One-time API calls** (tek seferlik API çağrıları)
2. **Data fetching** (veri çekme)
3. **Initialization** (başlatma)

### StateProvider Kullanın:
1. **Simple state** (basit state)
2. **User inputs** (kullanıcı girdileri)
3. **UI preferences** (UI tercihleri)

---

## 🚀 Avantajları

1. **Real-time updates**: Gerçek zamanlı güncellemeler
2. **Automatic UI refresh**: Otomatik UI yenileme
3. **Error handling**: Hata yönetimi
4. **Loading states**: Yükleme durumları
5. **Memory efficiency**: Bellek verimliliği (autoDispose ile)
6. **Reactive programming**: Reaktif programlama

---

## ⚠️ Dikkat Edilmesi Gerekenler

1. **Memory leaks**: autoDispose kullanın
2. **Performance**: Gereksiz stream'leri durdurun
3. **Error handling**: Hataları düzgün yönetin
4. **Testing**: Async testler için await kullanın
5. **Resource management**: Stream'leri uygun şekilde temizleyin

---

## 🎓 Sonuç

StreamProvider, **real-time applications** için mükemmeldir. Bu pattern'i kullanarak:
- **Live dashboards** oluşturabilirsiniz
- **Real-time chat** uygulamaları yapabilirsiniz
- **Live notifications** sistemi kurabilirsiniz
- **Continuous data monitoring** sağlayabilirsiniz

Bu sayfa, sürekli veri akışı gerektiren modern uygulamalar için temel bir yapı taşıdır! 