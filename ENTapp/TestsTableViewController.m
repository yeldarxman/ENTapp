//
//  TestsTableViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestsTableViewController.h"
#import "CoreData.h"
#import "TestsTopicSelectionViewController.h"
#import "JsonParser.h"

@interface TestsTableViewController ()

@end

@implementation TestsTableViewController

@synthesize selectedLanguage;
@synthesize subjects;
@synthesize selectedSubject;
@synthesize progresses;

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
    //NSLog(@"Device name is : %@",[[UIDevice currentDevice] name]);
    [[self.parentViewController.tabBarController.tabBar.items objectAtIndex:0] setTitle:AMLocalizedString(@"Tests", @"")];
    [[self.parentViewController.tabBarController.tabBar.items objectAtIndex:1] setTitle:AMLocalizedString(@"Read", @"")];
    [[self.parentViewController.tabBarController.tabBar.items objectAtIndex:2] setTitle:AMLocalizedString(@"More", @"")];
    
    [[[self.navigationController.viewControllers objectAtIndex:0] navigationItem] setTitle:AMLocalizedString(@"Subjects", @"")];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    selectedLanguage = [prefs stringForKey:@"SelectedLanguage"];
    
    [self loadSubjects];
    NSLog(@"Finished loading in view did load");
}

-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *language = [prefs stringForKey:@"SelectedLanguage"];
    
    if(![selectedLanguage isEqualToString:language]){
        selectedLanguage = language;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadSubjects];
            [self.tableView reloadData];
        });
        
        [[[self.navigationController.viewControllers objectAtIndex:0] navigationItem] setTitle:AMLocalizedString(@"Subjects", @"")];
    } else {
        [self calculateProgresses];
        [self.tableView reloadData];
    }
    
    NSLog(@"First Subject is %@", [subjects objectAtIndex:0]);
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
    return [subjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"TestsTableViewCell";
    TestsTableViewCell *cell = [tableView
                                dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[TestsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell.titleLabel setText:[[subjects objectAtIndex:indexPath.row] subjectName]];
    
    NSLog(@"The progress is %f", [[progresses objectAtIndex:indexPath.row] floatValue]);
    [cell.progressView setProgress:[[progresses objectAtIndex:indexPath.row] floatValue]/100];
    [cell.percentageLabel setText:[NSString stringWithFormat:@"%.1f%%", cell.progressView.progress*100 ] ];
    
    if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Math", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"math_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Kazakh language", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"kaztil_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Kazakhstan history", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"kaz_history_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Russian language", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"russian_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"English language", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"english_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Biology", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"biology_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Geography", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"geography_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Physics", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"physics_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"Chemistry", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"chemistry_icon.png"]];
    } else if([[cell.titleLabel text] isEqualToString:AMLocalizedString(@"World history", @"")]){
        [cell.imageView setImage:[UIImage imageNamed:@"world_history_icon.png"]];
    } else {
        [cell.imageView setImage:nil];
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedSubject = [subjects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"subjectSelected" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"subjectSelected"]){
        TestsTestSelectionViewController *tempTarget = segue.destinationViewController;
        [tempTarget setSubject:selectedSubject];
    }
}

-(void) loadSubjects {
    
    //first try to fetch from database
    NSArray *array = [self fetchSubjects];
    NSLog(@"Successfully fetched the subjects");
    subjects = [[NSMutableArray alloc] init];
    NSLog(@"Array of subjects is: %@", array);
    [subjects addObjectsFromArray:array];
    
    //if the database is empty initialize them
    if([subjects  count] == 0){
        [self initializeSubjects];
        array = [self fetchSubjects];
        NSLog(@"Size of subjects array is %i", [array count]);
        [subjects addObjectsFromArray:array];
    }
    
    NSLog(@"Before calculating the progress");
    
    //then cache the progresses
    [self calculateProgresses];
    NSLog(@"Successfully calculated everything");
}

/*
 Read the subject names from 'SubjectNames' file and intializes Subject objects and saves them in the Core Data
 */
-(void) initializeSubjects {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Subject"
                                              inManagedObjectContext:[CoreData managedObjectContext]];
    NSEntityDescription *testEntity = [NSEntityDescription entityForName:@"Test"
                                                   inManagedObjectContext:[CoreData managedObjectContext]];
    
    NSDictionary *subjectDictionary = nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SubjectNames" ofType:@""];
    if (filePath) {
        NSError *error;
        NSString* subjectsText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        
        if (subjectsText) {
            NSArray *allLines = [subjectsText componentsSeparatedByString: @"\n"];
            
            for(int i = 0; i < [allLines count]; i++){
                NSLog(@"Subject name is %@", [allLines objectAtIndex:i]);
                NSString *folderPath = [NSString stringWithFormat:@"%@_%@", selectedLanguage,
                                                                            AMLocalizedString([allLines objectAtIndex:i], @"")];
                subjectDictionary = [JsonParser parseJsonFormMainBundleFile: folderPath fileName:[NSString stringWithFormat:@"%@_%@", selectedLanguage, AMLocalizedString([allLines objectAtIndex:i], @"")] fileType:@""];
                Subject *subject = [[Subject alloc] initWithEntity:entity insertIntoManagedObjectContext:[CoreData managedObjectContext]];
                subject.language = selectedLanguage;
                [subject setSubjectName:AMLocalizedString([allLines objectAtIndex:i], @"")];
                
                // adding topics
                //topics = [subjectDictionary objectForKey:@"Topics"];
                /*
                for (NSDictionary *topic in topics) {
                    Topic *tempTopic = [[Topic alloc] initWithEntity:
                                        variantEntity insertIntoManagedObjectContext:[CoreData managedObjectContext]];
                    [tempTopic setTopicName:[topic objectForKey:@"variantName"]];
                    int numberOfTests = [[topic objectForKey:@"variantTests"] intValue];
                    
                    for(int i=0; i<numberOfTests; i++){
                        Test *test = [[Test alloc] initWithEntity:testEntity insertIntoManagedObjectContext:[CoreData managedObjectContext]];
                        [test setTestName:[NSString stringWithFormat:@"%i - %@", (i+1), AMLocalizedString(@"Variant", @"")]];
                        [tempTopic addConsistsOfObject:test];
                    }
                    
                    [subject addConsistsOfObject: tempTopic];
                }*/
                
                //adding variant object
                //Variant *variant = [[Topic alloc] initWithEntity: variantEntity insertIntoManagedObjectContext:[CoreData managedObjectContext]];
                //[variant setTopicName:AMLocalizedString(@"Variants", @"")];
                
                int numberOfTests = [[subjectDictionary objectForKey:@"Variants"] intValue];
                for(int i=0; i<numberOfTests; i++){
                    Test *test = [[Test alloc] initWithEntity:testEntity insertIntoManagedObjectContext:[CoreData managedObjectContext]];
                    [test setTestName:[NSString stringWithFormat:@"%i - %@", (i+1), AMLocalizedString(@"Variant", @"")]];
                    [subject addConsistsOfObject:test];
                }
                
                //[subject setVariant:variant];
                //[variant setVariantOf:subject];
                
                [CoreData saveContext];
            }
        }
        
    } else {
        NSLog(@"Nothing to load");
    }
    
}

-(NSArray *) fetchSubjects{
    NSManagedObjectContext *context = [CoreData managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Subject"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"language == %@", [self selectedLanguage]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    return [context executeFetchRequest:fetchRequest error:&error];
}

-(void) calculateProgresses{
    progresses = [[NSMutableArray alloc]init];
    
    for(int i=0; i<[subjects count]; i++){
        [progresses addObject:[NSNumber numberWithFloat:[[subjects objectAtIndex:i] getProgress]]];
    }
}


/*
 This method is for future use
 */
-(void)writeToFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"kk_Ағылшын тiлi_Topics" ofType:@""];
    NSError *error = nil;
    NSString*s = @"some text";
    BOOL successful = [s writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@",error);
    NSLog(@"%d",successful);
    NSLog(@"Saved to file");
}



@end
