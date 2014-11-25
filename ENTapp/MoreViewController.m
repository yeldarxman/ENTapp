//
//  MoreViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 22.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize selectedLanguage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *language = [prefs stringForKey:@"SelectedLanguage"];
    
    if(![selectedLanguage isEqualToString:language]){
        selectedLanguage = language;
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[self.navigationController.viewControllers objectAtIndex:0] navigationItem] setTitle:AMLocalizedString(@"More", @"")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch(section){
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"MoreViewCell";
    MoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:{
            if(indexPath.row == 0){
                [cell.textLabel setText:AMLocalizedString(@"Clear my progress", @"progress text")];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            } else {
                [cell.textLabel setText:AMLocalizedString(@"Change language", @"language text")];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            break;
        }
        case 1:{
            [cell.textLabel setText:AMLocalizedString(@"About us", @"about us text")];
            //[cell.textLabel setText:@"\u221C 245"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        }
        default:{
            break;
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                [self showActionSheet];
            } else {
                [self performSegueWithIdentifier:@"ChangeLanguage" sender:self];
            }
            break;
        case 1:
            
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Action sheet methods
//Your delegate for pressed buttons.
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self resetProgress];
            break;
        default:
            break;
    }
}

-(void)showActionSheet
{
    NSString *actionSheetTitle =
    AMLocalizedString(@"Are you sure that you want to reset your progress?", @"");
    
    UIActionSheet *menu = [[UIActionSheet alloc]
                            initWithTitle: actionSheetTitle
                            delegate:self
                            cancelButtonTitle:AMLocalizedString(@"No", @"")
                            destructiveButtonTitle:AMLocalizedString(@"Yes", @"")
                            otherButtonTitles:nil];
    [menu showFromTabBar:self.tabBarController.tabBar];
}

- (void) resetProgress {
    NSManagedObjectContext *context = [CoreData managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Subject"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language == %@", [self selectedLanguage]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *subjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for(Subject *subject in subjects){
        for(Test *test in [[subject consistsOf] allObjects]){
            [test setCorrectAnswers:[NSNumber numberWithInt:0]];
            [test setWrongAnswers:[NSNumber numberWithInt:0]];
        }
    }
    
    [CoreData saveContext];
}

@end
