//
//  ReadTableViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 24.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "ReadTableViewController.h"
#import "LocalizationSystem.h"

@interface ReadTableViewController ()

@end

@implementation ReadTableViewController

@synthesize subjects;
@synthesize selectedSubject;
@synthesize selectedLanguage;

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
    [self loadSubjects];
    
    [[[self.navigationController.viewControllers objectAtIndex:0] navigationItem] setTitle:AMLocalizedString(@"Subjects", @"")];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    selectedLanguage = [prefs stringForKey:@"SelectedLanguage"];
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *language = [prefs stringForKey:@"SelectedLanguage"];
    
    if(![selectedLanguage isEqualToString:language]){
        selectedLanguage = language;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadSubjects];
            [self.tableView reloadData];
        });
        
        [[[self.navigationController.viewControllers objectAtIndex:0] navigationItem] setTitle:AMLocalizedString(@"Subjects", @"")];
    }
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
    NSLog(@"Subjects coutn is %i", subjects.count);
    return [subjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ReadTableViewCell";
    ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the scell...
    [cell.textLabel setText:[subjects objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedSubject = [subjects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"subjectSelected" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"subjectSelected"]){
        TopicSelectionTableViewController *tempTarget = segue.destinationViewController;
        [tempTarget setSubject:selectedSubject];
    }
}


-(void) loadSubjects{
    subjects = [[NSMutableArray alloc] init];
    [subjects addObject:AMLocalizedString(@"Math",@"")];
    [subjects addObject:AMLocalizedString(@"Physics",@"")];
    [subjects addObject:AMLocalizedString(@"Kazakh language",@"")];
    [subjects addObject:AMLocalizedString(@"Kazakhstan history",@"")];
    [subjects addObject:AMLocalizedString(@"Russian language",@"")];
    [subjects addObject:AMLocalizedString(@"English language",@"")];
}


@end
