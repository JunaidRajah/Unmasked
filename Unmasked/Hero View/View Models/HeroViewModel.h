//
//  HeroViewModel.h
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/19.
//

#import <Foundation/Foundation.h>
#import "Unmasked-Swift.h"
#import <UnmaskedEngine/UnmaskedEngine-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeroViewModel : NSObject
- (void)set:(SuperheroResponseModel *) selectedHero;
- (NSString *)heroName;
- (NSString *)heroImageURL;
- (NSString *)heroIntelligence;
- (NSString *)heroDurability;
- (NSString *)heroStrength;
- (NSString *)heroCombat;
- (NSString *)heroPower;
- (NSString *)heroSpeed;
@end

NS_ASSUME_NONNULL_END
