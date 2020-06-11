import 'package:events_mobile/bloc/auth_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  // ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(
    create: (_) => AuthBloc.instance(),
  )
];

List<SingleChildWidget> dependentServices = [];
