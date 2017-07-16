//
//  Converter.m
//  Currency Converter
//
//  Created by Admin on 16.07.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "Converter.h"
#define QUERY_TODAY @"http://api.fixer.io/latest"
#define QUERY_YESTERDAY @"http://api.fixer.io/%@"

@implementation Converter
-(void) setRates {
    NSLog(@"load method!");
    
    NSData *jsonDataToday = [[NSString stringWithContentsOfURL:[NSURL URLWithString:QUERY_TODAY] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *errorToday = nil;
    self.todayRates = jsonDataToday ? [NSJSONSerialization JSONObjectWithData:jsonDataToday options:0 error:&errorToday] : nil;
    if (errorToday) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), errorToday.localizedDescription);
    

}
- (double) getRate: (NSString *) fromCurrency to: (NSString *) toCurrency {
    

    double rateEuroFrom = [fromCurrency isEqualToString:@"EUR"]?1:[(NSString*)[[self.todayRates objectForKey:@"rates"] objectForKey:fromCurrency] doubleValue];
    double rateEuroTo = [toCurrency isEqualToString:@"EUR"]?1:[(NSString*)[[self.todayRates objectForKey:@"rates"] objectForKey:toCurrency] doubleValue];
    return rateEuroTo/rateEuroFrom;
}

- (double) exchange: (NSString *) fromCurrency to: (NSString *) toCurrency amt: (double) amount{
    return [self getRate:fromCurrency to:toCurrency] * amount;
}
@end
