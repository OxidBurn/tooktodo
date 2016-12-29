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
#import "ProjectTaskRoom+CoreDataClass.h"
#import "DataManager+ProjectInfo.h"

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

- (NSString*) getProjectName
{
    return [DataManagerShared getSelectedProjectName];;
}

//- (RACSignal*) updateContent
//{
//   return [self.model updateContent];
//}

- (void) resetAllWithCompletion: (CompletionWithSuccess) completion
{
    [self.model resetAllWithCompletion: completion];
}

- (SelectedRoomsInfo*) getSelectedInfo
{
    return [self.model getSelectedInfo];
}

- (void) fillSelectedRoomsInfo: (SelectedRoomsInfo*) selectedRooms
{
    [self.model fillSelectedRoomsInfo: selectedRooms];
}


#pragma mark - Table view datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{

    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: @"checkMarkCellID"];
    
    RoomContent* room = [self.model getRoomContentForIndexPath: indexPath];
    
    if ( room )
    {
        [cell fillCellWithContent: room.roomTitle
                withSelectedState: room.isSelected];
    }
    else
        cell = nil;
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [self.model getNumberOfSections];
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRowsInSection: section];
}

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    return 48.0f;
}

- (nullable UIView*)     tableView: (UITableView*) tableView
            viewForHeaderInSection: (NSInteger)    section
{
    RoomLevelSectionView* sectionView = [[MainBundle loadNibNamed: @"RoomLevelSectionView"
                                                            owner: self
                                                          options: nil] firstObject];
    
    sectionView.tag = section;
    
//    ProjectTaskRoomLevel* level = [self.model getLevelForSection: section];
    
    LevelContent* levelContent = [self.model getLevelContentForSection: section];
    
    [sectionView fillHeaderViewWithContent: levelContent];
    
    // Handle changing expand state of the project
    __weak typeof(self) blockSelf = self;
    
    //обновление таблицы, когда секция раскрывается
    sectionView.didChangeExpandState = ^( NSUInteger section ){
        
        [blockSelf.model markLevelAsExpandedAtIndexPath: section
                                         withCompletion: ^(BOOL isSuccess) {
             
             [tableView reloadData];
                                             
         }];
        
    };
    
    
    //таблица обновляется, когда выбрана какая-то из секций
    sectionView.didChangeSelectedState = ^(NSUInteger section){
        
        [blockSelf.model handleCheckmarkForSection: section
                                    withCompletion: ^(BOOL isSuccess) {
             
             [tableView reloadData];
         }];
    };
    

    
    return sectionView;
}

#pragma mark - Table view delegate methods -

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    
    [self.model handleCheckmarkForIndexPath: indexPath
                             withCompletion:^(BOOL isSuccess) {
                                 
                                 [tableView reloadData];
                             }];

}

@end
