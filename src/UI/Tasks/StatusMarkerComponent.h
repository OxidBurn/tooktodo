//
//  StatusMarkerComponent.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, StatusMarkerComponentType)
{
    StatusMarkerOrangeType,
    StatusMarkerBlueType,
};

@interface StatusMarkerComponent : UIView

- (void) setStatusString: (NSString*) status
                withType: (StatusMarkerComponentType) type;

@end
