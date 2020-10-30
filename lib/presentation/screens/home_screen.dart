import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
    this.title,
    this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.bloc<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.bloc<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Wi-Fi',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.green),
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Mobile',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.red),
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.grey),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incremented'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incremented'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'Brrr, negative! ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'Yay! ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'Hummm, number 5.',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  }
                },
              ),
              SizedBox(height: 24),
              MaterialButton(
                color: Colors.redAccent,
                child: Text(
                  'Go to second screen',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/second');
                },
              ),
              SizedBox(height: 24.0),
              MaterialButton(
                color: Colors.greenAccent,
                child: Text(
                  'Go to third screen',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/third');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
