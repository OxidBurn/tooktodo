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

// Categories
#import "NSString+Utils.h"


@interface CancelRequestModel()

// properties


// methods


@end

@implementation CancelRequestModel


#pragma mark - Public -

-(void) sendRequestLetter: (NSString*) letterText
{
    letterText = [NSString getStringWithoutWhiteSpacesAndNewLines: letterText];
    
    if ( letterText.length > 0 )
    {
        ProjectTask* currentTask = [DataManagerShared getSelectedTask];
        
        ProjectTaskOwner* owner = currentTask.ownerUser;
        
        NSString* email = owner.email;
    }
    else
    {
        [AlertViewBlocks confirmWithTitle: @"Ошибка"
                                  message: @"Текст сообщения не может быть пустым"
                                  confirm: nil];
    }
}

@end
