import 'package:flutter/material.dart';

import 'package:imy_bloc/imy_bloc.dart';

Type _typeOf<B>() => B;

class BlocProvider<B extends Bloc> extends StatefulWidget {
  final Widget child;
  final B bloc;

  BlocProvider({
    Key key,
    @required this.bloc,
    @required this.child,
  }): super(key: key);

  @override
  _BlocProviderState<B> createState() => _BlocProviderState<B>();

  static B of<B extends Bloc>(BuildContext context){
    final type = _typeOf<_BlocProviderInherited<B>>();
    _BlocProviderInherited<B> provider = context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<B extends Bloc> extends State<BlocProvider<B>>{

  @override
  void dispose(){
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new _BlocProviderInherited<B>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  final T bloc;

  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProviderInherited<T> oldWidget) => oldWidget.bloc != bloc;
//  bool updateShouldNotify(_BlocProviderInherited<T> oldWidget) => false;
}