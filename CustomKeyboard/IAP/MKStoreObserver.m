//
//  MKStoreObserver.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//

#import "MKStoreObserver.h"
#import "MKStoreManager.h"
#import "Constant.h"

static MKStoreObserver* _sharedObject = nil;
NSString *const MKStoreObserverProductPurchasedNotification = @"MKStoreObserverProductPurchasedNotification";
@implementation MKStoreObserver
@synthesize arrayRet;
@synthesize FlashLevel,EMLevel,SALevel,TFLevel;


+ (id)sharedObject {
    @synchronized(self) {
        if (_sharedObject == nil) {
            _sharedObject = [[self alloc] init];
        }
    }
    return _sharedObject;
}


- (NSString *)dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}



- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch (transaction.transactionState) {
                
   			case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"------success");
                [self completeTransaction:transaction];
            }
                break;
				
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"-------failed");
                [self failedTransaction:transaction];
            }
                break;
				
            case SKPaymentTransactionStateRestored:
            {
				NSLog(@"-------restored");
                [self restoreTransaction:transaction];
            }
				break;
            default:
				
                break;
		}
	}
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    NSUserDefaults *userdefalts = [NSUserDefaults standardUserDefaults];
    [userdefalts setBool:true forKey:@"purchaseflage"];
    [userdefalts synchronize];
    if (transaction.error.code == SKErrorPaymentCancelled )
    {
		NSLog(@"cancelled");
	}
    
	if (transaction.error.code == SKErrorPaymentNotAllowed ) {
		NSLog(@"pay not allowd");
	}
	
	if (transaction.error.code == SKErrorPaymentInvalid ) {
		NSLog(@"invalid");
	}
    
    if (transaction.error.code == SKErrorClientInvalid ) {
		NSLog(@"SKErrorClientInvalid");
	}
	
	if (transaction.error.code == SKErrorUnknown ) {
		NSLog(@"SKErrorUnknown");
	}
    
	if (transaction.error.code == SKErrorStoreProductNotAvailable ) {
		NSLog(@"SKErrorStoreProductNotAvailable");
	}
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed",@"") message:NSLocalizedString(@"Purchase Failed. Please try again.",@"")
                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles: nil];
    [alert show];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [[NSNotificationCenter defaultCenter]postNotificationName:IAPNOTIFICATION object:nil userInfo:nil];
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"HUDHIDE" object:nil userInfo:nil];
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"test_purchase=%@",transaction.payment.productIdentifier);
    
    [self provideContent: transaction.payment.productIdentifier shouldSerialize:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SUCCESSFUL",@"") message:NSLocalizedString(@"Purchase successful. Thank you.",@"")
                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles: nil];
    [alert show];

    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    
        NSUserDefaults *userdefalts = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
        [userdefalts setBool:true forKey:@"CATEGORY1"];
  
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    isRestoring = YES;
    [self provideContent: transaction.originalTransaction.payment.productIdentifier shouldSerialize:YES];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [[NSNotificationCenter defaultCenter]postNotificationName:IAPNOTIFICATION object:nil userInfo:nil];
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    isRestoring = YES;
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        NSString *productID = transaction.payment.productIdentifier;
        [self provideContent:productID shouldSerialize:YES];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:IAPRESTORENOTIFICATION object:nil userInfo:nil];
}

-(void) provideContent: (NSString*)productIdentifier shouldSerialize: (BOOL) serialize
{
    if(serialize)
    {
        NSUserDefaults *userdefalts = [[NSUserDefaults alloc] initWithSuiteName:@"group.keygoard"];
        
        [userdefalts setBool:true forKey:@"CATEGORY1"];
        
        if([productIdentifier isEqualToString:FUNKYFRESH_IAP])
            [userdefalts setBool:true forKey:@"CATEGORY1"];
        else if([productIdentifier isEqualToString:CRAYCRAY_IAP])
            [userdefalts setBool:true forKey:@"CATEGORY2"];
        else if([productIdentifier isEqualToString:GUNGHO_IAP])
            [userdefalts setBool:true forKey:@"CATEGORY3"];
        else if([productIdentifier isEqualToString:AVANTGARDE_IAP])
            [userdefalts setBool:true forKey:@"CATEGORY4"];
        
    
        [userdefalts synchronize];
       
        [[NSNotificationCenter defaultCenter]postNotificationName:IAPNOTIFICATION object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HUDHIDE" object:nil userInfo:nil];
    }
    
}


@end
