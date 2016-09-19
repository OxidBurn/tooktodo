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

typedef NS_ENUM(NSUInteger, AddTaskScreenSegueId) {
    
    ShowAddCommentSegueId,
    ShowTermsSegueID,
    ShowFilterForResponsibleSegueID,
    ShowPremisesSegueID,
    
};


static NSString* CellIdKey           = @"CellIdKey";
static NSString* SegueIdKey          = @"SegueIdKey";

static NSString* TitleTextKey        = @"TitleKey";
static NSString* DetailTextKey       = @"DetailTextKey";
static NSString* isHiddenKey         = @"isHiddenKey";
static NSString* SingleUserInfoKey   = @"MemberInfoKey";
static NSString* GroupOfUsersInfoKey = @"GroupOfUsersInfoKey";
static NSString* MarkImageKey        = @"MarkImageKey";

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

- (NSArray*) addTaskTableViewSeguesInfo
{
    if ( _addTaskTableViewSeguesInfo == nil )
    {
        _addTaskTableViewSeguesInfo = @[@"ShowAddMassageController", @"ShowAddTermTaskController", @"ShowFilterForResponsibleController", @"ShowSelectionPremisesController"];
    }
    
    return _addTaskTableViewSeguesInfo;
}

- (NSArray*) addTaskTableViewContent
{
    if ( _addTaskTableViewContent == nil )
    {
        _addTaskTableViewContent = [self createTableViewContent];
    }
    
    return _addTaskTableViewContent;
}

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
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content[TitleTextKey]
                                            withDetailText: content[DetailTextKey]
                                              forTableView: tableView];
            break;
        }
            
        case FlexibleCell:
        {
            OSFlexibleTextCellFactory* factory = [OSFlexibleTextCellFactory new];
            
            cell = [factory returnFlexibleCellWithTextContent: content[TitleTextKey]
                                                 forTableView: tableView];
            
        }
            break;
            
        case SwitchCell:
        {
            OSSwitchTableCellFactory* factory = [OSSwitchTableCellFactory new];
            
            NSNumber* stateNumberValue = content[isHiddenKey];
            
            BOOL stateBoolValue = stateNumberValue.boolValue;
            
            cell = [factory returnSwitchCellWithTitle: content[TitleTextKey]
                                      withSwitchState: stateBoolValue
                                         forTableView: tableView];
        }
            break;
            
        case SingleUserInfoCell:
        {
            OSSingleUserInfoCellFactory* factory = [OSSingleUserInfoCellFactory new];
            
            cell = [factory returnSingleUserCellWithTitle: content[TitleTextKey]
                                         withUserFullName: @"Имя пользователя"
                                           withUserAvatar: [UIImage imageNamed: @"Mail"]
                                             forTableView: tableView];
        }
            break;
            
        case GroupOfUsersCell:
        {
            OSGroupOfUsersInfoCellFactory* factory = [OSGroupOfUsersInfoCellFactory new];
            
            cell = [factory returnGroupOfUsersCellWithTitle: content[TitleTextKey]
                                               forTableView: tableView];

        }
            break;
            
        case MarkedRightDetailCell:
        {
            OSMarkedRightDetailCellFactory* factory = [OSMarkedRightDetailCellFactory new];

            cell = [factory returnMarkedRightDetailCellWithTitle: content[TitleTextKey]
                                                  withDetailText: content[DetailTextKey]
                                                   withMarkImage: content[MarkImageKey]
                                                    forTableView: tableView];
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

- (NSArray*) createTableViewContent
{
    NSArray* sectionOne   = [self createSectionOne];
    
    NSArray* sectionTwo   = [self createSectionTwo];
    
    NSArray* sectionThree = [self createSectionThree];
    
    return [NSArray arrayWithObjects: sectionOne, sectionTwo, sectionThree, nil];
}

- (NSArray*) createSectionOne
{
    
    NSDictionary* rowOne   = @{ CellIdKey : self.addTaskTableViewCellsInfo[FlexibleCell],
                                TitleTextKey  : @"Название задачи" };
    
    NSDictionary* rowTwo   = @{ CellIdKey  : self.addTaskTableViewCellsInfo[FlexibleCell],
                                TitleTextKey   : @"Описание задачи",
                                SegueIdKey : self.addTaskTableViewSeguesInfo[ShowAddCommentSegueId] };
    
    NSDictionary* rowThree = @{ CellIdKey  : self.addTaskTableViewCellsInfo[SwitchCell],
                                isHiddenKey : @(0),
                                TitleTextKey    : @"Скрытая задача"};
    
    NSDictionary* rowFour  = @{ CellIdKey    : self.addTaskTableViewCellsInfo[SingleUserInfoCell],
                                TitleTextKey : @"Ответственный",
                                SegueIdKey   : self.addTaskTableViewSeguesInfo[ShowFilterForResponsibleSegueID] };
    
    NSString* cellForRowFiveId = [self determineCellIdForGroupOfMembers: @[@"TestString"]];
    
    NSString* cellFiveDetailText  = [cellForRowFiveId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбрано" : @"";
    
    NSDictionary* rowFive  = @{ TitleTextKey    : @"Утверждающие",
                                DetailTextKey   : cellFiveDetailText,
                                CellIdKey       : cellForRowFiveId,
                                SegueIdKey      : self.addTaskTableViewSeguesInfo[ShowFilterForResponsibleSegueID]};
    
    NSString* cellForRowSixId = self.addTaskTableViewCellsInfo[GroupOfUsersCell];
    
    NSString* cellSixDetailText  = [cellForRowSixId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбрано" : @"";
    
    NSDictionary* rowSix   = @{ TitleTextKey  : @"Наблюдатели",
                                DetailTextKey : cellSixDetailText,
                                CellIdKey     : cellForRowSixId,
                                SegueIdKey    : self.addTaskTableViewSeguesInfo[ShowFilterForResponsibleSegueID]};
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}

- (NSArray*) createSectionTwo
{
    NSDictionary* row = @{ TitleTextKey  : @"Сроки",
                           DetailTextKey : @"Не выбраны",
                           CellIdKey     : self.addTaskTableViewCellsInfo[RightDetailCell],
                           SegueIdKey    : self.addTaskTableViewSeguesInfo[ShowTermsSegueID]};
    
    return @[ row ];
}

- (NSArray*) createSectionThree
{
    NSDictionary* rowOne   = @{ TitleTextKey  : @"Помещение",
                                DetailTextKey : @"Не реализовано",
                                CellIdKey     : self.addTaskTableViewCellsInfo[RightDetailCell] };
    
    NSDictionary* rowTwo   = @{ TitleTextKey  : @"Задача на плане",
                                DetailTextKey : @"Не реализовано",
                                CellIdKey     : self.addTaskTableViewCellsInfo[RightDetailCell] };
    
    NSDictionary* rowThree = @{ TitleTextKey  : @"Этап",
                                DetailTextKey : @"Не реализовано",
                                CellIdKey     : self.addTaskTableViewCellsInfo[RightDetailCell] };
    
    NSDictionary* rowFour  = @{ TitleTextKey  : @"Система",
                                DetailTextKey : @"Не реализовано",
                                CellIdKey     : self.addTaskTableViewCellsInfo[RightDetailCell] };
    
    NSDictionary* rowFive  = @{ TitleTextKey  : @"Тип задачи",
                                MarkImageKey  : [UIImage imageNamed: @"GreenMark"],
                                DetailTextKey : @"Не реализовано",
                                CellIdKey     : self.addTaskTableViewCellsInfo[MarkedRightDetailCell] };
    
    NSDictionary* rowSix   = @{ TitleTextKey  : @"Документы к задаче",
                                DetailTextKey : @"Не реализовано",
                                CellIdKey     : self.addTaskTableViewCellsInfo[RightDetailCell] };
    
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}



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
