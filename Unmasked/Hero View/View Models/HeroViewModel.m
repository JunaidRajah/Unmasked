//
//  HeroViewModel.m
//  Unmasked
//
//  Created by Junaid Rajah on 2021/10/19.
//

#import "HeroViewModel.h"

@implementation HeroViewModel {
    SuperheroResponseModel * _hero;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)set:(SuperheroResponseModel *) selectedHero {
    _hero = selectedHero;
}

- (NSString *)heroName {
    return _hero.name;
}

- (NSString *)heroImageURL {
    return _hero.image.url;
}

- (NSString *)heroIntelligence {
    return _hero.powerstats.intelligence;
}

- (NSString *)heroDurability {
    return _hero.powerstats.durability;
}

- (NSString *)heroStrength {
    return _hero.powerstats.strength;
}

- (NSString *)heroCombat {
    return _hero.powerstats.combat;
}

- (NSString *)heroPower {
    return _hero.powerstats.power;
}

- (NSString *)heroSpeed {
    return _hero.powerstats.speed;
}
@end
