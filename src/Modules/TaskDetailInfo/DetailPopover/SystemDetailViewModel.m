//
//  SystemDetailViewModel.m
//  TookTODO
//
//  Created by Lera on 24.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SystemDetailViewModel.h"
#import "SystemDetailModel.h"

@interface SystemDetailViewModel ()

@property (nonatomic, strong) SystemDetailModel* model;

@end

@implementation SystemDetailViewModel


#pragma mark - Properties -

- (SystemDetailModel*) model
{
    if (_model == nil)
    {
        _model = [SystemDetailModel new];
    }
    
    return _model;
}

- (NSString*) getProjectSystemDetails
{
    NSString* systemTitle = [self.model getProjectSystemDetailTitle];
    
    return systemTitle;
}


@end
