//
//  LocalStorageProvider.m
//  Book Store
//
//  Created by Luiz Duraes on 13/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "LocalStorageProvider.h"

@implementation LocalStorageProvider

#pragma mark - Public methods

+(instancetype)sharedProvider {
    static LocalStorageProvider *_sharedProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProvider = [[LocalStorageProvider alloc] init];
    });
    
    return _sharedProvider;
}

-(void)persistDictionaryArray:(DictionaryArray * _Nonnull)dictionaryArray withKey:(NSString * _Nonnull)key {
    [[NSUserDefaults standardUserDefaults] setObject:dictionaryArray forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
