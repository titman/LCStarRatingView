LCStarRatingView 

![badge-pod] ![badge-languages] ![badge-platforms] ![badge-mit]

Features
> * No images.
> * It supports multiple UI Setting.
> * It supports gestures and call back block.
> * It supports counting type switch.

Counting type
```objc
/**
 * LCStarRatingViewCountingTypeInteger [0, 1, 2, 3, 4, 5]
 * LCStarRatingViewCountingTypeFloat [0, 0.1, ... 0.4, ... 1, 1.1, ... 4.9, 5]
 * LCStarRatingViewCountingTypeHalfCutting [0, 0.5, 1, 1.5, 2, ...]
 */
```

Preview (GIF)
-
![image](https://github.com/titman/Pictures-of-the-warehouse/blob/master/LCStarRatingView1.gif?raw=false)
-

Call back

```objc
ratingView.progressDidChangedByUser = ^(CGFloat progress){
        
    // to do something.
};
```

Update
 - 1.01
    * Fix bugs and supports XIB.
 - 1.0
    * First commit.


[badge-platforms]: https://img.shields.io/badge/platforms-iOS-lightgrey.svg
[badge-pod]: https://img.shields.io/cocoapods/v/LCPhotoBrowser.svg?label=version
[badge-languages]: https://img.shields.io/badge/languages-ObjC-orange.svg
[badge-mit]: https://img.shields.io/badge/license-MIT-blue.svg
