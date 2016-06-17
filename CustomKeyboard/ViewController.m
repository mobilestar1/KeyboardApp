//
//  ViewController.m
//  CustomKeyboard
//
//  Created by Sky on 2/26/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "ViewController.h"
#import "StoreViewController.h"
#import "TutorialViewController.h"
#import "MKStoreManager.h"

@interface ViewController ()
{
    NSString *cattegory_list;
    NSUserDefaults *userdefalts;
}

@end

@implementation ViewController

#define CATEGORY_COUNT  4
#define SUBVIEW_HEIGHT  225
#define FACE_ICON_SIZE  60

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    userdefalts = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
    
    if (self.Free_Flag) cattegory_list = @"Free";
    else cattegory_list = @"Rampagemoji Pack 1";
    
    [self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
    _scrollview.contentSize = CGSizeMake(self.view.bounds.size.width, SUBVIEW_HEIGHT*2);
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.delegate = self;
    
    for (UIView *view in _scrollview.subviews) {
        [view removeFromSuperview];
    }
    
    UIFont *categoryfont = [UIFont systemFontOfSize:17.0f];
    UIFont *emojicountfont = [UIFont systemFontOfSize:13.0f];
    
    int ii = 0;
    if (self.Free_Flag) ii = 0;
    else ii = 1;
    
        UIView *subview = [[UIView alloc]initWithFrame:CGRectMake(0, -15, self.view.bounds.size.width, SUBVIEW_HEIGHT)];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fullpackcontroller:)];
        subview.tag = ii;
        [subview addGestureRecognizer:gesture];
        
        UILabel *categorylbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 200, 30)];
        categorylbl.font = categoryfont;
        categorylbl.text = cattegory_list;
        UILabel *emojicountlbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 200, 20)];
        emojicountlbl.font = emojicountfont;
        UIButton *purchasebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 110, 10, 100, 30)];
        [purchasebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [purchasebtn setTitle:@"$1.99" forState:UIControlStateNormal];
        purchasebtn.tag = ii + 100;
        purchasebtn.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *purchase_gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emojipurchasebtnclick:)];
        [purchasebtn addGestureRecognizer:purchase_gesture];
        
        UILabel *fullpacklbl = [[UILabel alloc]initWithFrame:CGRectMake(subview.bounds.size.width - 110, SUBVIEW_HEIGHT - 37, 110, 20)];
        fullpacklbl.font = emojicountfont;
        fullpacklbl.text = @"View Full Pack >";
        
        for(int i=0;i<8;i++)
        {
            UIImageView *emojiview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FACE_ICON_SIZE, FACE_ICON_SIZE)];
            float emojiview_xcenter = (i%4) * (self.view.bounds.size.width/CATEGORY_COUNT) + (self.view.bounds.size.width/CATEGORY_COUNT)/2;
            float emojiview_ycenter = i<4?80:155;
            emojiview.center = CGPointMake(emojiview_xcenter, emojiview_ycenter);
            switch (ii) {
                case 0:
                    [purchasebtn setTitle:@"FREE" forState:UIControlStateNormal];
                    _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                                [[NSBundle mainBundle] pathForResource:@"Freebies"
                                                                ofType:@"plist"]];
                    break;
                case 1:
                {
                    _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                                [[NSBundle mainBundle] pathForResource:@"Rampage"
                                                                ofType:@"plist"]];
                }
            
                    break;
                default:
                    break;
            }
            NSArray* keysArray = [_faceMap keysSortedByValueUsingComparator:^(id first, id second) {
                
                return [first compare:second];
                
            }];
            
            
            keysArray = [keysArray sortedArrayUsingSelector:@selector(compare:)];
            emojicountlbl.text = [NSString stringWithFormat:@"%lu Emojis", (unsigned long)keysArray.count];
            emojiview.image = [UIImage imageNamed:[_faceMap objectForKey:[keysArray objectAtIndex:i]]];
            
            [subview addSubview:emojiview];
        }
        
        [subview addSubview:categorylbl];
        [subview addSubview:emojicountlbl];
        [subview addSubview:fullpacklbl];
        purchasebtn.layer.borderColor = [UIColor grayColor].CGColor;
        purchasebtn.layer.borderWidth = 1.0f;
        purchasebtn.layer.cornerRadius = 5.0f;
        [subview addSubview:purchasebtn];
        
        subview.layer.borderColor = [UIColor grayColor].CGColor;
        subview.layer.borderWidth = 0.4f;
        [_scrollview addSubview:subview];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for(UIView *view in _scrollview.subviews)
    {
        for(UIButton *btn in view.subviews)
        {
            if(btn.tag > 100)
                NSLog(@"%ld", (long)btn.tag);
            if([userdefalts boolForKey:@"CATEGORY1"])
                NSLog(@"Catagory1");
            if([userdefalts boolForKey:@"CATEGORY1"] && btn.tag == 101)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
            else if([userdefalts boolForKey:@"CATEGORY2"]  && btn.tag == 102)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
            else if([userdefalts boolForKey:@"CATEGORY3"] && btn.tag == 103)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
            else if([userdefalts boolForKey:@"CATEGORY4"] && btn.tag == 104)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
        }
    }
}

- (void)fullpackcontroller:(UITapGestureRecognizer *)gesture
{
    UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StoreViewController *storecontroller = [mainstoryboard instantiateViewControllerWithIdentifier:@"StoreViewController"];
    storecontroller.titlestr = cattegory_list;
    [self.navigationController pushViewController:storecontroller animated:YES];
}

- (IBAction)keyboardbtnclick:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage*)image:(UIImage *)sourceImage scaledToWidth:(float) i_width
{
    float oldWidth = sourceImage.size.width;
    float oldHeight = sourceImage.size.height;
    //    float imgHeight = imagePreview.frame.size.height * 2;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = oldHeight * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)emojipurchasebtnclick:(UITapGestureRecognizer *)gesture
{
    UIButton *purchase_btn = (UIButton*)gesture.view;
    int btnindex = (int)(gesture.view.tag);
    switch (btnindex) {
        case 101:
            iap_string = FUNKYFRESH_IAP;
            break;
        default:
            break;
    }
    if(btnindex>100)
    {
        if([purchase_btn.titleLabel.text isEqualToString:@"ADDED"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SUCCESSFUL",@"") message:NSLocalizedString(@"You already purchased. Thank you.",@"")
                                                           delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            NSLog(@"test=%@", iap_string);
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudhide:) name:@"HUDHIDE" object:nil];
            [[MKStoreManager sharedManager]buyMag:iap_string];
            if(_HUD == nil)
                _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            else
                [_HUD show:YES];
            [_HUD setLabelText:@"Connecting....."];
            [_HUD show:YES];
        }
    }
}

- (void)hudhide:(NSNotification *)notification
{
    [_HUD hide:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HUDHIDE" object:nil];
    for(UIView *view in _scrollview.subviews)
    {
        for(UIButton *btn in view.subviews)
        {
            NSLog(@"%ld", (long)btn.tag);
            if([userdefalts boolForKey:@"CATEGORY1"] && btn.tag == 101)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
            else if([userdefalts boolForKey:@"CATEGORY2"]  && btn.tag == 102)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
            else if([userdefalts boolForKey:@"CATEGORY3"] && btn.tag == 103)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
            else if([userdefalts boolForKey:@"CATEGORY4"] && btn.tag == 104)
                [btn setTitle:@"ADDED" forState:UIControlStateNormal];
        }
    }
}

- (void)hudhidefunction:(NSNotification *)notification
{
    if(HUD_hide_flag)
    {
        HUD_hide_flag = FALSE;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SUCCESSFUL",@"") message:NSLocalizedString(@"Restore successful. Thank you.",@"")
                                                       delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles: nil];
        [alert show];
        [_HUD hide:YES];
        for(UIView *view in _scrollview.subviews)
        {
            for(UIButton *btn in view.subviews)
            {
                NSLog(@"%ld", (long)btn.tag);
                if([userdefalts boolForKey:@"CATEGORY1"] && btn.tag == 101)
                    [btn setTitle:@"ADDED" forState:UIControlStateNormal];
                else if([userdefalts boolForKey:@"CATEGORY2"]  && btn.tag == 102)
                    [btn setTitle:@"ADDED" forState:UIControlStateNormal];
                else if([userdefalts boolForKey:@"CATEGORY3"] && btn.tag == 103)
                    [btn setTitle:@"ADDED" forState:UIControlStateNormal];
                else if([userdefalts boolForKey:@"CATEGORY4"] && btn.tag == 104)
                    [btn setTitle:@"ADDED" forState:UIControlStateNormal];
            }
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IAPRESTORENOTIFICATION object:nil];
}

- (IBAction)restorebtnclick:(id)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudhidefunction:) name:IAPRESTORENOTIFICATION object:nil];
    HUD_hide_flag = TRUE;
    [[MKStoreManager sharedManager]restorefunction];
    if(_HUD == nil)
        _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    else
        [_HUD show:YES];
    [_HUD setLabelText:@"Connecting....."];
    [_HUD show:YES];
    
}

@end
