//
//  DataManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright (c) 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

@interface DataManager()

//! Listeners
@property (nonatomic, retain) NSMutableArray* listeners;

// methods

@end


@implementation DataManager


#pragma mark - General -

+ (DataManager*) sharedInstance
{
	static DataManager* sharedInstance = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^
	{
		sharedInstance = [[DataManager alloc] init];
	});
  
  return sharedInstance;
}


- (instancetype) init
{
	if ( self = [super init] )
	{
        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed: @"DataBaseModel"];
        
		self.listeners = [NSMutableArray array];
	}

	return self;
}


#pragma mark - Listeners -

- (void) addListener: (id <DataManagerListener>) listener
{
	// Add listener only if it doesn't already exist
	if ([self.listeners indexOfObject: listener] == NSNotFound)
		[self.listeners addObject: listener];
}


- (void) removeListener: (id <DataManagerListener>) listener
{
	// Remove listener only if it does exist
	if ([self.listeners indexOfObject: listener] != NSNotFound)
		[self.listeners removeObject: listener];
}

@end
