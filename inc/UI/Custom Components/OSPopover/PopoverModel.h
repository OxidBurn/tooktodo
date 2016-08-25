//
//  PopoverModel.h
//  TookTODO
//
//  Created by Глеб on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopoverModelDelegate;

@interface PopoverModel : NSObject <UITableViewDataSource, UITableViewDelegate>

//properties

@property (nonatomic, copy) void(^didDismiss)();

//methods
- (instancetype) initWithType: (NSUInteger)                popoverType
                 withDelegate: (id <PopoverModelDelegate>) delegate;

- (CGSize) getPopoverSize;

@end


@protocol PopoverModelDelegate <NSObject>

// methods
- (void) didSelectItemAtIndex: (NSUInteger) index;

@end
