//
//  ViewMedicineDetailsRequestClass.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol MedicineDetailsSearchDelegate <NSObject>

@optional
-(void)successJSONParsingCategoryMedicine:(NSMutableDictionary *)responseDictionary;
-(void)failureJSONParsingCategoryMedicineResult;
@end

@interface ViewMedicineDetailsRequestClass : NSObject
{
    
    id MedicineDetailsSearchDelegate;
    BOOL checkStatus;
    NSMutableArray *fetchedReponseArray;
    
}
@property (nonatomic, retain) id MedicineDetailsSearchDelegate;


-(void)makeRequestForCheckingDetailsOfMedicineWithmedicineId: (NSString *)medicineId;

@end
