//
//  AddMessageModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddMessageModel : NSObject

// methods
- (void) fillText: (NSString*) textContent;

- (UIColor*) getPlacelderColor;

- (NSString*) getDescriptionText;

@end
