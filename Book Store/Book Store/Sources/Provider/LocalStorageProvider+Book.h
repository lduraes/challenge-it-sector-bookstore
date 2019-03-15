//
//  LocalStorageProvider+Book.h
//  Book Store
//
//  Created by Luiz Duraes on 14/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "LocalStorageProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocalStorageProvider (Book)

-(void)saveBook:(NSDictionary *)book;
-(void)removeBook:(NSDictionary *)book;
-(DictionaryArray *)retrieveBookList;

@end

NS_ASSUME_NONNULL_END
