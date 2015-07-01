//
//  ZBTemp.h
//  ZapBam
//
//  Created by Arslan Asim on 30/06/2015.
//  Copyright (c) 2015 Arslan Asim. All rights reserved.
//

#import "JSONModel.h"

@interface NutrientsDetailsModel : JSONModel
@property (strong,nonatomic)NSString *unit;
@property (strong,nonatomic)NSString *value;
@end
@interface ImportantModel:JSONModel
@property (strong,nonatomic)NSString *trans;
@property (strong,nonatomic)NutrientsDetailsModel *dietary_fibre;
@property (strong,nonatomic)NutrientsDetailsModel *saturated;
@property (strong,nonatomic)NutrientsDetailsModel *total_carbs;
@property (strong,nonatomic)NutrientsDetailsModel *sodium;
@property (strong,nonatomic)NutrientsDetailsModel *potassium;
@property (strong,nonatomic)NutrientsDetailsModel *polyunsaturated;
@property (strong,nonatomic)NutrientsDetailsModel *calories;
@property (strong,nonatomic)NutrientsDetailsModel *sugar;
@property (strong,nonatomic)NutrientsDetailsModel *total_fats;
@property (strong,nonatomic)NutrientsDetailsModel *monounsaturated;
@property (strong,nonatomic)NutrientsDetailsModel *cholesterol;
@property (strong,nonatomic)NutrientsDetailsModel *protein;
@end

@interface NutrientsModel : JSONModel
@property (strong,nonatomic) NSArray *unhandled;
@property (strong,nonatomic) NSDictionary *extra;
@property (strong,nonatomic) ImportantModel *important;
@end


@protocol PortionsModel <NSObject>
@end

@interface PortionsModel : JSONModel
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NutrientsModel *nutrients;

@end

@interface ZBTemp : JSONModel
@property (strong,nonatomic)NSString *_id;
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSArray <PortionsModel>* portions;
@end
