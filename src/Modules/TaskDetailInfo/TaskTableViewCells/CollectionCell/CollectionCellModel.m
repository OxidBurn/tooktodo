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

// Factories
#import "TermsInfoCollectionCellFactory.h"
#import "DetailCollectionCellFactory.h"
#import "OnPlanCollectionCellFactory.h"
#import "SingleUserCollectionCellFactory.h"
#import "GroupOfUsersCollectionFactory.h"

// Helpers
#import "NSDate+Helper.h"

typedef NS_ENUM(NSUInteger, CollectionItemsList) {

    TermsItem,
    ActualTermsItem,
    PremisesItem,
    OnPlanItem,
    TaskCreatorItem,
    TaskResponsibleItem,
    TaskClaimingItem,
    TaskObserversItem,
    
};

typedef NS_ENUM(NSUInteger, CellectionItemCellId) {
    
    TermsCell,
    DetailCell,
    OnPlanCell,
    SingleUserCell,
    GroupOfUsersCell,
    
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
    
    itemSeven.cellId  = self.collectionViewCellsIdArray[GroupOfUsersCell];
    itemSeven.cellTitle = @"Утверждающий";
    
    TaskCollectionCellsContent* itemEight = [TaskCollectionCellsContent new];

    itemEight.cellId  = self.collectionViewCellsIdArray[GroupOfUsersCell];
    itemEight.cellTitle = @"Наблюдатели";
    
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
