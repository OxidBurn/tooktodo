//
//  InfoiPadViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InfoiPadViewModel.h"

// Frameworks
@import UIKit;

// Classes
#import "InfoiPadModel.h"
#import "AboutProjectTableViewCell.h"

static NSString* cellId = @"AboutProjectiPadCellId";

@interface InfoiPadViewModel()

// properties
@property (strong, nonatomic) InfoiPadModel* model;

@property (strong, nonatomic) NSArray* allCells;

// methods


@end

@implementation InfoiPadViewModel

#pragma mark - Properties -

- (InfoiPadModel*) model
{
    if ( _model == nil )
    {
        _model = [InfoiPadModel new];
    }
    
    return _model;
}

- (NSArray*) allCells
{
    if ( _allCells == nil )
    {
        _allCells = @[ [NSIndexPath indexPathForRow: 0 inSection: 0],
                       [NSIndexPath indexPathForRow: 1 inSection: 0],
                       [NSIndexPath indexPathForRow: 2 inSection: 0]];
    }
    
    return _allCells;
}

#pragma mark - Public -

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return 3;
}


 - (UITableViewCell*) tableView: (UITableView*) tableView
          cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    AboutProjectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    [cell fillCellWithTitle: [self.model getTitleForIndexPath: indexPath]];
    
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
 
    return cell;
}

#pragma mark - Table view delegate -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [self.allCells enumerateObjectsUsingBlock: ^(NSIndexPath* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AboutProjectTableViewCell* cell = [tableView cellForRowAtIndexPath: obj];
        
        if ( obj == indexPath)
        {
            [cell selectCell];
        }
        else
        {
            [cell deselectCell];
        }
        
    }];
    
    if ( self.performSegueWithId )
        self.performSegueWithId([self.model getSegueIdForIndexPath: indexPath]);
}

@end
