# 📡 WebSocket Page - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu sayfa, **WebSocket** teknolojisi ile **gerçek zamanlı Bitcoin fiyat takibi** yapan bir uygulamadır. Binance API'si üzerinden **canlı BTC/USDT** fiyatlarını anlık olarak alır ve ekranda gösterir. Real-time data streaming'in mükemmel bir örneğidir.

---

## 🧠 WebSocket Page Nedir? (Çok Basit Anlatım)

Düşünün ki **canlı bir borsa ekranı** var. Bu ekranda:
- **Bitcoin fiyatı** sürekli değişiyor
- **Saniyede onlarca** güncelleme geliyor
- **Hiç durmadan** yeni veriler akıyor

WebSocket da aynen böyledir! **Sürekli açık bir kanal** kurar ve:
- **Server'dan client'a** sürekli veri gönderir
- **Gerçek zamanlı** iletişim sağlar
- **Çift yönlü** veri akışı mümkündür

### 🌍 Gerçek Hayat Örnekleri:
1. **💰 Kripto para fiyatları** (Bitcoin, Ethereum)
2. **📈 Borsa verileri** (hisse senedi fiyatları)
3. **💬 Canlı chat** (WhatsApp, Telegram)
4. **🎮 Online oyunlar** (multiplayer games)
5. **⚽ Canlı skor** (futbol maçları)
6. **🌡️ IoT sensörleri** (sıcaklık, nem)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/web_socket_provider.dart';

class WebSocketPage extends ConsumerWidget {
  const WebSocketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webSocketStream = ref.watch(webSocketProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket')),
      body: Center(
        child: webSocketStream.when(
          data: (data) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BTC/USDT Price',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Text(data, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
```

**Kelime kelime açıklama:**

### 1. 📦 Import Statements:
```dart
import 'package:flutter/material.dart';  // UI widgets
import 'package:flutter_riverpod/flutter_riverpod.dart';  // State management
import 'package:riverpod_learn/providers/web_socket_provider.dart';  // WebSocket provider
```

### 2. 🔄 WebSocket Stream'i İzleme:
```dart
final webSocketStream = ref.watch(webSocketProvider);
```

**Ne yapar?**
- `ref.watch()`: WebSocket provider'ını dinler
- `webSocketProvider`: Binance WebSocket'ine bağlanan provider
- `webSocketStream`: AsyncValue<String> tipinde canlı fiyat verisi

### 3. 🎭 AsyncValue.when() ile Durum Yönetimi:
```dart
webSocketStream.when(
  data: (data) => /* Bitcoin fiyatını göster */,
  error: (error, stackTrace) => /* Hata durumu */,
  loading: () => /* Bağlantı kuruluyor */,
)
```

**3 farklı durumu yönetir:**
- `data`: Fiyat verisi geldiğinde
- `error`: WebSocket hatası olduğunda
- `loading`: Bağlantı kurulurken

---

## 🎮 Gelişmiş WebSocket Page Örnekleri

### 1. 🚀 Enhanced Crypto Price Display:
```dart
class EnhancedWebSocketPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webSocketStream = ref.watch(webSocketProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('🪙 Live Crypto Prices'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => ref.invalidate(webSocketProvider),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade100, Colors.white],
          ),
        ),
        child: webSocketStream.when(
          data: (price) => Center(
            child: Card(
              elevation: 8,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Bitcoin Icon
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.currency_bitcoin,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Symbol
                    Text(
                      'BTC/USDT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    
                    SizedBox(height: 12),
                    
                    // Price
                    Text(
                      '\$${double.parse(price).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Live indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'LIVE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  'Connection Error',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => ref.invalidate(webSocketProvider),
                  child: Text('🔄 Retry Connection'),
                ),
              ],
            ),
          ),
          loading: () => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.orange),
                SizedBox(height: 20),
                Text(
                  'Connecting to Binance...',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### 2. 📊 Multi-Crypto Dashboard:
```dart
class MultiCryptoDashboard extends ConsumerWidget {
  final List<String> symbols = ['btcusdt', 'ethusdt', 'adausdt', 'dotusdt'];
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚀 Crypto Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: symbols.length,
        itemBuilder: (context, index) {
          final symbol = symbols[index];
          return CryptoTileWidget(symbol: symbol);
        },
      ),
    );
  }
}

class CryptoTileWidget extends ConsumerWidget {
  final String symbol;
  
  const CryptoTileWidget({required this.symbol});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Her symbol için ayrı provider kullanılabilir
    final cryptoStream = ref.watch(webSocketProvider); // Simplified for example
    
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getCryptoColor(symbol),
          child: Text(
            _getCryptoSymbol(symbol),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          symbol.toUpperCase().replaceAll('USDT', '/USDT'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: cryptoStream.when(
          data: (price) => Text('\$${double.parse(price).toStringAsFixed(2)}'),
          error: (error, stack) => Text('Error loading price'),
          loading: () => Text('Loading...'),
        ),
        trailing: Icon(Icons.trending_up, color: Colors.green),
      ),
    );
  }

  Color _getCryptoColor(String symbol) {
    switch (symbol) {
      case 'btcusdt': return Colors.orange;
      case 'ethusdt': return Colors.blue;
      case 'adausdt': return Colors.indigo;
      case 'dotusdt': return Colors.pink;
      default: return Colors.grey;
    }
  }

  String _getCryptoSymbol(String symbol) {
    switch (symbol) {
      case 'btcusdt': return 'BTC';
      case 'ethusdt': return 'ETH';
      case 'adausdt': return 'ADA';
      case 'dotusdt': return 'DOT';
      default: return '?';
    }
  }
}
```

### 3. 📈 Price History Chart:
```dart
// Price point model
class PricePoint {
  final DateTime timestamp;
  final double price;

  PricePoint(this.timestamp, this.price);
}

// Price history provider
final priceHistoryProvider = StateNotifierProvider<PriceHistoryNotifier, List<PricePoint>>((ref) {
  return PriceHistoryNotifier();
});

class PriceHistoryNotifier extends StateNotifier<List<PricePoint>> {
  static const maxPoints = 50;
  
  PriceHistoryNotifier() : super([]);

  void addPrice(double price) {
    final newPoint = PricePoint(DateTime.now(), price);
    final newList = [...state, newPoint];
    
    if (newList.length > maxPoints) {
      newList.removeAt(0);
    }
    
    state = newList;
  }

  void clear() => state = [];
}

class ChartWebSocketPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webSocketStream = ref.watch(webSocketProvider);
    final priceHistory = ref.watch(priceHistoryProvider);
    
    // Her yeni fiyatı history'ye ekle
    ref.listen(webSocketProvider, (previous, next) {
      next.whenData((price) {
        ref.read(priceHistoryProvider.notifier).addPrice(double.parse(price));
      });
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text('📈 BTC Price Chart'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => ref.read(priceHistoryProvider.notifier).clear(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Current price section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.grey[100],
            child: webSocketStream.when(
              data: (price) => Column(
                children: [
                  Text(
                    'Current Price',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${double.parse(price).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              error: (error, stack) => Text('Price Error'),
              loading: () => CircularProgressIndicator(),
            ),
          ),
          
          // Chart section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: priceHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.show_chart, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Waiting for price data...',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          height: 200,
                          child: SimplePriceChart(priceHistory),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Price History (Last ${priceHistory.length} updates)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: priceHistory.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              final point = priceHistory[priceHistory.length - 1 - index];
                              return ListTile(
                                leading: Text('#${priceHistory.length - index}'),
                                title: Text('\$${point.price.toStringAsFixed(2)}'),
                                trailing: Text(
                                  '${point.timestamp.hour.toString().padLeft(2, '0')}:'
                                  '${point.timestamp.minute.toString().padLeft(2, '0')}:'
                                  '${point.timestamp.second.toString().padLeft(2, '0')}',
                                ),
                              );
                            },
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
}

// Simple chart widget
class SimplePriceChart extends StatelessWidget {
  final List<PricePoint> points;

  const SimplePriceChart(this.points);

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return Center(child: Text('Need at least 2 data points'));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: PriceChartPainter(points),
        size: Size.infinite,
      ),
    );
  }
}

class PriceChartPainter extends CustomPainter {
  final List<PricePoint> points;

  PriceChartPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    
    // Min/Max price for normalization
    final prices = points.map((p) => p.price).toList();
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final priceRange = maxPrice - minPrice;
    
    // Draw line chart
    for (int i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = priceRange > 0 
          ? size.height - ((points[i].price - minPrice) / priceRange) * size.height
          : size.height / 2;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      
      // Draw points
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = Colors.red);
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

### 4. 🔄 Connection Status Indicator:
```dart
class ConnectionStatusPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webSocketStream = ref.watch(webSocketProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Status'),
        actions: [
          // Connection status indicator
          Container(
            margin: EdgeInsets.only(right: 16),
            child: webSocketStream.when(
              data: (_) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text('LIVE', style: TextStyle(fontSize: 10, color: Colors.green)),
                ],
              ),
              error: (_, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text('ERROR', style: TextStyle(fontSize: 10, color: Colors.red)),
                ],
              ),
              loading: () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 8,
                    height: 8,
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                  SizedBox(width: 4),
                  Text('...', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: webSocketStream.when(
        data: (price) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi, size: 64, color: Colors.green),
              SizedBox(height: 16),
              Text(
                'Connected to Binance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'BTC/USDT',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Text(
                '\$${double.parse(price).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Connection Failed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => ref.invalidate(webSocketProvider),
                icon: Icon(Icons.refresh),
                label: Text('Retry'),
              ),
            ],
          ),
        ),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Connecting to WebSocket...',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('WebSocket Page Tests', () {
    testWidgets('should show loading indicator initially', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: WebSocketPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display app bar with correct title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: WebSocketPage(),
          ),
        ),
      );

      expect(find.text('WebSocket'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should show BTC/USDT Price label', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: WebSocketPage(),
          ),
        ),
      );

      // Pump to allow async operations
      await tester.pump();
      
      // Should either show loading or the price label
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Text && 
            (widget.data == 'BTC/USDT Price' || widget is CircularProgressIndicator)
        ),
        findsAtLeastNWidgets(1),
      );
    });

    test('PricePoint model should work correctly', () {
      final now = DateTime.now();
      final pricePoint = PricePoint(now, 45000.50);
      
      expect(pricePoint.timestamp, now);
      expect(pricePoint.price, 45000.50);
    });

    test('PriceHistoryNotifier should maintain max limit', () {
      final notifier = PriceHistoryNotifier();
      
      // Add more than max points
      for (int i = 0; i < 60; i++) {
        notifier.addPrice(45000.0 + i);
      }
      
      expect(notifier.state.length, PriceHistoryNotifier.maxPoints);
      expect(notifier.state.first.price, 45010.0); // First 10 removed
    });

    testWidgets('Enhanced WebSocket Page should show Bitcoin icon', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: EnhancedWebSocketPage(),
          ),
        ),
      );

      await tester.pump();
      
      // Should find either the Bitcoin icon or loading indicator
      expect(
        find.byWidgetPredicate(
          (widget) => (widget is Icon && widget.icon == Icons.currency_bitcoin) ||
                      widget is CircularProgressIndicator
        ),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('Chart page should handle empty data gracefully', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ChartWebSocketPage(),
          ),
        ),
      );

      await tester.pump();
      
      // Should show waiting message when no data
      expect(
        find.textContaining('Waiting for price data'),
        findsOneWidget,
      );
    });
  });
}
```

---

## 🎯 WebSocket Page Kullanım Senaryoları

### ✅ İdeal Kullanım Alanları:
1. **💰 Cryptocurrency trading apps** (kripto para ticaret uygulamaları)
2. **📈 Stock market displays** (borsa ekranları)
3. **⚽ Live sports scoreboards** (canlı spor skorları)
4. **💬 Real-time chat interfaces** (gerçek zamanlı sohbet)
5. **🎮 Gaming leaderboards** (oyun skor tabloları)
6. **📊 IoT monitoring dashboards** (IoT izleme panelleri)

### ❌ Kullanmayın:
1. **Static data** (statik veriler için)
2. **One-time API calls** (tek seferlik API çağrıları)
3. **File uploads** (dosya yüklemeleri)
4. **Authentication** (kimlik doğrulama)

---

## 🚀 Avantajları

1. **⚡ Real-time Updates**: Gerçek zamanlı güncellemeler
2. **🔄 Automatic Reconnection**: Otomatik yeniden bağlanma
3. **📱 Responsive UI**: Duyarlı kullanıcı arayüzü
4. **🎯 Low Latency**: Düşük gecikme süresi
5. **🔧 Easy Integration**: Kolay entegrasyon
6. **♻️ Resource Management**: Kaynak yönetimi (autoDispose)

---

## ⚠️ Dikkat Edilmesi Gerekenler

1. **🌐 Network Connection**: Ağ bağlantısı kesintileri
2. **🧠 Memory Usage**: Bellek kullanımı (sürekli veri akışı)
3. **🔋 Battery Drain**: Batarya tüketimi
4. **📊 Data Validation**: Gelen veri doğrulaması
5. **🚨 Error Handling**: Kapsamlı hata yönetimi
6. **⏱️ Rate Limiting**: Hız sınırlaması

---

## 🎓 Sonuç

WebSocket Page, **modern real-time applications** için vazgeçilmezdir. Bu sayfa ile:
- **🪙 Live cryptocurrency tracking** yapabilirsiniz
- **📊 Professional trading interfaces** oluşturabilirsiniz
- **🎮 Real-time multiplayer games** geliştirebilirsiniz
- **📈 Live data visualization** uygulayabilirsiniz

Bu örnek, gerçek zamanlı veri akışı ihtiyaçlarına mükemmel bir çözüm sunar ve modern finansal uygulamaların temelini oluşturur! 