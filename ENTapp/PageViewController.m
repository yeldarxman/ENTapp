//
//  PageVIewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 27.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController

@synthesize pageContent;
@synthesize pageController;
@synthesize containerView;
@synthesize doneButton;
@synthesize topic;
@synthesize image;
@synthesize containerHeight;
@synthesize containerWidth;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set title of the page on the navigation controller
    [[[self.navigationController.viewControllers objectAtIndex:0] navigationItem] setTitle:topic];
    
    containerHeight = [[self containerView] frame].size.height;
    containerWidth = [[self containerView] frame].size.width;
    
    //create content pages
    [self createContentPages];
    
    NSDictionary *options =
    [NSDictionary dictionaryWithObject:
     [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                forKey: UIPageViewControllerOptionSpineLocationKey];
    
    self.pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options: options];
    
    pageController.dataSource = self;
    pageController.delegate = self;
    [[pageController view] setFrame:[[self containerView] bounds]];
    
    PageChildViewController *initialViewController =
    [self viewControllerAtIndex:0];
    NSArray *viewControllers =
    [NSArray arrayWithObject:initialViewController];
    
    [pageController setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:YES
                            completion:nil];
    if([[self childViewControllers] count] > 0){
        [[[self childViewControllers] objectAtIndex:0] removeFromParentViewController];
    }
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
    
    //customize done button
    [doneButton setTitle:AMLocalizedString(@"Done",@"")];
}

- (void) createContentPages
{
    NSURL *pdfFile = [[NSBundle mainBundle]
                      URLForResource: @"test 2" withExtension:@"pdf"];
    [self readPDFFile: pdfFile];
}

- (PageChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) ||
        (index >= [self.pageContent count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    PageChildViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"PageChildViewController"];
    NSLog(@"The height in page is %f", containerHeight);
    dataViewController.index = index;
    dataViewController.image = [pageContent objectAtIndex:index];
    dataViewController.height = containerHeight;
    dataViewController.width = containerWidth;
    dataViewController.navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    NSLog(@"NAVIGATION is %f", self.parentViewController.navigationController.navigationBar.frame.size.height);
    NSLog(@"Returning view controller here is %@", dataViewController);
    NSLog(@"And the text is %@", dataViewController.label.text);
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(PageChildViewController *)viewController
{
    NSLog(@"Index here is: %i", viewController.index);
    return viewController.index;
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController: (PageChildViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (PageChildViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(IBAction)donePressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

#pragma mark - PDF related stuff
- (void) readPDFFile:(NSURL *)PDFURL {
    pageContent = [[NSMutableArray alloc] init];
    //make a pdf document and point it to the url of our pdf file
    CGPDFDocumentRef pdfDocument;
    pdfDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)(PDFURL));
    
    if (pdfDocument) {
        //get page count
        int pageCount = CGPDFDocumentGetNumberOfPages (pdfDocument);
        NSLog(@"Number of pages for the PDF is: %i", pageCount);
        
        for(int i=1; i <= pageCount; i++){
            [pageContent addObject:[self getThumbForPage:pdfDocument page_number:i]];
        }
    }
}

-(UIImage *)getThumbForPage:(CGPDFDocumentRef)myDocumentRef page_number:(int)page_number{
    CGFloat width = 580.0;
    
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








