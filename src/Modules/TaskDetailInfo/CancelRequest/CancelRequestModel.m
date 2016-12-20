//
//  CancelReguestModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 17.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CancelRequestModel.h"

// Classes
#import "ProjectTask+CoreDataClass.h"
#import "DataManager+Tasks.h"
#import "ProjectTaskOwner+CoreDataClass.h"
#import "AlertViewBlocks.h"
#import "TasksService.h"

// Categories
#import "NSString+Utils.h"

@interface CancelRequestModel()

// properties

// methods


@end

@implementation CancelRequestModel


#pragma mark - Public -

- (void) sendRequestLetter: (NSString*)             letterText
            withCompletion: (CompletionWithSuccess) completion
{
    letterText = [NSString getStringWithoutWhiteSpacesAndNewLines: letterText];
    
    if ( letterText.length > 0 )
    {
        [[[TasksService sharedInstance] requestToCancelTask: letterText]
         subscribeNext: ^(id x) {
             
             if ( completion )
                 completion(YES);
             
         }
         error: ^(NSError *error) {
             
         }];
    }
    else
    {
        [AlertViewBlocks confirmWithTitle: @"Ошибка"
                                  message: @"Текст сообщения не может быть пустым"
                                  confirm: nil];
    }
}

@end
