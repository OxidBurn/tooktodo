//
//  OnRevisionModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OnRevisionModel.h"

// Classes
#import "TasksService.h"

@implementation OnRevisionModel

- (RACSignal*) sendReworkStatusMessage: (NSString*) message
{
    return [[TasksService sharedInstance] sendReworkStatusMessage: message];
}

@end
