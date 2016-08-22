//
//  DataManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright (c) 2016 Nikolay Chaban. All rights reserved.
//

@import Foundation;
@import CoreData;

#import <MagicalRecord/MagicalRecord.h>

@protocol DataManagerListener;

@interface DataManager : NSObject

/** Shared data manager
 */
+ (id) sharedInstance;

/** Add listener
 */
- (void) addListener: (id <DataManagerListener>) listener;

/** Remove listener
 */
- (void) removeListener: (id <DataManagerListener>) listener;

@end


@protocol DataManagerListener <NSObject>

@optional


@end