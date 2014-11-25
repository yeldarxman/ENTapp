//
//  TestsTopicSelectionViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestsTopicSelectionViewController.h"
#import "LocalizationSystem.h"

@interface TestsTopicSelectionViewController ()

@end

@implementation TestsTopicSelectionViewController

@synthesize subject;
@synthesize topics;

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
    [[[self.navigationController.viewControllers objectAtIndex:1] navigationItem] setTitle:AMLocalizedString(@"Topics", @"")];
    [self updateTopicsArray];
}

- (void) viewWillAppear:(BOOL)animated{
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
    switch (section) {
        case 0:
            return 1;
            break;
            
        default:
            return [topics count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"TopicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            //[[cell textLabel] setText:[[subject variant] topicName]];
            //[[cell detailTextLabel] setText: [NSString stringWithFormat:@"%.1f %%",[[subject variant] getProgress]] ];
            break;
        case 1:{
            //[[cell textLabel] setText:[[topics objectAtIndex:indexPath.row] topicName]];
            //[[cell detailTextLabel] setText: [NSString stringWithFormat:@"%.1f %%",[[topics objectAtIndex:indexPath.row] getProgress]] ];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return AMLocalizedString(@"Mixed", @"");
            break;
            
        default:
            return AMLocalizedString(@"Separate", @"");
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            //selectedTopic = [subject variant];
            break;
        case 1:
            //selectedTopic = [topics objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    [self performSegueWithIdentifier:@"topicSelected" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"topicSelected"]){
        TestsTestSelectionViewController *tempTarget = segue.destinationViewController;
        //[tempTarget setTopic:selectedTopic];
        [tempTarget setSubject:subject];
    }
}

#pragma mark - Data manipulation methods
-(void)updateTopicsArray{
    topics = [[NSMutableArray alloc] init];
    //NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    //NSArray *sortedArray = [[[subject consistsOf] allObjects] sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    //[topics addObjectsFromArray:sortedArray ];
}

@end





