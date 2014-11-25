//
//  PDFUtility.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 01.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "PDFUtility.h"

@implementation PDFUtility

+ (NSMutableArray *) readPDFFile:(NSURL *)PDFURL width:(float) width {
    NSMutableArray *pageContent = [[NSMutableArray alloc] init];
    //make a pdf document and point it to the url of our pdf file
    CGPDFDocumentRef pdfDocument;
    pdfDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)(PDFURL));
    
    if (pdfDocument) {
        //get page count
        int pageCount = CGPDFDocumentGetNumberOfPages (pdfDocument);
        NSLog(@"Number of pages for the PDF is: %i", pageCount);
        
        for(int i=1; i <= pageCount; i++){
            [pageContent addObject:[self getThumbForPage:pdfDocument page_number:i width:width]];
        }
    }
    
    return pageContent;
}

+ (UIImage *)getThumbForPage:(CGPDFDocumentRef)myDocumentRef page_number:(int)page_number width:(float)width{
    
    // Get the page
    CGPDFPageRef myPageRef = CGPDFDocumentGetPage(myDocumentRef, page_number);
    // Changed this line for the line above which is a generic line
    //CGPDFPageRef page = [self getPage:page_number];
    
    CGRect pageRect = CGPDFPageGetBoxRect(myPageRef, kCGPDFMediaBox);
    CGFloat pdfScale = width/pageRect.size.width;
    pageRect.size = CGSizeMake(pageRect.size.width*pdfScale, pageRect.size.height*pdfScale);
    pageRect.origin = CGPointZero;
    
    
    UIGraphicsBeginImageContext(pageRect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // White BG
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context,pageRect);
    
    CGContextSaveGState(context);
    
    // ***********
    // Next 3 lines makes the rotations so that the page look in the right direction
    // ***********
    CGContextTranslateCTM(context, 0.0, pageRect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(myPageRef, kCGPDFMediaBox, pageRect, 0, true));
    
    CGContextDrawPDFPage(context, myPageRef);
    CGContextRestoreGState(context);
    
    UIImage *thm = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return thm;
    
}


@end
