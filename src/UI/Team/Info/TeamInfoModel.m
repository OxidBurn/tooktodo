//
//  TeamInfoModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoModel.h"

// Classes
#import "TeamService.h"

@interface TeamInfoModel()

// properties

@property (strong, nonatomic) NSArray* teamList;

// methods


@end

@implementation TeamInfoModel

#pragma mark - Public methods -

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion
{
    [[[[TeamService sharedInstance] getTeamInfo] subscribeOn: [RACScheduler mainThreadScheduler]]
    subscribeNext: ^(NSArray* teamInfo) {
        
        self.teamList = teamInfo;
        
        NSLog(@"Team list %@", self.teamList);
        
        if ( completion )
            completion(YES);
        
    }
    error:^(NSError *error) {
        
        if ( completion )
            completion(NO);
        
    }
    completed:^{
        
        if ( completion )
            completion(YES);
        
    }];
}

- (NSUInteger) countOfItems
{
    return self.teamList.count;
}

- (TeamMember*) teamMemberByIndex: (NSUInteger) index
{
    return self.teamList[index];
}

@end
