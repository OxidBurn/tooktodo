//
//  PopoverModel.m
//  TookTODO
//
//  Created by Глеб on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PopoverModel.h"
#import "SortPopoverCell.h"

static NSString* PopoverCellID = @"SortPopoverCellID";

@interface PopoverModel ()

//properties
@property (nonatomic, strong) NSArray* sortDataContent;

@property (strong, nonatomic) NSArray* currentPopover;

@end

@implementation PopoverModel


#pragma mark - Initialization -

- (instancetype) initWithType: (NSUInteger)                popoverType
                 withDelegate: (id <PopoverModelDelegate>) delegate
{
    self.currentPopover = self.sortDataContent[popoverType];
    
    self.delegate = delegate;
    
    return self;
}


#pragma mark - Properties -

- (NSArray*) sortDataContent
{
    if ( _sortDataContent == nil )
    {
        _sortDataContent = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"SortDataContent" ofType: @"plist"]];
    }
    
    return _sortDataContent;
}




#pragma mark - UITableViewDataSource methods -

- (NSInteger) tableView: (UITableView* )tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return self.currentPopover.count;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    SortPopoverCell* cell = [tableView dequeueReusableCellWithIdentifier: PopoverCellID];
    
    [cell fillCellWithOptionString: self.currentPopover[indexPath.row]];
    
    return cell;
}


#pragma mark - UITableViewDelegateMethods -

- (CGFloat)   tableView: (UITableView*) tableView
heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return 50;
}

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    if ( [self.delegate respondsToSelector: @selector(didSelectItemAtIndex:)])
    {
        [self.delegate didSelectItemAtIndex: indexPath.row];
    }
    
    if ( [self.delegate respondsToSelector: @selector(dismissPopover)])
    {
        [self.delegate dismissPopover];
    }
    
}

#pragma mark - Public -

- (CGSize) getPopoverSizeForType: (NSUInteger) typeIndex
{
    NSArray* filterOptions = self.sortDataContent[typeIndex];
    
    NSUInteger numberOfRows = filterOptions.count;
    
    CGFloat totalHeight = numberOfRows * 52 + 5;
    
    self.currentPopover = filterOptions;
    
    return CGSizeMake (220, totalHeight);
}

@end
