import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_flutter/features/auth/repository/auth_repository.dart';

// this is going to make the authProvider broadcast AuthRepository to be available from everywhere
final authProvider = Provider((ref) => AuthRepository());