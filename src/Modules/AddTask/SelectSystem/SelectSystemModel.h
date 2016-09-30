//
//  SelectSystemModel.h
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Classes
#import "ProjectSystem.h"

@interface SelectSystemModel : NSObject

// Methods
- (NSInteger) countOfRows;

- (NSArray*) getSystems;

@end
