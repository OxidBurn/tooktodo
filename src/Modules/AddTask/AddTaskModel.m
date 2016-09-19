//
//  AddTaskModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskModel.h"

// Classes
#import "OSRightDetailCellFactory.h"
#import "OSMarkedRightDetailCellFactory.h"
#import "OSSingleUserInfoCellFactory.h"
#import "OSGroupOfUsersInfoCellFactory.h"
#import "OSSwitchTableCellFactory.h"
#import "OSFlexibleTextCellFactory.h"

typedef NS_ENUM( NSUInteger, AddTaskTableViewCellType) {
    
    FlexibleCell,
    RightDetailCell,
    SwitchCell,
    SingleUserInfoCell,
    GroupOfUsersCell,
    MarkedRightDetailCell,
};

/*typedef NS_ENUM(NSUInteger, AddTaskScreenSegueId) {
    
    ShowResponsibleSegueID,
    ShowApprovalsSegueID,
    ShowWatchersSegueID,
    ShowTermsSegueID,
    
};*/


static NSString* CellIdKey         = @"CellIdKey";
static NSString* SegueIdKey        = @"SegueIdKey";

@interface AddTaskModel()

// properties
@property (strong, nonatomic) NSArray* addTaskTableViewContent;

@property (strong, nonatomic) NSArray* addTaskTableViewCellsInfo;

@property (strong, nonatomic) NSArray* addTaskTableViewSeguesInfo;


// methods


@end

@implementation AddTaskModel

#pragma mark - Properties -

- (NSArray*) addTaskTableViewCellsInfo
{
    if ( _addTaskTableViewCellsInfo == nil )
    {
        _addTaskTableViewCellsInfo = @[@"FlexibleTextCellID", @"RightDetailCellID", @"SwitchCellID", @"SingleUserInfoCellID", @"GroupOfUsersCellID", @"MarkedRightDetailsCellID" ];
    }
    
    return _addTaskTableViewCellsInfo;
}

/*- (NSArray*) addTaskTableViewSeguesInfo
{
    if ( _addTaskTableViewSeguesInfo == nil )
    {
        _addTaskTableViewSeguesInfo = @[@"ShowResponsible", @"ShowApprovals", @"ShowWatchers", @"ShowTerms"];
    }
    
    return _addTaskTableViewSeguesInfo;
} */

/* - (NSArray*) addTaskTableViewContent
{
    if ( _addTaskTableViewContent == nil )
    {
        _addTaskTableViewContent = [self createTableViewContent];
    }
    
    return _addTaskTableViewContent;
} */

#pragma mark - Public -

- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section;
{
    return [self.addTaskTableViewContent[section] count];
}

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath
{
    NSArray* section = self.addTaskTableViewContent[indexPath.section];
    
    NSDictionary* content = section[indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    NSString* cellID = content[CellIdKey];
    
    NSUInteger cellTypeIndex = [self.addTaskTableViewCellsInfo indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case RightDetailCell:
        {
            
            break;
        }
            
        case FlexibleCell:
        {
           // OSFlexibleTextCellFactory* factory = [OSFlexibleTextCellFactory new];
            
        }
            break;
            
        case SwitchCell:
        {
            
        }
            break;
            
        case SingleUserInfoCell:
        {
            
        }
            break;
            
        case GroupOfUsersCell:
        {
            
        }
            break;
            
        case MarkedRightDetailCell:
        {
            
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath
{
    NSDictionary* content = self.addTaskTableViewContent[indexPath.section][indexPath.row];
    
    return content[SegueIdKey];
}
#pragma mark - Internal -


#pragma mark - Helpers -

- (NSString*) determineCellIdForGroupOfMembers: (NSArray*) membersGroup
{
    NSString* cellID = [NSString new];
    
    if ( membersGroup.count == 0 )
    {
        cellID = self.addTaskTableViewCellsInfo[RightDetailCell];
    } else
        if ( membersGroup.count == 1 )
        {
            cellID = self.addTaskTableViewCellsInfo[SingleUserInfoCell];
        } else
        {
            cellID = self.addTaskTableViewCellsInfo[GroupOfUsersCell];
        }
    
    return cellID;
}

@end
