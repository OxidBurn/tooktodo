//
//  OfflineSettings+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 8/22/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OfflineSettings.h"

NS_ASSUME_NONNULL_BEGIN

@interface OfflineSettings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *isEnable;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSSet<OfflineSettings *> *children;
@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

@interface OfflineSettings (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(OfflineSettings *)value;
- (void)removeChildrenObject:(OfflineSettings *)value;
- (void)addChildren:(NSSet<OfflineSettings *> *)values;
- (void)removeChildren:(NSSet<OfflineSettings *> *)values;

@end

NS_ASSUME_NONNULL_END
