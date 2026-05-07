import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/local_storage_service.dart';

class ThemeController extends GetxController {
  ThemeController(this._storageService);

  final LocalStorageService _storageService;

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    final storedValue = _storageService.readString(StorageKeys.themeMode);
    if (storedValue == 'light') {
      _themeMode.value = ThemeMode.light;
    } else if (storedValue == 'dark') {
      _themeMode.value = ThemeMode.dark;
    }
  }

  Future<void> toggleTheme(bool enabled) async {
    _themeMode.value = enabled ? ThemeMode.dark : ThemeMode.light;
    await _storageService.writeString(
      StorageKeys.themeMode,
      enabled ? 'dark' : 'light',
    );
    Get.changeThemeMode(_themeMode.value);
  }
}
