//
//  OnRevisionModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ReactiveCocoa.h"

@interface OnRevisionModel : NSObject

- (RACSignal*) sendReworkStatusMessage: (NSString*) message;

@end
