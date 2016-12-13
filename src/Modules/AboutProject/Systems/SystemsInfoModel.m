//
//  SystemsInfoModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SystemsInfoModel.h"

// Classes
#import "SystemsService.h"

@interface SystemsInfoModel()

// properties

@property (strong, nonatomic) NSArray* systemItems;

// methods


@end

@implementation SystemsInfoModel

#pragma mark - Public methods -

- (RACSignal*) updateInfo
{
    @weakify(self)
    
    RACSignal* fetchSystemsInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] schedule: ^{
        
            @strongify(self)
            
            self.systemItems = [[SystemsService sharedInstance] getCurrentProjectSystems];
            
            [subscriber sendNext: nil];
            
        }];
        
        [[[SystemsService sharedInstance] loadSelectedProjectSystems]
         subscribeNext: ^(id x) {
             
             @strongify(self)
             
             self.systemItems = [[SystemsService sharedInstance] getCurrentProjectSystems];
             
             [subscriber sendNext: nil];
             [subscriber sendCompleted];
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return fetchSystemsInfoSignal;
}

- (NSUInteger) countOfSystemItems
{
    return self.systemItems.count;
}

- (NSAttributedString*) getTitleForCellAtIndex: (NSUInteger) index
{
    ProjectSystem* systemInfo = [self getSystemInfoAtIndex: index];
    
    NSMutableAttributedString* cellTitleString = [[NSMutableAttributedString alloc] initWithString: @""];
    
    // Short title with attributes
    NSDictionary* shortTitleAttribute = @{NSFontAttributeName : [UIFont fontWithName: @"SFUIText-Medium"
                                                                                size: 15]};
    
    NSAttributedString* shortTitleString = [[NSAttributedString alloc] initWithString: systemInfo.shortTitle
                                                                           attributes: shortTitleAttribute];
    
    // Title with attributes
    NSDictionary* titleAttribute = @{NSFontAttributeName : [UIFont fontWithName: @"SFUIText-Regular"
                                                                           size: 15]};
    NSAttributedString* titleString = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @" %@", systemInfo.title]
                                                                      attributes: titleAttribute];
    
    [cellTitleString appendAttributedString: shortTitleString];
    [cellTitleString appendAttributedString: titleString];
    
    return cellTitleString;
}


#pragma mark - Internal string -

- (ProjectSystem*) getSystemInfoAtIndex: (NSUInteger) index
{
    return self.systemItems[index];
}


@end
