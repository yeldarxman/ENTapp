//
//  LanguageSelectionViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 22.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "LanguageSelectionViewController.h"

@interface LanguageSelectionViewController ()

@end

@implementation LanguageSelectionViewController

@synthesize kazakhButton;
@synthesize russianButton;
@synthesize imageBackground;

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
    [self.imageBackground setImage:[[UIImage imageNamed:@"language_selection_background.png"] stretchableImageWithLeftCapWidth:320.0 topCapHeight:480.0]];
    //[self.view addSubview:kazakhButton];
    //[self.view addSubview:russianButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)kazakhButtonPressed:(id)sender {
    LocalizationSetLanguage(@"kk");
    [[NSUserDefaults standardUserDefaults] setObject:@"kk" forKey:@"SelectedLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"GoToTabs" sender:self];
}

- (IBAction)russianButtonPressed:(id)sender {
    LocalizationSetLanguage(@"ru");
    [[NSUserDefaults standardUserDefaults] setObject:@"ru" forKey:@"SelectedLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"GoToTabs" sender:self];
}
@end
