//
//  AddTaskViewModel.m
//  TookTODO
//
//  Created by Глеб on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskViewModel.h"

// Classes
#import "AddTaskModel.h"

@interface AddTaskViewModel()

// properties
@property (strong, nonatomic) AddTaskModel* model;

// methods


@end


@implementation AddTaskViewModel

#pragma mark - Properties -

- (AddTaskModel*) model
{
    if ( _model == nil )
    {
        _model = [AddTaskModel new];
    }
    
    return _model;
}


@end
