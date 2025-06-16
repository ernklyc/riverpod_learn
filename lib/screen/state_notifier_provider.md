# State Notifier Provider Page - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu sayfa, **StateNotifierProvider**'ın nasıl kullanıldığını gösteren bir demo ekranıdır. Complex state management için kullanılan StateNotifier sınıfını UI'da nasıl kullanacağınızı öğretir. Artırma, azaltma ve sıfırlama işlemleri ile counter mantığını yönetir.

---

## 🧠 State Notifier Provider Page Nedir? (Çok Basit Anlatım)

Düşünün ki **uzaktan kumandanız** var ve televizyonun sesini kontrol ediyorsunuz:
- `Ses +` → Sesi artırır
- `Ses -` → Sesi azaltır
- `Reset` → Varsayılan seviyeye döner

Bu sayfa da aynı mantıkla çalışır! StateNotifier ile counter değerini kontrol edersiniz.

### Bu Sayfanın Özellikleri:
1. **StateNotifier kullanımı** (complex state management)
2. **Multiple actions** (artır, azalt, sıfırla)
3. **Immutable state updates** (değişmez state güncellemeleri)
4. **Business logic separation** (iş mantığı ayrımı)
5. **Reactive UI** (reaktif kullanıcı arayüzü)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### Kod Analizi:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/state_notifier_provider.dart';

class StateNotifierProviderPage extends ConsumerWidget {
  const StateNotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterStateNotifier = ref.watch(counterStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('State Notifier Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $counterStateNotifier',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(onPressed: () {
            ref.read(counterStateNotifierProvider.notifier).increment();
          }, child: Icon(Icons.add)),
          FloatingActionButton(onPressed: () {
            ref.read(counterStateNotifierProvider.notifier).reset();
          }, child: Icon(Icons.refresh)),
          FloatingActionButton(onPressed: () {
            ref.read(counterStateNotifierProvider.notifier).decrement();
          }, child: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
```

**Kelime kelime açıklama:**

### 1. Import Statements:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/state_notifier_provider.dart';
```

**Ne yapar?**
- `material.dart`: Flutter UI bileşenlerini kullanmak için
- `flutter_riverpod.dart`: Riverpod state management için
- `state_notifier_provider.dart`: StateNotifier provider'ını import eder

### 2. State'i İzleme:
```dart
final counterStateNotifier = ref.watch(counterStateNotifierProvider);
```

**Kelime kelime açıklama:**
- `ref.watch()`: StateNotifier provider'ını dinler
- `counterStateNotifierProvider`: Counter StateNotifier'ı
- `counterStateNotifier`: Mevcut counter değerini tutar

### 3. UI Gösterimi:
```dart
Text(
  'Counter: $counterStateNotifier',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
)
```

**Açıklama:**
- Counter değerini büyük ve kalın yazı ile gösterir

### 4. Action Buttons:
```dart
FloatingActionButton(onPressed: () {
  ref.read(counterStateNotifierProvider.notifier).increment();
}, child: Icon(Icons.add))
```

**Kelime kelime açıklama:**
- `ref.read()`: Provider'ı bir kez okur (sadece action için)
- `.notifier`: StateNotifier instance'ına erişim sağlar
- `.increment()`: StateNotifier'daki increment metodunu çağırır

---

## 🌊 StateNotifier Nasıl Çalışır?

### StateNotifier Definition (state_notifier_provider.dart):
```dart
class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0); // Initial state = 0

  void increment() {
    state = state + 1; // State'i artır
  }

  void decrement() {
    state = state - 1; // State'i azalt
  }

  void reset() {
    state = 0; // State'i sıfırla
  }
}

// Provider definition
final counterStateNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});
```

### State Management Flow:
```
User clicks button → StateNotifier method called → State updated → UI rebuilds
```

---

## 🎮 Gelişmiş StateNotifier Örnekleri

### 1. Enhanced Counter with History:
```dart
class CounterWithHistory {
  final int value;
  final List<int> history;
  final DateTime lastUpdated;

  CounterWithHistory({
    required this.value,
    required this.history,
    required this.lastUpdated,
  });

  CounterWithHistory copyWith({
    int? value,
    List<int>? history,
    DateTime? lastUpdated,
  }) {
    return CounterWithHistory(
      value: value ?? this.value,
      history: history ?? this.history,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class CounterHistoryNotifier extends StateNotifier<CounterWithHistory> {
  CounterHistoryNotifier() : super(
    CounterWithHistory(
      value: 0,
      history: [0],
      lastUpdated: DateTime.now(),
    )
  );

  void increment() {
    final newValue = state.value + 1;
    state = state.copyWith(
      value: newValue,
      history: [...state.history, newValue],
      lastUpdated: DateTime.now(),
    );
  }

  void decrement() {
    final newValue = state.value - 1;
    state = state.copyWith(
      value: newValue,
      history: [...state.history, newValue],
      lastUpdated: DateTime.now(),
    );
  }

  void reset() {
    state = CounterWithHistory(
      value: 0,
      history: [0],
      lastUpdated: DateTime.now(),
    );
  }

  void undoLastAction() {
    if (state.history.length > 1) {
      final newHistory = state.history.sublist(0, state.history.length - 1);
      state = state.copyWith(
        value: newHistory.last,
        history: newHistory,
        lastUpdated: DateTime.now(),
      );
    }
  }
}

final counterHistoryProvider = StateNotifierProvider<CounterHistoryNotifier, CounterWithHistory>((ref) {
  return CounterHistoryNotifier();
});

class EnhancedCounterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterHistoryProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Enhanced Counter')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Current Value',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    Text(
                      '${counterState.value}',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Last updated: ${_formatTime(counterState.lastUpdated)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History (${counterState.history.length} items)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: counterState.history.length,
                        itemBuilder: (context, index) {
                          final value = counterState.history[index];
                          final isLast = index == counterState.history.length - 1;
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isLast ? Colors.blue : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$value',
                              style: TextStyle(
                                color: isLast ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(counterHistoryProvider.notifier).increment(),
            child: Icon(Icons.add),
            heroTag: "increment",
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => ref.read(counterHistoryProvider.notifier).decrement(),
            child: Icon(Icons.remove),
            heroTag: "decrement",
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => ref.read(counterHistoryProvider.notifier).undoLastAction(),
            child: Icon(Icons.undo),
            heroTag: "undo",
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => ref.read(counterHistoryProvider.notifier).reset(),
            child: Icon(Icons.refresh),
            heroTag: "reset",
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
```

### 2. Todo List StateNotifier:
```dart
class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String title) {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    state = [...state, newTodo];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void clearCompleted() {
    state = state.where((todo) => !todo.isCompleted).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListPage extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final completedCount = todos.where((todo) => todo.isCompleted).length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        subtitle: Text('${completedCount}/${todos.length} completed'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Yeni görev ekle...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      ref.read(todoListProvider.notifier).addTodo(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Text('Ekle'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) {
                      ref.read(todoListProvider.notifier).toggleTodo(todo.id);
                    },
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ref.read(todoListProvider.notifier).removeTodo(todo.id);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoListProvider.notifier).clearCompleted();
        },
        child: Icon(Icons.clear_all),
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
  group('StateNotifierProvider Tests', () {
    test('should increment counter correctly', () {
      final container = ProviderContainer();
      
      expect(container.read(counterStateNotifierProvider), 0);
      
      container.read(counterStateNotifierProvider.notifier).increment();
      expect(container.read(counterStateNotifierProvider), 1);
      
      container.read(counterStateNotifierProvider.notifier).increment();
      expect(container.read(counterStateNotifierProvider), 2);
      
      container.dispose();
    });
    
    test('should decrement counter correctly', () {
      final container = ProviderContainer();
      
      container.read(counterStateNotifierProvider.notifier).increment();
      container.read(counterStateNotifierProvider.notifier).increment();
      expect(container.read(counterStateNotifierProvider), 2);
      
      container.read(counterStateNotifierProvider.notifier).decrement();
      expect(container.read(counterStateNotifierProvider), 1);
      
      container.dispose();
    });

    test('should reset counter to zero', () {
      final container = ProviderContainer();
      
      container.read(counterStateNotifierProvider.notifier).increment();
      container.read(counterStateNotifierProvider.notifier).increment();
      expect(container.read(counterStateNotifierProvider), 2);
      
      container.read(counterStateNotifierProvider.notifier).reset();
      expect(container.read(counterStateNotifierProvider), 0);
      
      container.dispose();
    });

    testWidgets('should update UI when state changes', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: StateNotifierProviderPage(),
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

## ⚡ Performance Optimizasyonları

### 1. AutoDispose StateNotifier:
```dart
final autoDisposeCounterProvider = StateNotifierProvider.autoDispose<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});
```

### 2. Family StateNotifier:
```dart
final counterFamilyProvider = StateNotifierProvider.family<CounterStateNotifier, int, String>((ref, id) {
  return CounterStateNotifier();
});
```

### 3. Selective Watching:
```dart
// Sadece belirli bir değeri izle
final isPositiveProvider = Provider<bool>((ref) {
  final counter = ref.watch(counterStateNotifierProvider);
  return counter > 0;
});
```

---

## 🎯 StateNotifier vs StateProvider

### StateNotifier Kullanın:
1. **Complex state logic** gerektiğinde
2. **Multiple methods** olduğunda
3. **Business logic** ayrımı istediğinizde
4. **Immutable updates** yaparken
5. **Testing** kolaylığı için

### StateProvider Kullanın:
1. **Simple state** için
2. **Single value** updates için
3. **Quick prototyping** için

---

## 🚀 Avantajları

1. **Business Logic Separation**: İş mantığı UI'dan ayrı
2. **Immutability**: State güncellemeleri güvenli
3. **Testability**: Test etmesi kolay
4. **Performance**: Optimized rebuilds
5. **Scalability**: Büyük uygulamalar için uygun

---

## ⚠️ Dikkat Edilmesi Gerekenler

1. **Immutability**: State'i direkt değiştirmeyin
2. **Method naming**: Method isimleri açıklayıcı olsun
3. **State complexity**: Çok karmaşık state'lerden kaçının
4. **Memory management**: AutoDispose kullanın

---

## 🎓 Sonuç

StateNotifierProvider, **complex state management** için güçlü bir araçtır. Bu pattern'i kullanarak:
- **Business logic**'i UI'dan ayırabilirsiniz
- **Type-safe state updates** yapabilirsiniz
- **Scalable architectures** kurabilirsiniz
- **Testable code** yazabilirsiniz

Bu sayfa, Riverpod'un en güçlü özelliklerinden biri olan StateNotifier'ı kullanmayı öğretir!