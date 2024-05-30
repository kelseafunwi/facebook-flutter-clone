import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/chat/repository/chat_repository.dart';

final chatProvider = Provider((ref) => ChatRepository());