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

//! Managed object model
@property (nonatomic, retain) NSManagedObjectModel* managedObjectModel;

//! Managed object context
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;

//! Persistent store coordinator
@property (nonatomic, retain) NSPersistentStoreCoordinator* persistentStoreCoordinator;

//! Persistent store URL
@property (nonatomic, readonly) NSURL* persistentStoreURL;

// methods

@end


@implementation DataManager

@dynamic persistentStoreURL;


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


#pragma mark - Database -


- (NSURL*) persistentStoreURL
{
  return [NSURL fileURLWithPath: [NSString stringWithFormat: @"%@/Documents/DataBaseModel.sqlite", NSHomeDirectory()]];
}


- (NSManagedObjectContext*) managedObjectContext
{
	if (_managedObjectContext != nil)
		return _managedObjectContext;
	
	NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
  
	if (coordinator != nil)
	{
		_managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
    
        _managedObjectContext.persistentStoreCoordinator = coordinator;
        _managedObjectContext.undoManager                = nil;
	}
	
	return _managedObjectContext;
}


- (NSManagedObjectModel*) managedObjectModel
{
	if (_managedObjectModel != nil)
		return _managedObjectModel;
  
	_managedObjectModel = [NSManagedObjectModel mergedModelFromBundles: nil];
  
	return _managedObjectModel;
}


- (NSPersistentStoreCoordinator*) persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil)
		return _persistentStoreCoordinator;
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.managedObjectModel];
  
  if (![self addPersistenStore])
  {
    [self clearDatabase];
		
    [self addPersistenStore];
  }
	
	return _persistentStoreCoordinator;
}


- (BOOL) addPersistenStore
{
	NSError* error = nil;
    
	[self.persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType
                                                  configuration: nil
                                                            URL: self.persistentStoreURL
                                                        options: nil
                                                          error: &error];
        
  if (error)
		NSLog(@"Failed to add persistent store; error: %@\n  info: %@", error, error.userInfo);
	
  return !error;
}


- (void) clearDatabase
{
  // Remove persistent store (underlying sqlite database)
  [[NSFileManager defaultManager] removeItemAtURL: self.persistentStoreURL
                                            error: nil];
  
  // Null database linked objects
  self.managedObjectContext       = nil;
  self.managedObjectModel         = nil;
  self.persistentStoreCoordinator = nil;
}


- (NSError*) saveContext
{
	NSError* error = nil;
  
	[self.managedObjectContext save: &error];
  
  if (error != nil)
    NSLog(@"Error saving managed context: %@", error);
	
	return error;
}


- (void) resetContext
{
  [self.managedObjectContext reset];
}


- (void) refreshObjects: (NSArray*) objects
{
  for (NSManagedObject* object in objects)
    [self.managedObjectContext refreshObject: object mergeChanges: NO];
}


- (void) removeObject: (NSManagedObject*) object
{
  [self.managedObjectContext deleteObject: object];
  [self saveContext];
}


- (id) insertNewObjectForEntityForName: (NSString*) name
{
  if (name == nil)
    return nil;
  
  return [NSEntityDescription insertNewObjectForEntityForName: name
                                       inManagedObjectContext: self.managedObjectContext];
}


- (void) saveLocalChanges
{
  [self saveContext];
}


- (void) rollbackLocalChanges
{
  [self.managedObjectContext rollback];
}


#pragma mark - Fetch -

- (id) fetchObjectForEntityForName: (NSString*)    name
                     withPredicate: (NSPredicate*) predicate
{
    if (name == nil)
        return nil;
    
    NSEntityDescription* entity = [NSEntityDescription entityForName: name
                                              inManagedObjectContext: self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    request.entity    = entity;
    request.predicate = predicate;
    
    NSError* error;
    NSArray* results = [self.managedObjectContext executeFetchRequest: request error: &error];
    
    return [results count] ? [results objectAtIndex: 0] : nil;
}


- (id) fetchObjectsForEntityForName: (NSString*) name
{
  if (name == nil)
    return nil;
  
	NSEntityDescription* entity = [NSEntityDescription entityForName: name
                                              inManagedObjectContext: self.managedObjectContext];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
	request.entity = entity;
	
	NSError* error;
	NSArray* results = [self.managedObjectContext executeFetchRequest: request error: &error];
	
	return results;
}

@end
