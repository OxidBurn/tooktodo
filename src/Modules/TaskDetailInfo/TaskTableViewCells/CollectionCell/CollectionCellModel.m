//
//  CollectionCellModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CollectionCellModel.h"

// Classes
#import "DataManager+Tasks.h"
#import "TaskCollectionCellsContent.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectTaskOwner+CoreDataProperties.h"
#import "FilledTeamInfo.h"
#import "ProjectTaskRoleAssignments.h"
#import "DataManager+Team.h"
#import "TaskApprovments+CoreDataClass.h"

// Factories
#import "TermsInfoCollectionCellFactory.h"
#import "DetailCollectionCellFactory.h"
#import "OnPlanCollectionCellFactory.h"
#import "SingleUserCollectionCellFactory.h"
#import "GroupOfUsersCollectionFactory.h"

// Helpers
#import "NSDate+Helper.h"

typedef NS_ENUM(NSUInteger, CollectionItemsList)
{
    TermsItem,
    ActualTermsItem,
    PremisesItem,
    OnPlanItem,
    TaskCreatorItem,
    TaskResponsibleItem,
    TaskClaimingItem,
    TaskObserversItem,
    
};

typedef NS_ENUM(NSUInteger, CellectionItemCellId)
{
    TermsCell,
    DetailCell,
    OnPlanCell,
    SingleUserCell,
    GroupOfUsersCell,
    
};

typedef NS_ENUM(NSUInteger, AssignmentRoleType)
{
    ResponsibleType,
    ClaimingsType,
    ObserverType,
};

@interface CollectionCellModel()

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskCollectionViewContent;

@property (strong, nonatomic) NSArray* collectionViewCellsIdArray;

// methods


@end

@implementation CollectionCellModel

#pragma mark - Properties -

- (ProjectTask*) task
{
    if ( _task == nil )
    {
        _task = [DataManagerShared getSelectedTask];
    }
    
    return _task;
}

- (NSArray*) collectionViewCellsIdArray
{
    if ( _collectionViewCellsIdArray == nil )
    {
        _collectionViewCellsIdArray = @[ @"TermsInfoCollectionCellId", @"DetailCollectionCellId", @"OnPlanCollectionCellId", @"SingleUserCollectionCellId", @"GroupOfUsersCollectionCellId" ];
    }
    
    return _collectionViewCellsIdArray;
}

- (NSArray*) taskCollectionViewContent
{
    if ( _taskCollectionViewContent == nil )
    {
        _taskCollectionViewContent = [self createCollectionViewContent];
    }
    
    return _taskCollectionViewContent;
}

#pragma mark - Public -

- (UICollectionViewCell*) createCellForCollectionView: (UICollectionView*) collection
                                         forIndexPath: (NSIndexPath*)      indexPath
{
    TaskCollectionCellsContent* content = self.taskCollectionViewContent[indexPath.row];
    
    UICollectionViewCell* cell = [[UICollectionViewCell alloc] init];
    
    NSString* cellID = content.cellId;
    
    NSUInteger cellTypeIndex = [self.collectionViewCellsIdArray indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case TermsCell:
        {
            TermsInfoCollectionCellFactory* factory = [TermsInfoCollectionCellFactory new];
            
            cell = [factory returnTermsInfoCellWithContent: content
                                         forCollectionView: collection
                                             withIndexPath: indexPath];
        }
            break;
            
        case DetailCell:
        {
            DetailCollectionCellFactory* factory = [DetailCollectionCellFactory new];
            
            cell = [factory returnDetailCellWithContent: content
                                      forCollectionView: collection
                                          withIndexPath: indexPath];
        }
            break;
            
        case OnPlanCell:
        {
            OnPlanCollectionCellFactory* factory = [OnPlanCollectionCellFactory new];
            
            cell = [factory returnOnPlanCellWithContent: content
                                      forCollectionView: collection
                                          withIndexPath: indexPath];
        }
            break;
            
        case SingleUserCell:
        {
            SingleUserCollectionCellFactory* factory = [SingleUserCollectionCellFactory new];
            
            cell = [factory returnSingleUserCellWithContent: content
                                          forCollectionView: collection
                                              withIndexPath: indexPath];
        }
            break;
            
        case GroupOfUsersCell:
        {
            GroupOfUsersCollectionFactory* factory = [GroupOfUsersCollectionFactory new];
            
            cell = [factory returnGroupOfUsersCellWithContent: content
                                            forCollectionView: collection
                                                withIndexPath: indexPath];
        }
            break;
    }
    
    return cell;

}


#pragma mark - Internal -

- (NSArray*) createCollectionViewContent
{
    TaskCollectionCellsContent* itemOne = [TaskCollectionCellsContent new];
    
    itemOne.cellId     = self.collectionViewCellsIdArray[TermsCell];
    itemOne.cellTitle  = @"Сроки";
    itemOne.cellDetail = [self createTermsLabelTextForStartDate: self.task.startDay
                                                 withFinishDate: self.task.endDate];

    TaskCollectionCellsContent* itemTwo = [TaskCollectionCellsContent new];
    
    itemTwo.cellId     = self.collectionViewCellsIdArray[TermsCell];
    itemTwo.cellTitle  = @"Фактическая дата";
    itemTwo.cellDetail = [self createTermsLabelTextForStartDate: self.task.startDay
                                                 withFinishDate: self.task.closedDate];
    
    TaskCollectionCellsContent* itemThree = [TaskCollectionCellsContent new];
    
    itemThree.cellId     = self.collectionViewCellsIdArray[DetailCell];
    itemThree.cellTitle  = @"Помещение";
    itemThree.cellDetail = self.task.room.title;
    
    TaskCollectionCellsContent* itemFour = [TaskCollectionCellsContent new];
    
    itemFour.cellId    = self.collectionViewCellsIdArray[OnPlanCell];
    itemFour.cellTitle = @"На плане";
    itemFour.roomNumber = self.task.room.number.integerValue;
    
    TaskCollectionCellsContent* itemFive = [TaskCollectionCellsContent new];
    
    itemFive.cellId    = self.collectionViewCellsIdArray[SingleUserCell];
    itemFive.cellTitle = @"Создатель";
    itemFive.taskOwner = [self createOwnerTaskArray];
    
    TaskCollectionCellsContent* itemSix = [TaskCollectionCellsContent new];
    
    itemSix.cellId    = self.collectionViewCellsIdArray[SingleUserCell];
    itemSix.cellTitle = @"Ответственный";
    itemSix.responsible = [self createResponsibleArray];
    
    TaskCollectionCellsContent* itemSeven = [TaskCollectionCellsContent new];
    
    itemSeven.cellId  = self.collectionViewCellsIdArray[SingleUserCell];
    itemSeven.cellTitle = @"Утверждающие";
    itemSeven.claiming  = [self createApproversArray];
    
    TaskCollectionCellsContent* itemEight = [TaskCollectionCellsContent new];

    itemEight.cellId  = self.collectionViewCellsIdArray[GroupOfUsersCell];
    itemEight.cellTitle = @"Наблюдатели";
//    itemEight.observers = [self createRoleAssignmentsArray];
    
    return @[ itemOne, itemTwo, itemThree, itemFour, itemFive, itemSix, itemSeven, itemEight];
}



#pragma mark - Helpers -

- (NSString*) createTermsLabelTextForStartDate: (NSDate*) startDate
                                withFinishDate: (NSDate*) finishDate
{
    NSString* labelText;
    
    NSString* firstDate = [NSDate stringFromDate: startDate withFormat: @"dd.MM"];
    
    NSString* secondDate = [NSDate stringFromDate: finishDate withFormat: @"dd.MM.yyyy"];
    
    labelText = [NSString stringWithFormat: @"%@ - %@", firstDate, secondDate];
    
    return labelText;
}

- (NSArray*) createOwnerTaskArray
{
    FilledTeamInfo* owner = [FilledTeamInfo new];
    
    [owner convertTaskOwnerToTeamInfo: self.task.ownerUser];
    
    return @[ owner ];
}

- (NSArray*) createResponsibleArray
{
    FilledTeamInfo* responsible = [FilledTeamInfo new];
    
    [responsible convertTaskResponsibleToTeamInfo: self.task.responsible];
    
    return @[ responsible ];
}

- (NSArray*) createApproversArray
{
    NSArray* teamInfo = [DataManagerShared getAllTeamInfo];
    NSMutableArray* convertedTeamTmpArr = [NSMutableArray array];
    
    [teamInfo enumerateObjectsUsingBlock: ^(ProjectRoleAssignments*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        FilledTeamInfo* filledUserObj = [FilledTeamInfo new];
        
        [filledUserObj fillTeamInfo: obj];
        
        [convertedTeamTmpArr addObject: filledUserObj];
    }];
    
    //tmp array to save claiming users
    NSMutableArray* tmpApproversArray = [NSMutableArray array];
    
    NSArray* taskApprovements = self.task.approvments.allObjects;
    
    [taskApprovements enumerateObjectsUsingBlock: ^(TaskApprovments*  _Nonnull approvment, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [convertedTeamTmpArr enumerateObjectsUsingBlock: ^(FilledTeamInfo*  _Nonnull user,  NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([approvment.approverUserId isEqual: user.userId])
            {
                [tmpApproversArray addObject: user];
            }
            
        }];
        
    }];
    
    return tmpApproversArray.copy;
}

//- (NSArray*) createRoleAssignmentsArray
//{
//    //getting roleAssignments witch linked with task (claimings, observers, responsible)
//    NSArray* roleAssignments = self.task.taskRoleAssignments.allObjects;
//    
//    //getting all team info to compare with taskRoleAssignments
//    NSArray* teamInfo = [DataManagerShared getAllTeamInfo];
//    NSMutableArray* convertedTeamTmpArr = [NSMutableArray array];
//    
//    [teamInfo enumerateObjectsUsingBlock: ^(ProjectRoleAssignments*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        FilledTeamInfo* filledUserObj = [FilledTeamInfo new];
//        
//        [filledUserObj fillTeamInfo: obj];
//        
//        [convertedTeamTmpArr addObject: filledUserObj];
//    }];
//    
//    //tmp array to save claiming users
//    NSMutableArray* tmpTaskRoleAssignmentUsers = [NSMutableArray array];
//    
//    //enumeration of roleAssignments to check its role
//    [roleAssignments enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignments*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        switch (obj.taskRoleType.integerValue)
//        {
//            case ResponsibleType:
//            {
//                [convertedTeamTmpArr enumerateObjectsUsingBlock: ^(FilledTeamInfo*  _Nonnull responsible,  NSUInteger idx, BOOL * _Nonnull stop) {
//                    
//                    if ([obj.roleAssignmentsID isEqual: responsible.memberID])
//                    {
//                        [tmpTaskRoleAssignmentUsers addObject: responsible];
//                    }
//                    
//                }];
//            }
//                break;
//                
//            case ClaimingsType:
//            {
//                [convertedTeamTmpArr enumerateObjectsUsingBlock: ^(FilledTeamInfo*  _Nonnull claimingUrs,  NSUInteger idx, BOOL * _Nonnull stop) {
//                    
//                    if ([obj.roleAssignmentsID isEqual: claimingUrs.memberID])
//                    {
//                        [tmpTaskRoleAssignmentUsers addObject: claimingUrs];
//                    }
//                    
//                }];
//
//            }
//                
//            case ObserverType:
//            {
//                [convertedTeamTmpArr enumerateObjectsUsingBlock: ^(FilledTeamInfo*  _Nonnull observerUrs,  NSUInteger idx, BOOL * _Nonnull stop) {
//                    
//                    if ([obj.roleAssignmentsID isEqual: observerUrs.memberID])
//                    {
//                        [tmpTaskRoleAssignmentUsers addObject: observerUrs];
//                    }
//                    
//                }];
//            }
//                
//            default:
//                break;
//        }
//        
//    }];
//    
//    return tmpTaskRoleAssignmentUsers.copy;
//}


- (NSString*) determineCollectionCellIdForContent: (NSArray*) arrayToCheck
{
    NSString* cellId;
    
    if ( arrayToCheck == nil || arrayToCheck.count == 0 )
    {
        cellId = self.collectionViewCellsIdArray[DetailCell];
    } else
        if ( arrayToCheck.count == 1 )
        {
            cellId = self.collectionViewCellsIdArray[SingleUserCell];
        } else
            cellId = self.collectionViewCellsIdArray[GroupOfUsersCell];
    
    return cellId;
}
@end
