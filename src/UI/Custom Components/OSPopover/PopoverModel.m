//
//  PopoverModel.m
//  TookTODO
//
//  Created by Глеб on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PopoverModel.h"
#import "PopoverCell.h"

static NSString* PopoverCellID = @"SortPopoverCellID";

@interface PopoverModel ()

//properties
@property (weak, nonatomic) id <PopoverModelDelegate> delegate;

@property (nonatomic, strong) NSArray* sortDataContent;

@property (strong, nonatomic) NSArray* currentPopoverContent;

@end

@implementation PopoverModel


#pragma mark - Initialization -

- (instancetype) initWithType: (NSUInteger)                popoverType
                 withDelegate: (id <PopoverModelDelegate>) delegate
{
    if ( self = [super init] )
    {
        self.currentPopoverContent = self.sortDataContent[popoverType];
        
        self.delegate = delegate;
    }
    
    return self;
}


#pragma mark - Properties -

- (NSArray*) sortDataContent
{
    if ( _sortDataContent == nil )
    {
        _sortDataContent = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"PopoverContentData" ofType: @"plist"]];
    }
    
    return _sortDataContent;
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

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{    
    if ( [self.delegate respondsToSelector: @selector(didSelectItemAtIndex:)])
    {
        [self.delegate didSelectItemAtIndex: indexPath.row];
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
