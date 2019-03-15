//
//  BookBusiness.h
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "LocalStorageProvider.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BookItems)(NSArray<Book *> * _Nullable books, NSError * _Nullable error);
typedef NSMutableArray<Book *> BookArray;

@interface BookBusiness : NSObject

+(void)listBookWithPage:(NSInteger)page withCompletionHandler:(BookItems)handler;
+(Book *)saveBook:(Book * _Nonnull)book;
+(Book *)removeBook:(Book * _Nonnull)book;
+(BookArray *)retrieveBookList;

@end

NS_ASSUME_NONNULL_END
