abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  final String email;
  final String userName;
  final String photoUrl;
  final bool isBiometric;

  const HomeSuccess({
    required this.email,
    required this.userName,
    required this.photoUrl,
    required this.isBiometric,
  });
}

class HomeFailure extends HomeState {
  final String error;
  const HomeFailure({required this.error});
}