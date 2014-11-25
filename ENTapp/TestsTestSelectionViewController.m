//
//  TestsTestSelectionViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestsTestSelectionViewController.h"
#import "LocalizationSystem.h"
#import "TestsVariantCell.h"
#import "PurchaseSpecificViewController.h"

@interface TestsTestSelectionViewController ()

@end

@implementation TestsTestSelectionViewController

@synthesize tests;
@synthesize subject;
@synthesize selectedTest;
@synthesize purchased;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[self.navigationController.viewControllers objectAtIndex:1] navigationItem] setTitle:AMLocalizedString(@"Variants", @"")];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *language = [prefs stringForKey:@"SelectedLanguage"];
    NSString *temp = [NSString stringWithFormat:@"%@_%@_Purchased", language, [subject subjectName]];
    purchased = [prefs stringForKey:temp];
    
    [self updateTestsArray];
}

-(void)viewWillAppear:(BOOL)animated{
    // check whether the flag has been changed
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *language = [prefs stringForKey:@"SelectedLanguage"];
    NSString *temp = [NSString stringWithFormat:@"%@_%@_Purchased", language, [subject subjectName]];
    NSString *tempPurchased = [prefs stringForKey:temp];
    
    NSLog(@"PURCHASED - %@", tempPurchased);
    NSLog(@"%@ is unknown", temp);
    
    if(tempPurchased && [tempPurchased isEqualToString:@"YES"] && ![tempPurchased isEqualToString:purchased]){
        purchased = tempPurchased;
        [self updateTestsArray];
    }
    
    [self.tableView reloadData];
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
    return [tests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"TestCell";
    TestsVariantCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    /*
    if( indexPath.row >= 5 && (!purchased  || [purchased isEqualToString:@"NO"]) ){
        [cell.textLabel setText:[NSString stringWithFormat:@"(6 - 30) %@", AMLocalizedString(@"Variants", @"")]];
        [cell setLocked];
        return cell;
    }*/
    
    [cell.textLabel setText:[[tests objectAtIndex:indexPath.row] testName]];
    [cell.lockImage setFrame:CGRectMake(0,0,0,0)];
    [cell.detailTextLabel setText:
     [NSString stringWithFormat:@"%@",[[tests objectAtIndex:indexPath.row] correctAnswers]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedTest = [tests objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"testSelected" sender:self];
    
    //this was thought as monitisation method
    /*
    if( indexPath.row >= 5 && (!purchased  || [purchased isEqualToString:@"NO"]) ){
        [self performSegueWithIdentifier:@"purchasePressed" sender:self];
    } else {
        [self performSegueWithIdentifier:@"testSelected" sender:self];
    }
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"testSelected"]){
        UINavigationController *navigationController = segue.destinationViewController;
        TestsMainViewController *tempTarget = [[navigationController childViewControllers] objectAtIndex:0];
        [tempTarget setSubject:subject];
        [tempTarget setTest:selectedTest];
    } else if([segue.identifier isEqualToString:@"purchasePressed"]){
        PurchaseSpecificViewController *tempTarget = segue.destinationViewController;
        [tempTarget setSubject:subject];
    }
}

#pragma mark - Data manipulation methods
-(void)updateTestsArray{
    tests = [[NSMutableArray alloc] init];
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    NSArray *sortedArray = [[[subject consistsOf] allObjects] sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    [tests addObjectsFromArray:sortedArray];
    
    /*
    if([tests count] == 5){
        NSEntityDescription *testEntity = [NSEntityDescription entityForName:@"Test"
                                                      inManagedObjectContext:[CoreData managedObjectContext]];
        Test *test = [[Test alloc] initWithEntity:testEntity insertIntoManagedObjectContext:[CoreData managedObjectContext]];
        [tests addObject:test];
    }
     */
}

@end
