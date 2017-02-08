##LCStarRatingView 

![badge-pod] ![badge-languages] ![badge-platforms] ![badge-mit]

### Features
> * No images.
> * It supports multiple UI Setting.
> * It supports gestures and call back block.
> * It supports counting type switch.

### Value style

There's three kinds of styles for you to choose.

- LCStarRatingViewCountingTypeInteger [0, 1, 2, 3, 4, 5]
- LCStarRatingViewCountingTypeFloat [0, 0.1, ... 0.4, ... 1, 1.1, ... 4.9, 5]
- LCStarRatingViewCountingTypeHalfCutting [0, 0.5, 1, 1.5, 2, ...]

To specify the value style you just simply code this:

```objc
ratingView.type = LCStarRatingViewCountingTypeInteger;
```

###Preview (GIF)
-
![image](https://github.com/titman/Pictures-of-the-warehouse/blob/master/LCStarRatingView1.gif?raw=false)
-

### Callback

There're two ways to listen the changing of star value.

#### Callback Functor

```objc
ratingView.progressDidChangedByUser = ^(CGFloat progress){
    // to do something.
};
```

#### Delegate

Just conform protocol ```LCStarRatingViewDelegate```. Then redirect view's delegate to that object.

```objc
ratingView.delegate = self;
```
Implement ```[LCStarRatingViewDelegate LCStarRatingView:progressDidChangedByUser:]``` method. Then you are good to go.

```objc
-(void) LCStarRatingView:(LCStarRatingView *)starRatingView progressDidChangedByUser:(CGFloat)progress {
    NSLog(@"Delegate output: %@", @(progress));
}
```


[badge-platforms]: https://img.shields.io/badge/platforms-iOS-lightgrey.svg
[badge-pod]: https://img.shields.io/cocoapods/v/LCPhotoBrowser.svg?label=version
[badge-languages]: https://img.shields.io/badge/languages-ObjC-orange.svg
[badge-mit]: https://img.shields.io/badge/license-MIT-blue.svg
