//
//  LocalStorageProvider+Book.m
//  Book Store
//
//  Created by Luiz Duraes on 14/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "LocalStorageProvider+Book.h"

static NSString *const kUserDefaultsBookList = @"localBookList";

@implementation LocalStorageProvider (Book)

-(void)saveBook:(NSDictionary *)book {
    DictionaryArray *books = [[LocalStorageProvider sharedProvider] retrieveBookList];
    [books addObject:book];
 
    [[LocalStorageProvider sharedProvider] persistDictionaryArray:books withKey:kUserDefaultsBookList];
}

-(void)removeBook:(NSDictionary *)book {
    DictionaryArray *books = [[LocalStorageProvider sharedProvider] retrieveBookList];
    [books removeObject:book];
    
    [[LocalStorageProvider sharedProvider] persistDictionaryArray:books withKey:kUserDefaultsBookList];
}

-(NSArray *)retrieveBookList {
    DictionaryArray *books = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsBookList]];
    
    return books;
}

@end
