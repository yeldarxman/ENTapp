//
//  PDFUtility.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 01.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFUtility : NSObject

+ (NSMutableArray *) readPDFFile:(NSURL *)PDFURL width:(float) width;
+ (UIImage *)getThumbForPage:(CGPDFDocumentRef)myDocumentRef page_number:(int)page_number width:(float)width;

@end
