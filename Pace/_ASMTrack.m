// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ASMTrack.m instead.

#import "_ASMTrack.h"

const struct ASMTrackAttributes ASMTrackAttributes = {
	.duration = @"duration",
	.mediaItemPersistentID = @"mediaItemPersistentID",
	.tempo = @"tempo",
	.title = @"title",
	.trackHash = @"trackHash",
};

const struct ASMTrackRelationships ASMTrackRelationships = {
};

const struct ASMTrackFetchedProperties ASMTrackFetchedProperties = {
};

@implementation ASMTrackID
@end

@implementation _ASMTrack

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Track" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Track";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Track" inManagedObjectContext:moc_];
}

- (ASMTrackID*)objectID {
	return (ASMTrackID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"durationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"duration"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"mediaItemPersistentIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"mediaItemPersistentID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"trackHashValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"trackHash"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic duration;



- (double)durationValue {
	NSNumber *result = [self duration];
	return [result doubleValue];
}

- (void)setDurationValue:(double)value_ {
	[self setDuration:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveDurationValue {
	NSNumber *result = [self primitiveDuration];
	return [result doubleValue];
}

- (void)setPrimitiveDurationValue:(double)value_ {
	[self setPrimitiveDuration:[NSNumber numberWithDouble:value_]];
}





@dynamic mediaItemPersistentID;



- (int64_t)mediaItemPersistentIDValue {
	NSNumber *result = [self mediaItemPersistentID];
	return [result longLongValue];
}

- (void)setMediaItemPersistentIDValue:(int64_t)value_ {
	[self setMediaItemPersistentID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveMediaItemPersistentIDValue {
	NSNumber *result = [self primitiveMediaItemPersistentID];
	return [result longLongValue];
}

- (void)setPrimitiveMediaItemPersistentIDValue:(int64_t)value_ {
	[self setPrimitiveMediaItemPersistentID:[NSNumber numberWithLongLong:value_]];
}





@dynamic tempo;






@dynamic title;






@dynamic trackHash;



- (int64_t)trackHashValue {
	NSNumber *result = [self trackHash];
	return [result longLongValue];
}

- (void)setTrackHashValue:(int64_t)value_ {
	[self setTrackHash:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveTrackHashValue {
	NSNumber *result = [self primitiveTrackHash];
	return [result longLongValue];
}

- (void)setPrimitiveTrackHashValue:(int64_t)value_ {
	[self setPrimitiveTrackHash:[NSNumber numberWithLongLong:value_]];
}










@end
