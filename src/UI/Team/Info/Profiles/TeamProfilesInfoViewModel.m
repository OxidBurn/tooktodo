//
//  TeamProfilesInfoViewModel.m
//  TookTODO
//
//  Created by Глеб on 03.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfilesInfoViewModel.h"

// Classes
#import "TeamProfilesInfoModel.h"

@interface TeamProfilesInfoViewModel()

// properties
@property (strong, nonatomic) TeamProfilesInfoModel* model;

// methods


@end

@implementation TeamProfilesInfoViewModel

#pragma mark - Properties -

- (TeamProfilesInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [TeamProfilesInfoModel new];
    }
    
    return _model;
}

#pragma mark - Table view data source methods -

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger) section
{
    return 6;
}

#pragma mark - Table view delegate methods -


@end
