//
//  SortModel.m
//  TookTODO
//
//  Created by Глеб on 23.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SortModel.h"

static NSString* PopoverCellID = @"PopoverCellID";

@interface SortModel() 

// properties

@property (nonatomic, strong) NSArray* sortDataContent;

@property (strong, nonatomic) NSArray* currentPopover;
// methods


@end

@implementation SortModel

#pragma mark - Properties -

- (NSArray*) sortDataContent
{
    if ( _sortDataContent == nil )
    {
        _sortDataContent = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"SortDataContent" ofType: @"plist"]];
    }
    
    return _sortDataContent;
}


#pragma mark - Public -

- (CGSize) returnPopoverSizeForDataType: (SortDataType) dataType
{
    NSArray* filterOptions = self.sortDataContent[dataType];
    
    NSUInteger numberOfRows = filterOptions.count;
    
    CGFloat totalHeight = numberOfRows * 44;
    
    self.currentPopover = filterOptions;
    
    return CGSizeMake (200, totalHeight);
}

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView* )tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return self.currentPopover.count;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: PopoverCellID];
    
    cell.textLabel.text = self.currentPopover[indexPath.row];
    
    return cell;
}


@end
