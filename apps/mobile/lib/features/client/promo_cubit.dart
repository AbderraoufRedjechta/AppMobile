import 'package:flutter_bloc/flutter_bloc.dart';

class PromoCubit extends Cubit<PromoState> {
  PromoCubit() : super(PromoState());

  void applyPromo(String code) {
    // Validate promo code
    final promo = _validatePromo(code);
    if (promo != null) {
      emit(state.copyWith(appliedPromo: promo, errorMessage: null));
    } else {
      emit(
        state.copyWith(
          appliedPromo: null,
          errorMessage: 'Code promo invalide ou expiré',
        ),
      );
    }
  }

  void removePromo() {
    emit(state.copyWith(appliedPromo: null, errorMessage: null));
  }

  Map<String, dynamic>? _validatePromo(String code) {
    // Demo promo codes
    final promos = {
      'WELCOME10': {
        'code': 'WELCOME10',
        'discount': 10,
        'type': 'percentage',
        'description': '10% de réduction',
      },
      'FIRST50': {
        'code': 'FIRST50',
        'discount': 50,
        'type': 'fixed',
        'description': '50 DA de réduction',
      },
      'GUSTO20': {
        'code': 'TAYABLI20',
        'discount': 20,
        'type': 'percentage',
        'description': '20% de réduction',
      },
    };

    return promos[code.toUpperCase()];
  }

  double calculateDiscount(double total) {
    if (state.appliedPromo == null) return 0;

    final promo = state.appliedPromo!;
    if (promo['type'] == 'percentage') {
      return total * (promo['discount'] as int) / 100;
    } else {
      return (promo['discount'] as int).toDouble();
    }
  }
}

class PromoState {
  final Map<String, dynamic>? appliedPromo;
  final String? errorMessage;

  PromoState({this.appliedPromo, this.errorMessage});

  PromoState copyWith({
    Map<String, dynamic>? appliedPromo,
    String? errorMessage,
  }) {
    return PromoState(appliedPromo: appliedPromo, errorMessage: errorMessage);
  }
}
