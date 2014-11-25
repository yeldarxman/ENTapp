//
//  PurchaseSpecificViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "PurchaseSpecificViewController.h"
#import "NetworkController.h"
#import "JSONKit.h"
#import "LocalizationSystem.h"
#import "CoreData.h"
#import "Constants.h"

@interface PurchaseSpecificViewController ()

@end

@implementation PurchaseSpecificViewController

@synthesize codeTextField;
@synthesize downloadButton;
@synthesize progressBar;
@synthesize explanationTextLabel;
@synthesize purchaseTitle;
@synthesize subject;
@synthesize totalSize;
@synthesize currentSize;
@synthesize network;
@synthesize downloadingLabel;
@synthesize downloadProgressLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //hide the progress bar and the download detail labels until the download starts
    progressBar.alpha = 0.0;
    [progressBar setProgress: 0.0];
    
    [downloadingLabel setAlpha:0.0];
    [downloadProgressLabel setAlpha:0.0];
}

- (void)viewWillAppear:(BOOL)animated{
}

-(IBAction)downloadButtonPressed:(id)sender {
    network = [[PurchaseNetworkController alloc] init];
    [network setPurchaseNetworkDelegate:self];
    NSLog(@"Sending request");
    NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    [nameElements setObject:@"6933624" forKey:@"code"];
    [nameElements setObject:@"kk" forKey:@"language"];
    [nameElements setObject:@"Маth" forKey:@"subject"];
    
    [network getFileSize:nameElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAlertView:(NSString *)title message:(NSString *) message{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    });
}

#pragma mark PurchaseNetworkContorllerDelegate methods
- (void) didFinishLoadingData{
    NSFileManager *fileManager = [[NSFileManager  alloc] init];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderName = [NSString stringWithFormat:@"%@_%@", subject.language, subject.subjectName];
    documentsPath = [documentsPath stringByAppendingPathComponent:folderName];
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:documentsPath];
    
    NSEntityDescription *testEntity = [NSEntityDescription entityForName:@"Test"
                                                  inManagedObjectContext:[CoreData managedObjectContext]];
    
    int counter = 6;
    // just to print out the names
    for (NSString *filename in fileEnumerator) {
        if ([filename hasSuffix:@".pdf"] || [filename hasSuffix:@".txt"]){
            Test *test = [[Test alloc] initWithEntity:testEntity insertIntoManagedObjectContext:[CoreData managedObjectContext]];
            NSString *testName = [NSString stringWithFormat:@"%i - %@", counter, AMLocalizedString(@"Variant", @"")];
            [test setTestName:testName];
            //[[subject variant] addConsistsOfObject:test];
            counter++;
            NSLog(@"Test is: %@", [filename substringToIndex:[filename length] - 4]);
        }
        
        //save the modifications
        [CoreData saveContext];
        
        //update the flag in the NSUserDefaults
        NSString *temp = [NSString stringWithFormat:@"%@_%@_Purchased", [subject language], [subject subjectName]];
        NSLog(@"%@ is YES", temp);
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:temp];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank You!" message:@"Thank you for purchasing tests!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void) didReceiveTotalSize:(int) size{
    NSLog(@"PURCHASE size is %i", size);
    totalSize = size;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.7
                              delay:0.3
                            options: UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             downloadButton.alpha = 0.0;
                             progressBar.alpha = 1.0;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                             [network getFile];
                         }];
    });
}

- (void) didReceiveData:(int)size {
    currentSize += size;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.6
                              delay:0.1
                            options: UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             [progressBar setProgress:(currentSize/totalSize)];
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    });
}

- (void)errorOccured:(NSString*) errorMessage{
    [self showAlertView:AMLocalizedString(@"Connection error!", @"") message:errorMessage];
}

#pragma mark UIAlertView methods
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
