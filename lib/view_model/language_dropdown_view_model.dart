import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageDropDownViewModel with ChangeNotifier {
  Map<String, String> languageMap = {
    "English": "en",
    "Spanish": "es",
    "French": "fr",
    "German": "de",
    "Chinese (Simplified)": "zh-CN",
    "Chinese (Traditional)": "zh-TW",
    "Japanese": "ja",
    "Korean": "ko",
    "Russian": "ru",
    "Arabic": "ar",
    "Portuguese": "pt",
    "Italian": "it",
    "Dutch": "nl",
    "Hindi": "hi",
    "Bengali": "bn",
    "Urdu": "ur",
    "Turkish": "tr",
    "Vietnamese": "vi",
    "Thai": "th",
    "Greek": "el",
    "Polish": "pl",
    "Czech": "cs",
    "Swedish": "sv",
    "Finnish": "fi",
    "Danish": "da",
    "Norwegian": "no",
    "Hungarian": "hu",
    "Romanian": "ro",
    "Catalan": "ca",
    "Hebrew": "he",
    "Malay": "ms",
    "Indonesian": "id",
    "Filipino": "fil",
    "Swahili": "sw",
    "Zulu": "zu",
    "Xhosa": "xh",
    "Afrikaans": "af",
    "Albanian": "sq",
    "Armenian": "hy",
    "Azerbaijani": "az",
    "Basque": "eu",
    "Belarusian": "be",
    "Bosnian": "bs",
    "Bulgarian": "bg",
    "Croatian": "hr",
    "Estonian": "et",
    "Galician": "gl",
    "Georgian": "ka",
    "Gujarati": "gu",
    "Haitian Creole": "ht",
    "Icelandic": "is",
    "Irish": "ga",
    "Kannada": "kn",
    "Kazakh": "kk",
    "Khmer": "km",
    "Lao": "lo",
    "Latvian": "lv",
    "Lithuanian": "lt",
    "Macedonian": "mk",
    "Malayalam": "ml",
    "Maltese": "mt",
    "Maori": "mi",
    "Marathi": "mr",
    "Mongolian": "mn",
    "Nepali": "ne",
    "Persian": "fa",
    "Punjabi": "pa",
    "Serbian": "sr",
    "Sinhala": "si",
    "Slovak": "sk",
    "Slovenian": "sl",
    "Tamil": "ta",
    "Telugu": "te",
    "Ukrainian": "uk",
    "Welsh": "cy",
    "Yiddish": "yi",
  };

  String _selectedLanguage = 'English';

  void updateLanguage(newLanguage) {
    _selectedLanguage = newLanguage;
    notifyListeners();
  }

  Widget getLanguageDropdown(context, Function(dynamic) onChange) {
    return Container(
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 5.r),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _selectedLanguage,
          underline: const SizedBox.shrink(),
          isDense: true,
          isExpanded: false,
          items: languageMap.keys
              .map(
                (currentLanguage) => DropdownMenuItem<String>(
                  value: currentLanguage,
                  child: Text(
                    currentLanguage,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
          onChanged: (newLanguage) {
            updateLanguage(newLanguage);
            onChange(newLanguage);
          },
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
