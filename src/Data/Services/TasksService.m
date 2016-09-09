//
//  TasksService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksService.h"

// Classes
#import "TasksAPIService.h"
#import "ProjectTaskModel.h"
#import "APIConstance.h"

// Categories
#import "DataManager+Tasks.h"

@implementation TasksService


#pragma mark - Shared -

+ (instancetype) sharedInstance
{
    static TasksService* instance = nil;

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [TasksService new];
        
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) loadAllTasksForProjectWithID: (NSNumber*) projectID
{
    NSString* requestURL = [projectTasksURL stringByReplacingOccurrencesOfString: @"{id}"
                                                                      withString: projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadTasksForProjectSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TasksAPIService sharedInstance] loadTasksForProjectWithURL: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseTasksForProjectFromResponse: response[0]
                                     withCompletion: ^(BOOL isSuccess) {
                                         
                                         [subscriber sendNext: nil];
                                         [subscriber sendCompleted];
                                         
                                     }];
             
         }
         error: ^(NSError* error) {
             
             [subscriber sendError: error];
         }];
        
        
        return nil;
    }];
    
    return loadTasksForProjectSignal;
}


#pragma mark - Internal methods -

- (void) parseTasksForProjectFromResponse: (NSArray*)               response
                           withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError = nil;
    NSArray* tasks        = [ProjectTaskModel arrayOfModelsFromDictionaries: response
                                                                      error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> Error with parsing tasks response %@", parsingError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewTasks: tasks
                            withCompletion: completion];
    }
}

@end
