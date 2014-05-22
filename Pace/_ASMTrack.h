// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ASMTrack.h instead.

#import <CoreData/CoreData.h>


extern const struct ASMTrackAttributes {
	__unsafe_unretained NSString *duration;
	__unsafe_unretained NSString *mediaItemPersistentID;
	__unsafe_unretained NSString *tempo;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *trackHash;
} ASMTrackAttributes;

extern const struct ASMTrackRelationships {
} ASMTrackRelationships;

extern const struct ASMTrackFetchedProperties {
} ASMTrackFetchedProperties;








@interface ASMTrackID : NSManagedObjectID {}
@end

@interface _ASMTrack : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ASMTrackID*)objectID;





@property (nonatomic, strong) NSNumber* duration;



@property double durationValue;
- (double)durationValue;
- (void)setDurationValue:(double)value_;

//- (BOOL)validateDuration:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* mediaItemPersistentID;



@property int64_t mediaItemPersistentIDValue;
- (int64_t)mediaItemPersistentIDValue;
- (void)setMediaItemPersistentIDValue:(int64_t)value_;

//- (BOOL)validateMediaItemPersistentID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDecimalNumber* tempo;



//- (BOOL)validateTempo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* trackHash;



@property int64_t trackHashValue;
- (int64_t)trackHashValue;
- (void)setTrackHashValue:(int64_t)value_;

//- (BOOL)validateTrackHash:(id*)value_ error:(NSError**)error_;






@end

@interface _ASMTrack (CoreDataGeneratedAccessors)

@end

@interface _ASMTrack (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDuration;
- (void)setPrimitiveDuration:(NSNumber*)value;

- (double)primitiveDurationValue;
- (void)setPrimitiveDurationValue:(double)value_;




- (NSNumber*)primitiveMediaItemPersistentID;
- (void)setPrimitiveMediaItemPersistentID:(NSNumber*)value;

- (int64_t)primitiveMediaItemPersistentIDValue;
- (void)setPrimitiveMediaItemPersistentIDValue:(int64_t)value_;




- (NSDecimalNumber*)primitiveTempo;
- (void)setPrimitiveTempo:(NSDecimalNumber*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSNumber*)primitiveTrackHash;
- (void)setPrimitiveTrackHash:(NSNumber*)value;

- (int64_t)primitiveTrackHashValue;
- (void)setPrimitiveTrackHashValue:(int64_t)value_;




@end
