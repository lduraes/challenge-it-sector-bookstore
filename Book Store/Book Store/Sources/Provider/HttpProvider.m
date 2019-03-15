//
//  HttpProvider.m
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "HttpProvider.h"

static NSString *const kBaseUrl = @"https://www.googleapis.com";

@implementation HttpProvider

#pragma mark - Public methods

+(instancetype)sharedProvider {
    static HttpProvider *_sharedProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:kBaseUrl];
        _sharedProvider = [[HttpProvider alloc] initWithBaseURL:url];
    });
    
    return _sharedProvider;
}

@end
