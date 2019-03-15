//
//  BookListCollectionViewCell.h
//  Book Store
//
//  Created by Luiz Duraes on 10/03/19.
//  Copyright © 2019 IT Sector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;

-(void)loadCellWithBooks:(Book * _Nonnull)book;

@end

NS_ASSUME_NONNULL_END
