//
//  KeyboardView.h
//  CustomKeyboard
//
//  Created by Sky on 3/3/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardView : UIView

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIScrollView *emoji_scrollview;
@property (strong, nonatomic) IBOutlet UIScrollView *category_scrollview;
@property (strong, nonatomic) IBOutlet UIButton *btnSwitch;
@property (strong, nonatomic) IBOutlet UIButton *btnBackSpace;
@property (strong, nonatomic) IBOutlet UILabel *pastelbl;

@property (strong, nonatomic) IBOutlet UIView *text_keyboardview;
@property (strong, nonatomic) IBOutlet UIView *number_keyboardview;
@property (strong, nonatomic) IBOutlet UIButton *txt_emoji_switchbtn;

@property (weak, nonatomic) IBOutlet UIButton *gif_btn;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnKeyBoardArray;

@property (weak, nonatomic) IBOutlet UIButton *number_swtichbtn;
@property (weak, nonatomic) IBOutlet UIButton *txt_swtichbtn;
@property (weak, nonatomic) IBOutlet UIButton *uppper_lower_btn;

@property (weak, nonatomic) IBOutlet UIButton *numberbtnSpace;
@property (weak, nonatomic) IBOutlet UIButton *txtbtnSpace;
@property (weak, nonatomic) IBOutlet UIButton *txtbtnClear;

@property (weak, nonatomic) IBOutlet UIButton *txtreturn_btn;
@property (weak, nonatomic) IBOutlet UIButton *numberreturn_btn;




- (IBAction)presentGif:(id)sender;


@end
