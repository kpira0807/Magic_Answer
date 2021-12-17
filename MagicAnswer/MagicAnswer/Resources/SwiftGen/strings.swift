// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Shake!
  internal static let answerLaber = L10n.tr("Localizable", "answerLaber")
  /// Please write your question
  internal static let emptyField = L10n.tr("Localizable", "emptyField")
  /// Error
  internal static let errorAlert = L10n.tr("Localizable", "errorAlert")
  /// Game
  internal static let gameTitle = L10n.tr("Localizable", "gameTitle")
  /// History
  internal static let history = L10n.tr("Localizable", "history")
  /// History
  internal static let historyTitle = L10n.tr("Localizable", "historyTitle")
  /// Home
  internal static let homeTitle = L10n.tr("Localizable", "homeTitle")
  /// Welcome
  internal static let intro = L10n.tr("Localizable", "intro")
  /// The ball will answer any question!
  internal static let introLabel = L10n.tr("Localizable", "introLabel")
  /// Magic Answer
  internal static let navigationItemAVC = L10n.tr("Localizable", "navigationItemAVC")
  /// Settings
  internal static let navigationItemSVC = L10n.tr("Localizable", "navigationItemSVC")
  /// Okey
  internal static let okeyAlert = L10n.tr("Localizable", "okeyAlert")
  /// Choose the answer you want
  internal static let placeholder = L10n.tr("Localizable", "placeholder")
  /// Choose first answer
  internal static let presentFirstLabel = L10n.tr("Localizable", "presentFirstLabel")
  /// Choose second answer
  internal static let presentSecondLabel = L10n.tr("Localizable", "presentSecondLabel")
  /// Choose third answer
  internal static let presentThirdLabel = L10n.tr("Localizable", "presentThirdLabel")
  /// Write your question
  internal static let questionTextField = L10n.tr("Localizable", "questionTextField")
  /// Setting
  internal static let settingTitle = L10n.tr("Localizable", "settingTitle")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
