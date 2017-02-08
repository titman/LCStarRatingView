//
//
//      _|          _|_|_|
//      _|        _|
//      _|        _|
//      _|        _|
//      _|_|_|_|    _|_|_|
//
//
//  Copyright (c) 2016-2017, Licheng Guo. ( http://titm.me )
//  http://github.com/titman
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

/**
 * Enumerations to specify rating value type.
 */
typedef NS_ENUM(NSInteger, LCStarRatingViewCountingType) {
    
    /**
     0 1 2 3 4 5
     */
    LCStarRatingViewCountingTypeInteger,
    /**
     0.1 0.2 0.3 ... 1 1.1 ... 4.9 5
     */
    LCStarRatingViewCountingTypeFloat,
    /**
     0.5 1 1.5 2 2.5 3 3.5 ...
     */
    LCStarRatingViewCountingTypeHalfCutting,
};
/**
 *  proceeding callback typedefine
 */
typedef void(^LCStarRatingViewProgressDidChangedByUser)(CGFloat progress);
/// Class pre-declaration.
@class LCStarRatingView;
/**
 *  Delegate for LCStarRatingView
 */
@protocol LCStarRatingViewDelegate <NSObject>

/**
 *  Called on star rating view's progress changed by user.
 *
 *  @param starRatingView LCStarRatingView
 *  @param progress       CGFloat progress
 */
-(void) LCStarRatingView:(nonnull LCStarRatingView *) starRatingView progressDidChangedByUser:(CGFloat) progress;

@end

/**
 *  Star Rating View
 *  You can touch and drag to rate for things.
 */
@interface LCStarRatingView : UIView
/**
 *  delegate for LCStarRatingView
 */
@property(nonatomic, weak, nullable) id<LCStarRatingViewDelegate> delegate;

#pragma mark - Configuring UI style

/**
 Default is LCStarRatingViewCountingTypeInteger .

 * LCStarRatingViewCountingTypeInteger [0, 1, 2, 3, 4, 5]
 * LCStarRatingViewCountingTypeFloat [0, 0.1, ... 0.4, ... 1, 1.1, ... 4.9, 5]
 * LCStarRatingViewCountingTypeHalfCutting [0, 0.5, 1, 1.5, 2, ...]
 */
@property(nonatomic, assign) LCStarRatingViewCountingType type;

/**
 The margin for starts
 Default is 5.0 .
 */
@property(nonatomic, assign) CGFloat starMargin;

/**
 The highlighted star color for the rating stars
 Default is Yellow(255, 198, 0) .
 */
@property(nullable, nonatomic, strong) UIColor * starColor;

/**
 Border color for highlighted stars
 Default is nil .
 */
@property(nullable, nonatomic, strong) UIColor * starBorderColor;

/**
 Border width for star
 Default is 0 .
 */
@property(nonatomic, assign) CGFloat starBorderWidth;

/**
 The darkened star color.
 Default is Light gray .
 */
@property(nullable, nonatomic, strong) UIColor * starPlaceHolderColor;

/**
 The darkened star border color.
 Default is nil .
 */
@property(nullable, nonatomic, strong) UIColor * starPlaceHolderBorderColor;

/**
 Border width for darkened stars.
 Default is 0 .
 */
@property(nonatomic, assign) CGFloat starPlaceHolderBorderWidth;

#pragma mark - Main attribute

/**
 Current rating value
 Default 3. this value pinned to [0, 5].
 */
@property(nonatomic, assign) CGFloat progress;

/**
 Default is YES. if NO, ignores touch events.
 */
@property(nonatomic, assign) BOOL enabled;


#pragma mark - Designated initializers.
/**
 *  Create a star rating view
 *
 *  @return instance
 */
-(nonnull instancetype) init NS_DESIGNATED_INITIALIZER;
/**
 *  Create a star rating view with specified frame
 *
 *  @param frame CGRect
 *
 *  @return instance
 */
-(nonnull instancetype) initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
/**
 *  Create a star rating view from nib.
 *
 *  @param aDecoder NSCoder
 *
 *  @return instance
 */
-(nullable instancetype) initWithCoder:(nullable NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

#pragma mark - Call back
/**
 *  Call back when progress changed by user.
 */
@property(nonatomic, copy) LCStarRatingViewProgressDidChangedByUser _Nullable progressDidChangedByUser;

@end
