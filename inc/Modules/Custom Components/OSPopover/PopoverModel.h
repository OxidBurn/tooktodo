//
//  PopoverModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopoverModelDataSource;
@protocol PopoverModelDelegate;

@interface PopoverModel : NSObject <UITableViewDataSource, UITableViewDelegate>

//properties

@property (nonatomic, copy) void(^didDismiss)();

//methods
- (instancetype) initWithDataSource: (id <PopoverModelDataSource>) dataSource
                       withDelegate: (id <PopoverModelDelegate>)   delegate;

- (CGSize) getPopoverSize;

@end


@protocol PopoverModelDataSource <NSObject>

// methods

- (NSArray*) getPopoverContent;

- (NSUInteger) selectedItem;

@end

@protocol PopoverModelDelegate <NSObject>

// methods
- (void) didSelectItemAtIndex: (NSUInteger) index;

@end
