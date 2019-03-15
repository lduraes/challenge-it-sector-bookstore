//
//  BookListCollectionViewCell.m
//  Book Store
//
//  Created by Luiz Duraes on 10/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import "BookListCollectionViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface BookListCollectionViewCell ()

@property (strong, nonatomic) Book *book;

@end

@implementation BookListCollectionViewCell

-(void)loadCellWithBooks:(Book * _Nonnull)book {
    self.book = book;
    
    __weak typeof(self) weakSelf = self;
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:self.book.smallThumbnail] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(error) {
            NSLog(@"[ERR] >> %@", error);
        } else {
            weakSelf.thumbImageView.image = image;
        }
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

@end
