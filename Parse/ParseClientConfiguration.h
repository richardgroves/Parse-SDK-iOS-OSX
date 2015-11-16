/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

#import <Parse/PFConstants.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ParseMutableClientConfiguration<NSObject>

@property (nullable, nonatomic, copy, readwrite) NSString *applicationId;
@property (nullable, nonatomic, copy, readwrite) NSString *clientKey;

@property (nonatomic, assign, readwrite, getter=isLocalDatastoreEnabled) BOOL localDatastoreEnabled;

@property (nullable, nonatomic, copy, readwrite) NSString *applicationGroupIdentifier;
@property (nullable, nonatomic, copy, readwrite) NSString *containingApplicationBundleIdentifier;

@end

/*!
 This represents the entirety of a parse configuration
 */
@interface ParseClientConfiguration : NSObject<NSCopying>

@property (nullable, nonatomic, copy, readonly) NSString *applicationId;
@property (nullable, nonatomic, copy, readonly) NSString *clientKey;

@property (nonatomic, assign, readonly, getter=isLocalDatastoreEnabled) BOOL localDatastoreEnabled;

@property (nullable, nonatomic, copy, readonly) NSString *applicationGroupIdentifier;
@property (nullable, nonatomic, copy, readonly) NSString *containingApplicationBundleIdentifier;

+ (instancetype)configurationWithBlock:(void(^)(id<ParseMutableClientConfiguration> configuration))configurationBlock;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
