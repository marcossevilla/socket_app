import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import '../../blocs/socket_bloc.dart';

class AddBandDialog extends StatefulWidget {
  const AddBandDialog({
    Key key,
    this.confirmationAction,
  }) : super(key: key);

  static const Text buttonText = Text('Add');
  static const Text dialogTitle = Text('New band name');
  static const Text cancelButtonText = Text('Cancel');

  final Function(String) confirmationAction;

  @override
  _AddBandDialogState createState() => _AddBandDialogState();
}

class _AddBandDialogState extends State<AddBandDialog> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoAlertDialog(
        title: AddBandDialog.dialogTitle,
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: AddBandDialog.buttonText,
            onPressed: addBand,
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: AddBandDialog.cancelButtonText,
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    } else {
      return AlertDialog(
        title: AddBandDialog.dialogTitle,
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            child: AddBandDialog.buttonText,
            elevation: 5.0,
            textColor: Theme.of(context).primaryColor,
            onPressed: addBand,
          ),
        ],
      );
    }
  }

  void addBand() {
    if (textController.text.length > 1) {
      context.read<SocketBloc>().emit('add_band', {
        'name': textController.text,
      });
    }

    Navigator.of(context).pop();
  }
}
