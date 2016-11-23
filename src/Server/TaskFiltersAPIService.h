//
//  TaskFiltersAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "BaseAPIService.h"

@interface TaskFiltersAPIService : BaseAPIService


// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadTaskFilterCreators: (NSString*) url;

- (RACSignal*) loadTaskFilterWorkAreas: (NSString*) url;

- (RACSignal*) loadTaskFilterApprovers: (NSString*) url;

- (RACSignal*) loadTaskFilterTypes: (NSString*) url;

- (RACSignal*) loadTaskFilterStatuses: (NSString*) url;

- (RACSignal*) loadTaskFilterResponsibles: (NSString*) url;

- (RACSignal*) loadTaskFilterExpired: (NSString*) url;

@end
