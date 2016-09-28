//
//  RowContent.h
//  TookTODO
//
//  Created by Глеб on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RowContent : NSObject

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSString* detail;

@property (strong, nonatomic) NSArray*  membersArray;

@property (strong, nonatomic) NSString* cellId;

@property (strong, nonatomic) NSString* segueId;

@property (assign, nonatomic) BOOL      isHidden;

@property (strong, nonatomic) NSString* markImageName;

@end
