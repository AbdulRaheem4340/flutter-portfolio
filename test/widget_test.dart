import 'package:flutter/material.dart';
import 'package:flutter_portfolio/launcher_helper.dart';
import 'package:flutter_portfolio/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('exposes the portfolio color palette', () {
      expect(AppTheme.bgOffWhite, const Color(0xFFF4F7F5));
      expect(AppTheme.accentBlue, const Color(0xFF10B981));
      expect(AppTheme.terminalBg, const Color(0xFF1A1A1A));
    });
  });

  group('LaunchHelpers', () {
    test('contains the expected contact links', () {
      expect(LaunchHelpers.email, 'ar4942876@gmail.com');
      expect(LaunchHelpers.github, 'https://github.com/AbdulRaheem4340/');
      expect(LaunchHelpers.linkedIn, contains('abdul-raheem'));
    });
  });
}
