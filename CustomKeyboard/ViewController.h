//
//  ViewController.h
//  CustomKeyboard
//
//  Created by Sky on 2/26/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//
                                                                                                                                                                                                                                                                                                                                                                               
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Constant.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    NSDictionary *_faceMap;
    NSString *iap_string;
    BOOL HUD_hide_flag;
}

@property BOOL Free_Flag;
@property(nonatomic, retain) IBOutlet UIScrollView *scrollview;
@property(nonatomic, retain) MBProgressHUD *HUD;
@end

