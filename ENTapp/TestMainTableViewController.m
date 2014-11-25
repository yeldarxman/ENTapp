//
//  TestMainTableViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 19.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestMainTableViewController.h"

#define CHOICE_FONT_SIZE 15
#define QUESTION_FONT_SIZE 17
#define PADDING 40
#define QUESTION_IMAGE_HEIGHT 204.7
#define QUESTION_IMAGE_WIDTH 292

@interface TestMainTableViewController ()

@end

@implementation TestMainTableViewController

@synthesize question;
@synthesize delegate;
@synthesize answer;
@synthesize answered;
@synthesize rightAnswerIndex;
@synthesize answerIndex;
@synthesize scienseTest;


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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    answered = NO;
    //self.view.backgroundColor = [UIColor clearColor];
}

-(void) updateRightAnswerIndex {
    if(self.scienseTest == YES){
        rightAnswerIndex = question.rightAnswerIndex;
        NSLog(@"RIGHT ANSWER INDEX %i", question.rightAnswerIndex);
        return;
    }
    
    if([question.rightAnswer isEqualToString:question.choiceA]){
        rightAnswerIndex = 0;
    } else if([question.rightAnswer isEqualToString:question.choiceB]){
        rightAnswerIndex = 1;
    } else if([question.rightAnswer isEqualToString:question.choiceC]){
        rightAnswerIndex = 2;
    } else if([question.rightAnswer isEqualToString:question.choiceD]){
        rightAnswerIndex = 3;
    } else if([question.rightAnswer isEqualToString:question.choiceE]){
        rightAnswerIndex = 4;
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"TestChoiceCell";
    
    TestChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *choiceText = @"TestChoiceCell";
    
    if(question.scienceQuestion == YES){
        [cell setNormalBackgroundScience];
    }
    switch (indexPath.section)
    {
        case 0:
            choiceText = question.choiceA;
            [cell.choiceLetterButton setTitle:@"A" forState:UIControlStateDisabled];
            if(question.scienceQuestion == YES){
                [cell.choiceTextImage setImage:question.choiceAImage];
            }
            
            break;
        case 1:
            choiceText = question.choiceB;
            [cell.choiceLetterButton setTitle:@"B" forState:UIControlStateDisabled];
            if(question.scienceQuestion == YES){
                [cell.choiceTextImage setImage:question.choiceBImage];
            }
            break;
        case 2:
            choiceText = question.choiceC;
            [cell.choiceLetterButton setTitle:@"C" forState:UIControlStateDisabled];
            if(question.scienceQuestion == YES){
                [cell.choiceTextImage setImage:question.choiceCImage];
            }
            break;
        case 3:
            choiceText = question.choiceD;
            [cell.choiceLetterButton setTitle:@"D" forState:UIControlStateDisabled];
            if(question.scienceQuestion == YES){
                [cell.choiceTextImage setImage:question.choiceDImage];
            }
            break;
        case 4:
            choiceText = question.choiceE;
            [cell.choiceLetterButton setTitle:@"E" forState:UIControlStateDisabled];
            if(question.scienceQuestion == YES){
                [cell.choiceTextImage setImage:question.choiceEImage];
            }
            break;
        default:
            choiceText = @"";
            break;
    }
    
     if(question.scienceQuestion == NO){
        cell.choiceTextLabel.text = choiceText;
    }
    
    if(answered == YES){
        if(scienseTest == YES){
            if(indexPath.section == answerIndex && indexPath.section != rightAnswerIndex){
                [cell setWrongBackgroundScience];
            } else if(indexPath.section == rightAnswerIndex){
                [cell setCorrectBackgroundScience];
            } else {
                [cell makeInvisible];
            }
        } else {
            switch (indexPath.section) {
                case 0:
                        if(![question.choiceA isEqualToString:question.rightAnswer] && [question.choiceA isEqualToString:answer]){
                            [cell setWrongBackground];
                        } else if([question.choiceA isEqualToString:question.rightAnswer]){
                            [cell setCorrectBackground];
                        } else {
                            [cell makeInvisible];
                        }
                    
                        break;
                case 1:
                    if(![question.choiceB isEqualToString:question.rightAnswer] && [question.choiceB isEqualToString:answer]){
                        [cell setWrongBackground];
                    } else if([question.choiceB isEqualToString:question.rightAnswer]){
                        [cell setCorrectBackground];
                    } else {
                        [cell makeInvisible];
                    }
                    
                    break;
                case 2:
                    if(![question.choiceC isEqualToString:question.rightAnswer] && [question.choiceC isEqualToString:answer]){
                        [cell setWrongBackground];
                    } else if([question.choiceC isEqualToString:question.rightAnswer]){
                        [cell setCorrectBackground];
                    } else {
                        [cell makeInvisible];
                    }
                    
                    break;
                case 3:
                    if(![question.choiceD isEqualToString:question.rightAnswer] && [question.choiceD isEqualToString:answer]){
                        [cell setWrongBackground];
                    } else if([question.choiceD isEqualToString:question.rightAnswer]){
                        [cell setCorrectBackground];
                    } else {
                        [cell makeInvisible];
                    }
                    
                    break;
                case 4:
                    if(![question.choiceE isEqualToString:question.rightAnswer] && [question.choiceE isEqualToString:answer]){
                        [cell setWrongBackground];
                    } else if([question.choiceE isEqualToString:question.rightAnswer]){
                        [cell setCorrectBackground];
                    } else {
                        [cell makeInvisible];
                    }
                    
                    break;
                default:
                    break;
            }
        }
        
        //cell.choiceTextLabel.text = choiceText;
        [cell setUserInteractionEnabled:NO];
        return cell;
    }
    
    NSLog(@"%@", choiceText);
    NSLog(@"%@", cell.textLabel.text);
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"mySectionName", @"mySectionName");
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

//calculates appropriate height for the message in order to wrap it with a bubble in a nice way
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Right answer index %i", rightAnswerIndex);
    NSLog(@"Answer index %i", answerIndex);
    
    if(answered == YES){
        if([answer isEqualToString:question.rightAnswer] && scienseTest == NO){
            if(indexPath.section != rightAnswerIndex){
                return 0.1;
            }
        } else {
            if(indexPath.section != rightAnswerIndex && indexPath.section != answerIndex) {
                return 0.1;
            }
        }
    }
    
    if(self.scienseTest == YES){
        switch (indexPath.section)
        {
            case 0:
                return question.choiceAImage.size.height/2 + 22;
                break;
            case 1:
                return question.choiceBImage.size.height/2 + 22;
                break;
            case 2:
                return question.choiceCImage.size.height/2 + 22;
                break;
            case 3:
                return question.choiceDImage.size.height/2 + 22;
                break;
            case 4:
                return question.choiceEImage.size.height/2 + 22;
                break;
            case 5:
                return 50;
            default:
                break;
        }
    }
    
    NSString *choiceText = @"";
    
    switch (indexPath.section)
    {
        case 0:
            choiceText = question.choiceA;
            break;
        case 1:
            choiceText = question.choiceB;
            break;
        case 2:
            choiceText = question.choiceC;
            break;
        case 3:
            choiceText = question.choiceD;
            break;
        case 4:
            choiceText = question.choiceE;
            break;
        case 5:
            return 50;
        default:
            choiceText = @"";
            break;
    }
    
    CGSize  textSize = { 245.0, 10000.0 };
    CGSize size = [choiceText sizeWithFont:[UIFont boldSystemFontOfSize:CHOICE_FONT_SIZE]
                         constrainedToSize:textSize
                             lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"Size is: width - %f and  height - %f", size.width, size.height);
    
    size.height = size.height + PADDING/2;
    
    return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            if([self scienseTest] == NO){
                CGSize  textSize = { 280.0, 10000.0 };
                CGSize size = [question.question sizeWithFont:[UIFont boldSystemFontOfSize:QUESTION_FONT_SIZE]
                                            constrainedToSize:textSize
                                                lineBreakMode:NSLineBreakByWordWrapping];
                NSLog(@"Header is: width - %f and  height - %f", size.width, size.height);
                return size.height + PADDING - 5;
            } else {
                return QUESTION_IMAGE_HEIGHT + 20;
            }
        }
        case 5:
            return 20;
        default:
            if(answered == YES){
                if([answer isEqualToString:question.rightAnswer]){
                    if(section != rightAnswerIndex){
                        return 0.1;
                    }
                } else {
                    if(section != rightAnswerIndex && section != answerIndex) {
                        return 0.1;
                    }
                }
            }
            return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 4:
            return 60;
        default:
            return 0.000001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0: {
            if(self.scienseTest == NO){
                NSLog(@"This section has to be returned");
                UILabel *headerTitle = [[UILabel alloc] init];
                [headerTitle setText:question.question];
                [headerTitle setTextColor:[UIColor whiteColor]];
                headerTitle.font = [UIFont systemFontOfSize: QUESTION_FONT_SIZE];
                headerTitle.lineBreakMode = NSLineBreakByWordWrapping;
                headerTitle.numberOfLines = 0;
                [headerTitle sizeToFit];
            
                headerTitle.frame = CGRectMake(20,
                                               15,
                                               self.view.frame.size.width - 40,
                                               headerTitle.frame.size.height);
                [headerTitle sizeToFit];
            
                headerTitle.backgroundColor = [UIColor clearColor];
            
                UIView *wholeHeader = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               self.view.frame.size.width,
                                                                               headerTitle.frame.size.height)];
                UIImageView *background = [[UIImageView alloc]
                                           initWithFrame:CGRectMake(headerTitle.frame.origin.x - 10,
                                                                    headerTitle.frame.origin.y - 10,
                                                                    300,
                                                                    headerTitle.frame.size.height + 20)];
                background.image = [[UIImage imageNamed:@"question_background1.png"] stretchableImageWithLeftCapWidth:50.0
                                                                                                    topCapHeight:25.0];
                [wholeHeader addSubview:background];
                [wholeHeader addSubview:headerTitle];
            
                return wholeHeader;    
            }
            else {
                UIImageView *questionImageView = [[UIImageView alloc] init];
                CGRect frame = CGRectMake(5, 5, QUESTION_IMAGE_WIDTH, QUESTION_IMAGE_HEIGHT);
                [questionImageView setBounds:frame];
                [questionImageView setImage:question.questionImage];
                
                UIView *wholeHeader = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               self.view.frame.size.width,
                                                                               questionImageView.frame.size.height + 20)];
                [questionImageView setCenter:wholeHeader.center];
                
                UIImageView *background = [[UIImageView alloc]
                                           initWithFrame:CGRectMake(questionImageView.frame.origin.x - 5,
                                                                    questionImageView.frame.origin.y - 4,
                                                                    QUESTION_IMAGE_WIDTH + 10,
                                                                    questionImageView.frame.size.height + 7.8)];
                background.image = [[UIImage imageNamed:@"question_background1.png"] stretchableImageWithLeftCapWidth:50.0
                                                                                                         topCapHeight:25.0];
                [wholeHeader addSubview:background];
                [wholeHeader addSubview:questionImageView];
                
                return wholeHeader;
            }
        }
        default:
            NSLog(@"This section is default to be returned");
            return [[UIView alloc] init];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            answer = question.choiceA;
            break;
        case 1:
            answer = question.choiceB;
            break;
        case 2:
            answer = question.choiceC;
            break;
        case 3:
            answer = question.choiceD;
            break;
        case 4:
            answer = question.choiceE;
            break;
        default:
            break;
    }
    
    answerIndex = indexPath.section;
    
    [self answerAction];
}

-(void)answerAction{
    answered = YES;
    
    //[self.tableView setBackgroundColor:[UIColor clearColor]];
    
    NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.tableView]);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
    
    [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
    
    [self performSelector:@selector(flipParentContainer) withObject:nil afterDelay:1.2];
}

-(void)flipParentContainer{
    if([delegate respondsToSelector:@selector(flipParent:)]){
        NSLog(@"Did answer, 1st place");
        [delegate flipParent:([answer isEqualToString:question.rightAnswer])];
    }
}


-(void) setScienceIndication{
    self.scienseTest = question.scienceQuestion;
}

@end
