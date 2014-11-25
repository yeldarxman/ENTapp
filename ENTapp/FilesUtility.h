//
//  FilesUtility.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 20.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipFile.h"
#import "FileInZipInfo.h"
#import "ZipReadStream.h"
#import "PDFUtility.h"

@interface FilesUtility : NSObject

@property (strong, nonatomic) NSString *folderToUnzip;
@property (strong, nonatomic) NSString *zipFilePath;
@property (strong, nonatomic) NSString *documentsPath;
@property (strong, nonatomic) NSFileManager *fileManager;


- (void) initFolderToUnzip:(NSString *) folderName;
- (void) writeDataZipToFile:(NSData *) data;
- (BOOL) unzipTheFile;

@end
