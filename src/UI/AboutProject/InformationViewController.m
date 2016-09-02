//
//  InformationInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationViewModel.h"

@interface InformationViewController ()

// properties

@property (weak, nonatomic) IBOutlet UITableView* informationTableView;

@property (nonatomic, strong)  InformationViewModel* viewModel;

// methods

@end

@implementation InformationViewController

#pragma mark - Properties -

- (InformationViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [[InformationViewModel alloc] init];
    }
    
    return _viewModel;
}

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.informationTableView.dataSource = self.viewModel;
    self.informationTableView.delegate   = self.viewModel;
    
}


@end
