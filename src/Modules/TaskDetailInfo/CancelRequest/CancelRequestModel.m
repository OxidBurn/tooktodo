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
#import <MessageUI/MessageUI.h>

// Categories
#import "NSString+Utils.h"
#import "UIViewController+Utils.h"

@interface CancelRequestModel() <MFMailComposeViewControllerDelegate>

// properties

@property (strong, nonatomic) MFMailComposeViewController* mc;

@property (copy, nonatomic) void(^sendMailCompletionBlock)(BOOL isSuccess);

// methods


@end

@implementation CancelRequestModel


#pragma mark - Public -

- (void) sendRequestLetter: (NSString*)             letterText
            withCompletion: (CompletionWithSuccess) completion
{
    letterText = [NSString getStringWithoutWhiteSpacesAndNewLines: letterText];
    
    if ( [MFMailComposeViewController canSendMail] )
    {
        if ( letterText.length > 0 )
        {
            self.sendMailCompletionBlock = completion;
            
            ProjectTask* currentTask = [DataManagerShared getSelectedTask];
            
            ProjectTaskOwner* owner = currentTask.ownerUser;
            
            NSString* emailAdress = owner.email;
            // To address
            NSArray *toRecipents = [NSArray arrayWithObject: emailAdress];
            
            self.mc = [[MFMailComposeViewController alloc] init];
            self.mc.mailComposeDelegate = self;
            
            [self.mc setSubject: @"Запрос на отмену проекта"];
            
            [self.mc setMessageBody: letterText
                        isHTML: NO];
            
            [self.mc setToRecipients: toRecipents];
            
            // Present mail view controller on screen
            [[UIViewController topMostController] presentViewController: self.mc
                                                               animated: YES
                                                             completion: NULL];
            
        }
        else
        {
            [AlertViewBlocks confirmWithTitle: @"Ошибка"
                                      message: @"Текст сообщения не может быть пустым"
                                      confirm: nil];
        }
    }
    else
    {
        [AlertViewBlocks confirmWithTitle: @"Ошибка"
                                  message: @"Вы не можете отправить письмо"
                                  confirm: nil];
    }
}


#pragma mark - Mail delegate methods -

- (void) mailComposeController: (MFMailComposeViewController*) controller
           didFinishWithResult: (MFMailComposeResult)          result
                         error: (NSError*)                     error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
        {
            if ( self.sendMailCompletionBlock )
                self.sendMailCompletionBlock(YES);
            
            NSLog(@"Mail sent");
        }
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self.mc dismissViewControllerAnimated: YES
                                completion: NULL];
}

@end
