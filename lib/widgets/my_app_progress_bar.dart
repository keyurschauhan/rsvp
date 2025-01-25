import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/my_app_text_style.dart';

class MyAppPageRefresherDialog extends StatefulWidget {
  const MyAppPageRefresherDialog(
      {this.process, this.canShowGif = true, super.key});
  final Future Function()? process;
  final bool canShowGif;

  @override
  State<MyAppPageRefresherDialog> createState() =>
      _MyAppPageRefresherDialogState();
}

class _MyAppPageRefresherDialogState extends State<MyAppPageRefresherDialog> {
  @override
  void initState() {
    // TODO: implement initState
    _doProcess();
    super.initState();
  }

  void _doProcess() async {
    try {
      if (widget.process != null) {
        var result = await widget.process!();
        if (result != null && mounted) {
          Navigator.pop(context, result);
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    MyAppTextStyle myAppTextStyle = MyAppTextStyle();

    return Stack(
      children: [
        if (widget.canShowGif) const Center(child: CircularProgressIndicator(color: Color(0xFFD3AF37),)),
      ],
    );
  }
}


class BuildWidgetFromFuture extends StatelessWidget {
  const BuildWidgetFromFuture(
      {required this.future,
        this.onSuccess,
        this.loadingWidget,
        this.onSuccessWithObject,
        this.bgColor,
        this.onError,
        this.onErrorWidget,
        super.key});
  final Future future;
  final Widget Function()? onSuccess;
  final Widget Function(Object? object)? onErrorWidget;
  final Widget Function(dynamic object)? onSuccessWithObject;
  final Widget? loadingWidget;
  final Color? bgColor;
  final void Function(Object? object)? onError;

  @override
  Widget build(BuildContext context) {
    // final TextStyleConst textStyleConst = Provider.of(context);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (onError != null) {
            Future.delayed(const Duration(milliseconds: 100),
                    () => onError!(snapshot.error));
          }
          if (onErrorWidget != null) {
            return onErrorWidget!(snapshot.error);
          } else {
            return Material(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (onSuccessWithObject != null) {
            return onSuccessWithObject!(snapshot.data);
          }
          return onSuccess!();
        }

        return Material(
          color: bgColor,
          child: Center(
            child: loadingWidget ?? const Text("Loading..."),
          ),
        );
      },
    );
  }
}


