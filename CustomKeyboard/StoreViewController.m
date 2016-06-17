//
//  StoreViewController.m
//  CustomKeyboard
//
//  Created by Sky on 3/18/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "StoreViewController.h"
#import "MKStoreManager.h"

@interface StoreViewController ()
{
    NSMutableArray* keysArray_list;
    NSArray *cattegory_list;
    int scroll_index;
    
    NSUserDefaults *userdefalts;
    UIButton *purchase_btn;
}
@end

@implementation StoreViewController
#define CATEGORY_COUNT  3
#define FACE_ICON_SIZE  70

#define Title_subview_Height 50

- (void)viewDidLoad {
       [super viewDidLoad];


UITabBarController *tabBarController = (UITabBarController *)self.parentViewController;
UITabBar *tabBar = tabBarController.tabBar;
[tabBar sizeToFit];
tabBar.backgroundImage = [UIImage imageNamed:@"emoji_1x.png"];
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    UITabBarController *tabBarController = (UITabBarController *)self.parentViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    [tabBar sizeToFit];
    tabBar.backgroundImage = [UIImage imageNamed:@"emoji_1x.png"];
    
    
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
    
    NSString *checkVersion = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"rampage"];
    
    if([checkVersion isEqualToString:@"Free Rampagemojis"])
    {
        
        self.title2.text= @"Free Version";
        
    }
    else
    {
        
        self.title2.text = @"Full Version";
        
    }
    
//    
//    [tabBar setUserInteractionEnabled:YES];
    
//    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    
   
////   [tabBarItem1 setImage:[UIImage imageNamed:@"emoji_tap.png"]];
////    [tabBarItem2 setImage:[UIImage imageNamed:@"emoji_tap.png"]];
//
//        CGFloat tabBarHeight = 42.0;
//    CGRect frame = self.view.frame;
//    tabBar.frame = CGRectMake(0, frame.size.height - tabBarHeight, frame.size.width, tabBarHeight);
//    
//    
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"emoji_tap.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"emojis_untap.png"]];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"gif_tap.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"gif_untap.png"]];
//    
//    
    
    userdefalts = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudhide:) name:IAPNOTIFICATION object:nil];
    
    self.lblTitle.text = self.titlestr;
    category_all_dictionary = [[NSMutableDictionary alloc]init];
    _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                [[NSBundle mainBundle] pathForResource:@"All"
                                                ofType:@"plist"]];
    [category_all_dictionary addEntriesFromDictionary:_faceMap];
    
    cattegory_list = [[NSArray alloc] initWithObjects:@"Free Rampagemojis",@"Rampagemoji Pack 1", nil];
    
    keysArray_list = [[NSMutableArray alloc]init];
     // Do any additional setup after loading the view.
    _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"Freebies"
                                                    ofType:@"plist"]];
    NSArray *array = [_faceMap keysSortedByValueUsingComparator:^(id first, id second) {
        
        return [first compare:second];
        
    }];
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    [keysArray_list addObject:array];
    
    _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                [[NSBundle mainBundle] pathForResource:@"Rampage"
                                                ofType:@"plist"]];
    array = [_faceMap keysSortedByValueUsingComparator:^(id first, id second) {
        
        return [first compare:second];
        
    }];
        array = [array sortedArrayUsingSelector:@selector(compare:)];
    [keysArray_list addObject:array];
   
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"rampage"];
//    
//    scroll_index = 1;
    if([savedValue isEqualToString:@"Free Rampagemojis"])
        scroll_index = 0;
    else if([savedValue isEqualToString:@"Rampagemoji Pack 1"])
        scroll_index = 1;
    
    _storescrollview.pagingEnabled = YES;
    _storescrollview.contentSize = CGSizeMake (self.view.bounds.size.width * (CATEGORY_COUNT-1), _storescrollview.bounds.size.height);
    _storescrollview.showsHorizontalScrollIndicator = NO;
    _storescrollview.showsVerticalScrollIndicator = NO;
    _storescrollview.delegate = self;
    _storescrollview.scrollEnabled = NO ;
  
    
    UIFont *categoryfont = [UIFont systemFontOfSize:17.0f];
    UIFont *emojicountfont = [UIFont systemFontOfSize:13.0f];
    
        for(int ii=0;ii<(CATEGORY_COUNT + 1);ii++)
        {
            if (ii > keysArray_list.count - 1) continue;
            
            NSArray *keysArray = [keysArray_list objectAtIndex:ii];
            UIView *mainsubview = [[UIView alloc]initWithFrame:CGRectMake(ii*self.view.bounds.size.width+10, 10, _storescrollview.bounds.size.width-20, _storescrollview.bounds.size.height-20)];
            UIView *subview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainsubview.bounds.size.width, Title_subview_Height)];
            subview.backgroundColor = [UIColor whiteColor];
            
            UILabel *categorylbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 30)];
            categorylbl.font = categoryfont;
            categorylbl.text = [cattegory_list objectAtIndex:ii];
            UILabel *emojicountlbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 200, 20)];
            emojicountlbl.font = emojicountfont;
            UIButton *purchasebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 110, 10, 80, 30)];
            [purchasebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           
            if([categorylbl.text isEqualToString:@"Free Rampagemojis"])
                [purchasebtn setTitle:@"Free" forState:UIControlStateNormal];
            else
            {
                [purchasebtn setTitle:@"$1.99" forState:UIControlStateNormal];
                if([userdefalts boolForKey:@"CATEGORY1"] && [categorylbl.text isEqualToString:@"Rampagemoji Pack 1"])
                    [purchasebtn setTitle:@"ADDED" forState:UIControlStateNormal];
            }
            purchasebtn.tag = ii;
            purchasebtn.layer.cornerRadius = 5.0f;
            purchasebtn.layer.borderColor = [UIColor grayColor].CGColor;
            purchasebtn.layer.borderWidth = 1.0f;
            
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emojipurchasebtnclick:)];
            [purchasebtn addGestureRecognizer:gesture];
            
            UITableView *tablelview = [[UITableView alloc]initWithFrame:CGRectMake(0, Title_subview_Height + 5, mainsubview.bounds.size.width, mainsubview.bounds.size.height-Title_subview_Height-5)];
            
            tablelview.delegate = self;
            tablelview.dataSource = self;
            tablelview.userInteractionEnabled = YES;
            tablelview.scrollEnabled = YES;
            tablelview.showsHorizontalScrollIndicator = NO;
            tablelview.showsVerticalScrollIndicator = NO;

            
            tablelview.backgroundColor = [UIColor whiteColor];
            [tablelview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            tablelview.tag = ii + 100;
            [tablelview reloadData];
          
            emojicountlbl.text = [NSString stringWithFormat:@"%lu Emojis", (unsigned long)keysArray.count];
            [mainsubview addSubview:tablelview];
            [subview addSubview:categorylbl];
            [subview addSubview:emojicountlbl];
            [subview addSubview:purchasebtn];
            
            [mainsubview addSubview:subview];
            [_storescrollview addSubview:mainsubview];
        }
    [_storescrollview setContentOffset:CGPointMake(scroll_index*self.view.bounds.size.width, _storescrollview.bounds.origin.y) animated:NO];
}

- (void)hudhide:(NSNotification *)notification
{
    [_HUD hide:YES];
    if([userdefalts boolForKey:@"CATEGORY1"])
        [purchase_btn setTitle:@"ADDED" forState:UIControlStateNormal];
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

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = _storescrollview.frame.size.width;
    scroll_index = floor((_storescrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
   
    if (scroll_index == 0)self.lblTitle.text = @"Free Rampagemojis";
    else self.lblTitle.text = @"Rampagemoji Pack 1";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *array = [keysArray_list objectAtIndex:(tableView.tag - 100)];
    float count_float = (double)array.count/ 4;
    int count = (int)count_float;
    if ((count_float - count)>0)
        return (count+1);
    else
        return count;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    NSArray *array = [keysArray_list objectAtIndex:(tableView.tag - 100)];
    
    for(UIImageView *view in cell.contentView.subviews)
        [view removeFromSuperview];
    for(int i=0;i<4; i++)
    {
        if((i + indexPath.row*4)<array.count)
        {
            UIImageView *emojiview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FACE_ICON_SIZE, FACE_ICON_SIZE)];
            float emojiview_xcenter = (i%4) * (tableView.bounds.size.width/CATEGORY_COUNT) + (tableView.bounds.size.width/CATEGORY_COUNT)/2;
            float emojiview_ycenter = 40;
            emojiview.tag = 200 + i + indexPath.row*4;
            emojiview.center = CGPointMake(emojiview_xcenter, emojiview_ycenter);
            
            if(category_all_dictionary.count > 3)emojiview.image = [UIImage imageNamed:[category_all_dictionary objectForKey:[array objectAtIndex:(i + indexPath.row*4)]]];
            [cell.contentView addSubview:emojiview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)emojipurchasebtnclick:(UITapGestureRecognizer *)gesture
{
    purchase_btn = (UIButton*)gesture.view;
   
     int btnindex = (int)(gesture.view.tag);
     switch (btnindex) {
        case 1:
            iap_string = FUNKYFRESH_IAP;
            break;
        default:
            break;
    }
    if(btnindex>0)
    {
        if([purchase_btn.titleLabel.text isEqualToString:@"ADDED"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SUCCESSFUL",@"") message:NSLocalizedString(@"You already purchased. Thank you.",@"")
                                                           delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles: nil];
            
            
            [alert show];
            
            NSUserDefaults *userdefalts1 = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
            
            [userdefalts1 setBool:true forKey:@"CATEGORY1"];
            
        }
        else
        {
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

- (IBAction)bckbtnclick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IAPNOTIFICATION object:nil];
}
@end
