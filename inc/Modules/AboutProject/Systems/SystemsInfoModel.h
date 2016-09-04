//
//  SystemsInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "ProjectSystem.h"

@interface SystemsInfoModel : NSObject

// methods
- (RACSignal*) updateInfo;

- (NSUInteger) countOfSystemItems;

- (NSAttributedString*) getTitleForCellAtIndex: (NSUInteger) index;

@end
