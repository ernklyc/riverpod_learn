# Team Player Model - Kapsamlı ve Detaylı Açıklama

## 🎯 Bu Dosya Ne İçin Var?

Bu dosya, **TeamPlayer model**'ini tanımlar. Trabzonspor futbol takımı oyuncularının bilgilerini tutmak için kullanılan basit ama etkili bir veri yapısıdır. Team Provider ile birlikte çalışarak oyuncu listesi yönetimini sağlar.

---

## 🧠 Team Player Model Nedir? (Çok Basit Anlatım)

Düşünün ki **oyuncu kartları** topluyorsunuz. Her kartta:
- **Oyuncunun adı** yazıyor
- **Hangi pozisyonda** oynadığı belirtiliyor  
- **Fotoğrafı** var

TeamPlayer model'i de aynen böyle bir **dijital oyuncu kartı**dır! Her oyuncunun temel bilgilerini saklar.

### Bu Model'in Özellikleri:
1. **Simple structure** (basit yapı)
2. **Immutable data** (değişmez veri)
3. **Type safety** (tip güvenliği)
4. **Clean representation** (temiz gösterim)
5. **Easy to use** (kullanımı kolay)

---

## 📝 Kodun Satır Satır, Kelime Kelime Açıklaması

### Kod Analizi:
```dart
class TeamPlayer {
  final String name;
  final String position;
  final String avatar;

  TeamPlayer({
    required this.name,
    required this.position,
    required this.avatar,
  });
}
```

**Kelime kelime açıklama:**

### 1. Class Definition:
```dart
class TeamPlayer {
```

**Ne yapar?**
- `class`: Yeni bir sınıf tanımlar
- `TeamPlayer`: Sınıfın adı
- Futbol oyuncusu verilerini temsil eder

### 2. Properties:
```dart
final String name;
final String position;
final String avatar;
```

**Her property'nin anlamı:**

#### `final String name;`
- **`final`**: Değer bir kez atandıktan sonra değiştirilemez
- **`String`**: Metin tipinde veri
- **`name`**: Oyuncunun tam adı (örn: "Uğurcan Çakır")

#### `final String position;`
- **`position`**: Oyuncunun mevkii
- Örnekler: "Kaleci", "Stoper", "Orta Saha", "Forvet"

#### `final String avatar;`
- **`avatar`**: Oyuncunun profil fotoğrafı URL'i
- Network image veya asset path olabilir

### 3. Constructor:
```dart
TeamPlayer({
  required this.name,
  required this.position,
  required this.avatar,
});
```

**Constructor açıklaması:**
- **Named constructor**: İsimli parametreler kullanır
- **`required`**: Bu parametreler zorunludur
- **`this.name`**: Gelen değeri name property'sine atar

---

## 🎮 Gelişmiş TeamPlayer Örnekleri

### 1. Enhanced TeamPlayer Model:
```dart
class EnhancedTeamPlayer {
  final String id;
  final String name;
  final String position;
  final String avatar;
  final int jerseyNumber;
  final String nationality;
  final int age;
  final double marketValue; // Million euros
  final bool isInjured;
  final DateTime joinDate;
  final PlayerStats stats;

  const EnhancedTeamPlayer({
    required this.id,
    required this.name,
    required this.position,
    required this.avatar,
    required this.jerseyNumber,
    required this.nationality,
    required this.age,
    required this.marketValue,
    this.isInjured = false,
    required this.joinDate,
    required this.stats,
  });

  // Factory constructor for creating from JSON
  factory EnhancedTeamPlayer.fromJson(Map<String, dynamic> json) {
    return EnhancedTeamPlayer(
      id: json['id'] as String,
      name: json['name'] as String,
      position: json['position'] as String,
      avatar: json['avatar'] as String,
      jerseyNumber: json['jerseyNumber'] as int,
      nationality: json['nationality'] as String,
      age: json['age'] as int,
      marketValue: (json['marketValue'] as num).toDouble(),
      isInjured: json['isInjured'] as bool? ?? false,
      joinDate: DateTime.parse(json['joinDate'] as String),
      stats: PlayerStats.fromJson(json['stats'] as Map<String, dynamic>),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'avatar': avatar,
      'jerseyNumber': jerseyNumber,
      'nationality': nationality,
      'age': age,
      'marketValue': marketValue,
      'isInjured': isInjured,
      'joinDate': joinDate.toIso8601String(),
      'stats': stats.toJson(),
    };
  }

  // Copy with method for immutable updates
  EnhancedTeamPlayer copyWith({
    String? id,
    String? name,
    String? position,
    String? avatar,
    int? jerseyNumber,
    String? nationality,
    int? age,
    double? marketValue,
    bool? isInjured,
    DateTime? joinDate,
    PlayerStats? stats,
  }) {
    return EnhancedTeamPlayer(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      avatar: avatar ?? this.avatar,
      jerseyNumber: jerseyNumber ?? this.jerseyNumber,
      nationality: nationality ?? this.nationality,
      age: age ?? this.age,
      marketValue: marketValue ?? this.marketValue,
      isInjured: isInjured ?? this.isInjured,
      joinDate: joinDate ?? this.joinDate,
      stats: stats ?? this.stats,
    );
  }

  // Computed properties
  String get displayName => '$name (#$jerseyNumber)';
  String get positionShort => _getPositionShort(position);
  bool get isVeteran => age > 30;
  bool get isYoung => age < 23;
  String get experienceLevel {
    final yearsInTeam = DateTime.now().difference(joinDate).inDays ~/ 365;
    if (yearsInTeam < 1) return 'Yeni';
    if (yearsInTeam < 3) return 'Deneyimli';
    return 'Veteran';
  }

  String _getPositionShort(String position) {
    switch (position.toLowerCase()) {
      case 'kaleci': return 'KAL';
      case 'sağ bek': return 'SAĞ';
      case 'sol bek': return 'SOL';
      case 'stoper': return 'STP';
      case 'defansif orta saha': return 'DMF';
      case 'merkez orta saha': return 'CMF';
      case 'sağ kanat': return 'RMF';
      case 'sol kanat': return 'LMF';
      case 'on numara': return 'AMF';
      case 'santrfor': return 'STR';
      default: return 'UNK';
    }
  }

  @override
  String toString() {
    return 'EnhancedTeamPlayer(name: $name, position: $position, jersey: $jerseyNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EnhancedTeamPlayer && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class PlayerStats {
  final int goals;
  final int assists;
  final int matches;
  final int yellowCards;
  final int redCards;
  final double rating;

  const PlayerStats({
    required this.goals,
    required this.assists,
    required this.matches,
    required this.yellowCards,
    required this.redCards,
    required this.rating,
  });

  factory PlayerStats.fromJson(Map<String, dynamic> json) {
    return PlayerStats(
      goals: json['goals'] as int,
      assists: json['assists'] as int,
      matches: json['matches'] as int,
      yellowCards: json['yellowCards'] as int,
      redCards: json['redCards'] as int,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goals': goals,
      'assists': assists,
      'matches': matches,
      'yellowCards': yellowCards,
      'redCards': redCards,
      'rating': rating,
    };
  }

  // Computed properties
  double get goalsPerMatch => matches > 0 ? goals / matches : 0.0;
  double get assistsPerMatch => matches > 0 ? assists / matches : 0.0;
  int get totalContributions => goals + assists;
  bool get isTopScorer => goals > 10;
  bool get isPlaymaker => assists > goals;
}
```

Bu model, futbol takımı uygulamanızın temel veri yapısını oluşturur ve Riverpod state management ile mükemmel uyum sağlar! 