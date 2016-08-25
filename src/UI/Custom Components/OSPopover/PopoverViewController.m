//
//  PopoverViewController.m
//  TookTODO
//
//  Created by Глеб on 23.08.16.
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
    
    // Set popover modal presentation style
    self.modalPresentationStyle = UIModalPresentationPopover;
    
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
