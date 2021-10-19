//
//  HeroViewModel.h
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/19.
//

#import <Foundation/Foundation.h>
#import "Unmasked-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeroViewModel : NSObject
- (void)set:(SuperheroResponseModel *) selectedHero;
- (NSString *)heroName;
- (NSString *)heroImageURL;
- (NSString *)heroInt;
- (NSString *)heroDur;
- (NSString *)heroStr;
- (NSString *)heroCom;
- (NSString *)heroPow;
- (NSString *)heroSpd;
@end

NS_ASSUME_NONNULL_END
