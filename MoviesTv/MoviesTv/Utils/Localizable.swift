// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

enum L10n {
    
    enum Erro {
        static let unavailable = L10n.tr("Localizable", "unavailable")
    }
    
    enum Favorite {
        static let empty = L10n.tr("Localizable", "empty.favorite")
        static let title = L10n.tr("Localizable", "title.favorite")
    }
    
    enum Movie {
       
    }
    
    enum Search {

    }
}

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
