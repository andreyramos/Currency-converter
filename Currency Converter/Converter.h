//
//  Converter.h
//  Currency Converter
//
//  Created by Admin on 16.07.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Converter : NSObject
@property (strong,nonatomic) NSDictionary * todayRates;
//@property (strong,nonatomic) NSDictionary * yesterdaytRates;
- (void) setRates;
- (double) exchange: (NSString *) fromCurrency to: (NSString *) toCurrency amt: (double) amount;
@end
