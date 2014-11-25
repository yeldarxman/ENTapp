//
//  PurchaseNetworkControllerDelegate.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 20.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PurchaseNetworkControllerDelegate <NSObject>

- (void) didFinishLoadingData;
- (void) didReceiveTotalSize:(int) size;
- (void) didReceiveData:(int) size;
- (void) errorOccured:(NSString  *) errorMessage;

@end
