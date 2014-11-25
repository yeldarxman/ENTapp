//
//  TopicSelectionTableViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 24.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TopicSelectionTableViewController.h"

@interface TopicSelectionTableViewController ()

@end

@implementation TopicSelectionTableViewController

@synthesize selectedTopic;
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
    [[[self.navigationController.viewControllers objectAtIndex:1] navigationItem] setTitle:subject];
    [self loadTopicNames];
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
    return [topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ReadTopicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.textLabel setText:[topics objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedTopic = [topics objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"topicSelected" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"topicSelected"]){
        UINavigationController *navigationController = segue.destinationViewController;
        PageViewController *tempTarget = [[navigationController childViewControllers] objectAtIndex:0];
        [tempTarget setTopic:selectedTopic];
    }
}

#pragma mark - data manipulation methods
-(void) loadTopicNames{
    topics = [[NSMutableArray alloc] init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *selectedLanguage = [prefs stringForKey:@"SelectedLanguage"];
    
    NSDictionary *topicDictionary = [JsonParser parseJsonFormMainBundleFile:@"" fileName:[NSString stringWithFormat:@"%@_Read_Subjects", selectedLanguage] fileType:@""];
    
    NSArray *subjects = [topicDictionary objectForKey:@"Subjects"];
    
    NSLog(@"subjects %@", [topicDictionary objectForKey:@"Subjects"]);
    
    for(int i = 0;  i < [subjects count]; i++){
        if([subject isEqualToString:[[subjects objectAtIndex:i] objectForKey:@"subjectName"]]){
            NSArray *topicsArray = [[subjects objectAtIndex:i] objectForKey:@"Topics"];
            
            for(int j = 0; j < [topicsArray count]; j++){
                NSLog(@"eeee %@", [topicsArray objectAtIndex:j]);
                [topics addObject:[[topicsArray objectAtIndex:j] objectForKey:@"topicName"]];
            }
        }
    }
}

@end












