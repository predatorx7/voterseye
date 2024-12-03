import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

import 'gen/app_localizations.dart';

extension CommonLocalizations on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  MaterialLocalizations get l10nMaterial => MaterialLocalizations.of(this);
  CupertinoLocalizations get l10nCupertino => CupertinoLocalizations.of(this);

  FirebaseUILocalizationLabels get l10nFirebase =>
      FirebaseUILocalizations.of(this).labels;
}
