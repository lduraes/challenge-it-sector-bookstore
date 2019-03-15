//
//  BookBusiness.m
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "BookBusiness.h"
#import "HttpProvider+Book.h"
#import "LocalStorageProvider+Book.h"
#import <JSONModel.h>

static NSString *const kItems = @"items";
static NSString *const kVolumeInfo = @"volumeInfo";
static NSString *const kSaleInfo = @"saleInfo";
static NSInteger const kMaxResults = 20;

@implementation BookBusiness

#pragma mark - Public methods

+(void)listBookWithPage:(NSInteger)page withCompletionHandler:(BookItems)handler {
    [[HttpProvider sharedProvider] listBooksWithMaxResults:kMaxResults withStartIndex:(page * kMaxResults) withCompletionHandler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        if(error) {
            handler(nil, error);
        } else {
            NSError *error;
            NSArray <Book *> *books = [Book arrayOfModelsFromDictionaries:response[kItems] error:&error];
            
            handler(books, error);
        }
    }];
}

+(Book *)saveBook:(Book * _Nonnull)book {
    book.favorite = YES;
    [[LocalStorageProvider sharedProvider] saveBook:book.toDictionary];
    
    return book;
}

+(Book *)removeBook:(Book * _Nonnull)book {
    [[LocalStorageProvider sharedProvider] removeBook:book.toDictionary];
    book.favorite = NO;

    return book;
}

+(BookArray *)retrieveBookList {
    NSError *error;
    BookArray *books = [Book arrayOfModelsFromDictionaries:[[LocalStorageProvider sharedProvider] retrieveBookList] error:&error];

    return books;
}

@end
