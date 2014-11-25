//
//  JsonParser.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 26.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "JsonParser.h"
#import "JSONKit.h"

@implementation JsonParser

+ (NSDictionary *) parseJsonFormMainBundleFile: (NSString *)folderName fileName:(NSString *) filename fileType:(NSString *) fileType {
    NSString *mainBundleFilePath = [[NSBundle mainBundle] pathForResource: filename ofType: fileType];
    
    if (mainBundleFilePath) {
        NSError *error;
        NSString* topicsText = [NSString stringWithContentsOfFile:mainBundleFilePath encoding:NSUTF8StringEncoding error:&error];
        
        NSLog(@"JSON is %@", topicsText);
        
        JSONDecoder* decoder = [[JSONDecoder alloc] init];
        NSDictionary *resultsDictionary = [decoder objectWithData: [topicsText dataUsingEncoding:NSUTF8StringEncoding]];
        
        return resultsDictionary;
    } else {
        //try to open the file from the documents folder
        NSString *absolutePath = folderName;
        absolutePath = [absolutePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", filename, fileType]];
        NSDictionary *resultsDictionary = [self parseJsonFormDocumentsFolderFile:absolutePath];
        
        return resultsDictionary;
    }
    
    return nil;
}

+ (NSDictionary *) parseJsonFormDocumentsFolderFile:(NSString *) filePathFromDocumentsFolder{
    //point to documents folder
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:filePathFromDocumentsFolder];
    
    if (filePath) {
        NSError *error;
        NSString* jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        
        NSLog(@"JSON is %@", jsonString);
        
        JSONDecoder* decoder = [[JSONDecoder alloc] init];
        NSDictionary *resultsDictionary = [decoder objectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        
        return resultsDictionary;
    } else {
        NSLog(@"File not found");
    }
    
    return nil;
}

+ (NSDictionary *) parseJsonFromData:(NSData *) data {
    JSONDecoder* decoder = [[JSONDecoder alloc] init];
    NSDictionary *resultsDictionary = [decoder objectWithData: data];

    return resultsDictionary;
}

@end
