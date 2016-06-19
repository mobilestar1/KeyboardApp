//
//  GifViewController.m
//  CustomKeyboard
//
//  Created by Santosh on 12/06/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

#import "GifViewController.h"
#import "MKStoreManager.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "UIImage+GIF.h"
@interface GifViewController ()
{
    NSMutableArray* keysArray_list;
    NSArray *cattegory_list;
    int scroll_index;
    
    NSUserDefaults *userdefalts;
    UIButton *purchase_btn;

}
@property (atomic, strong) FLAnimatedImageView *imageView1;
@end

NSArray * rampageGif;

@implementation GifViewController
#define CATEGORY_COUNT  4
#define FACE_ICON_SIZE  60

#define Title_subview_Height 50



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarController *tabBarController = (UITabBarController *)self.parentViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    [tabBar sizeToFit];
    tabBar.backgroundImage = [UIImage imageNamed:@"gif_1x.png"];
    
    userdefalts = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudhide:) name:IAPNOTIFICATION object:nil];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    UITabBarController *tabBarController = (UITabBarController *)self.parentViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    [tabBar sizeToFit];
    tabBar.backgroundImage = [UIImage imageNamed:@"gif_1x.png"];
    
    userdefalts = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hudhide:) name:IAPNOTIFICATION object:nil];
   
    rampageGif = [NSArray arrayWithObjects:@"giphy1",@"giphy2",@"giphy3",@"giphy4",@"giphy5",@"giphy6",@"giphy7",@"giphy8",@"giphy9",nil];
    
    
    //    UITabBarController *tabBarController = (UITabBarController *)self.parentViewController;
//    UITabBar *tabBar = tabBarController.tabBar;
//    [tabBar sizeToFit];
//    tabBar.backgroundImage = [UIImage imageNamed:@"gif_1x.png"];
//    tabBar.barTintColor = [UIColor blackColor];
//    tabBar.tintColor = [UIColor blackColor];
////    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
////    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//    
////
////        CGFloat tabBarHeight = 42.0;
////        CGRect frame = self.view.frame;
////        tabBar.frame = CGRectMake(0, frame.size.height - tabBarHeight, frame.size.width, tabBarHeight);
////    
////    
//    
//    
//    
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"emoji_tap.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"emojis_untap.png"]];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"gif_tap.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"gif_untap.png"]];

    
//    _collectionView.dataSource = self;
//    _collectionView.delegate = self;
    
    [_collectionView reloadData];
    
       
    
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"rampage"];
    
        if([savedValue isEqualToString:@"Free Rampagemojis"])
        {
            self.lblTitle.text = @"Free Rampagemoji GIFs";
        self.gifCountLbl.text = [NSString stringWithFormat:@"%lu GIFs",(unsigned long)rampageGif.count];
    
            // To set the title
    
            [[_purchaseBtn layer] setBorderWidth:1.0f];
            [[_purchaseBtn layer] setBorderColor:[UIColor blackColor].CGColor];
            [[_purchaseBtn layer] setCornerRadius:5.0f];
    
            [_purchaseBtn setTitle:@"Free" forState:UIControlStateNormal];
            [_purchaseBtn setUserInteractionEnabled:YES];
    
            self.title2.text= @"Free Version";
    
        }
        else
        {
            
            if([userdefalts boolForKey:@"CATEGORY1"])
            {
                NSLog(@"purchased");
                [[_purchaseBtn layer] setBorderWidth:1.0f];
                [[_purchaseBtn layer] setBorderColor:[UIColor blackColor].CGColor];
                [[_purchaseBtn layer] setCornerRadius:5.0f];
                
                [_purchaseBtn setTitle:@"ADDED" forState:UIControlStateNormal];
                [_purchaseBtn setUserInteractionEnabled:YES];
                
            }
            else {
                NSLog(@"Not purchased1");
                [[_purchaseBtn layer] setBorderWidth:1.0f];
                [[_purchaseBtn layer] setBorderColor:[UIColor blackColor].CGColor];
                [[_purchaseBtn layer] setCornerRadius:5.0f];
                
                [_purchaseBtn setTitle:@"$1.99" forState:UIControlStateNormal];
                [_purchaseBtn setUserInteractionEnabled:YES];
            }
            
            
            self.lblTitle.text = @"Rampagemoji Full Version";
            self.gifCountLbl.text = [NSString stringWithFormat:@"%lu GIFs",(unsigned long)rampageGif.count];
             // To set the title
    
            
            self.title2.text = @"Full Version";
    
        }

    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"rampage"];
    
    if([savedValue isEqualToString:@"Free Rampagemojis"])
    
        return rampageGif.count;
    
    else
        
        return rampageGif.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell =
    [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                              forIndexPath:indexPath];
    
    
    UIImageView * rampageGifImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, cell.frame.size.height)];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"rampage"];
    
    if([savedValue isEqualToString:@"Free Rampagemojis"])
    {
        [rampageGifImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",[rampageGif objectAtIndex:indexPath.row]]]];
        [cell.layer setCornerRadius:0];
        
        
        // Animating Images in Collection Views
        
        //    if (!self.imageView1) {
        self.imageView1 = [[FLAnimatedImageView alloc] init];
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView1.clipsToBounds = YES;
        //    }
        //[self.view addSubview:self.imageView1];
        self.imageView1.frame = CGRectMake(0,0, cell.frame.size.width, cell.frame.size.height);
        
        NSURL *url1 = [[NSBundle mainBundle] URLForResource:[rampageGif objectAtIndex:indexPath.row] withExtension:@"gif"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
        self.imageView1.animatedImage = animatedImage1;
        
        rampageGifImage = self.imageView1;
        
        //    [rampageGifImage setImage:[UIImage sd_animatedGIFNamed:@"YOURGIF_IMAGE"]];
        
        [cell addSubview:rampageGifImage];
        
    }
    else{
        [rampageGifImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",[rampageGif objectAtIndex:indexPath.row]]]];
        [cell.layer setCornerRadius:0];
        [cell.layer setCornerRadius:0];
        
        
        // Animating Images in Collection Views
        
        //    if (!self.imageView1) {
        self.imageView1 = [[FLAnimatedImageView alloc] init];
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView1.clipsToBounds = YES;
        //    }
        //[self.view addSubview:self.imageView1];
        self.imageView1.frame = CGRectMake(0,0, cell.frame.size.width, cell.frame.size.height);
        
        NSURL *url1 = [[NSBundle mainBundle] URLForResource:[rampageGif objectAtIndex:indexPath.row] withExtension:@"gif"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
        self.imageView1.animatedImage = animatedImage1;
        
        rampageGifImage = self.imageView1;
        
        //    [rampageGifImage setImage:[UIImage sd_animatedGIFNamed:@"YOURGIF_IMAGE"]];
        
        [cell addSubview:rampageGifImage];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hudhide:(NSNotification *)notification
{
    [_HUD hide:YES];
    if([userdefalts boolForKey:@"CATEGORY1"])
        [_purchaseBtn setTitle:@"ADDED" forState:UIControlStateNormal];
}

- (IBAction)buy:(id)sender {
    
    iap_string = FUNKYFRESH_IAP;
  
            if([_purchaseBtn.titleLabel.text isEqualToString:@"ADDED"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SUCCESSFUL",@"") message:NSLocalizedString(@"You already purchased. Thank you.",@"")
                                                           delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles: nil];
            [alert show];
        }
    
     else if([_purchaseBtn.titleLabel.text isEqualToString:@"Free"])
    {
        
    }
        else
        {
            NSLog(@"test=%@", iap_string);
            [[MKStoreManager sharedManager]buyMag:iap_string];
            if(_HUD == nil)
                _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            else
                [_HUD show:YES];
            [_HUD setLabelText:@"Connecting....."];
            [_HUD show:YES];
        }
}
@end
