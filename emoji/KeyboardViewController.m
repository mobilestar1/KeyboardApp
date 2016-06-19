//
//  KeyboardViewController.m
//  emoji
//
//  Created by Sky on 3/2/15.
//  Copyright (c) 2015 Sky. All rights reserved.
//

#import "KeyboardViewController.h"
#import "KeyboardView.h"
#import <AudioToolbox/AudioToolbox.h>

#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "UIImage+GIF.h"

#import "NibCell.h"

#import "DFImageManager.h"
#import "DFImageView.h"

@interface KeyboardViewController ()
{
    NSUserDefaults *sharedDefaults;
}
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property(strong, nonatomic) KeyboardView *keyboard;

@property (atomic, strong) FLAnimatedImageView *imageView1;

@property (strong, nonatomic) IBOutlet UIButton *gifs;
@end

NSArray * rampageGif;
BOOL boolArray[];
CGFloat bottomWidth;
CGFloat bottomHeight;

@implementation KeyboardViewController

#define FACE_COUNT_ROW  2
#define FACE_COUNT_CLU  4
#define FACE_COUNT_PAGE ( FACE_COUNT_ROW * FACE_COUNT_CLU )
#define FACE_ICON_SIZE  60

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    rampageGif = [NSArray arrayWithObjects:@"giphy1",@"giphy2",@"giphy3",@"giphy4",@"giphy5",@"giphy6",@"giphy7",@"giphy8",@"giphy9",nil];
    
//    gifArray = [[NSMutableArray alloc] init];
//    for (int i = 0;i < rampageGif.count;i ++) {
//        NSURL *url1 = [[NSBundle mainBundle] URLForResource:[rampageGif objectAtIndex:i] withExtension:@"gif"];
//        NSData *data1 = [NSData dataWithContentsOfURL:url1];
//        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//        [gifArray addObject:animatedImage1];
//    }
    for (int i = 1;i <= 10;i ++) {
        boolArray[i] = false;
    }
    [_keyboard.collectionView reloadData];
    
    sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([sharedDefaults boolForKey:@"CATEGORY1"]) {
        return rampageGif.count;
    } else {
        [self.keyboard.pastelbl setText:[NSString stringWithFormat:@"%lu", (unsigned long)rampageGif.count]];
        return rampageGif.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    NibCell *cell = [self.keyboard.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView * rampageGifImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, cell.frame.size.height)];
    if (!boolArray[indexPath.row]) {
        NSLog(@"printed");
        FLAnimatedImage __block *gifImage = nil;
        FLAnimatedImageView *animateImage1 = [[FLAnimatedImageView alloc] initWithFrame:cell.bounds];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            gifImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [rampageGif objectAtIndex:indexPath.row]] ofType:@"gif"]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                boolArray[indexPath.row] = true;
                animateImage1.animatedImage = gifImage;
                [cell addSubview:animateImage1];
                //gifImage = nil;
            });
        });

    }
    else{
        NSLog(@"not printed");
    }
//    [rampageGifImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",[rampageGif objectAtIndex:indexPath.row]]]];
//    [cell addSubview:rampageGifImage];
    
    
//    if ([sharedDefaults boolForKey:@"CATEGORY1"]) {
//        //        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        //        cell.imageView.clipsToBounds = YES;
//        //
//        //        NSURL *url1 = [[NSBundle mainBundle] URLForResource:[allRampageGifs objectAtIndex:indexPath.row] withExtension:@"gif"];
//        //        NSData *data1 = [NSData dataWithContentsOfURL:url1];
//        //        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//        //        cell.imageView.animatedImage = animatedImage1;
//        
////            @try {
//                FLAnimatedImage __block *gifImage = nil;
//                FLAnimatedImageView *animateImage1 = [[FLAnimatedImageView alloc] initWithFrame:cell.bounds];
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    gifImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [rampageGif objectAtIndex:indexPath.row]] ofType:@"gif"]]];
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        
//                        animateImage1.animatedImage = gifImage;
//                        [cell addSubview:animateImage1];
//                        //gifImage = nil;
//                    });
//                });
////            }
////            @catch (NSException *exception) {
////                NSLog(@"Exception :%@",exception.debugDescription);
////            }
//        [cell addSubview:rampageGifImage];
//    }
//    else{
//        
//        [rampageGifImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",[rampageGif objectAtIndex:indexPath.row]]]];
//        @try {
//            FLAnimatedImage __block *gifImage = nil;
//            FLAnimatedImageView *animateImage1 = [[FLAnimatedImageView alloc] initWithFrame:cell.bounds];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                gifImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [rampageGif objectAtIndex:indexPath.row]] ofType:@"gif"]]];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    animateImage1.animatedImage = gifImage;
//                    [cell addSubview:animateImage1];
//                    //gifImage = nil;
//                });
//            });
//        }
//        @catch (NSException *exception) {
//            NSLog(@"Exception :%@",exception.debugDescription);
//        }
//    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    NibCell *Cell = (NibCell*) [collectionView cellForItemAtIndexPath:indexPath];
        FLAnimatedImage __block *gifImage = nil;
        FLAnimatedImageView *animateImage1 = [[FLAnimatedImageView alloc] initWithFrame:Cell.bounds];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            gifImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [rampageGif objectAtIndex:indexPath.row]] ofType:@"gif"]]];

            dispatch_async(dispatch_get_main_queue(), ^{

                animateImage1.animatedImage = gifImage;
                [Cell addSubview:animateImage1];
                //gifImage = nil;
            });
        });
//    if ([sharedDefaults boolForKey:@"CATEGORY1"]) {
//        Cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        Cell.imageView.clipsToBounds = YES;
//        
//        NSURL *url2 = [[NSBundle mainBundle] URLForResource:[allRampageGifs objectAtIndex:indexPath.row] withExtension:@"gif"];
//        NSData *data1 = [NSData dataWithContentsOfURL:url2];
//        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//        Cell.imageView.animatedImage = animatedImage1;
//    }
//    else{
//        Cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        Cell.imageView.clipsToBounds = YES;
//        
//        NSURL *url2 = [[NSBundle mainBundle] URLForResource:[rampageGif objectAtIndex:indexPath.row] withExtension:@"gif"];
//        NSData *data1 = [NSData dataWithContentsOfURL:url2];
//        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//        Cell.imageView.animatedImage = animatedImage1;
//    }

    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:[rampageGif objectAtIndex:indexPath.row] withExtension:@"gif"];
    
    NSData *data = [NSData dataWithContentsOfURL:url1];
    UIPasteboard *pasteBoard=[UIPasteboard generalPasteboard];
    [pasteBoard setData:data forPasteboardType:@"com.compuserve.gif"];
    //custom font
    
    UILabel *copiedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (Cell.frame.size.height/2)-10, Cell.frame.size.width, 20)];
    // copiedLabel.text = @"Copied!";
    
    self.keyboard.pastelbl.text = @"Paste the GIF in your message!";
    [category_dictionary removeAllObjects];
    [self.keyboard.pastelbl setHidden:NO];
    pastelbltimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pastelblhide:) userInfo:nil repeats:NO];
    
    copiedLabel.numberOfLines = 1;
    copiedLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    copiedLabel.adjustsFontSizeToFitWidth = YES;
    copiedLabel.backgroundColor = [UIColor grayColor];
    
    copiedLabel.minimumScaleFactor = 10.0f/12.0f;
    copiedLabel.clipsToBounds = YES;
    copiedLabel.backgroundColor =[UIColor colorWithRed:189 green:195 blue:199 alpha:0.7];;
    copiedLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:14.0];
    copiedLabel.textColor = [UIColor blackColor];
    copiedLabel.textAlignment = NSTextAlignmentCenter;
    //[Cell addSubview:copiedLabel];
    [UIView animateWithDuration:3 animations:^(void) {
        copiedLabel.alpha = 0;
        
    }];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    txt_number_keyboardflag = true;
    upper_lower_switchflag = false;
    
    sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
    
    category_dictionary = [[NSMutableDictionary alloc]init];
    category_all_dictionary = [[NSMutableDictionary alloc]init];
    itemclickedarray = [[NSMutableArray alloc]init];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"RecentedEmoji"];
    
    for(NSString *name in array)
        [itemclickedarray addObject:name];
    
    facePageControl = [[UIPageControl alloc]init];
    
    self.keyboard = [[[NSBundle mainBundle] loadNibNamed:@"KeyboardView" owner:self options:nil] objectAtIndex:0];
    // [self.keyboard.collectionView registerClass:[NibCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self.keyboard.collectionView registerNib:[UINib nibWithNibName:@"NibCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    self.inputView = (UIInputView*)self.keyboard;
    
    [self.keyboard.pastelbl setHidden:YES];
    self.keyboard.pastelbl.layer.cornerRadius = 5.0;
    [self.keyboard.pastelbl.layer setMasksToBounds:YES];
    
    [self.keyboard.btnSwitch addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.btnBackSpace addTarget:self action:@selector(pressDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.txtbtnClear addTarget:self action:@selector(pressDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.txtbtnSpace addTarget:self action:@selector(spaceButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.numberbtnSpace addTarget:self action:@selector(spaceButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.numberreturn_btn addTarget:self action:@selector(returnButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.txtreturn_btn addTarget:self action:@selector(returnButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.number_swtichbtn addTarget:self action:@selector(txtnumberswitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.txt_swtichbtn addTarget:self action:@selector(txtnumberswitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.keyboard.txt_emoji_switchbtn addTarget:self action:@selector(txtnumberswitch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.uppper_lower_btn addTarget:self action:@selector(upperlowerswitch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboard.gif_btn addTarget:self action:@selector(gifBtnClkd:) forControlEvents:UIControlEventTouchUpInside];
    
    self.keyboard.emoji_scrollview.pagingEnabled = YES;
    self.keyboard.emoji_scrollview.showsHorizontalScrollIndicator = NO;
    self.keyboard.emoji_scrollview.showsVerticalScrollIndicator = NO;
    self.keyboard.emoji_scrollview.delegate = self;
    
    _keyboard.collectionView.dataSource = self;
    _keyboard.collectionView.delegate = self;
    
    self.keyboard.collectionView.hidden = YES;
    
    //    if([sharedDefaults boolForKey:@"CATEGORY1"])
    //    {
    //
    //        _faceMap = [NSDictionary dictionaryWithContentsOfFile:
    //                    [[NSBundle mainBundle] pathForResource:@"All"
    //                                                    ofType:@"plist"]];
    //        [category_all_dictionary addEntriesFromDictionary:_faceMap];
    //
    //
    //    }
    //    else
    //    {
    //
    //        _faceMap = [NSDictionary dictionaryWithContentsOfFile:
    //                    [[NSBundle mainBundle] pathForResource:@"Freebies"
    //                                                    ofType:@"plist"]];
    //        [category_dictionary addEntriesFromDictionary:_faceMap];
    //
    //
    //    }
    
    _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                [[NSBundle mainBundle] pathForResource:@"All"
                                                ofType:@"plist"]];
    [category_all_dictionary addEntriesFromDictionary:_faceMap];
    
    if([sharedDefaults boolForKey:@"CATEGORY1"])
    {
        _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"All"
                                                    ofType:@"plist"]];
        [category_dictionary addEntriesFromDictionary:_faceMap];
    }
    else{
        _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"Freebies"
                                                    ofType:@"plist"]];
        [category_dictionary addEntriesFromDictionary:_faceMap];
        
    }
    
    [self categorysettings:1];
    
    
    CGRect frame = CGRectMake(0, 5, self.view.bounds.size.width, 10);
    facePageControl.frame = frame;
    facePageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.404 green:0.412 blue:0.42 alpha:1.0f];
    facePageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.647 green:0.659 blue:0.6784 alpha:1.0f];;
    facePageControl.tintColor = [UIColor greenColor];
    facePageControl.userInteractionEnabled = NO;
    //    facePageControl.numberOfPages =[_faceMap count];
    facePageControl.currentPage = 0;
    [self.keyboard addSubview:facePageControl];
    
    for (UIButton *keyButton in self.keyboard.btnKeyBoardArray) {
        [keyButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self txtnumberkeyboardviewhide];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    bottomWidth = self.keyboard.frame.size.width;
    bottomHeight = self.keyboard.btnSwitch.frame.size.height;
    
    int buttonWidth = (int)bottomWidth / 6;
    int buttonHeight = (int)bottomHeight;
    self.keyboard.category_scrollview.showsHorizontalScrollIndicator = NO;
    self.keyboard.category_scrollview.showsVerticalScrollIndicator = NO;
    self.keyboard.category_scrollview.contentSize = CGSizeMake(6 * buttonWidth, buttonHeight);
    for(int i=0;i<2;i++)
    {
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emojibottombtnclick:)];
        switch (i) {
            case 0:
                [bottomButton setImage:[UIImage imageNamed:@"recent_normal.png"] forState:UIControlStateNormal];
                self.keyboard.collectionView.hidden = YES;
                self.keyboard.emoji_scrollview.hidden = NO;
                break;
            case 1:
                [bottomButton setImage:[UIImage imageNamed:@"emoji_active.png"] forState:UIControlStateNormal];
                self.keyboard.collectionView.hidden = YES;
                self.keyboard.emoji_scrollview.hidden = NO;
                break;
            case 2:
                [bottomButton setImage:[UIImage imageNamed:@"funky_gray.png"] forState:UIControlStateNormal];
                self.keyboard.collectionView.hidden = YES;
                self.keyboard.emoji_scrollview.hidden = NO;
                break;
            case 3:
                [bottomButton setImage:[UIImage imageNamed:@"gung_gray.png"] forState:UIControlStateNormal];
                self.keyboard.collectionView.hidden = YES;
                self.keyboard.emoji_scrollview.hidden = NO;
                break;
            case 4:
                [bottomButton setImage:[UIImage imageNamed:@"avant_gray.png"] forState:UIControlStateNormal];
                self.keyboard.collectionView.hidden = YES;
                self.keyboard.emoji_scrollview.hidden = NO;
                break;
            case 5:
                [bottomButton setImage:[UIImage imageNamed:@"cray_gray.png"] forState:UIControlStateNormal];
                self.keyboard.emoji_scrollview.hidden = NO;
                
                break;
            default:
                break;
        }
        bottomButton.tag = i;
        bottomButton.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight );
        [bottomButton addGestureRecognizer:gesture];
        [self.keyboard.category_scrollview addSubview:bottomButton];
    }
    
    
}

-(void)buttonTapped:(UIButton *)button{
    if(upper_lower_switchflag)
        [self.textDocumentProxy insertText:[button currentTitle]];
    else
        [self.textDocumentProxy insertText:[[button currentTitle] lowercaseString]];
    AudioServicesPlaySystemSound(0x450);
}


-(void)returnButtonTapped{
    [self.textDocumentProxy insertText:@"\n"];
    AudioServicesPlaySystemSound(0x450);
}


- (void)categorysettings:(int)btnindex
{
    if(category_dictionary.count>0 || btnindex == 0)
    {
        if(category_dictionary.count>0)
            
            category_itemarray = [category_dictionary keysSortedByValueUsingComparator:^(id first, id second) {
                
                return [first compare:second];
                
            }];
        category_itemarray = [category_itemarray sortedArrayUsingSelector:@selector(compare:)];
        float pagefloat = (float) ([category_itemarray count]) / FACE_COUNT_PAGE;
        int pageCnt = (int)pagefloat;
        if(pagefloat>pageCnt)
            pageCnt = pageCnt + 1;
        
        facePageControl.numberOfPages = pageCnt;
        facePageControl.currentPage = 0;
        for(UIButton *btn in self.keyboard.emoji_scrollview.subviews)
            [btn removeFromSuperview];
        [self.keyboard.emoji_scrollview setContentOffset:CGPointZero animated:NO];
        
        if(category_itemarray.count>0)
        {
            self.keyboard.emoji_scrollview.contentSize = CGSizeMake((pageCnt) * self.view.bounds.size.width, 168);
            for (int i=0;i<category_itemarray.count;i++) {
                
                NSString *filename = [category_itemarray objectAtIndex:i];
                
                UIButton *emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
                emojiButton.tag = [[category_itemarray objectAtIndex:i] intValue];;
                emojiButton.userInteractionEnabled = YES;
                emojiButton.frame = CGRectMake(0, 0, FACE_ICON_SIZE, FACE_ICON_SIZE);
                [emojiButton addTarget:self
                                action:@selector(emojibtnclick:)
                      forControlEvents:UIControlEventTouchUpInside];
                
                UIImage *currImg =[UIImage imageNamed:[category_all_dictionary objectForKey:filename]];
                
                CGFloat x = (i%FACE_COUNT_CLU) * (self.view.bounds.size.width/FACE_COUNT_CLU) + (self.view.bounds.size.width/FACE_COUNT_CLU)/2 + ((i) / FACE_COUNT_PAGE * (self.view.bounds.size.width));
                
                CGFloat y = (((i/FACE_COUNT_CLU)%2) * 168/2) + 168/2/2 + 10;
                emojiButton.center = CGPointMake(x, y);
                
                if (currImg.size.width != FACE_ICON_SIZE) {
                    currImg = [self image:currImg scaledToWidth:FACE_ICON_SIZE];
                    //                NSLog(@"Image size is now %@",NSStringFromCGSize(currImg.size));
                }
                
                [emojiButton setImage:currImg forState:UIControlStateNormal];
                [self.keyboard.emoji_scrollview addSubview:emojiButton];
            }
        }
    }
}

- (void)bottombtninit
{
    [category_dictionary removeAllObjects];
    int index = 0;
    for(UIButton *bottomButton in self.keyboard.category_scrollview.subviews)
    {
        index = (int)(bottomButton.tag);
        switch (index) {
            case 0:
                [bottomButton setImage:[UIImage imageNamed:@"recent_normal.png"] forState:UIControlStateNormal];
                
                
                break;
            case 1:
                [bottomButton setImage:[UIImage imageNamed:@"emojis_normal.png"] forState:UIControlStateNormal];
                
                break;
            case 2:
                [bottomButton setImage:[UIImage imageNamed:@"funky_gray.png"] forState:UIControlStateNormal];
                
                break;
            case 3:
                [bottomButton setImage:[UIImage imageNamed:@"gung_gray.png"] forState:UIControlStateNormal];
                
                break;
            case 4:
                [bottomButton setImage:[UIImage imageNamed:@"avant_gray.png"] forState:UIControlStateNormal];
                
                break;
            case 5:
                [bottomButton setImage:[UIImage imageNamed:@"cray_gray.png"] forState:UIControlStateNormal];
                
                break;
            default:
                
                break;
        }
    }
    [self.keyboard.txt_emoji_switchbtn setBackgroundImage:[UIImage imageNamed:@"keyboard_normal.png"] forState:UIControlStateNormal];
    
    [self.keyboard.gif_btn setBackgroundImage:[UIImage imageNamed:@"gif_normal.png"] forState:UIControlStateNormal];
}


- (void)emojibottombtnclick:(UITapGestureRecognizer *)gesture
{
    [self txtnumberkeyboardviewhide];
    [facePageControl setHidden:NO];
    
    self.keyboard.pastelbl.hidden = YES;
    self.keyboard.pastelbl.text = @"Paste the emoji in your message!";
    [self bottombtninit];
    [category_dictionary removeAllObjects];
    int btnindex = (int)(gesture.view.tag);
    UIButton*bottomButton = (UIButton*)gesture.view;
    switch (btnindex) {
        case 0:
        {
            _faceMap = nil;
            category_itemarray = itemclickedarray;
            [bottomButton setImage:[UIImage imageNamed:@"recent_active.png"] forState:UIControlStateNormal];
            self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
        }
            break;
        case 1:
        {
            
            if([sharedDefaults boolForKey:@"CATEGORY1"])
            {
                
                _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"All"
                                                            ofType:@"plist"]];
                [category_dictionary addEntriesFromDictionary:_faceMap];
                [bottomButton setImage:[UIImage imageNamed:@"emoji_active.png"] forState:UIControlStateNormal];
                self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
            }
            else
            {
                
                _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"Freebies"
                                                            ofType:@"plist"]];
                [category_dictionary addEntriesFromDictionary:_faceMap];
                [bottomButton setImage:[UIImage imageNamed:@"emoji_active.png"] forState:UIControlStateNormal];
                self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
            }
        }
            break;
        case 2:
        {
            if([sharedDefaults boolForKey:@"CATEGORY1"])
            {
                _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"Rampage"
                                                            ofType:@"plist"]];
                [category_dictionary addEntriesFromDictionary:_faceMap];
                self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
            }
            else
            {
                self.keyboard.pastelbl.hidden = NO;
                self.keyboard.pastelbl.text = @"Please purchase emojis now.";
                [category_dictionary removeAllObjects];
                self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
            }
            [bottomButton setImage:[UIImage imageNamed:@"emoji_active.png"] forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            if([sharedDefaults boolForKey:@"CATEGORY2"])
            {
                
                _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"GungHo"
                                                            ofType:@"plist"]];
                [category_dictionary addEntriesFromDictionary:_faceMap];
                self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
            }
            else
            {
                self.keyboard.pastelbl.hidden = NO;
                self.keyboard.pastelbl.text = @"Please purchase emojis now.";
                [category_dictionary removeAllObjects];
                self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
            }
            [bottomButton setImage:[UIImage imageNamed:@"gung.png"] forState:UIControlStateNormal];
            
        }
            break;
        case 4:
        {
            if([sharedDefaults boolForKey:@"CATEGORY3"])
            {
                _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"AvantGarde"
                                                            ofType:@"plist"]];
                [category_dictionary addEntriesFromDictionary:_faceMap];
                self.keyboard.emoji_scrollview.hidden = NO;self.keyboard.collectionView.hidden = YES;
            }
            else
            {
                self.keyboard.pastelbl.hidden = NO;
                self.keyboard.pastelbl.text = @"Please purchase emojis now.";
                [category_dictionary removeAllObjects];
                self.keyboard.emoji_scrollview.hidden = NO;
                self.keyboard.collectionView.hidden = YES;
            }
            [bottomButton setImage:[UIImage imageNamed:@"avant.png"] forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            if([sharedDefaults boolForKey:@"CATEGORY4"])
            {
                _faceMap = [NSDictionary dictionaryWithContentsOfFile:
                            [[NSBundle mainBundle] pathForResource:@"CrayCray"
                                                            ofType:@"plist"]];
                [category_dictionary addEntriesFromDictionary:_faceMap];
                self.keyboard.emoji_scrollview.hidden = NO;
                self.keyboard.collectionView.hidden = YES;
            }
            else
            {
                self.keyboard.pastelbl.hidden = NO;
                self.keyboard.pastelbl.text = @"Please purchase emojis now.";
                [category_dictionary removeAllObjects];
                self.keyboard.emoji_scrollview.hidden = NO;
                self.keyboard.collectionView.hidden = YES;
            }
            [bottomButton setImage:[UIImage imageNamed:@"cray.png"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    for(UIButton *btn in self.keyboard.emoji_scrollview.subviews)
        [btn removeFromSuperview];
    
    [self categorysettings:btnindex];
    AudioServicesPlaySystemSound(0x450);
}

- (void)sameitemcheck:(NSString *)itemname
{
    int check_index = -1;
    for(int i=0; i<itemclickedarray.count; i++)
    {
        NSString *item = [itemclickedarray objectAtIndex:i];
        if([item isEqualToString:itemname])
        {
            check_index = i;
            break;
        }
    }
    if(check_index>-1)
    {
        [itemclickedarray removeObjectAtIndex:check_index];
        [itemclickedarray insertObject:itemname atIndex:0];
        if(itemclickedarray.count>42)
            [itemclickedarray removeLastObject];
    }
    else
    {
        [itemclickedarray insertObject:itemname atIndex:0];
        if(itemclickedarray.count>42)
            [itemclickedarray removeLastObject];
    }
    [[NSUserDefaults standardUserDefaults] setObject:itemclickedarray forKey:@"RecentedEmoji"];
}


- (void)emojibtnclick:(id)sender
{
    int i = (int)((UIButton*)sender).tag;
    if(!self.keyboard.pastelbl.hidden)
    {
        [self.keyboard.pastelbl setHidden:YES];
        [pastelbltimer invalidate];
        pastelbltimer = nil;
    }
    else
    {
        [self.keyboard.pastelbl setHidden:NO];
        pastelbltimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pastelblhide:) userInfo:nil repeats:NO];
    }
    
    NSString *emoji_name = [NSString stringWithFormat:@"%.3d",i];
    [self sameitemcheck:emoji_name];
    
    UIImage *mergedImage = [UIImage imageNamed:[category_all_dictionary objectForKey:[NSString stringWithFormat:@"%.3d",i]]];
    mergedImage = [self image:mergedImage scaledToWidth:64];
    NSData *pngData = UIImagePNGRepresentation(mergedImage);
    [[UIPasteboard generalPasteboard] setData:pngData forPasteboardType:@"public.png"];
}

- (void)pastelblhide:(NSTimer *)timer
{
    [self.keyboard.pastelbl setHidden:YES];
    [timer invalidate];
    timer = nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.keyboard.emoji_scrollview.frame.size.width;
    int page = floor((self.keyboard.emoji_scrollview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    facePageControl.currentPage = page;
}


-(void)spaceButtonTapped{
    [self.textDocumentProxy insertText:@" "];
    AudioServicesPlaySystemSound(0x450);
}



- (IBAction) pressDeleteKey:(id)sender{
    [self.textDocumentProxy deleteBackward];
    AudioServicesPlaySystemSound(0x450);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

- (UIImage*)image:(UIImage *)sourceImage scaledToWidth:(float) i_width
{
    float oldWidth = sourceImage.size.width;
    float oldHeight = sourceImage.size.height;
    //    float imgHeight = imagePreview.frame.size.height * 2;
    float scaleFactor = i_width / oldWidth;
    float newHeight = oldHeight * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, 0.0f);
    //    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (IBAction)txtnumberswitch:(id)sender
{
    self.keyboard.collectionView.hidden = YES;
    
    AudioServicesPlaySystemSound(0x450);
    
    [self bottombtninit];
    [facePageControl setHidden:YES];
    [self txtnumberkeyboardviewhide];
    if(sender == self.keyboard.number_swtichbtn)
    {
        [self.keyboard.number_keyboardview setHidden:NO];
        txt_number_keyboardflag = FALSE;
    }
    else if(sender == self.keyboard.txt_swtichbtn)
    {
        [self.keyboard.text_keyboardview setHidden:NO];
        txt_number_keyboardflag = TRUE;
    }
    else
    {
        if(txt_number_keyboardflag)
            [self.keyboard.text_keyboardview setHidden:NO];
        else
            [self.keyboard.number_keyboardview setHidden:NO];
        
        [self.keyboard.txt_emoji_switchbtn setBackgroundImage:[UIImage imageNamed:@"keyboard_active.png"] forState:UIControlStateNormal];
        
    }
}

-(void)upperlowerswitch:(id)sender
{
    if(!upper_lower_switchflag)
        [self.keyboard.uppper_lower_btn setBackgroundImage:[UIImage imageNamed:@"upload-hightlight.png"] forState:UIControlStateNormal];
    else
        [self.keyboard.uppper_lower_btn setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    upper_lower_switchflag = !upper_lower_switchflag;
}

- (void)txtnumberkeyboardviewhide
{
    [self.keyboard.text_keyboardview setHidden:YES];
    [self.keyboard.number_keyboardview setHidden:YES];
}

- (IBAction)gifBtnClkd:(id)sender;{
    
    [self txtnumberkeyboardviewhide];
    self.keyboard.emoji_scrollview.hidden = YES;
    self.keyboard.collectionView.hidden = NO;
    [self bottombtninit];
    [facePageControl setHidden:YES];
    
    [UIView animateWithDuration:0.2 animations:^(void) {
        
        self.keyboard.collectionView.alpha = 1;
        
        if(!gif_switchflag)
        {  [self.keyboard.gif_btn setBackgroundImage:[UIImage imageNamed:@"gif_active.png"] forState:UIControlStateNormal];
            gif_switchflag = true;
            
        }
        else
        {    [self.keyboard.gif_btn setBackgroundImage:[UIImage imageNamed:@"gif_normal.png"] forState:UIControlStateNormal];
            gif_switchflag = false;
        }
        gif_switchflag = !gif_switchflag;
    }];
    
    
    
}
@end
