//
//  NetworkController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 06.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkControllerDelegate.h"
#import "FilesUtility.h"

static NSString *urlString = @"http://212.48.64.187:9000/file/";

@interface NetworkController : NSObject<NSURLConnectionDelegate>

@property (strong, nonatomic) id<NetworkControllerDelegate> delegate;

- (void)sendRequest:(NSString *)url data:(NSData *) requestData;
- (BOOL)sendJsonRequest:(NSString*)httpMethod requestData:(NSData*)requestData requestUrl:(NSString*)requestUrl targetObject:(NSObject *)targetObject callbackSelector:(SEL)callbackSelector;

- (NSDictionary *) parseResponseData:(NSData *)data;

+ (NSString *)urlString;

@end
