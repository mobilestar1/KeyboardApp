//
//  KeyboardViewController.h
//  emoji
//
//  Created by Sky on 3/2/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIInputViewController<UIScrollViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *category_itemarray;
    NSDictionary *_faceMap;
    NSMutableDictionary* category_dictionary;
    
    NSMutableDictionary* category_all_dictionary;
    
    UIPageControl *facePageControl;
    NSTimer *pastelbltimer;
    NSMutableArray *itemclickedarray;
    
    BOOL txt_number_keyboardflag;
    BOOL upper_lower_switchflag;
    BOOL gif_switchflag;
}

@end
