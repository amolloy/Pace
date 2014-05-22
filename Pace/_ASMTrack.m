// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ASMTrack.m instead.

#import "_ASMTrack.h"

const struct ASMTrackAttributes ASMTrackAttributes = {
	.duration = @"duration",
	.name = @"name",
	.tempo = @"tempo",
	.trackHash = @"trackHash",
};

const struct ASMTrackRelationships ASMTrackRelationships = {
	.artist = @"artist",
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
	
	if ([key isEqualToString:@"tempoValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tempo"];
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






@dynamic name;






@dynamic tempo;



- (float)tempoValue {
	NSNumber *result = [self tempo];
	return [result floatValue];
}

- (void)setTempoValue:(float)value_ {
	[self setTempo:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveTempoValue {
	NSNumber *result = [self primitiveTempo];
	return [result floatValue];
}

- (void)setPrimitiveTempoValue:(float)value_ {
	[self setPrimitiveTempo:[NSNumber numberWithFloat:value_]];
}





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





@dynamic artist;

	






@end
