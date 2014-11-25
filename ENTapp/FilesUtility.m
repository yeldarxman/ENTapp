//
//  FilesUtility.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 20.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "FilesUtility.h"

@implementation FilesUtility

@synthesize folderToUnzip;
@synthesize zipFilePath;
@synthesize documentsPath;
@synthesize fileManager;

- (FilesUtility *) init {
    self = [super init];
    NSLog(@"Calling the initialization method of FilesUtility");
    
    // Point to Document directory
    documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // initialize the file manager
    fileManager = [NSFileManager defaultManager];
    
    return self;
}

- (void)initFolderToUnzip:(NSString *)folderName{
    folderToUnzip = [documentsPath stringByAppendingPathComponent:folderName];
    zipFilePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip", folderName]];
}

- (void) writeDataZipToFile:(NSData *) data{
    // Attempt to open the file and write the downloaded data to it
    BOOL fileExists = [fileManager fileExistsAtPath:zipFilePath];
    
    if (fileExists == NO) {
        [fileManager createFileAtPath:zipFilePath contents:nil attributes:nil];
    }
    
    // Append data to end of file
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:zipFilePath];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:data];
    [fileHandle closeFile];
}

- (BOOL) unzipTheFile {
    // I set buffer size to 2048 bytes, YMMV so feel free to adjust this
    #define BUFFER_SIZE 2048
    
    if ([fileManager fileExistsAtPath:zipFilePath]){
        NSLog(@"File %@ exists", zipFilePath);
    } else {
        NSLog(@"File %@ DOES NOT EXIST", zipFilePath);
        return NO;
    }
    
    int numberOfFilesExtracted = 0;
    
    ZipFile *unzipFile = [[ZipFile alloc] initWithFileName: zipFilePath mode:ZipFileModeUnzip];
    NSMutableData *unzipBuffer = [NSMutableData dataWithLength:BUFFER_SIZE];
    NSArray *fileArray = [unzipFile listFileInZipInfos];
    NSFileHandle *fileHandle;
    
    //create folder
    if (![fileManager fileExistsAtPath:folderToUnzip])
        [fileManager createDirectoryAtPath:folderToUnzip withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:documentsPath];
    
    // just to print out the names
    for (NSString *filename in fileEnumerator) {
        NSLog(@"File is: %@", filename);
    }
    
    [unzipFile goToFirstFileInZip];
    // For each file in the zipped file...
    for (NSString *file in fileArray) {
        // Get the file info/name, prepare the target name/path
        ZipReadStream *readStream = [unzipFile readCurrentFileInZip];
        FileInZipInfo *fileInfo = [unzipFile getCurrentFileInZipInfo];
        NSString *fileName = [fileInfo name];
        
        NSString *unzipFilePath = [folderToUnzip stringByAppendingPathComponent:fileName];
        
        if([fileName hasSuffix:@".pdf"] || [fileName hasSuffix:@".txt"]){
            numberOfFilesExtracted++;
        }
        
        // Create a file handle for writing the unzipped file contents
        if (![fileManager fileExistsAtPath:unzipFilePath]) {
            [fileManager createFileAtPath:unzipFilePath contents:nil attributes:nil];
        }
        
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:unzipFilePath];
        // Read-then-write buffered loop to conserve memory
        do {
            // Reset buffer length
            [unzipBuffer setLength:BUFFER_SIZE];
            // Expand next chunk of bytes
            int bytesRead = [readStream readDataWithBuffer:unzipBuffer];
            if (bytesRead > 0) {
                // Write what we have read
                [unzipBuffer setLength:bytesRead];
                [fileHandle writeData:unzipBuffer];
            } else
                break;
        } while (YES);
        
        [readStream finishedReading];
        [fileHandle closeFile];
        
        [unzipFile goToNextFileInZip];
    }
    
    [unzipFile close];
    
    // Also delete the zip file here to conserve disk space if applicable!
    if([fileManager removeItemAtPath:zipFilePath error:NULL] == YES){
        NSLog(@"Success in removing the zip file!!!");
    }
    
    return YES;
}

@end
