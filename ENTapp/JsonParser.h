//
//  JsonParser.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 26.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

+ (NSDictionary *) parseJsonFormMainBundleFile: (NSString *)folderName fileName:(NSString *) filename fileType:(NSString *) fileType;
+ (NSDictionary *) parseJsonFormDocumentsFolderFile:(NSString *) filePathFromDocumentsFolder;
+ (NSDictionary *) parseJsonFromData:(NSData *) data;

@end
