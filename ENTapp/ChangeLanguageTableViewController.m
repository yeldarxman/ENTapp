//
//  ChangeLanguageTableViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 22.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "ChangeLanguageTableViewController.h"

@interface ChangeLanguageTableViewController ()

@end

@implementation ChangeLanguageTableViewController

@synthesize selectedIndex;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *language = [prefs stringForKey:@"SelectedLanguage"];
    
    
    if(language && [language isEqualToString:@"kk"]){
        selectedIndex = 0;
    }
    else {
        selectedIndex = 1;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[self.navigationController.viewControllers objectAtIndex:1] navigationItem] setTitle:AMLocalizedString(@"Change language", @"")];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChangeLanguageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            [[cell textLabel] setText:AMLocalizedString(@"Kazakh", @"language")];
            break;
        case 1:
            [[cell textLabel] setText:AMLocalizedString(@"Russian", @"language")];
            break;
        default:
            break;
    }
    
    if(selectedIndex == indexPath.row){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.2];
    
    switch (selectedIndex) {
        case 0:
            LocalizationSetLanguage(@"kk");
            [[NSUserDefaults standardUserDefaults] setObject:@"kk" forKey:@"SelectedLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        case 1:
            LocalizationSetLanguage(@"ru");
            [[NSUserDefaults standardUserDefaults] setObject:@"ru" forKey:@"SelectedLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        default:
            break;
    }
    
    [[self.parentViewController.tabBarController.tabBar.items objectAtIndex:0] setTitle:AMLocalizedString(@"Tests", @"")];
    [[self.parentViewController.tabBarController.tabBar.items objectAtIndex:1] setTitle:AMLocalizedString(@"Read", @"")];
    [[self.parentViewController.tabBarController.tabBar.items objectAtIndex:2] setTitle:AMLocalizedString(@"More", @"")];
    
    //More tab view controllers
    [[[self.navigationController.viewControllers objectAtIndex:0] navigationItem] setTitle:AMLocalizedString(@"More", @"")];
    [[[self.navigationController.viewControllers objectAtIndex:1] navigationItem] setTitle:AMLocalizedString(@"Change language", @"")];
    
    [self popViewContorllersToRoots];
}

-(void) reloadTable {
    [self.tableView reloadData];
}

-(void) popViewContorllersToRoots {
    //TestsViewController
    UINavigationController *tests = [[self.tabBarController viewControllers] objectAtIndex:0];
    [tests popToRootViewControllerAnimated:YES];
    UIEdgeInsets insets = [[[[tests childViewControllers] objectAtIndex:0] tableView] contentInset];
    NSLog(@"Edge top inset %f", insets.top);
    //insets.top = 44;
    [[[[tests childViewControllers] objectAtIndex:0] tableView] setContentInset:insets];
    [[[[tests childViewControllers] objectAtIndex:0] tableView] scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    //ReadViewController
    UINavigationController *read = [[self.tabBarController viewControllers] objectAtIndex:1];
    [read popToRootViewControllerAnimated:YES];
    UIEdgeInsets readInsets = [[[[read childViewControllers] objectAtIndex:0] tableView] contentInset];
    NSLog(@"Edge top inset %f", readInsets.top);
    //readInsets.top = 44;
    [[[[read childViewControllers] objectAtIndex:0] tableView] setContentInset:readInsets];
    [[[[read childViewControllers] objectAtIndex:0] tableView] scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

@end
