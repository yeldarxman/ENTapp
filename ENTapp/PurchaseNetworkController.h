//
//  PurchaseNetworkController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 20.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilesUtility.h"
#import "PurchaseNetworkControllerDelegate.h"
#import "NetworkControllerDelegate.h"
#import "NetworkController.h"

@interface PurchaseNetworkController : NetworkController <NetworkControllerDelegate>

@property (strong, nonatomic) id<PurchaseNetworkControllerDelegate> purchaseNetworkDelegate;
@property (strong, nonatomic) FilesUtility *fileUtility;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *zipFilePath;
@property (strong, nonatomic) NSData *requestData;


- (void) getFileSize:(NSMutableDictionary *) json;
- (void) getFile;

@end
