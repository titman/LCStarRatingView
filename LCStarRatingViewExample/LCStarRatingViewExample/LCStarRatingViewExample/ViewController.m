//
//  ViewController.m
//  LCStarRatingViewExample
//
//  Created by Guolicheng on 2016/12/20.
//  Copyright © 2016年 titman. All rights reserved.
//

#import "ViewController.h"
#import "LCStarRatingView.h"

@interface ViewController ()<LCStarRatingViewDelegate>

@property(nonatomic, strong) LCStarRatingView * ratingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.slider.continuous = NO;

    self.ratingView = [[LCStarRatingView alloc] init];
    self.ratingView.frame = CGRectMake(100, 100, 200, 200);
    self.ratingView.delegate = self;
    
    [self.view addSubview:self.ratingView];
    
    __weak ViewController * vc = self;
    
    self.ratingView.progressDidChangedByUser = ^(CGFloat progress){
        
        NSLog(@"progressDidChangedByUser : %@", @(progress));
        vc.slider.value = progress;
    };
}

-(UIColor *) randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

-(CGFloat) increasingWidth
{
    static CGFloat width = -1;
    
    if (width == 5) width = -1;
    
    width += 1;
    
    return width;
}

-(IBAction)setColor:(UIButton *)sender
{
    if (sender.tag == 0) self.ratingView.starColor = self.randomColor;
    else                 self.ratingView.starPlaceHolderColor = self.randomColor;
}

-(IBAction)setBorderColor:(UIButton *)sender
{
    if (sender.tag == 0) self.ratingView.starBorderColor = self.randomColor;
    else                 self.ratingView.starPlaceHolderBorderColor = self.randomColor;
}

-(IBAction)setBorderWidth:(UIButton *)sender
{
    if (sender.tag == 0) self.ratingView.starBorderWidth = self.increasingWidth;
    else                 self.ratingView.starPlaceHolderBorderWidth = self.increasingWidth;
}

-(IBAction)setProgress:(UISlider *)sender
{
    self.ratingView.progress = sender.value;
}

-(IBAction)setType:(UISegmentedControl *)sender
{
    self.ratingView.type = sender.selectedSegmentIndex;
}

-(void) LCStarRatingView:(LCStarRatingView *)starRatingView progressDidChangedByUser:(CGFloat)progress {
    NSLog(@"Delegate output: %@", @(progress));
}

@end
