// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

@import AppCenter;

@interface AppCenterShared : NSObject

+ (void) setAppSecret: (NSString *)secret;

+ (void) setUserId: (NSString *)userId;

+ (NSString *) getAppSecretWithSettings: (NSDictionary*) settings;

+ (void) configureWithSettings: (NSDictionary* ) settings;

+ (MSACWrapperSdk *) getWrapperSdk;
+ (void) setWrapperSdk:(MSACWrapperSdk *)sdk;

@end
