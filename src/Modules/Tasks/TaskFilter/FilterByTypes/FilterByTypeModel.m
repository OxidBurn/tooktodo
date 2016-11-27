//
//  FilterByTypeModel.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTypeModel.h"

@interface FilterByTypeModel()

// properties
@property (strong, nonatomic) NSArray* selectedTypesIndexes;

// methods

@end

@implementation FilterByTypeModel


#pragma mark - Properties -

- (NSArray*) selectedTypesIndexes
{
    if ( _selectedTypesIndexes == nil )
    {
        _selectedTypesIndexes = [NSArray array];
    }
    
    return _selectedTypesIndexes;
}


#pragma mark - Public -


- (NSArray*) getSelectedTypeIndexesArray
{
    return self.selectedTypesIndexes;
}

- (void) handleTypesSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected types
    NSMutableArray* tmp = self.selectedTypesIndexes.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedTypesIndexes containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedTypesIndexes = tmp.copy;
}

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected;
    
    [self handleTypesSelectionForIndexPath: indexPath];
    
    if ( [self.selectedTypesIndexes containsObject: @(indexPath.row)] )
        isSelected = YES;
    
    return isSelected;
}

- (UIColor*) getTaskTypeColor: (TaskType) type
{
    UIColor* typeColor = [UIColor clearColor];
    
    switch (type)
    {
        case TaskWorkType:
            typeColor = [UIColor colorWithRed:0.310 green:0.773 blue:0.176 alpha:1.000];
            break;
            
        case TaskAgreementType:
            typeColor = [UIColor colorWithRed:0.424 green:0.663 blue:0.792 alpha:1.000];
            break;
            
        case TaskObservationType:
            typeColor = [UIColor colorWithRed:1.00 green:0.89 blue:0.27 alpha:1.00];
            break;
            
        case TaskRemarkType:
            typeColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1.000];
            break;
    }
    
    return typeColor;
}

- (NSString*) getTaskTypeDescription: (TaskType) type
{
    NSString* typeDescription = @"";
    
    switch (type)
    {
        case TaskWorkType:
            typeDescription = @"Работа";
            break;
            
        case TaskAgreementType:
            typeDescription = @"Согласование";
            break;
            
        case TaskObservationType:
            typeDescription = @"Наблюдение";
            break;
            
        case TaskRemarkType:
            typeDescription = @"Замечание";
            break;
    }
    
    return typeDescription;
}

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    self.selectedTypesIndexes = filterConfig.byTaskType;
}

- (void) selectAll
{
    __block NSMutableArray* tmp = [NSMutableArray new];
    NSArray* typesArr = @[@(TaskWorkType), @(TaskAgreementType), @(TaskObservationType), @(TaskRemarkType)];
    
    [typesArr enumerateObjectsUsingBlock: ^(NSNumber* type, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tmp addObject: @(idx)];
        
    }];
    
    self.selectedTypesIndexes = tmp.copy;
}

- (void) deselectAll
{
    self.selectedTypesIndexes = nil;
}

@end
