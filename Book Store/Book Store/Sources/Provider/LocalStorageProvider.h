//
//  LocalStorageProvider.h
//  Book Store
//
//  Created by Luiz Duraes on 13/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSMutableArray<NSDictionary *> DictionaryArray;

@interface LocalStorageProvider : NSObject

+(instancetype)sharedProvider;
-(void)persistDictionaryArray:(DictionaryArray * _Nonnull)dictionaryArray withKey:(NSString * _Nonnull)key;

@end

NS_ASSUME_NONNULL_END
