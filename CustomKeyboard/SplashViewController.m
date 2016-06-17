//
//  SplashViewController.m
//  CustomKeyboard
//
//  Created by Sky on 3/23/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "SplashViewController.h"
#import "StoreViewController.h"
#import "FirstViewController.h"

@interface SplashViewController ()
{
    NSUserDefaults *userdefalts;
}
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([userdefalts boolForKey:@"CATEGORY1"])
    {
        UIButton *fullVersinoBtn = self.fullVersionBtn;
        [fullVersinoBtn setBackgroundColor:[UIColor blackColor]];
        [fullVersinoBtn setTitle:@"FULL VERSION" forState:UIControlStateNormal];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (IBAction)onNext:(UIButton*)sender
{
        if (sender.tag == 0) {
//        UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        StoreViewController *storecontroller = [mainstoryboard instantiateViewControllerWithIdentifier:@"StoreViewController"];
//        storecontroller.titlestr = @"Free Rampagemojis";
//        [self.navigationController pushViewController:storecontroller animated:YES];
        
        NSString *valueToSave = @"Free Rampagemojis";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"rampage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (sender.tag == 1) {
//        UIStoryboard *mainstoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        StoreViewController *storecontroller = [mainstoryboard instantiateViewControllerWithIdentifier:@"StoreViewController"];
//        storecontroller.titlestr = @"Rampagemoji Pack 1";
//        [self.navigationController pushViewController:storecontroller animated:YES];
        
        NSString *valueToSave = @"Rampagemoji Pack 1";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"rampage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    if (sender.tag == 2) {
//        FirstViewController *controller = [mainstoryboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
//        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
