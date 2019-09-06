import 'package:flutter/material.dart';
import 'package:operation/http/http.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget
    {
  final T bloc;
  final Widget child;

  const BlocProvider({Key key, this.bloc, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BlocProviderState<T>();
  }

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;

}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

abstract class BlocBase implements RequestCallBack {
  void dispose();
}
