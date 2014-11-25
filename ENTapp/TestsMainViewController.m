//
//  TestsMainViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestsMainViewController.h"
#import "LocalizationSystem.h"
#import "JsonParser.h"
#import "ImageUtility.h"

@interface TestsMainViewController ()

@end

#define PAGES_NUMBER 25
#define PAGE_BUTTON_HEIGHT 30
#define PAGE_BUTTON_WIDTH 30

@implementation TestsMainViewController

@synthesize headerView;
@synthesize pageControl;
@synthesize pageButtons;
@synthesize mainContent;
@synthesize doneButton;
@synthesize pages;
@synthesize pageCounter;
@synthesize currentPage;
@synthesize subject;
@synthesize test;
@synthesize correctAnswersNumber;
@synthesize incorrectAnswersNumber;

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
    pageCounter = 0;
    
    pages = [[NSMutableArray alloc] init];
    pageButtons = [[NSMutableArray alloc] init];
    
    [self loadQuestions];
    
    [[[self childViewControllers] objectAtIndex:0] removeFromParentViewController];
    [self addChildViewController:[pages objectAtIndex:pageCounter]];
    NSLog(@"Number of pages: %i", pages.count);
    NSLog(@"Number of subpage: %i", [self childViewControllers].count);
    [mainContent addSubview:[[[self childViewControllers] objectAtIndex:0] view]];
    
    [self setTitle:[test testName]];
    
    //customize done button
    [doneButton setTitle:AMLocalizedString(@"Done",@"")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onPageControlBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    int tag = button.tag;
    
    if(tag == currentPage){
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [[pages objectAtIndex:currentPage] removeFromParentViewController];
    [[[pages objectAtIndex:currentPage] view] removeFromSuperview];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:mainContent cache:NO];
    
    [self addChildViewController:[pages objectAtIndex:(tag)]];
    [mainContent addSubview:[[[self childViewControllers] objectAtIndex:0] view]];
    
    [UIView commitAnimations];
    
    [self setActivePageControlWithIndex:tag];    
}

-(void)setActivePageControlWithIndex:(int)index
{
    
    for (int i=0; i<=pageCounter; i++)
    {
        UIImage *backgroundImg = [[pageButtons objectAtIndex:i] backgroundImageForState:(i==index)?UIControlStateHighlighted:UIControlStateDisabled];
        [[pageButtons objectAtIndex:i] setBackgroundImage:backgroundImg forState:UIControlStateNormal];
        [[pageButtons objectAtIndex:i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    if(index != pageCounter && pageCounter != [pages count]-1){
        [[pageButtons objectAtIndex:pageCounter] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    [pageControl setContentOffset:CGPointMake((index - 1) * (PAGE_BUTTON_WIDTH + 5), 0) animated:YES];
    
    currentPage = index;
}

-(void)flipParent:(BOOL) correctAnswer{
    
    if(correctAnswer == YES){
        [[pageButtons objectAtIndex:pageCounter] setBackgroundImage:[UIImage imageNamed:@"page_green.png"] forState:UIControlStateDisabled];
        correctAnswersNumber += 1;
    } else {
        [[pageButtons objectAtIndex:pageCounter] setBackgroundImage:[UIImage imageNamed:@"page_red.png"] forState:UIControlStateDisabled];
        incorrectAnswersNumber += 1;
    }
    
    [[pageButtons objectAtIndex:pageCounter] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if(pageCounter == [pages count] - 1){
        [self showAlertView];
        [[[pages objectAtIndex:pageCounter] tableView] setBackgroundColor: [UIColor whiteColor]];
        [self saveResults];
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:mainContent cache:YES];
    
    [[[pages objectAtIndex:pageCounter] tableView] setBackgroundColor: [UIColor whiteColor]];
    
    [[pages objectAtIndex:pageCounter] removeFromParentViewController];
    [[[pages objectAtIndex:pageCounter] view] removeFromSuperview];
    
    [self addChildViewController:[pages objectAtIndex:(++pageCounter)]];
    [mainContent addSubview:[[[self childViewControllers] objectAtIndex:0] view]];
    
    [[[pages objectAtIndex:pageCounter] tableView] setBackgroundColor: [UIColor whiteColor]];
    [UIView commitAnimations];
    
    [[pageButtons objectAtIndex:pageCounter] setEnabled:YES];
    [[pageButtons objectAtIndex:pageCounter] setBackgroundImage:[UIImage imageNamed:@"page_deselected.png"] forState:UIControlStateDisabled];
    
    [self setActivePageControlWithIndex:pageCounter];
}

#pragma mark - Data manipulation methods
- (void) loadQuestions {
    NSString *fileTitle = [NSString stringWithFormat:
                           @"%@_%@_%@",
                           [subject language],
                           [subject subjectName],
                           [test testName]];
    
    
    NSMutableArray *questionObjects = [[NSMutableArray alloc] init];
    NSString *folderPath = [NSString stringWithFormat:@"%@_%@", subject.language, subject.subjectName];
    NSDictionary *testDictionary =  [JsonParser parseJsonFormMainBundleFile:folderPath fileName:fileTitle fileType:@""];
    NSArray *questions = [testDictionary objectForKey:@"Questions"];
    NSLog(@"Questions list: %i", [questions count]);
    
    for (NSDictionary *questionDictionary in questions) {
        Question *question = [[Question alloc] init];
        [question setQuestion:[questionDictionary objectForKey:@"question"]];
        [question setChoiceA:[questionDictionary objectForKey:@"choiceA"]];
        [question setChoiceB:[questionDictionary objectForKey:@"choiceB"]];
        [question setChoiceC:[questionDictionary objectForKey:@"choiceC"]];
        [question setChoiceD:[questionDictionary objectForKey:@"choiceD"]];
        [question setChoiceE:[questionDictionary objectForKey:@"choiceE"]];
        [question setRightAnswer:[questionDictionary objectForKey:@"rightAnswer"]];
        
        [questionObjects addObject:question];
    }
    
    [self generatePages:questionObjects];
    
    // if the test is science test
    /*
    if([[subject subjectName] isEqualToString:AMLocalizedString(@"Math", @"")] ||
       [[subject subjectName] isEqualToString:AMLocalizedString(@"Physics", @"")] ||
       [[subject subjectName] isEqualToString:AMLocalizedString(@"Chemistry", @"")]
    ){
        NSURL *pdfFile = [[NSBundle mainBundle]
                      URLForResource: fileTitle withExtension:@"pdf"];
        if(pdfFile){
            NSLog(@"The file exists!!!");
        } else {
            NSLog(@"The file does not exist!!! Checking the documents directory");
            // Point to Document directory
            NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSLog(@"Documents path: %@", documentsPath);
            NSString *filePath = [NSString stringWithFormat:@"%@_%@", self.subject.language, @"Математика"];
            NSLog(@"File Path is: %@", filePath);
            filePath = [documentsPath stringByAppendingPathComponent:filePath];
            filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", fileTitle]];
            pdfFile = [NSURL fileURLWithPath:filePath];
        }
        
        NSLog(@"PDF File URL: %@", pdfFile);
        
        if(!pdfFile){
            [self dismissViewControllerAnimated:YES completion:^(void){}];
        }
        
        NSMutableArray *images = [PDFUtility readPDFFile:pdfFile width:581];
        
        
        for(int i=0; i<[images count] - 1; i = i + 2){
            Question *question = [[Question alloc] init];
            [question setScienceQuestion:YES];
            //question image
            [question setQuestionImage:[ImageUtility imageByCropping:[images objectAtIndex:i] toRect:CGRectMake(30, 25, 520, 360)]];
            //question choices
            [question setChoiceAImage:[ImageUtility imageByCropping:[images objectAtIndex:i+1] toRect:CGRectMake(30, 25, 520, 63)]];
            [question setChoiceBImage:[ImageUtility imageByCropping:[images objectAtIndex:i+1] toRect:CGRectMake(30, 89, 520, 63)]];
            [question setChoiceCImage:[ImageUtility imageByCropping:[images objectAtIndex:i+1] toRect:CGRectMake(30, 153, 520, 63)]];
            [question setChoiceDImage:[ImageUtility imageByCropping:[images objectAtIndex:i+1] toRect:CGRectMake(30, 217, 520, 63)]];
            [question setChoiceEImage:[ImageUtility imageByCropping:[images objectAtIndex:i+1] toRect:CGRectMake(30, 281, 520, 63)]];
            [question setRightAnswerIndex:2];
        
            [questionObjects addObject:question];
        }
    } //if the test is not science test
    else {
        NSString *folderPath = [NSString stringWithFormat:@"%@_%@", subject.language, subject.subjectName];
        NSDictionary *testDictionary =  [JsonParser parseJsonFormMainBundleFile:folderPath fileName:fileTitle fileType:@""];
        NSArray *questions = [testDictionary objectForKey:@"questions"];
        
        for (NSDictionary *questionDictionary in questions) {
            Question *question = [[Question alloc] init];
            [question setQuestion:[questionDictionary objectForKey:@"question"]];
            [question setChoiceA:[questionDictionary objectForKey:@"choiceA"]];
            [question setChoiceB:[questionDictionary objectForKey:@"choiceB"]];
            [question setChoiceC:[questionDictionary objectForKey:@"choiceC"]];
            [question setChoiceD:[questionDictionary objectForKey:@"choiceD"]];
            [question setChoiceE:[questionDictionary objectForKey:@"choiceE"]];
            [question setRightAnswer:[questionDictionary objectForKey:@"rightAnswer"]];
            
            [questionObjects addObject:question];
        }
    }
    
    [self generatePages:questionObjects];
    */
}

-(void)generatePages: (NSMutableArray *) questions
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    NSLog(@"Questions count is %i", [questions count]);
    for (int i=0; i<[questions count]; i++)
    {
        Question *question = [questions objectAtIndex:i];
        
        UIButton *pageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *buttonTitle = [NSString stringWithFormat:@"%i", (i+1)];
        
        [pageButton setTitle:buttonTitle forState:UIControlStateNormal];
        pageButton.titleLabel.font = [UIFont systemFontOfSize:13];
        pageButton.frame = CGRectMake(5 + i*(PAGE_BUTTON_WIDTH + 5),
                                      10.0,
                                      PAGE_BUTTON_WIDTH,
                                      PAGE_BUTTON_HEIGHT);
        pageButton.tag = i;
        [pageButton setBackgroundImage:[UIImage imageNamed: (i == 0) ? @"page_selected.png" : @"page_deselected.png"] forState:UIControlStateNormal];
        [pageButton setBackgroundImage:[UIImage imageNamed: @"page_selected.png"] forState:UIControlStateHighlighted];
        [pageButton setBackgroundImage:[UIImage imageNamed: @"page_disabled.png"] forState:UIControlStateDisabled];
        [pageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [pageButton setTitleColor:(i==0)?[UIColor whiteColor]:[UIColor grayColor] forState:UIControlStateNormal];
        [pageButton setTitleColor:(i==0)?[UIColor whiteColor]:[UIColor grayColor] forState:UIControlStateDisabled];
        pageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [pageButton setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        [pageButton setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateDisabled];
        [pageButton setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateSelected];
        [pageButton addTarget:self action:@selector(onPageControlBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [pageButton setEnabled: (i == 0) ? YES : NO];
        [pageButtons addObject:pageButton];
        [pageControl addSubview:pageButton];
        
        TestMainTableViewController *page =
        [storyboard instantiateViewControllerWithIdentifier:@"TestMainTableViewController"];
        
        [page.view setFrame: CGRectMake(0, 0, mainContent.frame.size.width, mainContent.frame.size.height)];
        [page setQuestion:question];
        [page setScienceIndication];
        [page updateRightAnswerIndex];
        page.delegate = self;
        
        [pages addObject:page];
    }
    
    
    pageControl.contentSize = CGSizeMake((5 + PAGE_BUTTON_WIDTH) * (PAGES_NUMBER),
                                         pageControl.frame.size.height);
    currentPage = 0;
}

#pragma mark - Action sheet methods
//Your delegate for pressed buttons.
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^(void){
                NSLog(@"Dismissed the test view controller");
            }];
            break;
        default:
            break;
    }
}

//Declare a method to show your sheet
-(IBAction)showActionSheet:(id)sender
{
    NSLog(@"Pages size %i",[pages count]);
    NSLog(@"page counter is %i",pageCounter);
    
    NSString *results = [NSString stringWithFormat: @"%@ \n%@%i \n %@%i",
                                                            AMLocalizedString(@"Your result for this test:", @""),
                                                            AMLocalizedString(@"Correct - ", @""),
                                                            correctAnswersNumber,
                                                            AMLocalizedString(@"Incorrect - ", @""),
                                                            incorrectAnswersNumber];
    
    NSString *actionSheetTitle = (pageCounter != [pages count] - 1) ?
                                            AMLocalizedString(@"You haven't finished the test! If you quit, your current progress for this test will not be saved.", @"") :
                                            results;
    
    if(pageCounter == [pages count] -1){
        [self dismissViewControllerAnimated:YES completion:^(void){}];
    } else{
        UIActionSheet *menu = [[UIActionSheet alloc]
                               initWithTitle: actionSheetTitle
                               delegate:self
                               cancelButtonTitle:AMLocalizedString(@"Cancel", @"")
                               destructiveButtonTitle:AMLocalizedString(@"Done", @"")
                               otherButtonTitles:nil];
        [menu showInView:self.view];
    }
}

#pragma mark - Alert view methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1) {
		//OK clicked
	} else {
	}
}

- (void) showAlertView
{
    NSString *title = AMLocalizedString(@"Test ended!", @"");
    NSString *message = [NSString stringWithFormat: @"%@ \n%@%i \n %@%i \n%@",
                      AMLocalizedString(@"Your result for this test:", @""),
                      AMLocalizedString(@"Correct - ", @""),
                      correctAnswersNumber,
                      AMLocalizedString(@"Incorrect - ", @""),
                      incorrectAnswersNumber,
                      AMLocalizedString(@"To quit press the \"done\" button.", @"")];
    
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
}

-(void) saveResults{
    [test setCorrectAnswers: [NSNumber numberWithInt: correctAnswersNumber]];
    [test setWrongAnswers: [NSNumber numberWithInt: incorrectAnswersNumber]];
    [CoreData saveContext];
}


@end
