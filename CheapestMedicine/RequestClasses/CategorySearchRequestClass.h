//
//  CategorySearchRequestClass.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 24/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol CategoryMedicineSearchDelegate <NSObject>

@optional
-(void)successJSONParsingCategoryMedicineSearch:(NSMutableDictionary *)responseDictionary;
-(void)failureJSONParsingCategoryMedicineSearchResult;
@end

@interface CategorySearchRequestClass : NSObject
{
    id CategoryMedicineSearchDelegate;
    BOOL checkStatus;
    
    NSMutableArray *fetchedReponseArray;
    
}
@property (nonatomic, retain) id CategoryMedicineSearchDelegate;


-(void)makeRequestForCheckingWithCategoryMedicineSearchtxt:(NSString*)usertext Value:(NSString *)val;

@end
