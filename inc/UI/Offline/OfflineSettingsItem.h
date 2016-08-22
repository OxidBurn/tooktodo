//
//  OfflineSettingsItem.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "OfflineSettingsTypes.h"

@interface OfflineSettingsItem : NSObject

// properties

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSArray* children;

@property (assign, nonatomic) OfflineSettingsItemType itemType;

// methods



@end
