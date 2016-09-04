//
//  RoleInfoViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoleInfoViewModel.h"

// Classes
#import "RoleInfoModel.h"

@interface RoleInfoViewModel()

// properties

@property (strong, nonatomic) RoleInfoModel* model;

// methods


@end

@implementation RoleInfoViewModel

#pragma mark - Properties -

- (RoleInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [[RoleInfoModel alloc] init];
    }
    
    return _model;
}




@end
