//
//  DataManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright (c) 2016 Nikolay Chaban. All rights reserved.
//

@import Foundation;
@import CoreData;

@protocol DataManagerListener;

@interface DataManager : NSObject

/** Shared data manager
 */
+ (id) sharedInstance;

/**
 *  Save context
 *
 *  @return error with saving context
 */
- (NSError*) saveContext;

/**
 *  Remove object from database
 *
 *  @param object object which need to remove
 */
- (void) removeObject: (NSManagedObject*) object;

/**
 *  Insert new object to database
 *
 *  @param name insert object name: entity name
 *
 *  @return return new empty object in database
 */
- (id) insertNewObjectForEntityForName: (NSString*) name;

/**
 *  Fetch object from database with parameters
 *
 *  @param name name of the object
 *  @param predicate predicate for filtering objects
 *
 *  @return retun fetched object from database
 */
- (id) fetchObjectForEntityForName: (NSString*)    name
                     withPredicate: (NSPredicate*) predicate;

/**
 *  Fetch object from database with parameters
 *
 *  @param name name of the object
 *
 *  @return retun fetched object from database with name parameter
 */
- (id) fetchObjectsForEntityForName: (NSString*) name;

/** Add listener
 */
- (void) addListener: (id <DataManagerListener>) listener;

/** Remove listener
 */
- (void) removeListener: (id <DataManagerListener>) listener;

@end


@protocol DataManagerListener <NSObject>

@optional


@end