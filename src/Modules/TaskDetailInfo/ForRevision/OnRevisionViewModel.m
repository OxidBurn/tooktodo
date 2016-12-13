//
//  OnRevisionViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OnRevisionViewModel.h"

// Class
#import "OnRevisionModel.h"


@interface OnRevisionViewModel()

// properties

@property (nonatomic, strong) RACSignal* enableSendSignal;

@property (strong, nonatomic) OnRevisionModel* model;

// methods


@end

@implementation OnRevisionViewModel


#pragma mark - Initialization -

- (instancetype) init
{
    if ( self = [super init] )
    {
        [self initialize];
    }
    
    return self;
}

- (void) initialize
{
    self.enableSendSignal = [RACObserve(self, commentText) map: ^id(NSString* value) {
        
        return @(value.length > 0);
        
    }];
}


#pragma mark - Properties -

- (OnRevisionModel*) model
{
    if ( _model == nil )
    {
        _model = [OnRevisionModel new];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (RACCommand*) sendReworkCommand
{
    RACCommand* sendCommand = [[RACCommand alloc] initWithEnabled: self.enableSendSignal
                                                      signalBlock: ^RACSignal *(id input) {
                                                          
                                                          return [self.model sendReworkStatusMessage: self.commentText];
                                                          
                                                      }];
    
    return sendCommand;
}

@end
