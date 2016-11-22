//
//  FilterByDatesModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByDatesModel.h"

// Classes
#import "FilterByDatesContentManager.h"

@interface FilterByDatesModel()

// properties
@property (strong, nonatomic) FilterByDatesContentManager* contentManager;

@property (strong, nonatomic) NSArray* tableViewContent;

// methods


@end

@implementation FilterByDatesModel


#pragma mark - Properties -

- (FilterByDatesContentManager*) contentManager
{
    if ( _contentManager == nil )
    {
        _contentManager = [FilterByDatesContentManager new];
    }
    
    return _contentManager;
}

- (NSArray*) tableViewContent
{
    if ( _tableViewContent == nil )
    {
        _tableViewContent = [self.contentManager getFilterByDatesContent];
    }
    
    return _tableViewContent;
}

#pragma mark - Public -


- (RowContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath
{
    return self.tableViewContent[indexPath.row];
}

@end
