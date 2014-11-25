//
//  PurchaseSpecificViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"
#import "Test.h"
#import "PurchaseNetworkController.h"
#import "PurchaseNetworkControllerDelegate.h"

@interface PurchaseSpecificViewController : UIViewController<PurchaseNetworkControllerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *explanationTextLabel;
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *downloadButton;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UILabel *downloadingLabel;
@property (strong, nonatomic) IBOutlet UILabel *downloadProgressLabel;
@property (strong, nonatomic) Subject *subject;
@property (strong, nonatomic) PurchaseNetworkController *network;

@property (strong, nonatomic) NSString *explanationText;
@property (strong, nonatomic) NSString *purchaseTitle;
@property float totalSize;
@property float currentSize;

-(IBAction)downloadButtonPressed:(id)sender;

@end
