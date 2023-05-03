##  TBIB Button with loader

<img src="https://raw.githubusercontent.com/the-best-is-best/tbib_button_with_loader/master/assets/github/Screenshot.png" />


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
