//
//  HttpProvider+Book.h
//  Book Store
//
//  Created by Luiz Duraes on 09/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "HttpProvider.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HttpProviderItems)(NSDictionary * _Nonnull response, NSError * _Nullable error);

@interface HttpProvider (Book)

-(void)listBooksWithMaxResults:(NSInteger)maxResults
                withStartIndex:(NSInteger)startIndex
         withCompletionHandler:(HttpProviderItems)handler;

@end

NS_ASSUME_NONNULL_END
