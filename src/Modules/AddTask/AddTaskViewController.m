//
//  AddTaskViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskViewController.h"

// Classes
#import "AddTaskViewModel.h"
#import "SelectResponsibleViewController.h"
#import "ProjectsEnumerations.h"

typedef NS_ENUM(NSUInteger, SeguesList) {
    
    ShowResponsibleSegue,
    ShowClaimingSegue,
    ShowObserversSegue,
    
};

@interface AddTaskViewController () <AddTaskViewModelDelegate>

// outlets

@property (weak, nonatomic) IBOutlet UIBarButtonItem* readyBtn;
@property (weak, nonatomic) IBOutlet UIButton*        addTaskAndCreateNewBtn;
@property (weak, nonatomic) IBOutlet UIButton*        addTaskBtn;


// properties
@property (weak, nonatomic) IBOutlet UITableView* addTaskTableView;

@property (strong, nonatomic) AddTaskViewModel* viewModel;

@property (strong, nonatomic) NSArray* seguesInfoArray;

@property (assign, nonatomic) SeguesList segue;

// methods
- (IBAction) onAddAndCreateNewBtn: (UIButton*) sender;

- (IBAction) onAddTaskBtn:         (UIButton*) sender;

@end

@implementation AddTaskViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self twoLineTitleView];
    
    [self setUpDefaults];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue sender: sender];
    
    SelectResponsibleViewController* controller = [SelectResponsibleViewController new];
    
    controller = segue.destinationViewController;
    
    NSUInteger segueIndex = [self.seguesInfoArray indexOfObject: segue.identifier];
    
    switch ( segueIndex )
    {
        case ShowResponsibleSegue:
        {
            [controller updateControllerType: SelectResponsibleController];
        }
            break;
            
        case ShowClaimingSegue:
        {
            
            [controller updateControllerType: SelectClaimingController];
        }
            break;
            
        case ShowObserversSegue:
        {
            [controller updateControllerType: SelectObserversController];
        }
            break;
            
        default:
            break;
    }

}


#pragma mark - Properties -

- (NSArray*) seguesInfoArray
{
    if ( _seguesInfoArray == nil )
    {
        _seguesInfoArray = @[@"ShowSelectResponsibleController", @"ShowSelectClaimingController", @"ShowSelectObserversController"];
    }
    
    return _seguesInfoArray;
}

- (AddTaskViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [AddTaskViewModel new];
        
        _viewModel.delegate = self;
    }
    
    return _viewModel;
}

#pragma mark - Actions -

- (IBAction) onAddAndCreateNewBtn: (UIButton*) sender
{
    
}

- (IBAction) onAddTaskBtn:         (UIButton*) sender
{
    
}

#pragma mark - AddTaskViewModel delegate methods -

- (void) performSegueWithSegueId: (NSString*) segueId
{
    if ( segueId )
    {
        [self performSegueWithIdentifier: segueId
                                  sender: self];
    }
}

- (void) reloadAddTaskTableView
{
    [self.addTaskTableView reloadData];
}

#pragma mark - Internal methods -

- (UIView*) twoLineTitleView
{
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 14.0f];
    UIFont* customFontForSubTitle = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 13.0f];
    
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = customFont;
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = @"НОВАЯ ЗАДАЧА";
    [titleLabel sizeToFit];
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFontForSubTitle;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    //    subTitleLabel.text            = [self.viewModel getProjectName];
    [subTitleLabel sizeToFit];
    
    UIView* twoLineTitleView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 32)];
    
    [twoLineTitleView addSubview: titleLabel];
    [twoLineTitleView addSubview: subTitleLabel];
    
    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
    
    if (widthDiff > 0)
    {
        CGRect frame     = titleLabel.frame;
        frame.origin.x   = widthDiff / 2;
        titleLabel.frame = CGRectIntegral(frame);
    }
    else
    {
        CGRect frame        = subTitleLabel.frame;
        frame.origin.x      = fabsf(widthDiff) / 2;
        subTitleLabel.frame = CGRectIntegral(frame);
    }
    
    self.navigationItem.titleView = twoLineTitleView;
    
    return twoLineTitleView;
}

- (void) setUpDefaults
{
    [self bindUI];
    
    self.addTaskTableView.dataSource = self.viewModel;
    self.addTaskTableView.delegate   = self.viewModel;
    
    self.addTaskTableView.rowHeight = UITableViewAutomaticDimension;
    self.addTaskTableView.estimatedRowHeight = 42;
}

- (void) bindUI
{
    self.readyBtn.rac_command               = self.viewModel.readyCommand;
    self.addTaskBtn.rac_command             = self.viewModel.addTaskCommand;
    self.addTaskAndCreateNewBtn.rac_command = self.viewModel.addTastAndCreateNewCommand;
}

@end
