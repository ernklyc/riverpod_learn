import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/user_future_provider.dart';

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsyncValue = ref.watch(userFutureProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Future Provider')),
      body: Column(
        children: [
          usersAsyncValue.when(
            data: (users) {
              return Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) {
              debugPrint('UI Hatası: $error');
              debugPrint('Stack Trace: $stackTrace');
              return Text('Beklenmeyen bir hata oluştu ${error.toString()}');
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
