//
//  AllProjectsViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsViewController.h"
#import "PopoverViewController.h"
#import "SortModel.h"

@interface AllProjectsViewController () <UIPopoverPresentationControllerDelegate>

//properties
@property (strong, nonatomic) SortModel* sortModel;


@end

@implementation AllProjectsViewController 

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self titleLabel];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (SortModel*) sortModel
{
    if ( _sortModel == nil )
    {
        _sortModel = [SortModel new];
    }
    return _sortModel;
}


#pragma mark - Navigation -

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (UIBarButtonItem*)   sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    UIViewController* dvc = segue.destinationViewController;
    
    dvc.navigationController.popoverPresentationController.sourceRect = sender.customView.bounds;
    
    dvc.preferredContentSize = [self.sortModel returnPopoverSizeForDataType: AllProgects];
    
    if ( dvc.navigationController.popoverPresentationController )
        dvc.navigationController.popoverPresentationController.delegate = self;
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


#pragma mark - UIPopoverPresentationControllerDelegate methods -


- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController*) controller
{    
    return UIModalPresentationNone;
}

@end
