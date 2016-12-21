//
//  ViewController.h
//  LCStarRatingViewExample
//
//  Created by Guolicheng on 2016/12/20.
//  Copyright © 2016年 titman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong) IBOutlet UIButton * starColorButton;
@property(strong) IBOutlet UIButton * starBorderColorButton;
@property(strong) IBOutlet UIButton * starBorderWithButton;
@property(strong) IBOutlet UIButton * starPlaceHolderColorButton;
@property(strong) IBOutlet UIButton * starPlaceHolderBorderColorButton;
@property(strong) IBOutlet UIButton * starPlaceHolderBorderWidthButton;

@property(strong) IBOutlet UISlider * slider;

@property(strong) IBOutlet UISegmentedControl * segment;

@end

