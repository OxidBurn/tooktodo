//
//  InfoiPadTableViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InfoiPadTableViewController.h"

// Classes
#import "InfoiPadViewModel.h"

@interface InfoiPadTableViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* infoiPadTableView;

// properties
@property (strong, nonatomic) InfoiPadViewModel* viewModel;


@end

@implementation InfoiPadTableViewController

#pragma mark - Lyfe cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Properties -

- (InfoiPadViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [InfoiPadViewModel new];
    }
    
    return _viewModel;
}

@end
