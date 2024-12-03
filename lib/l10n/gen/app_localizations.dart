import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart' deferred as app_localizations_en;

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Med Verify'**
  String get appTitle;

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @thatsAnError.
  ///
  /// In en, this message translates to:
  /// **'That\'s an error'**
  String get thatsAnError;

  /// No description provided for @requestedPageNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested page was not found.'**
  String get requestedPageNotFound;

  /// No description provided for @thatsAllWeKnow.
  ///
  /// In en, this message translates to:
  /// **'That\'s all we know.'**
  String get thatsAllWeKnow;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @confirmationCode.
  ///
  /// In en, this message translates to:
  /// **'CONFIRMATION CODE'**
  String get confirmationCode;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didntReceiveCode;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'{seconds, plural, =0{Send again} =1{Send again in 1 sec} other{Send again in {seconds} secs}}'**
  String sendAgain(int seconds);

  /// No description provided for @emailConfirmationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'A confirmation has been sent to your email. Please enter it to continue.'**
  String get emailConfirmationCodeSent;

  /// No description provided for @loginTermsCondition.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you accept privacy policy, and terms & conditions'**
  String get loginTermsCondition;

  /// No description provided for @createAnAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAnAccountButton;

  /// No description provided for @orLabel.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get orLabel;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @pairNewDevice.
  ///
  /// In en, this message translates to:
  /// **'Pair new device'**
  String get pairNewDevice;

  /// No description provided for @nearbyDevices.
  ///
  /// In en, this message translates to:
  /// **'Nearby Devices'**
  String get nearbyDevices;

  /// No description provided for @wellDiscoverDevices.
  ///
  /// In en, this message translates to:
  /// **'We\'ll try to discover compatible devices and you can select a device to connect'**
  String get wellDiscoverDevices;

  /// No description provided for @deviceControls.
  ///
  /// In en, this message translates to:
  /// **'Device Controls'**
  String get deviceControls;

  /// No description provided for @deviceUsage.
  ///
  /// In en, this message translates to:
  /// **'Device Usage'**
  String get deviceUsage;

  /// No description provided for @deviceSettings.
  ///
  /// In en, this message translates to:
  /// **'Device Settings'**
  String get deviceSettings;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @addressIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Address is required'**
  String get addressIsRequired;

  /// No description provided for @nameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameIsRequired;

  /// No description provided for @availableToConnect.
  ///
  /// In en, this message translates to:
  /// **'Available to connect'**
  String get availableToConnect;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @addressInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please make sure entered address is correct'**
  String get addressInvalid;

  /// No description provided for @nameInvaid.
  ///
  /// In en, this message translates to:
  /// **'Please make sure entered name is correct'**
  String get nameInvaid;

  /// No description provided for @youCanPairDevice.
  ///
  /// In en, this message translates to:
  /// **'You can pair a new device by tapping the button below'**
  String get youCanPairDevice;

  /// No description provided for @areYouSureSignout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get areYouSureSignout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @shareWifi.
  ///
  /// In en, this message translates to:
  /// **'Share Wi-Fi'**
  String get shareWifi;

  /// No description provided for @shareWifiDescription.
  ///
  /// In en, this message translates to:
  /// **'Provie a Wi-Fi credentials to allow the device to join'**
  String get shareWifiDescription;

  /// No description provided for @networkName.
  ///
  /// In en, this message translates to:
  /// **'Network name'**
  String get networkName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get password;

  /// No description provided for @securityType.
  ///
  /// In en, this message translates to:
  /// **'Security type'**
  String get securityType;

  /// No description provided for @places.
  ///
  /// In en, this message translates to:
  /// **'Places'**
  String get places;

  /// No description provided for @addPlace.
  ///
  /// In en, this message translates to:
  /// **'Add Place'**
  String get addPlace;

  /// No description provided for @addDevice.
  ///
  /// In en, this message translates to:
  /// **'Add Device'**
  String get addDevice;

  /// No description provided for @addRoom.
  ///
  /// In en, this message translates to:
  /// **'Add Room'**
  String get addRoom;

  /// No description provided for @noPlacesToShow.
  ///
  /// In en, this message translates to:
  /// **'No Places to show'**
  String get noPlacesToShow;

  /// No description provided for @unnamedPlace.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Place'**
  String get unnamedPlace;

  /// No description provided for @provideTheDocumentUrl.
  ///
  /// In en, this message translates to:
  /// **'Provide the document URL'**
  String get provideTheDocumentUrl;

  /// No description provided for @makeSureUrlIsValid.
  ///
  /// In en, this message translates to:
  /// **'Make sure the URL is valid'**
  String get makeSureUrlIsValid;

  /// No description provided for @unnamedRoom.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Room'**
  String get unnamedRoom;

  /// No description provided for @unnamedDevice.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Device'**
  String get unnamedDevice;

  /// No description provided for @noDevicesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Devices available'**
  String get noDevicesAvailable;

  /// No description provided for @noRoomsToShow.
  ///
  /// In en, this message translates to:
  /// **'No Rooms to show'**
  String get noRoomsToShow;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @joinNetwork.
  ///
  /// In en, this message translates to:
  /// **'Join Network'**
  String get joinNetwork;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return lookupAppLocalizations(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

Future<AppLocalizations> lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return app_localizations_en
          .loadLibrary()
          .then((dynamic _) => app_localizations_en.AppLocalizationsEn());
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
