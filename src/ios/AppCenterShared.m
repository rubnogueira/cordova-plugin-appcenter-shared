// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import <Cordova/NSDictionary+CordovaPreferences.h>
#import "AppCenterShared.h"

@implementation AppCenterShared

static NSString *appSecret;
static NSString *logUrl;

static MSACWrapperSdk * wrapperSdk;

+ (void) setAppSecret: (NSString *)secret
{
    appSecret = secret;
    [MSACAppCenter configureWithAppSecret:secret];
}

+ (void) setUserId: (NSString *)userId
{
    [MSACAppCenter setUserId:userId];
}

+ (NSString *) getAppSecretWithSettings: (NSDictionary*) settings
{
    if (appSecret == nil) {
        appSecret = [settings cordovaSettingForKey:@"APP_SECRET"];
        // If the AppSecret is not set, we will pass nil to MSACAppCenter which will error out, as expected
    }

    return appSecret;
}

+ (void) configureWithSettings: (NSDictionary* ) settings
{
    if ([MSACAppCenter isConfigured]) {
        return;
    }

    MSACWrapperSdk* wrapperSdk =
    [[MSACWrapperSdk alloc]
     initWithWrapperSdkVersion:@"0.5.2"
     wrapperSdkName:@"appcenter.cordova"
     wrapperRuntimeVersion:nil
     liveUpdateReleaseLabel:nil
     liveUpdateDeploymentKey:nil
     liveUpdatePackageHash:nil];

    [self setWrapperSdk:wrapperSdk];
    [MSACAppCenter configureWithAppSecret:[AppCenterShared getAppSecretWithSettings: settings]];

    NSString *logLevel = [settings cordovaSettingForKey:@"LOG_LEVEL"];
    MSACLogLevel logLevelValue = [logLevel intValue];
    [MSACAppCenter setLogLevel: logLevelValue];
    
    logUrl = [settings cordovaSettingForKey:@"LOG_URL"];
    if (logUrl != nil) {
        [MSACAppCenter setLogUrl:logUrl];
    }
}

+ (MSACWrapperSdk *) getWrapperSdk
{
    return wrapperSdk;
}

+ (void) setWrapperSdk:(MSACWrapperSdk *)sdk
{
    wrapperSdk = sdk;
    [MSACAppCenter setWrapperSdk:sdk];
}

@end
