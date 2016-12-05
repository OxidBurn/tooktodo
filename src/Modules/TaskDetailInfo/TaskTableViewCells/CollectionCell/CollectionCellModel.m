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
#import "ProjectTaskRoleAssignments+CoreDataClass.h"
#import "DataManager+Team.h"
#import "TaskApprovments+CoreDataClass.h"
#import "ProjectTaskRoleAssignment+CoreDataClass.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectInviteInfo+CoreDataClass.h"
#import "ParentCollectionCell.h"
#import "ProjectsEnumerations.h"
#import "ProjectTaskResponsible+CoreDataClass.h"

// Factories
#import "TermsInfoCollectionCellFactory.h"
#import "DetailCollectionCellFactory.h"
#import "OnPlanCollectionCellFactory.h"
#import "SingleUserCollectionCellFactory.h"
#import "GroupOfUsersCollectionFactory.h"
#import "DefaultCollectionCellFactory.h"

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

typedef NS_ENUM(NSUInteger, CollectionItemCellId)
{
    CollectionTermsCell,
    CollectionDetailCell,
    CollectionOnPlanCell,
    CollectionSingleUserCell,
    CollectionGroupOfUsersCell,
    CollectionDefaultCell,
};

@interface CollectionCellModel()

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskCollectionViewContent;

@property (strong, nonatomic) NSArray* collectionViewCellsIdArray;

@property (nonatomic, strong) id<ParentCollectionCellDelegate> varToStoreDelegate;

@property (nonatomic, strong) NSArray* approversIDsArray;

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
        _collectionViewCellsIdArray = @[ @"TermsInfoCollectionCellId", @"DetailCollectionCellId", @"OnPlanCollectionCellId", @"SingleUserCollectionCellId", @"GroupOfUsersCollectionCellId", @"DefaultCollectionCellId" ];
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

- (NSArray*) approversIDsArray
{
    if ( _approversIDsArray == nil )
    {
        NSMutableArray* tmpArr = [NSMutableArray arrayWithCapacity: self.task.approvments.count];
        
        [self.task.approvments enumerateObjectsUsingBlock:^(TaskApprovments * _Nonnull obj, BOOL * _Nonnull stop) {
            
            [tmpArr addObject: obj.approverUserId];
            
        }];
        
        _approversIDsArray = tmpArr.copy;
        
        tmpArr = nil;
    }
    
    return _approversIDsArray;
}

#pragma mark - Public -

- (UICollectionViewCell*) createCellForCollectionView: (UICollectionView*) collection
                                         forIndexPath: (NSIndexPath*)      indexPath
                                         withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    TaskCollectionCellsContent* content = self.taskCollectionViewContent[indexPath.row];
    
    ParentCollectionCell* cell = (ParentCollectionCell*)[[UICollectionViewCell alloc] init];
    
    NSString* cellID = content.cellId;
    
    NSUInteger cellTypeIndex = [self.collectionViewCellsIdArray indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case CollectionTermsCell:
        {
            TermsInfoCollectionCellFactory* factory = [TermsInfoCollectionCellFactory new];
            
            cell = [factory returnTermsInfoCellWithContent: content
                                         forCollectionView: collection
                                             withIndexPath: indexPath
                                              withDelegate: delegate];
        }
            break;
            
        case CollectionDetailCell:
        {
            DetailCollectionCellFactory* factory = [DetailCollectionCellFactory new];
            
            cell = [factory returnDetailCellWithContent: content
                                      forCollectionView: collection
                                          withIndexPath: indexPath
                                           withDelegate: delegate];
        }
            break;
            
        case CollectionOnPlanCell:
        {
            OnPlanCollectionCellFactory* factory = [OnPlanCollectionCellFactory new];
            
            cell = [factory returnOnPlanCellWithContent: content
                                      forCollectionView: collection
                                          withIndexPath: indexPath
                                           withDelegate: delegate];
        }
            break;
            
        case CollectionSingleUserCell:
        {
            SingleUserCollectionCellFactory* factory = [SingleUserCollectionCellFactory new];
            
            cell = [factory returnSingleUserCellWithContent: content
                                          forCollectionView: collection
                                              withIndexPath: indexPath
                                               withDelegate: delegate];
        }
            break;
            
        case CollectionGroupOfUsersCell:
        {
            GroupOfUsersCollectionFactory* factory = [GroupOfUsersCollectionFactory new];
            
            cell = [factory returnGroupOfUsersCellWithContent: content
                                            forCollectionView: collection
                                                withIndexPath: indexPath
                                                 withDelegate: delegate];
        }
            break;
            
        case CollectionDefaultCell:
        {
            DefaultCollectionCellFactory* factory = [DefaultCollectionCellFactory new];
            
            cell = [factory returnDefaultCellWithContent: content
                                       forCollectionView: collection
                                           withIndexPath: indexPath
                                            withDelegate: delegate];
        }
            break;
    }
    
    return cell;

}

- (void) fillParentCollectionCellDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    self.varToStoreDelegate = delegate;
}

- (id<ParentCollectionCellDelegate>) getVarToStoreParentCollectionCellDelegate
{
    return self.varToStoreDelegate;
}

#pragma mark - Internal -

- (NSArray*) createCollectionViewContent
{
    TaskCollectionCellsContent* itemOne = [TaskCollectionCellsContent new];
    
    itemOne.cellId     = self.collectionViewCellsIdArray[CollectionTermsCell];
    itemOne.cellTitle  = @"Сроки";
    itemOne.cellDetail = [self createTermsLabelTextForStartDate: self.task.startDay
                                                 withFinishDate: self.task.endDate];

    TaskCollectionCellsContent* itemTwo = [TaskCollectionCellsContent new];
    
    itemTwo.cellId     = self.collectionViewCellsIdArray[CollectionTermsCell];
    itemTwo.cellTitle  = @"Фактическая дата";
    itemTwo.cellDetail = [self createTermsLabelTextForStartDate: self.task.factualStartDate
                                                 withFinishDate: self.task.factualEndDate];
    
    TaskCollectionCellsContent* itemThree = [TaskCollectionCellsContent new];
    
    itemThree.cellId     = self.collectionViewCellsIdArray[CollectionDetailCell];
    itemThree.cellTitle  = @"Помещение";
    
    NSArray* rooms = self.task.rooms.array;
    
    [rooms enumerateObjectsUsingBlock:^(ProjectTaskRoom*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        itemThree.cellDetail = obj.title;
        itemThree.roomNumber = obj.number.integerValue;
    }];
    
    
    
    TaskCollectionCellsContent* itemFour = [TaskCollectionCellsContent new];
    
    itemFour.cellId    = self.collectionViewCellsIdArray[CollectionOnPlanCell];
    itemFour.cellTitle = @"На плане";
    itemFour.roomNumber = self.task.room.number.integerValue;
    
    TaskCollectionCellsContent* itemFive = [TaskCollectionCellsContent new];
    
    itemFive.cellId    = self.collectionViewCellsIdArray[CollectionSingleUserCell];
    itemFive.cellTitle = @"Создатель";
    itemFive.taskOwner = [self createOwnerTaskArray];
    
    TaskCollectionCellsContent* itemSix = [TaskCollectionCellsContent new];
    TaskCollectionCellsContent* itemSeven = [TaskCollectionCellsContent new];
    TaskCollectionCellsContent* itemEight = [TaskCollectionCellsContent new];
    
    [self fillResponsibleArray: itemSix
            withClaimingsArray: itemSeven
            withObserversArray: itemEight];
    
    NSString* responsibleCellId = [self determineCollectionCellIdForContent: itemSix.responsible];
    
    NSString* claimingCellId = [self determineCollectionCellIdForContent: itemSeven.claiming];
    
    NSString* observersCellId = [self determineCollectionCellIdForContent: itemEight.observers];
    
    NSString* responsibleDetailText  = [responsibleCellId isEqualToString: self.collectionViewCellsIdArray[CollectionDefaultCell]] ? @"Не указан" : @"";
    
    NSString* claimingDetailText  = [claimingCellId isEqualToString: self.collectionViewCellsIdArray[CollectionDefaultCell]] ? @"Не выбраны" : @"";
    
    NSString* observersDetailText  = [observersCellId isEqualToString: self.collectionViewCellsIdArray[CollectionDefaultCell]] ? @"Не выбраны" : @"";
    
    itemSix.cellTitle  = @"Ответственный";
    itemSix.cellId     = responsibleCellId;
    itemSix.cellDetail = responsibleDetailText;
    
    itemSeven.cellTitle  = @"Утверждающие";
    itemSeven.cellId     = claimingCellId;
    itemSeven.cellDetail = claimingDetailText;
    
    itemEight.cellTitle  = @"Наблюдатели";
    itemEight.cellId     = observersCellId;
    itemEight.cellDetail = observersDetailText;

    return @[ itemOne, itemTwo, itemThree, itemFour, itemFive, itemSix, itemSeven, itemEight];
}


#pragma mark - Helpers -

- (NSString*) createTermsLabelTextForStartDate: (NSDate*) startDate
                                withFinishDate: (NSDate*) finishDate
{
    NSString* startDateString = [NSDate stringFromDate: startDate withFormat: @"dd.MM"];
    NSString* endDateString   = [NSDate stringFromDate: finishDate withFormat: @"dd.MM.yyyy"];
    
    NSString* detailString = [NSString string];
    
    if ( startDateString )
    {
        if ( endDateString )
        {
            detailString = [NSString stringWithFormat: @"%@ — %@",
                            startDateString,
                            endDateString];
        }
        else
            detailString = [NSString stringWithFormat: @"%@ —", startDateString];
    }
    else
    {
        if ( endDateString)
        {
            detailString = [NSString stringWithFormat: @"— %@", endDateString];
        }
        else
            detailString = @"";
    }
    
    return detailString;
}

- (NSArray*) createOwnerTaskArray
{
    FilledTeamInfo* owner = [FilledTeamInfo new];
    
    [owner convertTaskOwnerToTeamInfo: self.task.ownerUser];
    
    return @[ owner ];
}

- (NSArray*) createResponsibleArray
{
    ProjectTaskResponsible* responsible = self.task.responsible;
    
    if (responsible != nil)
    {
        return @[ responsible ];
    }
    
    else
        return nil;
}


- (void) fillResponsibleArray: (TaskCollectionCellsContent*) contentResponsible
           withClaimingsArray: (TaskCollectionCellsContent*) contentClaimings
           withObserversArray: (TaskCollectionCellsContent*) contentObservers
{
    NSArray* roleAssignments = self.task.taskRoleAssignments.array;
    
    contentResponsible.responsible = [NSArray array];
    contentClaimings.claiming      = [NSArray array];
    contentObservers.observers     = [NSArray array];
    
    __block NSMutableArray* tmpResponsibleArr = contentResponsible.responsible.mutableCopy;
    __block NSMutableArray* tmpClaimingsArr   = contentClaimings.claiming.mutableCopy;
    __block NSMutableArray* tmpObserversArr   = contentObservers.observers.mutableCopy;
    
    [roleAssignments enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignments*  _Nonnull taskRoleAssignments, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (taskRoleAssignments.taskRoleType.integerValue)
        {
            case ResponsibleRoleType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.array;
                
                [taskRoleAss enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.array;
                        NSArray* inviteArr = obj.invite.array;
                        
                        [tmpResponsibleArr addObjectsFromArray: assigneeArr];
                        [tmpResponsibleArr addObjectsFromArray: inviteArr];
                    }
                    
                }];
            }
                break;
                
            case ClaimingsRoleType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.array;
                
                [taskRoleAss enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.array;
                        NSArray* inviteArr = obj.invite.array;
                        
                        [tmpClaimingsArr addObjectsFromArray: assigneeArr];
                        [tmpClaimingsArr addObjectsFromArray: inviteArr];
                    }
                    
                }];
            }
                break;
                
            case ObserverRoleType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.array;
                
                [taskRoleAss enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.array;
                        NSArray* inviteArr   = obj.invite.array;
                        
                        [tmpObserversArr addObjectsFromArray: assigneeArr];
                        [tmpObserversArr addObjectsFromArray: inviteArr];
                    
                    }
                    
                }];
                
            }
                
                break;
                
            default:
                break;
                
        }
    }];
    
    contentResponsible.responsible = tmpResponsibleArr.copy;
    contentClaimings.claiming      = tmpClaimingsArr.copy;
    contentObservers.observers     = tmpObserversArr.copy;
    contentClaimings.approvers     = [self checkIfTaskApprovedByApprovers: tmpClaimingsArr];
    
    tmpObserversArr = nil;
    tmpClaimingsArr = nil;
    tmpResponsibleArr = nil;
}

- (NSArray*) checkIfTaskApprovedByApprovers: (NSArray*) approvers
{
    NSArray* approvmentsArray = self.task.approvments.allObjects;
    
    NSMutableArray* tmpApproversArr = [NSMutableArray array];
    
    
    [approvmentsArray enumerateObjectsUsingBlock:^(TaskApprovments*  _Nonnull approvement, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [approvers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[ProjectTaskAssignee class]])
            {
                ProjectTaskAssignee* assignee = (ProjectTaskAssignee*)obj;
                
                if ([approvement.approverUserId isEqual: assignee.assigneeID])
                {
                    [tmpApproversArr addObject: assignee.assigneeID];
                }
            }
            
            if ([obj isKindOfClass:[ProjectInviteInfo class]])
            {
                ProjectInviteInfo* invite = (ProjectInviteInfo*)obj;
                
                if ([approvement.approverUserId isEqual: invite.inviteID])
                {
                    [tmpApproversArr addObject: invite.inviteID];
                }
            }
            
            
        }];
    }];
    
    return tmpApproversArr.copy;
}

- (NSString*) determineCollectionCellIdForContent: (NSArray*) arrayToCheck
{
    NSString* cellId;
    
    if ( arrayToCheck == nil || arrayToCheck.count == 0 )
    {
        cellId = self.collectionViewCellsIdArray[CollectionDefaultCell];
    } else
        if ( arrayToCheck.count == 1 )
        {
            cellId = self.collectionViewCellsIdArray[CollectionSingleUserCell];
        } else
            cellId = self.collectionViewCellsIdArray[CollectionGroupOfUsersCell];
    
    return cellId;
}
@end
