//
//  FilterByRoleInProjectModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoleInProjectModel.h"

// Classes
#import "ProjectsEnumerations.h"

@interface FilterByRoleInProjectModel()

// properties
@property (strong, nonatomic) NSArray* rolesTitlesArray;

@property (strong, nonatomic) NSNumber* selectedRole;

@property (strong, nonatomic) NSIndexPath* previousSelectedIndexPath;


// methods


@end

@implementation FilterByRoleInProjectModel


#pragma mark - Properties -

- (NSArray*) rolesTitlesArray
{
    if ( _rolesTitlesArray == nil )
    {
        _rolesTitlesArray = @[ @"Я участник",
                               @"Я ответственный",
                               @"Я утверждающий",
                               @"Я создатель" ];
    }
    
    return _rolesTitlesArray;
}


#pragma mark - Public -

- (void) fillSelectedRoleType: (NSNumber*) roleType
{
    self.selectedRole = roleType;
    
    self.previousSelectedIndexPath = [NSIndexPath indexPathForRow: roleType.integerValue
                                                        inSection: 0];
}

- (NSNumber*) getSelectedRoleType
{
    return self.selectedRole;
}

- (NSString*) getTitleForIndexPath: (NSIndexPath*) indexPath
{
    return self.rolesTitlesArray[indexPath.row];
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath
{
    if ( [indexPath isEqual: self.previousSelectedIndexPath] )
    {
        self.previousSelectedIndexPath = nil;
    }
    
    if ( [indexPath isEqual: self.previousSelectedIndexPath] == NO )
    {
        self.selectedRole = @(indexPath.row);
    }
    else
    {
        self.selectedRole = nil;
    }

}

- (BOOL) getSelectedStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected = NO;
    
    if ( self.selectedRole.integerValue == indexPath.row)
    {
        isSelected = YES;
    }
    
    return isSelected;
}

- (NSIndexPath*) getPreviousIndexPath
{
    return self.previousSelectedIndexPath;
}

- (void) updatePreviousCellIndexPath: (NSIndexPath*) indexPath
{
    self.previousSelectedIndexPath = indexPath;
}

@end
