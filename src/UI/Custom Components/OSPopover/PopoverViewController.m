//
//  PopoverViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 23.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController ()

@property (weak, nonatomic) IBOutlet UITableView* popoverTableView;

@property (strong, nonatomic) PopoverModel* model;

// methods

@end

@implementation PopoverViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Do any additional setup after loading the view.
    self.popoverTableView.dataSource = self.model;
    self.popoverTableView.delegate   = self.model;
    
    // Setup content size
    self.preferredContentSize = [self.model getPopoverSize];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public methods -

- (void) setupControllerWithDelegate: (id)                      delegate
                           withFrame: (CGRect)                  frame
                       withDirection: (UIPopoverArrowDirection) arrowDirection
{
    // Set popover modal presentation style
    self.modalPresentationStyle = UIModalPresentationPopover;
    
    // Setup popover
    self.popoverPresentationController.delegate                 = delegate;
    self.popoverPresentationController.sourceRect               = frame;
    self.popoverPresentationController.permittedArrowDirections = arrowDirection;
    self.popoverPresentationController.sourceView               = ((UIViewController*)delegate).view;
    
    // Present popover over delegate object
    // Delegate is controller where we presented popover
    [(UIViewController*)delegate presentViewController: self
                                              animated: YES
                                            completion: nil];
    
}

- (void) setPopoverModel: (PopoverModel*) model
{
    self.model = model;
    
    // Handle model actions
    __weak typeof(self) blockSelf = self;
    
    self.model.didDismiss = ^(){
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
        
    };
}

@end
