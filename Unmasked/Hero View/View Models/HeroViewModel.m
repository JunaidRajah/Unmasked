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

- (NSString *)heroInt {
    return _hero.powerstats.intelligence;
}

- (NSString *)heroDur {
    return _hero.powerstats.durability;
}

- (NSString *)heroStr {
    return _hero.powerstats.strength;
}

- (NSString *)heroCom {
    return _hero.powerstats.combat;
}

- (NSString *)heroPow {
    return _hero.powerstats.power;
}

- (NSString *)heroSpd {
    return _hero.powerstats.speed;
}
@end
