//
//  FirstViewController.m
//  CustomKeyboard
//
//  Created by Sky on 4/1/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"

@interface FirstViewController ()
{
    UIPageControl *pagecontrol;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tutorialview.pagingEnabled = YES;
    _tutorialview.contentSize = CGSizeMake (self.view.bounds.size.width * 4, _tutorialview.bounds.size.height);
    _tutorialview.showsHorizontalScrollIndicator = NO;
    _tutorialview.showsVerticalScrollIndicator = NO;
    _tutorialview.delegate = self;
    _tutorialview.scrollEnabled = YES ;
    
    pagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake(0, (_tutorialview.bounds.size.height + _tutorialview.frame.origin.y + 5), self.view.bounds.size.width, 30)];
    pagecontrol.numberOfPages = 4;
    pagecontrol.pageIndicatorTintColor = [UIColor lightGrayColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pagecontrol.userInteractionEnabled = NO;
    
    for(int i=1;i<5;i++)
    {
        NSString *filename = [NSString stringWithFormat:@"screen%i.png", i];
        UIImage *tutorial_img = [UIImage imageNamed:filename];
        UIImageView *tutorial_imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*(i-1)+7, 0, _tutorialview.bounds.size.width-14, _tutorialview.bounds.size.height)];
        tutorial_imageview.image = tutorial_img;
        tutorial_imageview.layer.cornerRadius = 5.0f;
        tutorial_imageview.layer.borderWidth = 1.0f;
        tutorial_imageview.contentMode = UIViewContentModeScaleAspectFit;
        tutorial_imageview.clipsToBounds = YES;
        tutorial_imageview.layer.borderColor = [UIColor grayColor].CGColor;
        [_tutorialview addSubview:tutorial_imageview];
    }
    
    [self.view addSubview:pagecontrol];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = _tutorialview.frame.size.width;
    int page = floor((_tutorialview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pagecontrol.currentPage = page;
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
