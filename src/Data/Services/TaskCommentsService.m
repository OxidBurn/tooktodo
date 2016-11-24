//
//  TaskCommentsService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskCommentsService.h"

// Classes
#import "ProjectTask+CoreDataClass.h"
#import "APIConstance.h"
#import "TaskCommentsAPIService.h"
#import "CommentsModel.h"

// Categories
#import "DataManager+Tasks.h"
#import "DataManager+TaskComments.h"

@implementation TaskCommentsService


#pragma mark - Shared -

+ (instancetype) sharedInstance
{
    static TaskCommentsService* instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [TaskCommentsService new];
        
    });
    
    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) getCommentsForSelectedTask
{
    NSString* requestURL = [self buildRequestURL];
    
    @weakify(self)
    
    RACSignal* loadCommentsForTaskSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskCommentsAPIService sharedInstance] loadAllCommentsForTask: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseCommentsResponse: response[0]
                          withCompletion: ^(BOOL isSuccess) {
                              
                              [subscriber sendNext: nil];
                              [subscriber sendCompleted];
                              
                          }];
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return loadCommentsForTaskSignal;
}

- (RACSignal*) postCommentForSelectedTask: (NSString *)message
{
    NSString* requestURL = [self buildPostCommentURL];

    NSDictionary* requestParameters = @{@"message" : message,
                                        @"files" : @[]};

    @weakify(self)
    
    RACSignal* loadCommentsForTaskSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskCommentsAPIService sharedInstance] postCommentForTask: requestURL
                                                          withParams: requestParameters]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseCommentsResponse: @[response[0]]
                          withCompletion: ^(BOOL isSuccess) {

                                 [subscriber sendNext: nil];
                                 [subscriber sendCompleted];
                              
                          }];
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        return nil;
    }];

    return loadCommentsForTaskSignal;
}

- (RACSignal*) editCommentForSelectedTask: (NSString *) message
                                commentID: (NSNumber*)  commentID
{
    NSString* requestURL = [self buildPostCommentURL];

    requestURL = [requestURL stringByAppendingFormat:@"/%@", commentID];

    NSDictionary* requestParameters = @{@"message" : message,
                                        @"files" : @[]};

    @weakify(self)

    RACSignal* loadCommentsForTaskSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

        [[[TaskCommentsAPIService sharedInstance] editCommentForTask: requestURL
                                                          withParams: requestParameters]
         subscribeNext: ^(RACTuple* response) {

             @strongify(self)

             [self parseCommentsResponse: @[response[0]]
                          withCompletion: ^(BOOL isSuccess) {

                              [subscriber sendNext: nil];
                              [subscriber sendCompleted];

                          }];
         }
         error: ^(NSError *error) {

             [subscriber sendError: error];

         }];
        return nil;
    }];
    
    return loadCommentsForTaskSignal;
}

- (RACSignal*) deleteCommentForSelectedTaskWithID: (NSNumber*) commentID
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString* requestURL = [self.buildPostCommentURL stringByAppendingFormat: @"/%@", commentID];
        [[[TaskCommentsAPIService sharedInstance] deleteCommentForTask: requestURL]
         subscribeNext: ^(RACTuple* response) {
             [DataManagerShared deleteCommentWithID: commentID
                                             inTask: [DataManagerShared getSelectedTask]
                                         completion:^{
                                             [subscriber sendNext: nil];
                                             [subscriber sendCompleted];
                                         }];
         }
         error: ^(NSError *error) {
             [subscriber sendError: error];
         }];
        return nil;
    }];
}

#pragma mark - Internal methods -

- (NSString*) buildRequestURL
{
    ProjectTask* selectedTask = [DataManagerShared getSelectedTask];
    
    NSString* requestURL = [taskCommentsURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                      withString: selectedTask.projectId.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: selectedTask.taskID.stringValue];
    
    return requestURL;
}

- (NSString*) buildPostCommentURL
{
    ProjectTask* selectedTask = [DataManagerShared getSelectedTask];

    NSString* requestURL = [postCommentURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                      withString: selectedTask.projectId.stringValue];

    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: selectedTask.taskID.stringValue];

    return requestURL;
}

- (void) parseCommentsResponse: (NSArray*)              response
                withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError   = nil;
    NSArray* commentsList = [CommentsModel arrayOfModelsFromDictionaries: response
                                                                   error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"Error with parsing task comments response: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewCommentsForSelectedTasks: commentsList
                                               withCompletion: completion];
    }
}

@end
