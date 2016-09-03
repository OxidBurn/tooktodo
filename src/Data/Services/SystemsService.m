//
//  SystemsService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SystemsService.h"

// Classes
#import "SystemsAPIService.h"
#import "APIConstance.h"
#import "ProjectSystemsObject.h"

// Categories
#import "DataManager+Systems.h"

@implementation SystemsService

static dispatch_once_t onceToken;
static SystemsService* SINGLETON = nil;
static bool isFirstAccess = YES;

#pragma mark - Public Method -

+ (instancetype) sharedInstance
{
    dispatch_once(&onceToken, ^{
        
        isFirstAccess = NO;
        SINGLETON     = [[super allocWithZone: NULL] init];
    });
    
    return SINGLETON;
}


#pragma mark - Public methods -

- (RACSignal*) loadCurrentProjectSystems: (NSNumber*) projectID
{
    NSString* requestURL = [projectSystemsURL stringByReplacingOccurrencesOfString: @"{projectID}"
                                                                        withString: projectID.stringValue];
    @weakify(self)
    
    RACSignal* loadSystemsSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[SystemsAPIService sharedInstance] loadProjectSystemsInfo: requestURL]
         subscribeNext: ^(RACTuple* response) {
            
             @strongify(self)
             
             [self parseLoadSystemsResponse: response[0]
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
    
    return loadSystemsSignal;
}

- (NSArray*) getCurrentProjectSystems
{
    return @[];
}


#pragma mark - Internal methods -

- (void) parseLoadSystemsResponse: (NSArray*)              response
                   withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError = nil;
    NSArray* systemsArr = [ProjectSystemsObject arrayOfModelsFromDictionaries: response
                                                                        error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> Parse roles error: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistSystemsForProject: systemsArr
                                     withCompletion: completion];
    }
}


#pragma mark - Life Cycle -

+ (instancetype) allocWithZone: (NSZone*) zone
{
    return [self sharedInstance];
}

+ (instancetype) copyWithZone: (struct _NSZone*) zone
{
    return [self sharedInstance];
}

+ (instancetype) mutableCopyWithZone: (struct _NSZone*) zone
{
    return [self sharedInstance];
}

- (instancetype) copy
{
    return [[SystemsService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[SystemsService alloc] init];
}

- (instancetype) init
{
    if( SINGLETON )
    {
        return SINGLETON;
    }
    
    if ( isFirstAccess )
    {
        [self doesNotRecognizeSelector: _cmd];
    }
    
    self = [super init];
    
    return self;
}


@end
