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

@property (nonatomic, strong) id<ParentCollectionCellDelegate> varToStoreDelegate;

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
                                         withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    TaskCollectionCellsContent* content = self.taskCollectionViewContent[indexPath.row];
    
    ParentCollectionCell* cell = (ParentCollectionCell*)[[UICollectionViewCell alloc] init];
    
    NSString* cellID = content.cellId;
    
    NSUInteger cellTypeIndex = [self.collectionViewCellsIdArray indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case TermsCell:
        {
            TermsInfoCollectionCellFactory* factory = [TermsInfoCollectionCellFactory new];
            
            cell = [factory returnTermsInfoCellWithContent: content
                                         forCollectionView: collection
                                             withIndexPath: indexPath
                                              withDelegate: delegate];
        }
            break;
            
        case DetailCell:
        {
            DetailCollectionCellFactory* factory = [DetailCollectionCellFactory new];
            
            cell = [factory returnDetailCellWithContent: content
                                      forCollectionView: collection
                                          withIndexPath: indexPath
                                           withDelegate: delegate];
        }
            break;
            
        case OnPlanCell:
        {
            OnPlanCollectionCellFactory* factory = [OnPlanCollectionCellFactory new];
            
            cell = [factory returnOnPlanCellWithContent: content
                                      forCollectionView: collection
                                          withIndexPath: indexPath
                                           withDelegate: delegate];
        }
            break;
            
        case SingleUserCell:
        {
            SingleUserCollectionCellFactory* factory = [SingleUserCollectionCellFactory new];
            
            cell = [factory returnSingleUserCellWithContent: content
                                          forCollectionView: collection
                                              withIndexPath: indexPath
                                               withDelegate: delegate];
        }
            break;
            
        case GroupOfUsersCell:
        {
            GroupOfUsersCollectionFactory* factory = [GroupOfUsersCollectionFactory new];
            
            cell = [factory returnGroupOfUsersCellWithContent: content
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
    TaskCollectionCellsContent* itemSeven = [TaskCollectionCellsContent new];
    TaskCollectionCellsContent* itemEight = [TaskCollectionCellsContent new];
    
    [self fillResponsibleArray: itemSix
            withClaimingsArray: itemSeven
            withObserversArray: itemEight];
    
    itemSix.cellId    = self.collectionViewCellsIdArray[SingleUserCell];
    itemSix.cellTitle = @"Ответственный";
    
    itemSeven.cellTitle = @"Утверждающие";
    itemSeven.hasApprovedTask = [self checkIfTaskApprovedByApprovers: itemSeven.claiming];
    
    if (itemSeven.claiming.count > 1)
        itemSeven.cellId  = self.collectionViewCellsIdArray[GroupOfUsersCell];
    
    else
        itemSeven.cellId  = self.collectionViewCellsIdArray[SingleUserCell];
    
   
    
    itemEight.cellTitle = @"Наблюдатели";
    
    if (itemEight.observers.count > 1)
        itemEight.cellId  = self.collectionViewCellsIdArray[GroupOfUsersCell];
    
    else
        itemEight.cellId  = self.collectionViewCellsIdArray[SingleUserCell];
    

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

- (void) fillResponsibleArray: (TaskCollectionCellsContent*) contentResponsible
           withClaimingsArray: (TaskCollectionCellsContent*) contentClaimings
           withObserversArray: (TaskCollectionCellsContent*) contentObservers
{
    NSArray* roleAssignments = self.task.taskRoleAssignments.allObjects;
    
    contentResponsible.responsible = [NSArray array];
    contentClaimings.claiming      = [NSArray array];
    contentObservers.observers     = [NSArray array];
    
    __block NSMutableArray* tmpResponsibleArr = contentResponsible.responsible.mutableCopy;
    __block NSMutableArray* tmpClaimingsArr   = contentClaimings.claiming.mutableCopy;
    __block NSMutableArray* tmpObserversArr   = contentObservers.observers.mutableCopy;
    
    [roleAssignments enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignments*  _Nonnull taskRoleAssignments, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (taskRoleAssignments.taskRoleType.integerValue)
        {
            case ResponsibleType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.allObjects;
                
                [taskRoleAss enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.allObjects;
                        NSArray* inviteArr = obj.invite.allObjects;
                        
                        [tmpResponsibleArr addObjectsFromArray: assigneeArr];
                        [tmpResponsibleArr addObjectsFromArray: inviteArr];
                    }
                    
                }];
            }
                break;
                
            case ClaimingsType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.allObjects;
                
                [taskRoleAss enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.allObjects;
                        NSArray* inviteArr = obj.invite.allObjects;
                        
                        [tmpClaimingsArr addObjectsFromArray: assigneeArr];
                        [tmpClaimingsArr addObjectsFromArray: inviteArr];
                        
                        [self checkIfTaskApprovedByApprovers: tmpClaimingsArr];
                    }
                    
                }];
            }
                break;
                
            case ObserverType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.allObjects;
                
                [taskRoleAss enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.allObjects;
                        NSArray* inviteArr   = obj.invite.allObjects;
                        
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
    contentClaimings.claiming   = tmpClaimingsArr.copy;
    contentObservers.observers   = tmpObserversArr.copy;
    
    tmpObserversArr = nil;
    tmpClaimingsArr = nil;
    tmpResponsibleArr = nil;
}

- (BOOL) checkIfTaskApprovedByApprovers: (NSArray*) approvers
{
    __block BOOL isApproved = NO;
  
    NSArray* approvmentsArray = self.task.approvments.allObjects;
    
    [approvmentsArray enumerateObjectsUsingBlock:^(TaskApprovments*  _Nonnull approvement, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [approvers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[ProjectTaskAssignee class]])
            {
                ProjectTaskAssignee* assignee = (ProjectTaskAssignee*)obj;
                
                if ([approvement.approverUserId isEqual: assignee.assigneeID])
                {
                    isApproved = YES;
                }
            }
            
            if ([obj isKindOfClass:[ProjectInviteInfo class]])
            {
                ProjectInviteInfo* invite = (ProjectInviteInfo*)obj;
                
                if ([approvement.approverUserId isEqual: invite.inviteID])
                {
                    isApproved = YES;
                }
            }
            
            
        }];
    }];
    
    return isApproved;
}

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
