//
//  AllProjectsViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsViewController.h"
#import "AllProjectsViewModel.h"

// Extensions
#import "UISearchBar+TextFieldControl.h"

@interface AllProjectsViewController ()

// propeties

@property (strong, nonatomic) AllProjectsViewModel* viewModel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* sortBtn;
@property (weak, nonatomic) IBOutlet UITableView *projectsTable;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;
@property (strong, nonatomic) UITextField* searchTextField;

// methods

- (void) bindingUI;

@end

@implementation AllProjectsViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup custom view of the navigation bar
    [self titleLabel];
    
    // Binding UI components with model
    [self bindingUI];
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear: animated];
    
    // Setup table view with search bar
    [self setupTableView];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (AllProjectsViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[AllProjectsViewModel alloc] init];
    }
    
    return _viewModel;
}


#pragma mark - Actions -

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (IBAction) onShowSortingMenu: (UIBarButtonItem*) sender
{
    [self showPopoverWithDataSource: self.viewModel
                       withDelegate: self.viewModel
                    withSourceFrame: [self getFrameForSortingPopover]];
}

#pragma mark - Internal Method -

- (UILabel*) titleLabel
{
    UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 14.0f];
    
    UILabel* label        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 18)];
    
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines   = 1;
    label.font            = customFont;
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor whiteColor];
    label.text            = @"ВСЕ ПРОЕКТЫ";
    
    [label sizeToFit];
    
    self.navigationItem.titleView = label;
    
    return label;
}

- (void) bindingUI
{
    [self.viewModel updateProjectsContent];
    
    self.projectsTable.dataSource = self.viewModel;
    self.projectsTable.delegate   = self.viewModel;
    self.searchBar.delegate       = self.viewModel;
#warning 'Move it to storyboard'
    self.searchBar.placeholder    = [self.viewModel getSearchBarPlaceholderText];
    
    [self handleModelActions];
}

- (void) setupTableView
{
    [self.projectsTable setContentOffset: CGPointMake(0, self.searchBar.frame.size.height)];
}

- (void) handleModelActions
{
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.didSelectedProject = ^(NSNumber* projectID){
        
        NSLog(@"Project id: %lu", (unsigned long)projectID.integerValue);
        
    };
    
    self.viewModel.reloadTable = ^(){
        
        [blockSelf.projectsTable reloadData];
        
    };
    
    self.viewModel.endSearching = ^(){
        
        [blockSelf.searchBar resignFirstResponder];
        [blockSelf.view endEditing: YES];
        
    };
}

- (CGRect) getFrameForSortingPopover
{
    CGRect barButtonFrame = self.sortBtn.customView.bounds;
    
    CGRect newFrame = CGRectMake( CGRectGetWidth(self.view.frame) - 35,
                                 barButtonFrame.origin.y + 62,
                                 barButtonFrame.size.width,
                                 barButtonFrame.size.height);
    
    return newFrame;
}

@end
