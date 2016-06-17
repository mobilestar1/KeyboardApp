//
//  FirstViewController.h
//  CustomKeyboard
//
//  Created by Sky on 4/1/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UIScrollViewDelegate>

@property BOOL Free_Flag;
@property(nonatomic, retain) IBOutlet UIScrollView *tutorialview;
@end
