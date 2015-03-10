//
//  MedicineDetailsViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 25/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "MedicineDetailsViewController.h"

@interface MedicineDetailsViewController ()

@end

@implementation MedicineDetailsViewController
@synthesize medicineIdString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"Medicine Details";
    checkNetwork=[[NetworkChecking alloc] init];
    
    [self makeRequestForDetailsOfMedicne];
}


-(void)makeRequestForDetailsOfMedicne{
    spinnerView.hidden=NO;
    if (![checkNetwork reachable]) {
        
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
    spinnerView.hidden=YES;
   
        if ([[responseDictionary objectForKey:@"result"] isEqualToString:@"success"])
    {
      
    medicineNameString=[[responseDictionary objectForKey:@"data"]objectForKey:@"medicine_name"];
   packingString= [[responseDictionary objectForKey:@"data"] objectForKey:@"packing"];
        
    sideEffectsString=[[responseDictionary objectForKey:@"data"] objectForKey:@"side_effects"];
    contentsString= [[responseDictionary objectForKey:@"data"] objectForKey:@"contents"];
    descriptionString=[[responseDictionary objectForKey:@"data"] objectForKey:@"Description"];
    categoryString=[[responseDictionary objectForKey:@"data"] objectForKey:@"category"];
    
    }
    [detailedTableView reloadData];
}
-(void)failureJSONParsingCategoryMedicineResult
{
    spinnerView.hidden=YES;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!" message:@"server is not responding" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag=123;
    [alert show];
    
    //[self.navigationController popViewControllerAnimated:YES];

}

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
         if ((indexPath.section==4)&&(sideEffectsString.length>1450)) {
            return 240;
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>2200)) {
            return 500;
        }
        else{
        return 150;
        }
    }
    else{
        if ((indexPath.section==3)&&(sideEffectsString.length>1350)) {
            return 500;
        }
        if ((indexPath.section==3)&&(descriptionString.length>900)) {
            return 320;
        }
        if ((indexPath.section==3)&&(descriptionString.length>450)){
            return 240;
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>1800)) {
            return 960;
        }
        if ((indexPath.section==4)&&(sideEffectsString.length>1350)) {
            return 720;
        }
       if ((indexPath.section==4)&&(sideEffectsString.length>900)) {
            return 480;
        }
        
        if ((indexPath.section==4)&&(sideEffectsString.length>450)){
            return 240;
        }

    return 120;

    }

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return @"medicine_name";
    }
    if (section==1) {
        return @"category";
    }
    if (section==2) {
        return @"packing";
    }
    if (section==3) {
        return @"DescriptionText";
    }
    if (section==4) {
        return @"Side Effects";
    }
    return @"";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
 
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
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
        if ((indexPath.section==3)&&(descriptionString.length>450)){
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"medium_cell_iPhone"]];
        }
        
        if ((indexPath.section==4)&&(sideEffectsString.length>1600)) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"big_cell_iPhone"]];
        }
         if ((indexPath.section==4)&&(sideEffectsString.length>900)) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"big_cell_iPhone"]];
        }
         if ((indexPath.section==4)&&(sideEffectsString.length>450)){
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
        cell.textLabel.adjustsFontSizeToFitWidth=YES;
        
    }
    if (indexPath.section==2) {
        cell.textLabel.text=packingString;
    }
    
    if (indexPath.section==3) {
//         NSLog(@"lenth:%ui",(unsigned int)descriptionString.length);
        if ([descriptionString isEqualToString:@""]) {
            cell.textLabel.text=@"No Description";
            
        }
        
        else{
            UITextView *detailTextView;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
//                if (descriptionString.length>1450) {
//                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,768, 300)];
//                }

                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 768, 150)];
            }
            else{
//                if (descriptionString.length>900) {
//                    detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,320)];
//                }
//                if(descriptionString.length>450){
//                    detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
//                }
        
                    
                    detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
            }

            detailTextView.delegate=self;
            detailTextView.textAlignment=NSTextAlignmentNatural;
            detailTextView.text=descriptionString;
            detailTextView.backgroundColor=[UIColor clearColor];
            detailTextView.userInteractionEnabled=NO;
            [detailTextView sizeToFit];
            
            cell.textLabel.font=[UIFont fontWithName:@"Helevetica" size:10.0f];
       [cell addSubview:detailTextView];
        }
    }
    if (indexPath.section==4) {
//        NSLog(@"lenth of side effects:%lu",(unsigned long)sideEffectsString.length);
        if ([sideEffectsString isEqualToString:@""]) {
            cell.textLabel.text=@"No Side Effects";
            
        }
        
        else{
        UITextView *detailTextView;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            if (sideEffectsString.length>2200) {
                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,768, 600)];
            }
            else if (sideEffectsString.length>1450){
                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,768, 300)];
            }
            else{
            detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 768, 150)];
            }

        }
        else{
//            if (sideEffectsString.length>1600) {
//                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,640)];
//            }
//             if (sideEffectsString.length>900) {
//                detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,480)];
//            }if(sideEffectsString.length>450){
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ((buttonIndex==0)&&(alertView.tag=123)) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
