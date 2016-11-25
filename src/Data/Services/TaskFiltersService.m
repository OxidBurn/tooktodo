//
//  TaskFiltersService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFiltersService.h"

// Classes
#import "TaskFiltersAPIService.h"

// Categories
#import "DataManager+Filters.h"

@interface TaskFiltersService()

// properties

@property (nonatomic, strong) NSNumber* projectID;

// methods

@end

@implementation TaskFiltersService


#pragma mark - Shared instance -

+ (instancetype) sharedInstance
{
    static TaskFiltersService* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [TaskFiltersService new];
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) loadAllTaskFiltersInfo: (NSNumber*) projectID
{
    self.projectID = projectID;
    
    NSArray* signals = @[[self loadFilterStatuses],
                         [self loadFilterCreators],
                         [self loadFilterWorkAreas],
                         [self loadFilterResponsibles],
                         [self loadFilterApproves],
                         [self loadFilterTypes],
                         [self loadFilterExpired]];
    
    RACSignal* combineOfLoadTaskFiltersInfoSignal = [RACSignal combineLatest: signals];
    
    return combineOfLoadTaskFiltersInfoSignal;
}

- (void) saveFilterConfiguration: (TaskFilterConfiguration*) config
                  withCompletion: (CompletionWithSuccess)    completion
{
    
}

- (void) resetFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion
{
    
}


#pragma mark - Internal methods -


// Load content signals
- (RACSignal*) loadFilterStatuses
{
    NSString* requestURL = [getFiltersStatusesURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                            withString: self.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadStatusesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [[[TaskFiltersAPIService sharedInstance] loadTaskFilterStatuses: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseFilterStatusesResopnse: response[0]
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
    
    return loadStatusesSignal;
}

- (RACSignal*) loadFilterApproves
{
    NSString* requestURL = [getFiltersApproversURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                             withString: self.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadApprovesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskFiltersAPIService sharedInstance] loadTaskFilterApprovers: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseFilterApprovesResopnse: response[0]
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
    
    return loadApprovesSignal;
}

- (RACSignal*) loadFilterWorkAreas
{
    NSString* requestURL = [getFiltersWorkAreasURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                             withString: self.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadWorkAreasSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskFiltersAPIService sharedInstance] loadTaskFilterWorkAreas: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseFilterWorkAreasResopnse: response[0]
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
    
    return loadWorkAreasSignal;
}

- (RACSignal*) loadFilterCreators
{
    NSString* requestURL = [getFiltersCreatersURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                            withString: self.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadCreatorsSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskFiltersAPIService sharedInstance] loadTaskFilterCreators: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseFilterCreatorsResopnse: response[0]
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
    
    return loadCreatorsSignal;
}

- (RACSignal*) loadFilterResponsibles
{
    NSString* requestURL = [getFiltersResponsiblesURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                                withString: self.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadResponsiblesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskFiltersAPIService sharedInstance] loadTaskFilterResponsibles: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseFilterResponsiblesResopnse: response[0]
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
    
    return loadResponsiblesSignal;
}

- (RACSignal*) loadFilterTypes
{
    NSString* requestURL = [getFiltersTypesURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                         withString: self.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadTypesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskFiltersAPIService sharedInstance] loadTaskFilterTypes: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseFilterTypesResopnse: response[0]
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
    
    return loadTypesSignal;
}

- (RACSignal*) loadFilterExpired
{
    NSString* requestURL = [getFiltersExpiredURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                           withString: self.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadExpiredSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TaskFiltersAPIService sharedInstance] loadTaskFilterExpired: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseFilterExpiredResopnse: response[0]
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
    
    return loadExpiredSignal;
}


// Parse loaded content signals
- (void) parseFilterStatusesResopnse: (NSDictionary*)         response
                      withCompletion: (CompletionWithSuccess) completion
{
    NSLog(@"<INFO> Loaded task statuses filter info response: %@", response);
    
    [DataManagerShared persistProjectFilter: response
                                   withType: StatusFilterType
                           forProjectWithID: self.projectID
                             withCompletion: completion];
}

- (void) parseFilterCreatorsResopnse: (NSDictionary*)         response
                      withCompletion: (CompletionWithSuccess) completion
{
    NSLog(@"<INFO> Loaded task creators filter info response: %@", response);
    
    [DataManagerShared persistProjectFilter: response
                                   withType: CreatorsFilterType
                           forProjectWithID: self.projectID
                             withCompletion: completion];
}

- (void) parseFilterWorkAreasResopnse: (NSDictionary*)         response
                       withCompletion: (CompletionWithSuccess) completion
{
    NSLog(@"<INFO> Loaded task work areas filter info response: %@", response);
    
    [DataManagerShared persistProjectFilter: response
                                   withType: WorkAreasFilterType
                           forProjectWithID: self.projectID
                             withCompletion: completion];
}

- (void) parseFilterResponsiblesResopnse: (NSDictionary*)         response
                          withCompletion: (CompletionWithSuccess) completion
{
    NSLog(@"<INFO> Loaded task responsibles filter info response: %@", response);
    
    [DataManagerShared persistProjectFilter: response
                                   withType: ResponsiblesFilterType
                           forProjectWithID: self.projectID
                             withCompletion: completion];
}

- (void) parseFilterApprovesResopnse: (NSDictionary*)         response
                      withCompletion: (CompletionWithSuccess) completion
{
    NSLog(@"<INFO> Loaded task approves filter info response: %@", response);
    
    [DataManagerShared persistProjectFilter: response
                                   withType: ApprovesFilterType
                           forProjectWithID: self.projectID
                             withCompletion: completion];
}

- (void) parseFilterTypesResopnse: (NSDictionary*)         response
                   withCompletion: (CompletionWithSuccess) completion
{
    NSLog(@"<INFO> Loaded task types filter info response: %@", response);
    
    [DataManagerShared persistProjectFilter: response
                                   withType: TypesFilterType
                           forProjectWithID: self.projectID
                             withCompletion: completion];
}

- (void) parseFilterExpiredResopnse: (NSDictionary*)         response
                     withCompletion: (CompletionWithSuccess) completion
{
    NSLog(@"<INFO> Loaded task expired filter info response: %@", response);
    
    [DataManagerShared persistProjectFilter: response
                                   withType: ExpiredFilterType
                           forProjectWithID: self.projectID
                             withCompletion: completion];
}

@end
