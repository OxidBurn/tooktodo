//
//  PopoverModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PopoverModel.h"
#import "PopoverCell.h"

static NSString* PopoverCellID = @"SortPopoverCellID";

@interface PopoverModel ()

//properties
@property (weak, nonatomic) id <PopoverModelDataSource> dataSource;

@property (weak, nonatomic) id <PopoverModelDelegate> delegate;

@property (nonatomic, strong) NSArray* sortDataContent;

@property (strong, nonatomic) NSArray* currentPopoverContent;

@property (assign, nonatomic) NSUInteger selectedPopoverItem;

@end

@implementation PopoverModel


#pragma mark - Initialization -

- (instancetype) initWithDataSource: (id <PopoverModelDataSource>) dataSource
                       withDelegate: (id <PopoverModelDelegate>)   delegate
{
    if ( self = [super init] )
    {
        self.dataSource = dataSource;
        self.delegate   = delegate;
        
        self.selectedPopoverItem   = [self.dataSource selectedItem];
        self.currentPopoverContent = [self.dataSource getPopoverContent];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource methods -

- (NSInteger) tableView: (UITableView* )tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return self.currentPopoverContent.count;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    PopoverCell* cell = (PopoverCell*)[tableView dequeueReusableCellWithIdentifier: PopoverCellID];
    
    [cell fillCellWithOptionString: self.currentPopoverContent[indexPath.row]];
    
    return cell;
}

- (CGFloat)   tableView: (UITableView*) tableView
heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return 50;
}


#pragma mark - UITableViewDelegateMethods -

- (void) tableView: (UITableView*)     tableView
   willDisplayCell: (UITableViewCell*) cell
 forRowAtIndexPath: (NSIndexPath*)     indexPath
{
    PopoverCell* popCell = (PopoverCell*)cell;
    
    if ( self.selectedPopoverItem == indexPath.row )
    {
        popCell.sortType = [self.dataSource getProjectsSortAccedingType];
        popCell.selected = YES;
    }
}

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    PopoverCell* selectedCell = (PopoverCell*)[tableView cellForRowAtIndexPath: indexPath];
    
    switch (selectedCell.sortType)
    {
        case GrowsSortingType:
        {
            selectedCell.sortType = DiminutionSortingType;
            break;
        }
        case DiminutionSortingType:
        {
            selectedCell.sortType = GrowsSortingType;
            break;
        }
    }
    
    if ( [self.delegate respondsToSelector: @selector(didGrowSortingAtIndex:)] &&
         [self.delegate respondsToSelector: @selector(didDiminutionSortingAtIndex:)])
    {
        switch (selectedCell.sortType)
        {
            case GrowsSortingType:
            {
                [self.delegate didGrowSortingAtIndex: indexPath.row];
                break;
            }
            case DiminutionSortingType:
            {
                [self.delegate didDiminutionSortingAtIndex: indexPath.row];
                break;
            }
        }
    }
    
    // dismiss popover
    if ( self.didDismiss )
        self.didDismiss();
}

#pragma mark - Public -

- (CGSize) getPopoverSize
{
    NSUInteger numberOfRows = self.currentPopoverContent.count;
    
    CGFloat totalHeight = (numberOfRows * 52) + 5;
    
    return CGSizeMake (220, totalHeight);
}

@end
