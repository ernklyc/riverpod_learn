# App Router (GoRouter) - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, Flutter uygulamanızda **sayfa geçişleri** ve **navigasyon** yönetimi için kullanılır. Yani hangi sayfadan hangi sayfaya nasıl gidileceğini, URL'lerin nasıl çalışacağını, deep linking'in nasıl olacağını kontrol etmek için bu dosyayı kullanırsınız. Bu dosya özellikle **modern routing** ve **web desteği** için tasarlanmıştır.

---

## 🧠 GoRouter Nedir? (Çok Basit Anlatım)

Düşünün ki bir şehirde yaşıyorsunuz ve farklı yerlere gitmek istiyorsunuz. Evden işe, işten markete, marketten parka... Her yere gitmek için bir yol haritası gerekir. İşte `GoRouter` da böyle çalışır. Uygulamanızın sayfaları arasında geçiş yapmak için bir yol haritası sağlar.

### GoRouter'ın Özellikleri:
1. **Declarative routing** (bildirimsel yönlendirme)
2. **URL-based navigation** (URL tabanlı navigasyon)
3. **Deep linking desteği** (derin bağlantı desteği)
4. **Web uyumluluğu** (web compatibility)
5. **Type-safe routing** (tip güvenli yönlendirme)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### 1. Import Satırları
```dart
import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/screen/autodispose/counter_autodispose_page.dart';
import '../screen/autodispose/index_page.dart';
```

**Ne yapar?**
- **`go_router`**: Modern routing paketi
- **`counter_autodispose_page.dart`**: Sayaç sayfası import'u
- **`index_page.dart`**: Ana sayfa import'u

**Neden gerekli?**
- GoRouter kullanabilmek için go_router paketi şart
- Sayfalara yönlendirme yapabilmek için sayfa sınıflarını import etmek gerekli

**Gerçek hayat örneği:**
Bir rehber kitap kullanmak için önce kitabı elinize almanız gerekir. Burada da routing yapmak için önce go_router paketini ve sayfa dosyalarını "import" etmeniz gerekir.

---

### 2. GoRouter Tanımı

```dart
final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const IndexPage()),
    GoRoute(path: '/counter', builder: (context, state) => const CounterAutodisposePage()),
  ],
);
```

Bu kod çok önemli! Kelime kelime açıklayalım:

#### `final appRouter =`
- **`final`**: Bu değişken sadece bir kez atanır
- **`appRouter`**: Router'ımızın adı (app = uygulama, router = yönlendirici)

#### `GoRouter(`
- **`GoRouter`**: Modern routing sınıfı
- **`(`**: Constructor başlar

#### `routes: [`
- **`routes`**: Rotalar listesi
- **`[`**: Liste başlar

#### `GoRoute(path: '/', builder: (context, state) => const IndexPage()),`
- **`GoRoute`**: Tek bir rota tanımı
- **`path: '/'`**: Ana sayfa URL'i (root)
- **`builder:`**: Sayfa oluşturucu fonksiyon
- **`(context, state)`**: Builder parametreleri
- **`=> const IndexPage()`**: IndexPage widget'ını döndür

#### `GoRoute(path: '/counter', builder: (context, state) => const CounterAutodisposePage()),`
- **`path: '/counter'`**: Sayaç sayfası URL'i
- **`builder:`**: Sayfa oluşturucu fonksiyon
- **`=> const CounterAutodisposePage()`**: CounterAutodisposePage widget'ını döndür

**Tüm kod ne anlama gelir?**
"appRouter adında bir GoRouter oluştur. Bu router iki rota tanımlasın: '/' URL'i için IndexPage göster, '/counter' URL'i için CounterAutodisposePage göster."

---

## 🗺️ Routing Nasıl Çalışır? (Detaylı Anlatım)

### URL ve Sayfa Eşleştirmesi:

#### Ana Sayfa (Root):
```
URL: https://myapp.com/
Path: '/'
Widget: IndexPage()
```

#### Sayaç Sayfası:
```
URL: https://myapp.com/counter
Path: '/counter'
Widget: CounterAutodisposePage()
```

### Navigation Flow:
```
Kullanıcı URL Girer/Tıklar
        ↓
GoRouter URL'i Analiz Eder
        ↓
Uygun Route'u Bulur
        ↓
Builder Fonksiyonu Çalışır
        ↓
Widget Oluşturulur
        ↓
Sayfa Gösterilir
```

### Deep Linking:
```
Web Browser: https://myapp.com/counter
        ↓
GoRouter: '/counter' path'ini yakalar
        ↓
CounterAutodisposePage() oluşturulur
        ↓
Kullanıcı direkt sayaç sayfasını görür
```

---

## 🏗️ Main.dart'ta Nasıl Kullanılır? (Adım Adım)

### 1. MaterialApp.router Kullanımı
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Riverpod Learn',
      routerConfig: appRouter, // Router'ımızı kullan
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
    );
  }
}
```

### 2. Navigation Nasıl Yapılır?

#### Programmatic Navigation:
```dart
// Sayaç sayfasına git
context.go('/counter');

// Ana sayfaya git
context.go('/');

// Geri git (push navigation için)
context.pop();

// Replace navigation
context.pushReplacement('/counter');
```

#### Widget İçinde Kullanım:
```dart
class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Riverpod Öğrenme Uygulaması',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Sayaç sayfasına git
                context.go('/counter');
              },
              icon: Icon(Icons.calculate),
              label: Text('Sayaç Sayfasına Git'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () {
                // URL ile navigation
                context.push('/counter');
              },
              icon: Icon(Icons.open_in_new),
              label: Text('Push Navigation'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎮 Gelişmiş GoRouter Örnekleri

### 1. Parametreli Rotalar
```dart
final advancedAppRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IndexPage(),
    ),
    GoRoute(
      path: '/user/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return UserProfilePage(userId: userId);
      },
    ),
    GoRoute(
      path: '/product/:productId',
      builder: (context, state) {
        final productId = state.pathParameters['productId']!;
        final category = state.uri.queryParameters['category'];
        return ProductDetailPage(
          productId: productId,
          category: category,
        );
      },
    ),
  ],
);

// Kullanım:
// context.go('/user/123');
// context.go('/product/456?category=electronics');
```

### 2. Nested Routes (İç İçe Rotalar)
```dart
final nestedAppRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IndexPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
      routes: [
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: 'analytics',
          builder: (context, state) => const AnalyticsPage(),
        ),
      ],
    ),
  ],
);

// URL'ler:
// /dashboard/profile
// /dashboard/settings
// /dashboard/analytics
```

### 3. Redirect ve Guards
```dart
final secureAppRouter = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = AuthService.isLoggedIn;
    final isLoginPage = state.uri.path == '/login';
    
    // Giriş yapmamışsa login sayfasına yönlendir
    if (!isLoggedIn && !isLoginPage) {
      return '/login';
    }
    
    // Giriş yapmışsa login sayfasından ana sayfaya yönlendir
    if (isLoggedIn && isLoginPage) {
      return '/';
    }
    
    return null; // Yönlendirme yok
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);
```

### 4. Error Handling
```dart
final errorHandlingRouter = GoRouter(
  errorBuilder: (context, state) {
    return ErrorPage(
      error: state.error.toString(),
      path: state.uri.path,
    );
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IndexPage(),
    ),
    GoRoute(
      path: '/counter',
      builder: (context, state) => const CounterPage(),
    ),
  ],
);

class ErrorPage extends StatelessWidget {
  final String error;
  final String path;
  
  const ErrorPage({
    Key? key,
    required this.error,
    required this.path,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hata'),
        backgroundColor: Colors.red,
      ),
      body: Center(
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
              'Sayfa Bulunamadı',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Path: $path'),
            SizedBox(height: 10),
            Text('Error: $error'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text('Ana Sayfaya Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 5. Bottom Navigation ile GoRouter
```dart
final bottomNavRouter = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavigationScaffold(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class BottomNavigationScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  
  const BottomNavigationScaffold({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Arama',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
```

---

## ⚡ Navigation Metodları ve Kullanım Alanları

### 1. **context.go()** (Replace Navigation)
```dart
context.go('/counter');
```
**Ne yapar:**
- Mevcut sayfayı değiştirir
- Geri butonuyla önceki sayfaya dönülemez
- URL değişir

**Kullanım alanları:**
- Tab navigation
- Main page transitions
- Login/logout redirects

### 2. **context.push()** (Stack Navigation)
```dart
context.push('/counter');
```
**Ne yapar:**
- Yeni sayfa ekler (stack'e push)
- Geri butonuyla önceki sayfaya dönülebilir
- Navigation history korunur

**Kullanım alanları:**
- Detail pages
- Modal-like navigation
- Form pages

### 3. **context.pop()** (Geri Git)
```dart
context.pop();
context.pop(result); // Sonuç ile geri git
```
**Ne yapar:**
- Son sayfayı kapatır
- Önceki sayfaya döner
- Sonuç döndürebilir

### 4. **context.pushReplacement()** (Replace Push)
```dart
context.pushReplacement('/counter');
```
**Ne yapar:**
- Mevcut sayfayı yeni sayfa ile değiştirir
- Stack'te yer değişimi yapar

### 5. **context.goNamed()** (Named Routes)
```dart
// Route tanımı
GoRoute(
  path: '/user/:id',
  name: 'user-profile',
  builder: (context, state) => UserProfilePage(),
)

// Kullanım
context.goNamed(
  'user-profile',
  pathParameters: {'id': '123'},
  queryParameters: {'tab': 'settings'},
);
```

---

## 🎯 Ne Zaman GoRouter Kullanmalısınız?

### ✅ Kullanın:
1. **Web desteği** gerekiyorsa
2. **Deep linking** istiyorsanız
3. **URL-based navigation** gerekiyorsa
4. **Modern routing** istiyorsanız
5. **Type-safe navigation** istiyorsanız
6. **Complex routing** gerekiyorsa

### ❌ Kullanmayın:
1. **Basit mobile-only** uygulamalar
2. **Navigator 1.0 yeterli** olan durumlar
3. **Öğrenme aşamasında** (başlangıç için karmaşık)
4. **Legacy kod** ile uyumsuzluk

### Karar Verme Rehberi:
```
Web desteği gerekli mi?
├─ Evet → GoRouter kullanın
└─ Hayır
   ├─ Deep linking gerekli mi? → GoRouter
   ├─ Complex routing var mı? → GoRouter
   ├─ URL kontrolü gerekli mi? → GoRouter
   └─ Basit navigation mi? → Navigator 1.0
```

---

## 🔧 GoRouter İpuçları ve En İyi Uygulamalar

### 1. **Route Organization**
```dart
// ✅ İyi - Routes'ları organize et
class AppRoutes {
  static const home = '/';
  static const counter = '/counter';
  static const profile = '/profile';
  static const userProfile = '/user/:userId';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.counter,
      builder: (context, state) => const CounterPage(),
    ),
  ],
);
```

### 2. **Type-Safe Navigation**
```dart
// ✅ İyi - Extension kullan
extension AppNavigation on BuildContext {
  void goToHome() => go(AppRoutes.home);
  void goToCounter() => go(AppRoutes.counter);
  void goToUserProfile(String userId) => go('/user/$userId');
}

// Kullanım:
context.goToCounter();
context.goToUserProfile('123');
```

### 3. **Route Guards**
```dart
// ✅ İyi - Route guard'ları kullan
class RouteGuard {
  static String? authGuard(BuildContext context, GoRouterState state) {
    if (!AuthService.isLoggedIn) {
      return '/login';
    }
    return null;
  }
  
  static String? adminGuard(BuildContext context, GoRouterState state) {
    if (!AuthService.isAdmin) {
      return '/unauthorized';
    }
    return null;
  }
}

final secureRouter = GoRouter(
  redirect: RouteGuard.authGuard,
  routes: [...],
);
```

### 4. **Error Handling**
```dart
// ✅ İyi - Merkezi error handling
final appRouter = GoRouter(
  errorBuilder: (context, state) => ErrorPage(
    error: state.error,
    path: state.uri.path,
  ),
  routes: [...],
);
```

### 5. **Riverpod ile Integration**
```dart
// ✅ İyi - Riverpod ile router state
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    redirect: (context, state) {
      if (!authState.isLoggedIn && state.uri.path != '/login') {
        return '/login';
      }
      return null;
    },
    routes: [...],
  );
});

// MaterialApp'te kullanım
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
```

---

## 🧪 Test Nasıl Yazılır?

### 1. Router Test Örneği:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  test('Router configuration test', () {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/counter',
          builder: (context, state) => const CounterPage(),
        ),
      ],
    );
    
    // Router'ın doğru yapılandırıldığını test et
    expect(router.configuration.routes.length, 2);
    expect(router.configuration.routes[0].path, '/');
    expect(router.configuration.routes[1].path, '/counter');
  });
}
```

### 2. Navigation Test Örneği:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('Navigation test', (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: ElevatedButton(
              onPressed: () => context.go('/counter'),
              child: Text('Go to Counter'),
            ),
          ),
        ),
        GoRoute(
          path: '/counter',
          builder: (context, state) => Scaffold(
            body: Text('Counter Page'),
          ),
        ),
      ],
    );
    
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );
    
    // Ana sayfada olduğumuzu kontrol et
    expect(find.text('Go to Counter'), findsOneWidget);
    
    // Butona tıkla
    await tester.tap(find.text('Go to Counter'));
    await tester.pumpAndSettle();
    
    // Sayaç sayfasına gittiğimizi kontrol et
    expect(find.text('Counter Page'), findsOneWidget);
  });
}
```

---

## 🚀 Avantajları (Neden Kullanmalısınız?)

### 1. **Web Compatibility** (Web Uyumluluğu)
- URL'ler web'de çalışır
- Browser back/forward butonları
- Bookmark desteği

### 2. **Deep Linking** (Derin Bağlantı)
- Direkt sayfa linkler
- Share edilebilir URL'ler
- External app integration

### 3. **Type Safety** (Tip Güvenliği)
- Compile-time route kontrolü
- Parameter validation
- IDE desteği

### 4. **Declarative** (Bildirimsel)
- Route'lar merkezi tanımlı
- Kolay yönetim
- Clear structure

### 5. **Modern Architecture** (Modern Mimari)
- Flutter 3.0+ uyumlu
- Best practices
- Future-proof

---

## ⚠️ Dezavantajları (Dikkat Edilmesi Gerekenler)

### 1. **Learning Curve** (Öğrenme Eğrisi)
- Navigator 1.0'dan daha karmaşık
- Yeni kavramlar
- Documentation okuma gerekli

### 2. **Migration Complexity** (Geçiş Karmaşıklığı)
- Mevcut koddan geçiş zor
- Breaking changes olabilir
- Refactoring gerekebilir

### 3. **Bundle Size** (Paket Boyutu)
- Ek dependency
- App size artışı
- Mobile için overhead

### 4. **Debugging** (Debug Zorluğu)
- Route state tracking
- Complex navigation flows
- Error tracing

---

## 🎓 Sonuç ve Öneriler

GoRouter, Flutter'da **modern routing** için vazgeçilmez bir araçtır. Eğer:

- Web desteği gerekiyorsa
- Deep linking istiyorsanız
- URL-based navigation gerekiyorsa
- Modern architecture kullanıyorsanız

O zaman GoRouter'ı kesinlikle kullanmalısınız.

### Öğrenme Sırası:
1. **Basic Flutter Navigation** → Navigator 1.0
2. **Route concepts** → Routes, paths, parameters
3. **GoRouter basics** → Simple routing
4. **Advanced features** → Guards, redirects, nested routes
5. **Integration** → Riverpod, state management

### Gerçek Projede Kullanım:
- **E-commerce**: Product pages, categories, checkout
- **Social Media**: Profiles, posts, feeds
- **News Apps**: Articles, categories, search
- **Dashboard Apps**: Analytics, settings, reports
- **Multi-platform**: Web + mobile apps

---

## 📚 Ek Kaynaklar ve İleri Seviye Örnekler

### 1. Custom Transition Animations:
```dart
GoRoute(
  path: '/counter',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      child: CounterPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: Offset(1.0, 0.0), end: Offset.zero),
          ),
          child: child,
        );
      },
    );
  },
)
```

### 2. Route-based State Management:
```dart
final routeStateProvider = StateProvider<String>((ref) => '/');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [...],
    redirect: (context, state) {
      // Route değişikliklerini state'e kaydet
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(routeStateProvider.notifier).state = state.uri.path;
      });
      return null;
    },
  );
});
```

### 3. Dynamic Route Generation:
```dart
final dynamicRouter = GoRouter(
  routes: [
    ...generateUserRoutes(), // Dinamik user routes
    ...generateProductRoutes(), // Dinamik product routes
  ],
);

List<GoRoute> generateUserRoutes() {
  return UserService.getAllUsers().map((user) {
    return GoRoute(
      path: '/user/${user.id}',
      builder: (context, state) => UserProfilePage(user: user),
    );
  }).toList();
}
```

Bu rehberi okuduktan sonra GoRouter'ı rahatlıkla kullanabilir ve modern navigation sistemleri geliştirebilirsiniz! 🚀