//
//  OnRevisionViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ReactiveCocoa.h"


@interface OnRevisionViewModel : NSObject

@property (strong, nonatomic) NSString* commentText;

- (RACCommand*) sendReworkCommand;

@end
