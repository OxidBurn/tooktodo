//
//  AllProjectsViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsViewController.h"
#import "PopoverViewController.h"
#import "PopoverModel.h"

@interface AllProjectsViewController () <UIPopoverPresentationControllerDelegate, PopoverModelDelegate>

//properties

//outlets
@property (weak, nonatomic) IBOutlet UIBarButtonItem* sortBtn;

@property (strong, nonatomic) PopoverViewController* popController;

//actions
- (IBAction) onShowSort: (UIBarButtonItem*) sender;

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

#pragma mark - Navigation -

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (UIBarButtonItem*)   sender
{
    [super prepareForSegue: segue
                    sender: sender];
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
    
    UILabel *label        = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 480, 18)];
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

- (void) popoverPresentationControllerDidDismissPopover: (UIPopoverPresentationController*) popoverPresentationController
{
    
}

- (IBAction) onShowSort: (UIBarButtonItem*) sender
{
    PopoverModel* model = [[PopoverModel alloc] initWithType: 0
                                                withDelegate: self];
    
    PopoverViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier: @"SortProjectsControllerID"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.preferredContentSize   = [model getPopoverSizeForType: 0];
    
    [controller setPopoverModel: model];
    
    UIPopoverPresentationController* popover = controller.popoverPresentationController;
        
    CGRect barButtonFrame = self.sortBtn.customView.bounds;
    
    CGRect newFrame = CGRectMake( CGRectGetWidth(self.view.frame) - 35,
                                 barButtonFrame.origin.y + 62,
                                 barButtonFrame.size.width,
                                 barButtonFrame.size.height);
    
    popover.sourceRect = newFrame;
    
    popover.sourceView               = self.view;
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    
    popover.delegate = self;
    
    [self presentViewController: controller
                       animated: YES
                     completion: nil];
    
    self.popController = controller;
}

- (void) didSelectItemAtIndex: (NSUInteger) index
{
    
}

- (void) dismissPopover
{
    [self.popController dismissViewControllerAnimated: YES
                                           completion: nil];
}

@end
