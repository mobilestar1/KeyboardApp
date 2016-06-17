//
//  GifViewController.h
//  CustomKeyboard
//
//  Created by Santosh on 12/06/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Constant.h"


@interface GifViewController : UIViewController

{
    NSDictionary *_faceMap;
    NSString *iap_string;
    
    int firstitemcategory_number;
    int lastitemcategory_number;
    
    NSMutableDictionary* category_all_dictionary;
}
@property(nonatomic, retain)MBProgressHUD *HUD;

@property(nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *gifCountLbl;
@property(nonatomic, strong) NSString *titlestr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;
@property (weak, nonatomic) IBOutlet UILabel *title2;

- (IBAction)buy:(id)sender;
@end
