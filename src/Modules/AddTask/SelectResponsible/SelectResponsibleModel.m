//
//  SelectResponsibleModel.m
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleModel.h"

@interface SelectResponsibleModel()

// properties
@property (strong, nonatomic) NSArray* membersArray;

// methods


@end

@implementation SelectResponsibleModel

#pragma mark - Public -

- (NSUInteger) getNumberOfRows
{
    return self.membersArray.count;
}

@end
