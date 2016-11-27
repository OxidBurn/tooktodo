//
//  FilterByDatesViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesViewController.h"

// Classes
#import "FilterByDatesViewModel.h"
#import "ProjectsEnumerations.h"

@interface FilterByDatesViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView*        filterByDatesTableView;

@property (weak, nonatomic) IBOutlet UIView*             quickFilterView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint* tableViewHeightConstraint;

// propetries
@property (assign, nonatomic) FilterByDateViewControllerType controllerType;

@property (strong, nonatomic) FilterByDatesViewModel* viewModel;

@property (assign, nonatomic) BOOL pickerIsExpanded;

// methods
- (IBAction) onResetBtn: (UIButton*) sender;
- (IBAction) onSaveBtn: (UIButton*) sender;
- (IBAction) onBeforeCurrentDate: (UIButton*) sender;
- (IBAction) onAfterCurrentDate: (UIButton*) sender;
- (IBAction) onLastWeek: (UIButton*) sender;
- (IBAction) onCurrentWeek: (UIButton*) sender;
- (IBAction) onLastMonth: (UIButton*) sender;
- (IBAction) onCurrentMonth: (UIButton*) sender;

- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

- (void) setupDefaults;

@end

@implementation FilterByDatesViewController


#pragma mark - Lyfe cycle -

- (void) loadView
{
    [super loadView];
    
    [self setupDefaults];
}


#pragma mark - Properties -

- (FilterByDatesViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [FilterByDatesViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Actions -

- (IBAction) onResetBtn: (UIButton*) sender
{
    
}

- (IBAction) onSaveBtn: (UIButton*) sender
{
    if ( [self.delegate respondsToSelector:@selector(updateConfigWithTerms:forControllerType:)] )
    {
        [self.delegate updateConfigWithTerms: [self.viewModel getTermsData]
                           forControllerType: self.controllerType];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}

- (IBAction) onBeforeCurrentDate: (UIButton*) sender
{
    
}

- (IBAction) onAfterCurrentDate: (UIButton*) sender
{
    
}

- (IBAction) onLastWeek: (UIButton*) sender
{
    
}

- (IBAction) onCurrentWeek: (UIButton*) sender
{
    
}

- (IBAction) onLastMonth: (UIButton*) sender
{
    
}

- (IBAction) onCurrentMonth: (UIButton*) sender
{
    
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - Public -

- (void) fillControllerType: (FilterByDateViewControllerType) controllerType
           withFilterConfig: (TaskFilterConfiguration*)       filterConfig
               withDelegate: (id)                             delegate
{
    self.controllerType = controllerType;
    self.delegate       = delegate;
    
    [self.viewModel fillFilterConfig: filterConfig
                  withControllerType: controllerType];
}


#pragma mark - Internal -

- (void) setupDefaults
{
    self.filterByDatesTableView.dataSource = self.viewModel;
    self.filterByDatesTableView.delegate   = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    blockSelf.viewModel.handleTableViewHeight = ^(BOOL didExpanded){
        
        if ( didExpanded )
        {
            [UIView animateWithDuration: 0.3
                             animations: ^{
               
                self.tableViewHeightConstraint.constant = 298;
                
                self.quickFilterView.hidden = YES;
            }];
        }
        else
        {
            [UIView animateWithDuration: 0.3
                             animations:^{
                                 
                                 self.tableViewHeightConstraint.constant = 82;
                                 
                                 self.quickFilterView.hidden = NO;
                             }];
        }
    };
    
    blockSelf.viewModel.reloadTableView = ^(){
        
        [self.filterByDatesTableView reloadData];
    };
}


@end
