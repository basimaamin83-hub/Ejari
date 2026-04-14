import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejari/app_router.dart';

void pushPublicProfile(BuildContext context, String userId) {
  context.push(AppRoutes.publicUserPath(userId));
}
