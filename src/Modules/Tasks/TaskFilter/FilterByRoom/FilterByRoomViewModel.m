//
//  FilterByRoomViewModel.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoomViewModel.h"

//Classes
#import "FilterByRoomModel.h"

@interface FilterByRoomViewModel()

// properties
@property (nonatomic, strong) FilterByRoomModel* model;

// methods


@end

@implementation FilterByRoomViewModel


#pragma mark - UITableViewDatasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return nil;
}

- (NSInteger)tableView: (UITableView*) tableView
 numberOfRowsInSection: (NSInteger)    section
{
    return 0;
}

@end
