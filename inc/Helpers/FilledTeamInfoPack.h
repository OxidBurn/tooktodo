//
//  FilledTeamInfoPack.h
//  TookTODO
//
//  Created by Lera on 21.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FilledTeamInfo.h"

@interface FilledTeamInfoPack : NSObject

+ (FilledTeamInfo*) convertObjectToTeamMember: (id) object;

@end
