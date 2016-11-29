//
//  FilterParameterViewDelegate.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FilterParameterViewDelegate <NSObject>

- (void) didDeleteFilterParameterWithTag: (NSUInteger) tag;

@end
