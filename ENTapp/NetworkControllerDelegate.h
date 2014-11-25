//
//  NetworkControllerDelegate.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 06.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkControllerDelegate <NSObject>

- (void) connectionDidFinishLoading:(NSURLConnection *)connection ;

- (void) didReceiveResponse:(NSURLResponse *)response;

- (void) didReceiveData:(NSData *)data;

- (void) didFailWithError:(NSError *)error;

@end
