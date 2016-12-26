//
//  LogRoomInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogRoomInfo : NSObject

- (instancetype) initWithRoomNumber: (NSNumber*) number
                          withTitle: (NSString*) title;

- (NSAttributedString*) getRoomInfoWithAttributesForLog;

@end
