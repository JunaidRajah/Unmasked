//
//  HeroViewController.h
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/19.
//

#import <UIKit/UIKit.h>
@class SuperheroResponseModel;

NS_ASSUME_NONNULL_BEGIN

@interface HeroViewController : UIViewController
- (void)set:(SuperheroResponseModel *) hero;
- (void)setReturn:(BOOL) fromSearch;
@end

NS_ASSUME_NONNULL_END
