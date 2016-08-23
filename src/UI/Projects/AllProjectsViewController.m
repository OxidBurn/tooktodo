//
//  AllProjectsViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsViewController.h"
#import "AllProjectsViewModel.h"

@interface AllProjectsViewController ()

// propeties

@property (strong, nonatomic) AllProjectsViewModel* viewModel;

@property (weak, nonatomic) IBOutlet UITableView *projectsTable;

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


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation -

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    
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

#pragma mark - Internal Method -

- (UILabel*) titleLabel
{
    UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 14.0f];
    
    UILabel *label        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 18)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines   = 1;
    label.font            = customFont;
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor whiteColor];
    label.text = @"ВСЕ ПРОЕКТЫ";
    
    [label sizeToFit];
    
    
    
    self.navigationItem.titleView = label;
    
    return label;
}

- (void) bindingUI
{
    [self.viewModel updateProjectsContent];
    
    self.projectsTable.dataSource = self.viewModel;
    self.projectsTable.delegate   = self.viewModel;
    
    [self handleModelActions];
}

- (void) handleModelActions
{
    self.viewModel.didSelectedProject = ^(NSNumber* projectID){
        
        NSLog(@"Project id: %lu", (unsigned long)projectID.integerValue);
        
    };
}

@end
