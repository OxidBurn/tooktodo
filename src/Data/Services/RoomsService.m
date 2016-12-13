//
//  RoomsService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoomsService.h"

// Classes
#import "RoomsAPIService.h"
#import "ProjectInfo+CoreDataClass.h"
#import "APIConstance.h"
#import "TaskRoomLevelModel.h"

// Categories
#import "DataManager+ProjectInfo.h"

@implementation RoomsService

#pragma mark - Shared instance -

+ (instancetype) sharedInstance
{
    static RoomsService* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [RoomsService new];
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) getRoomLevelsForSelectedProjectWithID: (NSNumber*) projectID
{
    @weakify(self)
    
    RACSignal* fetchRoomsLevelSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [[[RoomsAPIService sharedInstance] fetchRoomsLevelInfoForProject: [self buildGetRoomsLevelURLForProjectWithID: projectID]]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseRoomsLevelInfo: response[0]
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
    
    return fetchRoomsLevelSignal;
}


#pragma mark - Internal methods -

- (NSString*) buildGetRoomsLevelURLForProjectWithID: (NSNumber*) projectID
{
    NSString* fetchURL = [projectGetRoomsLevelURL stringByAppendingFormat: @"%@", projectID];
    
    return fetchURL;
}

- (void) parseRoomsLevelInfo: (NSArray*)              response
              withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError = nil;
    NSArray* roomLevels   = [TaskRoomLevelModel arrayOfModelsFromDictionaries: response
                                                                        error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> Error with parsing room level response data: %@", parsingError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistSelectedProjectRoomLevels: roomLevels
                                             withCompletion: completion];
    }
}

@end
