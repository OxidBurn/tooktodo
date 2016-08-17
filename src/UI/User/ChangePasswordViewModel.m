//
//  ChangePasswordViewModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangePasswordViewModel.h"
#import "ChangePasswordModel.h"

@interface ChangePasswordViewModel()

// properties

@property (strong, nonatomic) ChangePasswordModel* model;

// methods


@end

@implementation ChangePasswordViewModel

#pragma mark - Properties -

- (ChangePasswordModel*) model
{
    if ( _model == nil )
    {
        _model = [ChangePasswordModel new];
    }
    
    return _model;
}

@end
