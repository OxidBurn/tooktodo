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

- (void) resetAllWithCompletion: (CompletionWithSuccess) completion
{
    [self.model resetAllWithCompletion: ^(BOOL isSuccess) {
        
        if (completion)
            completion(YES);
        
            }];
    
    
}

- (void) fillSelectedRoom: (id) selectedRoom
{
    [self.model fillSelectedRoom: selectedRoom];
}

- (ProjectTaskRoom*) getSelectedRoom
{
    return [self.model getSelectedRoom];
}

- (ProjectTaskRoomLevel*) getSelectedLevel
{
    return [self.model getSelectedLevel];
}

- (id) getSelectedInfo
{
    return [self.model getSelectedInfo];
}

#pragma mark - Table view datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{

    OSCellWithCheckmark* cell = [tableView dequeueReusableCellWithIdentifier: @"checkMarkCellID"];
    
    ProjectTaskRoom* room = [self.model getInfoForCellAtIndexPath: indexPath];
    NSString* title       = room.title;
    
    [cell fillCellWithContent: title
            withSelectedState: [self.model isSelectedRoomAtIndexPath: indexPath]];
     
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
