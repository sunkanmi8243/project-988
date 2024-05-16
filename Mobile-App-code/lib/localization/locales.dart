import 'package:flutter_localization/flutter_localization.dart';

List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("zh", LocaleData.ZH),
];

mixin LocaleData {
  static const String title = "title";
  static const String body = "body";

  static Map<String, dynamic> EN = {
    title: "Localization",
    body: "Welcome to this localized flutter application"
  };

  static Map<String, dynamic> ZH = {
    title: "本土化",
    body: "欢迎使用这个本地化的 flutter 应用程序"
  };
  
}