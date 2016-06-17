//
//  StoreViewController.h
//  CustomKeyboard
//
//  Created by Sky on 3/18/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Constant.h"

@interface StoreViewController : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *_faceMap;
    NSString *iap_string;
    
    int firstitemcategory_number;
    int lastitemcategory_number;
    
    NSMutableDictionary* category_all_dictionary;
}
@property(nonatomic, retain)MBProgressHUD *HUD;
@property(nonatomic, retain) IBOutlet UILabel *lblTitle;
@property(nonatomic, strong) NSString *titlestr;
@property(nonatomic, retain) IBOutlet UIScrollView *storescrollview;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (retain, nonatomic) IBOutlet UITabBarItem *tabBarItem;

@end
