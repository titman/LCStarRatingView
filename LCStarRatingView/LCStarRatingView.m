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

#import "LCStarRatingView.h"


#define SAFE_INVOKE(f, arg0)   do{if(f) { (f)(arg0); }}while(0)
@interface __LCStar : UIView

@property(nullable, nonatomic, strong) UIColor * starColor;
@property(nullable, nonatomic, strong) UIColor * starBorderColor;
@property(nullable, nonatomic, strong) UIColor * starImage;

@property(nonatomic, assign) CGFloat starBorderWidth;

@property(nonatomic, assign) CGFloat value;

@end

@implementation __LCStar

-(instancetype) initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self __LCStarInitSelf];
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self __LCStarInitSelf];
    }
    return self;
}

-(void) __LCStarInitSelf {
    self.value           = 1;
    self.starColor       = [UIColor yellowColor];
    self.starBorderColor = [UIColor clearColor];
    self.starBorderWidth = 0;
    
    self.opaque = NO;
}

-(void) setValue:(CGFloat)value {
    _value = value;
    
    [self setNeedsDisplay];
}

-(void) setStarColor:(UIColor *)starColor {
    _starColor = starColor;
    
    [self setNeedsDisplay];
}

-(void) setStarBorderColor:(UIColor *)starBorderColor {
    _starBorderColor = starBorderColor;
    
    [self setNeedsDisplay];
}

-(void) setStarBorderWidth:(CGFloat)starBorderWidth {
    _starBorderWidth = starBorderWidth;
    
    [self setNeedsDisplay];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

-(void) setStarImage:(UIColor *)starImage {
    _starImage = starImage;
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    if (self.starImage) {
        [super drawRect:rect];
        return;
    }
    
    CGFloat th = M_PI / 180.;
    
    CGFloat x = self.frame.size.width / 2;
    CGFloat y = self.frame.size.height / 2;
    
    CGFloat radius = x < y ? x:y;
    
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    
    CGFloat r0 = radius * sin(18 * th)/cos(36 * th);
    CGFloat x1[5] = {0},y1[5]={0},x2[5]={0},y2[5]={0};
    
    for (int i = 0; i < 5; i ++)
    {
        x1[i] = centerX + radius * cos((90 + i * 72) * th);
        y1[i] =centerY - radius * sin((90 + i * 72) * th);
        
        x2[i] = centerX + r0 * cos((54 + i * 72) * th);
        y2[i] = centerY - r0 * sin((54 + i * 72) * th);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGMutablePathRef startPath = CGPathCreateMutable();
    CGPathMoveToPoint(startPath, NULL, x1[0], y1[0]);
        
    CGContextSetLineWidth(context, self.starBorderWidth);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    for (int i = 1; i < 5; i ++) {
        
        CGPathAddLineToPoint(startPath, NULL, x2[i], y2[i]);
        CGPathAddLineToPoint(startPath, NULL, x1[i], y1[i]);
    }
    
    CGPathAddLineToPoint(startPath, NULL, x2[0], y2[0]);
    CGPathCloseSubpath(startPath);
    
    
    CGContextAddPath(context, startPath);
    
    CGContextSetFillColorWithColor(context, self.starColor.CGColor);
    
    CGContextSetStrokeColorWithColor(context, self.starBorderColor.CGColor);
    CGContextStrokePath(context);
    
    CGRect range = CGRectMake(x1[1], 0, (x1[4] - x1[1]) * self.value , y1[2]);
    
    CGContextAddPath(context, startPath);
    CGContextClip(context);
    CGContextFillRect(context, range);
    
    
    CFRelease(startPath);
}


@end

@interface LCStarRatingView ()

@property(nullable, nonatomic, strong) UIImageView * progressImageView;
@property(nullable, nonatomic, strong) UIImageView * backgroundImageView;
/**
 * start positions of stars
 */
@property(nonatomic, copy) NSArray<NSNumber*>* starPositionCache;

@end

@implementation LCStarRatingView

#pragma mark - Designated initializer

-(instancetype) init {
    if(self = [super initWithFrame:CGRectZero]){
        [self initSelf];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self initSelf];
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        
        [self initSelf];
    }
    
    return self;
}

-(void) initSelf
{
    self.starMargin                 = 5;
    self.starColor                  = [UIColor colorWithRed:255./255. green:198./255. blue:0 alpha:1];
    self.starBorderColor            = [UIColor clearColor];
    self.starBorderWidth            = 0;
    self.starPlaceHolderColor       = [UIColor lightGrayColor];
    self.starPlaceHolderBorderColor = [UIColor clearColor];
    self.starPlaceHolderBorderWidth = 0;
    
    self.progress = 3;
    
    self.backgroundImageView                        = [[UIImageView alloc] init];
    self.backgroundImageView.frame                  = self.bounds;
    self.backgroundImageView.userInteractionEnabled = YES;
    self.backgroundImageView.contentMode            = UIViewContentModeLeft;
    self.backgroundImageView.clipsToBounds          = YES;
    [self addSubview:self.backgroundImageView];
    
    
    self.progressImageView               = [[UIImageView alloc] init];
    self.progressImageView.frame         = self.bounds;
    self.progressImageView.contentMode   = UIViewContentModeLeft;
    self.progressImageView.clipsToBounds = YES;
    [self addSubview:self.progressImageView];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.backgroundImageView addGestureRecognizer:tap];

    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.backgroundImageView addGestureRecognizer:pan];
    
    
    
    [self loadStars];
}

#pragma mark - Actions

-(void) didUserChangeProgress {
    SAFE_INVOKE(self.progressDidChangedByUser, self.progress);
    if(self.delegate && [self.delegate respondsToSelector:@selector(LCStarRatingView:progressDidChangedByUser:)]) {
        [self.delegate LCStarRatingView:self progressDidChangedByUser:self.progress];
    }
}
/**
 * calculate progress value for location in view
 */
-(CGFloat) progressForLocationInView:(CGPoint) location {
    if(location.x < 0) {
        return 0;
    }
    if(location.x > self.bounds.size.width) {
        return 5;
    }
    // trim out star margin distance.
    CGFloat totalWidth = self.bounds.size.width;
    totalWidth -= 4 * self.starMargin;
    double ratio = 5.0 / totalWidth;
    // trim out star margin distance for location.
    CGFloat touchX = location.x;
    CGFloat lastStarX = self.bounds.size.width;
    CGFloat starWidth = (self.frame.size.width - self.starMargin * 4) / 5;
    for(NSInteger i = self.starPositionCache.count - 1; i >= 0; i--) {
        CGFloat starPosition = [self.starPositionCache[i] doubleValue];
        if(starPosition < location.x) {
            lastStarX = starPosition + starWidth;
            if(touchX > lastStarX) {
                // when not touching the last star check whether user's touching margin
                if(i + 1 < self.starPositionCache.count && touchX <= [self.starPositionCache[i + 1] doubleValue]) {
                    touchX = lastStarX;
                }
            }
            touchX -= i * self.starMargin;
            break;
        }
    }
    return ratio * touchX;
}

-(void) tapAction:(UITapGestureRecognizer *)tap {
    CGPoint tapPoint = [tap locationInView:self.backgroundImageView];
    self.progress = [self progressForLocationInView: tapPoint];
    if(tapPoint.x >= 0 && tapPoint.x <= self.bounds.size.width) {
        [self didUserChangeProgress];
    }
}

-(void) panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint panPoint = [pan locationInView:self.backgroundImageView];
  
    self.progress = [self progressForLocationInView: panPoint];
    // possible be negative on dragging
    if(panPoint.x >= 0 && panPoint.x <= self.bounds.size.width) {
        [self didUserChangeProgress];
    }
}

-(void) loadStars {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadStars) object:nil];
    [self performSelector:@selector(loadStarsDelay) withObject:nil afterDelay:0];
}

-(void) loadStarsDelay {
    self.backgroundImageView.frame = self.bounds;
    self.progressImageView.frame   = self.bounds;
    self.progress = self.progress;
    
    
    CGFloat starWidth = (self.frame.size.width - self.starMargin * 4) / 5;
    
    UIView * backgroundCache = [[UIImageView alloc] init];
    backgroundCache.frame = self.bounds;
    
    // Background.
    NSMutableArray* starPositionCache = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 5; i++) {
        
        __LCStar * star = [[__LCStar alloc] init];
        star.frame = CGRectMake(starWidth * i + self.starMargin * i, 0, starWidth, self.frame.size.height);
        [starPositionCache addObject:@(CGRectGetMinX(star.frame))];
        star.starColor = self.starPlaceHolderColor;
        star.starBorderColor = self.starPlaceHolderBorderColor;
        star.starBorderWidth = self.starPlaceHolderBorderWidth;
        
        [backgroundCache addSubview:star];
    }
    self.starPositionCache = starPositionCache;
    self.backgroundImageView.image = [self convertViewToImage:backgroundCache];
    
    
    UIView * starCache = [[UIImageView alloc] init];
    starCache.frame = self.bounds;
    
    // Foreground.
    for (NSInteger i = 0; i < 5; i++) {
        
        __LCStar * star = [[__LCStar alloc] init];
        star.frame = CGRectMake([starPositionCache[i] doubleValue], 0, starWidth, self.frame.size.height);
        star.starColor = self.starColor;
        star.starBorderColor = self.starBorderColor;
        star.starBorderWidth = self.starBorderWidth;
        
        [starCache addSubview:star];
    }
    
    self.progressImageView.image = [self convertViewToImage:starCache];
}

-(UIImage *) convertViewToImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - Overwrite

-(void) dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadStars) object:nil];
}

-(void) setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    for (UIGestureRecognizer * ges in self.backgroundImageView.gestureRecognizers) {
        
        ges.enabled = enabled;
    }
}

-(void) setStarMargin:(CGFloat)starMargin {
    _starMargin = starMargin;
    
    [self loadStars];
}

-(void) setStarColor:(UIColor *)starColor {
    _starColor = starColor;
    
    [self loadStars];
}

-(void) setStarBorderColor:(UIColor *)starBorderColor {
    _starBorderColor = starBorderColor;
    
    [self loadStars];
}

-(void) setStarBorderWidth:(CGFloat)starBorderWidth {
    _starBorderWidth = starBorderWidth;
    
    [self loadStars];
}

-(void) setStarPlaceHolderColor:(UIColor *)starPlaceHolderColor {
    _starPlaceHolderColor = starPlaceHolderColor;
    
    [self loadStars];
}

-(void) setStarPlaceHolderBorderColor:(UIColor *)starPlaceHolderBorderColor {
    _starPlaceHolderBorderColor = starPlaceHolderBorderColor;
    
    [self loadStars];
}

-(void) setStarPlaceHolderBorderWidth:(CGFloat)starPlaceHolderBorderWidth {
    _starPlaceHolderBorderWidth = starPlaceHolderBorderWidth;
    
    [self loadStars];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    [self loadStars];
}

-(void) setType:(LCStarRatingViewCountingType)type {
    _type = type;
    
    self.progress = self.progress;
}

-(void) setProgress:(CGFloat)progress {
    if (progress > 5. || progress < 0) {
        
        NSLog(@"Progress could not greater than 5.0");
        
        if (progress > 5.) progress = 5.;
        else if(progress < 0) progress = 0;
    }
    
    switch (self.type) {
        case LCStarRatingViewCountingTypeInteger:
            progress = roundf(progress);
            break;
        case LCStarRatingViewCountingTypeFloat:
            break;
        case LCStarRatingViewCountingTypeHalfCutting:
            
#define HALF_CUTTING(number) if (progress > number - 0.25 && progress <= number + 0.25) progress = number
            for(NSInteger i = 0; i <= 10; i++) {
                HALF_CUTTING(i * 0.5);
            }
            break;
    }
    
    _progress = progress;
    CGFloat maskViewWidth = self.bounds.size.width;
    // trim out star margin distance.
    CGFloat totalWidth = self.bounds.size.width;
    totalWidth -= 4 * self.starMargin;
    CGFloat ratio = totalWidth / 5.0;
    for(NSInteger i = 4; i >= 0; i--) {
        CGFloat starPosition = [self.starPositionCache[i] doubleValue];
        if(progress >= i) {
            maskViewWidth = starPosition + ratio * (progress - i);
            break;
        }
    }
    self.progressImageView.frame = CGRectMake(0, 0, maskViewWidth, self.frame.size.height);
}


@end



