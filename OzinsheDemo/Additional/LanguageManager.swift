import Foundation

class LanguageManager {

    private static let languageKey = "appLanguage"

    static func setLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: languageKey)
        UserDefaults.standard.synchronize()
    }

    static func currentLanguage() -> String {
        return UserDefaults.standard.string(forKey: languageKey) ?? Locale.current.languageCode ?? "en"
    }
    
}
