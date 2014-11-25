//
//  PurchaseNetworkController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 20.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "PurchaseNetworkController.h"
#import "JSONKit.h"
#import "LocalizationSystem.h"

@implementation PurchaseNetworkController

@synthesize purchaseNetworkDelegate;
@synthesize fileUtility;
@synthesize language;
@synthesize subject;
@synthesize zipFilePath;
@synthesize requestData;

- (PurchaseNetworkController *) init{
    self = [super init];
    [super setDelegate:self];
    return self;
}

- (void) getFileSize:(NSMutableDictionary *) json{
    language = [json objectForKey:@"language"];
    subject = [json objectForKey:@"subject"];
    
    NSString* jsonString = [json JSONString];
    requestData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@/", [NetworkController urlString], @"get_size"];
    [super sendJsonRequest:@"POST" requestData:requestData requestUrl:url targetObject:self callbackSelector:@selector(receivedDataGetFileSize:)];
}

- (void) receivedDataGetFileSize: (NSData *) data{
    NSDictionary *json = [super parseResponseData:data];
    NSLog(@"THE JSON IS %@", json);
    if(json && json != nil){
        NSLog(@"Did RECEIVE json!!!");
        int error = (int)[json objectForKey:@"error"];
        
        if(error == 0){
            //TODO say that error has occured
        } else {
            int size = [[json objectForKey:@"size"] intValue];
            NSLog(@"Total size is: %i", size);
            if([purchaseNetworkDelegate respondsToSelector:@selector(didReceiveTotalSize:)]){
                [purchaseNetworkDelegate didReceiveTotalSize:size];
            }
        }
    }
}

- (void) getFile {
    NSLog(@"perfoeming selector");
    NSString *folderNameToBeCreated = [NSString stringWithFormat:@"%@_%@", language, subject];
    fileUtility = [[FilesUtility alloc] init];
    [fileUtility initFolderToUnzip:folderNameToBeCreated];
    [self sendRequest:[NetworkController urlString] data:requestData];
}

- (void) didReceiveResponse:(NSURLResponse *)response {
    
}

- (void) didReceiveData:(NSData *)data {
    NSLog(@"Did not receive json!!!");
    [fileUtility writeDataZipToFile:data];
    if([purchaseNetworkDelegate respondsToSelector:@selector(didReceiveData:)]){
        [purchaseNetworkDelegate didReceiveData:data.length];
    }
}

- (void) didFailWithError:(NSError *)error {
	NSString *string = [NSString stringWithFormat:@"Purchase Network Cotroller => Connection failed: %@", [error description]];
    NSLog(@"%@",string);
    
    NSString *message = AMLocalizedString(@"Could not connect to the server.", @"");
    
    if([error code] == -1004){
        message = AMLocalizedString(@"Could not connect to the server.", @"");
    }
    
    if([purchaseNetworkDelegate respondsToSelector:@selector(errorOccured:)]){
        [purchaseNetworkDelegate errorOccured:message];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Finished loading...");
    
    [fileUtility unzipTheFile];
    
    if([purchaseNetworkDelegate respondsToSelector:@selector(didFinishLoadingData)]){
        [purchaseNetworkDelegate didFinishLoadingData];
    }
}

@end
