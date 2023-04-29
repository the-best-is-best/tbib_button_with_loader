##  TBIB Button with loader


### Import

```dart
import 'package:tbib_button_with_loader/tbib_button_with_loader.dart';
```

### How To Use

```dart
    ButtonWithLoader(
        onPressed: (startLoading, stopLoading,
            Function(bool isSuccess) isSuccess, state) {
            this.startLoading = startLoading;
            this.stopLoading = stopLoading;
            this.isSuccess = isSuccess;
            this.startLoading?.call();
            Future.delayed(const Duration(seconds: 2), () {
            this.stopLoading?.call();
            });
        },
        title: 'Click Me',
        )
```
