//
//  TaskComment+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/16/16.
//
//

#import "TaskComment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskComment (CoreDataProperties)

+ (NSFetchRequest<TaskComment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *commentID;
@property (nullable, nonatomic, copy) NSString *message;
@property (nullable, nonatomic, copy) NSString *author;
@property (nullable, nonatomic, copy) NSString *avatarSrc;
@property (nullable, nonatomic, copy) NSString *authorId;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, retain) ProjectTask *task;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *storageFiles;

@end

@interface TaskComment (CoreDataGeneratedAccessors)

- (void)addStorageFilesObject:(NSManagedObject *)value;
- (void)removeStorageFilesObject:(NSManagedObject *)value;
- (void)addStorageFiles:(NSSet<NSManagedObject *> *)values;
- (void)removeStorageFiles:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
