import 'package:flutter/material.dart';

import '../widgets/animated_tap_button.dart';
import '../widgets/loading_animation.dart';
import '../widgets/scale_in.dart';
import '../services/dealer_chat_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.usesEmailPasswordAuth,
    required this.onLogIn,
    required this.onSignUp,
  });

  final bool usesEmailPasswordAuth;
  final Future<String?> Function(String username, String password) onLogIn;
  final Future<String?> Function(String username, String password) onSignUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.usesEmailPasswordAuth ? '' : 'driver',
    );
    _passwordController = TextEditingController(
      text: widget.usesEmailPasswordAuth ? '' : 'carstore',
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wideLayout = constraints.maxWidth >= 920;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: wideLayout ? 960 : 460),
                  child: ScaleIn(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withOpacity(0.86),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: wideLayout
                          ? Row(
                              children: [
                                Expanded(child: _BrandPane(theme: theme)),
                                Expanded(
                                  child: _LoginFormPane(
                                    usernameController: _usernameController,
                                    passwordController: _passwordController,
                                    formKey: _formKey,
                                    usesEmailPasswordAuth:
                                        widget.usesEmailPasswordAuth,
                                    submitting: _submitting,
                                    onLogIn: () => _handleAuthAction(
                                      widget.onLogIn,
                                      'Unable to sign in. Please try again.',
                                    ),
                                    onSignUp: () => _handleAuthAction(
                                      widget.onSignUp,
                                      'Unable to create account. Please try again.',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : _LoginFormPane(
                              usernameController: _usernameController,
                              passwordController: _passwordController,
                              formKey: _formKey,
                              usesEmailPasswordAuth:
                                  widget.usesEmailPasswordAuth,
                              submitting: _submitting,
                              onLogIn: () => _handleAuthAction(
                                widget.onLogIn,
                                'Unable to sign in. Please try again.',
                              ),
                              onSignUp: () => _handleAuthAction(
                                widget.onSignUp,
                                'Unable to create account. Please try again.',
                              ),
                              compact: true,
                            ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleAuthAction(
    Future<String?> Function(String username, String password) action,
    String fallbackMessage,
  ) async {
    if (_submitting) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _submitting = true;
    });

    try {
      final errorMessage = await action(
        _usernameController.text,
        _passwordController.text,
      );
      if (!mounted) {
        return;
      }
      if (errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(fallbackMessage)));
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }
}

class _BrandPane extends StatelessWidget {
  const _BrandPane({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final scheme = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 520),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(32)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary,
            scheme.primary.withOpacity(0.82),
            scheme.tertiary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'CarStore',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Reserve premium inventory with a showroom-grade buying flow.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.84),
            ),
          ),
          const SizedBox(height: 72),
          _FeatureLine(
            text: 'Curated EV, luxury and performance catalog',
            icon: Icons.verified_rounded,
          ),
          const SizedBox(height: 12),
          _FeatureLine(
            text: 'One-tap reservation and order tracking',
            icon: Icons.bolt_rounded,
          ),
          const SizedBox(height: 12),
          _FeatureLine(
            text: 'Cross-platform showroom experience',
            icon: Icons.devices_rounded,
          ),
        ],
      ),
    );
  }
}

class _LoginFormPane extends StatelessWidget {
  const _LoginFormPane({
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
    required this.usesEmailPasswordAuth,
    required this.submitting,
    required this.onLogIn,
    required this.onSignUp,
    this.compact = false,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool usesEmailPasswordAuth;
  final bool submitting;
  final Future<void> Function() onLogIn;
  final Future<void> Function() onSignUp;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (compact)
              Text(
                'CarStore',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            if (compact) const SizedBox(height: 8),
            Text(
              'Welcome back',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to continue into your curated garage.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: usernameController,
              keyboardType: usesEmailPasswordAuth
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: usesEmailPasswordAuth ? 'Email address' : 'Username',
                prefixIcon: Icon(
                  usesEmailPasswordAuth
                      ? Icons.alternate_email_rounded
                      : Icons.person_outline_rounded,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return usesEmailPasswordAuth
                      ? 'Email required'
                      : 'Username required';
                }
                if (usesEmailPasswordAuth && !value.contains('@')) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password required';
                }
                if (usesEmailPasswordAuth && value.length < 6) {
                  return 'Use at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Text(
              usesEmailPasswordAuth
                  ? 'Use an email and a password with at least six characters.'
                  : 'Demo credentials are prefilled for quick access.',
              style: theme.textTheme.bodySmall,
            ),
            if (usesEmailPasswordAuth) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                    0.6,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Test account: ${DealerChatService.testEmail} / ${DealerChatService.testPassword}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: submitting
                          ? null
                          : () {
                              usernameController.text =
                                  DealerChatService.testEmail;
                              passwordController.text =
                                  DealerChatService.testPassword;
                              onLogIn();
                            },
                      child: const Text('Use test'),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: AnimatedTapButton(
                onTap: submitting ? null : onLogIn,
                semanticLabel: 'Animated log in button',
                child: FilledButton.icon(
                  onPressed: submitting ? null : onLogIn,
                  icon: submitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.arrow_forward_rounded),
                  label: Text(submitting ? 'Signing in...' : 'Log in'),
                ),
              ),
            ),
            if (usesEmailPasswordAuth) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: AnimatedTapButton(
                  onTap: submitting ? null : onSignUp,
                  semanticLabel: 'Animated sign up button',
                  child: FilledButton.tonalIcon(
                    onPressed: submitting ? null : onSignUp,
                    icon: const Icon(Icons.person_add_alt_rounded),
                    label: const Text('Sign up'),
                  ),
                ),
              ),
            ],
            if (submitting) ...[
              const SizedBox(height: 16),
              const LoadingAnimation(),
            ],
          ],
        ),
      ),
    );
  }
}

class _FeatureLine extends StatelessWidget {
  const _FeatureLine({required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.9), size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
