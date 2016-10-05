//
//  SelectRoomViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 04.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectRoomViewModel.h"

//Classes
#import "RoomLevelSectionView.h"
#import "SelectRoomModel.h"
#import "OSCellWithCheckmark.h"

@interface SelectRoomViewModel()

// properties

@property (nonatomic, strong) NSArray* levelsArray;

@property (nonatomic, strong) SelectRoomModel* model;

// methods


@end

@implementation SelectRoomViewModel

#pragma mark - Properties -


- (SelectRoomModel*) model
{
    if (_model == nil)
    {
        _model = [SelectRoomModel new];
    }
    
    return _model;
}

#pragma mark - Public -

- (RACSignal*) updateContent
{
   return [self.model updateContent];
}

#pragma mark - Table view datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{

    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: @"checkMarkCellID"];
    
    [cell fillCellWithContent: [self.model getInfoForCellAtIndexPath: indexPath]
            withSelectedState: [self.model isSelectedRoom]];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [self.model sectionsCount];
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRowsInSection: section];
}

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    return 48.0f;
}

- (nullable UIView*)     tableView: (UITableView*) tableView
            viewForHeaderInSection: (NSInteger) section
{
    RoomLevelSectionView* sectionView = [[MainBundle loadNibNamed: @"RoomLevelSectionView"
                                                            owner: self
                                                          options: nil] firstObject];
    
    sectionView.tag = section;
    
    
    ProjectTaskRoomLevel* level = [self.model getLevelForSection: section];
    
    [sectionView fillInfo: level];
    
    // Handle changing expand state of the project
    __weak typeof(self) blockSelf = self;
    
    sectionView.didChangeExpandState = ^( NSUInteger section ){
        
        [blockSelf.model markLevelAsExpandedAtIndexPath: section
         withCompletion:^(BOOL isSuccess) {
             
             [tableView reloadData];
         }];
        
    };
    
    sectionView.didChangeSelectedState = ^(NSUInteger section){
        
        [blockSelf.model handleCheckmarkForSection:
         section withCompletion:^(BOOL isSuccess) {
             
             [tableView reloadData];
         }];
    };
    
    return sectionView;
}
#pragma mark - Table view delegate methods -


@end
