//
//  NetworkController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 06.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "NetworkController.h"
#import "JSONKit.h"
#import "JsonParser.h"

@implementation NetworkController

@synthesize delegate;

+ (NSString *)urlString{
    return urlString;
}

- (void)sendRequest:(NSString *) url data:(NSData *) requestData{
    
    NSLog(@"NetworkController => sendJsonRequest, url: %@", url);
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
	[NSURLConnection connectionWithRequest:request delegate:self];
}

- (BOOL)sendJsonRequest:(NSString*)httpMethod requestData:(NSData*)requestData requestUrl:(NSString*)requestUrl targetObject:(NSObject *)targetObject callbackSelector:(SEL)callbackSelector
{
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSLog(@"NetworkController => sendJsonRequest, url: %@", url);
    
    [request setHTTPMethod:httpMethod];
    [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: requestData];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:240];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"accept-charset"];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data != NULL && [data length] > 0) {
            if (callbackSelector != nil  && targetObject != nil)
                if([targetObject respondsToSelector:callbackSelector]){
                    //pritn the content of the data
                    NSLog(@"Data is %@:", data);
                    
                    #pragma clang diagnostic push
                    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [targetObject performSelector:callbackSelector withObject:data];
                    #pragma clang diagnostic pop
                }
        
        } else if ([data length]  == 0 && error == nil) {
            NSLog(@"NetworkController => EMPTY REPLY");
        }else if (error != nil) {
            if([delegate respondsToSelector:@selector(didFailWithError:)]){
                [delegate performSelector:@selector(didFailWithError:) withObject:error];
            }
            NSLog(@"NetworkController => Connection error: %@", error);
        }
    }];
    
    return YES;
    
}

- (NSDictionary *) parseResponseData:(NSData *)data{
    return [JsonParser parseJsonFromData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Response is: %@", response);

    NSString *fileMIMEType = [[response MIMEType] lowercaseString];
    NSLog(@"MIME is %@", fileMIMEType);
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger statusCode = [httpResponse statusCode];
    NSLog(@"Response status code is %i", statusCode);
    
    if([delegate respondsToSelector:@selector(didReceiveResponse:)]){
        [delegate didReceiveResponse:response];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"I am receiving some data...");
    
    if([delegate respondsToSelector:@selector(didReceiveData:)]) {
        [delegate didReceiveData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSString *string = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
    NSLog(@"%@",string);
    
    if([delegate respondsToSelector:@selector(didFailWithError:)]){
        [delegate didFailWithError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Finished loading...");
    
    if([delegate respondsToSelector:@selector(connectionDidFinishLoading:)]){
        [delegate connectionDidFinishLoading:connection];
    }
}

@end
