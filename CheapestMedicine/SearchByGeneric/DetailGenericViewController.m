//
//  DetailGenericViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 09/07/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "DetailGenericViewController.h"

@interface DetailGenericViewController ()

@end

@implementation DetailGenericViewController
@synthesize medicineIdString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkNetwork =[[NetworkChecking alloc]init];
    self.title=@"Medicine Details";
    [self makeRequestForDetailsOfMedicne];
    
}
-(void)makeRequestForDetailsOfMedicne{
    spinnerView.hidden=NO;
    if (![checkNetwork reachable])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Unable to reach the network"
                              delegate:nil
                              cancelButtonTitle:@"Dismiss"
                              otherButtonTitles:nil, nil];
        [alert show];
        spinnerView.hidden=YES;
    }
  
    else{
        ViewMedicineDetailsRequestClass *medicineView=[[ViewMedicineDetailsRequestClass alloc]init];
    medicineView.MedicineDetailsSearchDelegate=self;
    [medicineView makeRequestForCheckingDetailsOfMedicineWithmedicineId:self.medicineIdString];
    }
}
-(void)successJSONParsingCategoryMedicine:(NSMutableDictionary *)responseDictionary
{
    
    // result = failure;
   // status
    spinnerView.hidden=YES;
    if ([[responseDictionary valueForKey:@"result"]isEqualToString:@"failure"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:[responseDictionary objectForKey:@"status"]
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];

    }
    spinnerView.hidden=YES;
    if ([[responseDictionary objectForKey:@"result"] isEqualToString:@"success"])
    {
             
        medicineNameString =[[responseDictionary objectForKey:@"data"]objectForKey:@"medicine_name"];
        
        categoryString=[[responseDictionary objectForKey:@"data"] objectForKey:@"category"];
        packingString=[[responseDictionary objectForKey:@"data"] objectForKey:@"packing"];
        sideEffectsString=[[responseDictionary objectForKey:@"data"] objectForKey:@"side_effects"];
        descriptionString=[[responseDictionary objectForKey:@"data"] objectForKey:@"Description"];
      
    }
        [genericTableView reloadData];
    
}
-(void)failureJSONParsingCategoryMedicineResult
{
    spinnerView.hidden=YES;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!" message:@"Server Not Responding" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alert.tag=9;
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((alertView.tag==9)&&(buttonIndex==0)) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    }
}


#pragma mark - UITableViewDelegateMethods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        if ((indexPath.section==3)&&(descriptionString.length>1450)) {
            return 240;
        }
        else if ((indexPath.section==4)&&(sideEffectsString.length>1450)) {
            return 240;
        }
        else{
            return 150;
        }
    }
    else{
        if ((indexPath.section==3)&&(sideEffectsString.length>1400)) {
            return 500;
        }
        if ((indexPath.section==3)&&(descriptionString.length>900)) {
            return 320;
        }
        if ((indexPath.section==3)&&(descriptionString.length>565)){
            return 240;
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>2200)) {
            return 800;
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>1600)) {
            return 600;
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>900)) {
            return 320;
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>565)){
            return 240;
        }
        
        return 120;
        
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return @"MEDICINE NAME";
    }
    if (section==1) {
        return @"CATEGORY";
    }
    if (section==2) {
        return @"PACKING";
    }
    if (section==3) {
        return @"DESCRIPTION TEXT";
    }
    if (section==4) {
        return @"SIDE EFFECTS";
    }
    return @"";

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    //cell.backgroundColor=[UIColor clearColor];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if ((indexPath.section==3)&&(descriptionString.length>1450)) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"medium_cell_iPad"]];
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>1450)) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"medium_cell_iPad"]];
        }
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellbg_iPad"]];
    }
    else{
        
        if ((indexPath.section==3)&&(descriptionString.length>900)) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"big_cell_iPhone"]];
        }
        if ((indexPath.section==3)&&(descriptionString.length>565)){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"medium_cell_iPhone"]];
        }
        
        if ((indexPath.section==4)&&(sideEffectsString.length>1600)) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"big_cell_iPhone"]];
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>900)) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"big_cell_iPhone"]];
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>565)){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"medium_cell_iPhone"]];
        }
        
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellbg"]];
        
    }
  
    if(indexPath.section==0)
    {
        cell.textLabel.text=medicineNameString;
        cell.textLabel.adjustsFontSizeToFitWidth=YES;
    }
    if (indexPath.section==1) {
        cell.textLabel.text=categoryString;
        
    }
    if (indexPath.section==2) {
        cell.textLabel.text=packingString;
    }
    
    if (indexPath.section==3) {
            if ([descriptionString isEqualToString:@""]) {
            
            cell.textLabel.text=@"No Description";
        }
        
        else{
            UITextView *detailTextView;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                
//                if (descriptionString.length>1450) {
//                    detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,768, 300)];
//                }
                
                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 768, 150)];
            }
            else{
//                if (descriptionString.length>900) {
//                    detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,320)];
//                }
//                if(descriptionString.length>568){
//                    detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
//                }
                
                
                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];            }
           
            detailTextView.delegate=self;
            detailTextView.textAlignment=NSTextAlignmentNatural;
            detailTextView.text=descriptionString;
            detailTextView.backgroundColor=[UIColor clearColor];
            detailTextView.userInteractionEnabled=NO;
            [cell addSubview:detailTextView];
            cell.textLabel.font=[UIFont fontWithName:@"Helevetica" size:10.0f];
        }
    }
    if (indexPath.section==4) {
        
       
        UITextView *detailTextView;
        if ([sideEffectsString isEqualToString:@""]) {
            cell.textLabel.text=@"No Side Effects";
        }
        else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
//            if (sideEffectsString.length>1450) {
//                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,768, 300)];
//            }
            
            detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 768, 150)];
            
        }
        else{
//            if (descriptionString.length>1600) {
//                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,640)];
//            }
//            if (descriptionString.length>900) {
//                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,320)];
//            }if(sideEffectsString.length>565){
//                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,240)];
//            }
            detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
        }
            detailTextView.delegate=self;
            detailTextView.textAlignment=NSTextAlignmentNatural;
            detailTextView.text=sideEffectsString;
            detailTextView.userInteractionEnabled=NO;
        detailTextView.backgroundColor=[UIColor clearColor];
            [cell addSubview:detailTextView];
             [detailTextView sizeToFit];
        
    }
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
