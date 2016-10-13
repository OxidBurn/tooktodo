//
//  AddNewRoleModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

@interface AddNewRoleModel : NSObject

- (RACSignal*) createRoleWithTitle: (NSString*) title;

@end
