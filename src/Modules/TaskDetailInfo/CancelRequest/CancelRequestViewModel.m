//
//  CancelRequestViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 17.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CancelRequestViewModel.h"

// Classes
#import "CancelRequestModel.h"

@interface CancelRequestViewModel()

// properties
@property (strong, nonatomic) CancelRequestModel* model;

// methods


@end

@implementation CancelRequestViewModel


#pragma mark - Properties -

- (CancelRequestModel*) model
{
    if ( _model == nil )
    {
        _model = [CancelRequestModel new];
    }
    
    return _model;
}


#pragma mark - Public -

- (void) sendRequestLetter: (NSString*) letterText
{
    [self.model sendRequestLetter: letterText];
}

@end
