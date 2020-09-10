//
//  ViewController.m
//  LookInBody
//
//  Created by Apple on 2020/09/08.
//  Copyright © 2020 Apple. All rights reserved.
//

#define ADD_1 0
#define ADD_2 1
#define CAMERA_1 2
#define CAMERA_2 3
#define ALBUM_1 4
#define ALBUM_2 5
#define SAVE 8
#define DebugLog(format, ...) NSLog((@"%s [Line %d] %@"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:(format), ##__VA_ARGS__])

#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController
{
    UIView * bgView;
    UIView * leftView;
    UIView * rightView;
    UIView *cameraView_1;
    UIView *cameraView_2;
    
    UIButton *albumBtn_1;
    UIButton *albumBtn_2;
    
    UILabel *cameraLb_1;
    UIButton *cameraBtn_1;
    
    UILabel *cameraLb_2;
    UIButton *cameraBtn_2;
    
    UIButton *saveBtn;
    
    UIButton *addBtn_1;
    UIButton *addBtn_2;
    
    UIImageView *leftImgView;
    UIImageView *rightImgView;
    
    UILabel * beforeLb;
    UILabel * afterLb;
    
    UIImage *firstImg, *secondImg;
    
    BOOL isSave;
    BOOL isBefore;
    BOOL isAfter;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    isSave = NO;
    isBefore = NO;
    isAfter = NO;
}

- (void)initView{
    bgView = [[UIView alloc]initWithFrame:self.view.frame];
    [bgView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bgView];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, bgView.frame.size.width, 44)];
    [titleLb setBackgroundColor:[UIColor clearColor]];
    [titleLb setText:@"TEST"];
    [titleLb setTextAlignment:NSTextAlignmentCenter];
    [titleLb setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:15]];
    [titleLb setTextColor:[UIColor blackColor]];
    [bgView addSubview:titleLb];
    
    leftView = [[UIView alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLb.frame), bgView.frame.size.width/2 - 16, bgView.frame.size.height - 300)];
    [leftView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    leftView.layer.cornerRadius = 3;
    leftView.layer.borderWidth = 1;
    [leftView setBackgroundColor:[UIColor clearColor]];
    [bgView addSubview:leftView];
    
    leftImgView = [[UIImageView alloc]initWithFrame:leftView.bounds];
    [leftImgView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    leftImgView.layer.cornerRadius = 3;
    leftImgView.layer.borderWidth = 1;
    [leftImgView setUserInteractionEnabled:YES];
    [leftView addSubview:leftImgView];
    [leftImgView setHidden:YES];
    
    rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame), CGRectGetMaxY(titleLb.frame), bgView.frame.size.width/2 - 16, bgView.frame.size.height - 300)];
    [rightView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    rightView.layer.cornerRadius = 3;
    rightView.layer.borderWidth = 1;
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rightView];
    
    rightImgView = [[UIImageView alloc]initWithFrame:leftView.bounds];
    [rightImgView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    rightImgView.layer.cornerRadius = 3;
    rightImgView.layer.borderWidth = 1;
    [rightImgView setUserInteractionEnabled:YES];
    [rightView addSubview:rightImgView];
    [rightImgView setHidden:YES];
    
    addBtn_1 = [[UIButton alloc]initWithFrame:CGRectMake((leftView.frame.size.width - 100)/2, (leftView.frame.size.height - 100)/2, 100, 100)];
    [addBtn_1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn_1 setBackgroundColor:[UIColor clearColor]];
    [addBtn_1 setTitle:@"추가\n+" forState:UIControlStateNormal];
    [addBtn_1.titleLabel setTextAlignment:NSTextAlignmentCenter];
    addBtn_1.layer.cornerRadius = 3;
    addBtn_1.layer.borderWidth = 1;
    [addBtn_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn_1.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [addBtn_1.titleLabel setNumberOfLines:0];
    [addBtn_1 setTag:ADD_1];
    [leftView addSubview:addBtn_1];
    
    addBtn_2 = [[UIButton alloc]initWithFrame:CGRectMake((rightView.frame.size.width - 100)/2, (rightView.frame.size.height - 100)/2, 100, 100)];
    [addBtn_2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn_2 setBackgroundColor:[UIColor clearColor]];
    [addBtn_2 setTitle:@"추가\n+" forState:UIControlStateNormal];
    [addBtn_2.titleLabel setTextAlignment:NSTextAlignmentCenter];
    addBtn_2.layer.cornerRadius = 3;
    addBtn_2.layer.borderWidth = 1;
    [addBtn_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn_2.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [addBtn_2.titleLabel setNumberOfLines:0];
    [addBtn_2 setTag:ADD_2];
    [rightView addSubview:addBtn_2];
    
    cameraView_1 = [[UIView alloc]initWithFrame:CGRectMake((leftView.frame.size.width - 100)/2, 50, 100, 100)];
    cameraView_1.layer.cornerRadius = 3;
    cameraView_1.layer.borderWidth = 1;
    [leftView setBackgroundColor:[UIColor clearColor]];
    [leftView addSubview:cameraView_1];
    
    cameraLb_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, (cameraView_1.frame.size.height - 45)/2, cameraView_1.frame.size.width,45)];
    [cameraLb_1 setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [cameraLb_1 setText:@"사진\n촬영"];
    [cameraLb_1 setNumberOfLines:0];
    [cameraLb_1 setTextAlignment:NSTextAlignmentCenter];
    [cameraLb_1 setTextColor:[UIColor blackColor]];
    [cameraLb_1 setBackgroundColor:[UIColor clearColor]];
    [cameraView_1 addSubview:cameraLb_1];
    
    cameraBtn_1 = [[UIButton alloc]initWithFrame:cameraView_1.bounds];
    [cameraBtn_1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cameraBtn_1 setBackgroundColor:[UIColor clearColor]];
    [cameraBtn_1 setTag:CAMERA_1];
    [cameraView_1 addSubview:cameraBtn_1];
    
    cameraView_2 = [[UIView alloc]initWithFrame:CGRectMake((rightView.frame.size.width - 100)/2, 50, 100, 100)];
    cameraView_2.layer.cornerRadius = 3;
    cameraView_2.layer.borderWidth = 1;
    [cameraView_2 setBackgroundColor:[UIColor clearColor]];
    [rightView addSubview:cameraView_2];
    
    cameraLb_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, (cameraView_2.frame.size.height - 45)/2, cameraView_2.frame.size.width,45)];
    [cameraLb_2 setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [cameraLb_2 setText:@"사진\n촬영"];
    [cameraLb_2 setNumberOfLines:0];
    [cameraLb_2 setTextAlignment:NSTextAlignmentCenter];
    [cameraLb_2 setTextColor:[UIColor blackColor]];
    [cameraLb_2 setBackgroundColor:[UIColor clearColor]];
    [cameraView_2 addSubview:cameraLb_2];
    
    cameraBtn_2 = [[UIButton alloc]initWithFrame:cameraView_2.bounds];
    [cameraBtn_2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cameraBtn_2 setBackgroundColor:[UIColor clearColor]];
    [cameraBtn_2 setTag:CAMERA_2];
    [cameraView_2 addSubview:cameraBtn_2];
    
    albumBtn_1 = [[UIButton alloc]initWithFrame:CGRectMake((leftView.frame.size.width - 100)/2, CGRectGetMaxY(cameraView_1.frame) + 50, 100, 100)];
    albumBtn_1.layer.cornerRadius = 3;
    albumBtn_1.layer.borderWidth = 1;
    [albumBtn_1 setTitle:@"앨범" forState:UIControlStateNormal];
    [albumBtn_1.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [albumBtn_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [albumBtn_1 setTag:ALBUM_1];
    [albumBtn_1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:albumBtn_1];
    
    albumBtn_2 = [[UIButton alloc]initWithFrame:CGRectMake((rightView.frame.size.width - 100)/2, CGRectGetMaxY(cameraView_2.frame) + 50, 100, 100)];
    albumBtn_2.layer.cornerRadius = 3;
    albumBtn_2.layer.borderWidth = 1;
    [albumBtn_2 setTitle:@"앨범" forState:UIControlStateNormal];
    [albumBtn_2.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [albumBtn_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [albumBtn_2 setTag:ALBUM_2];
    [albumBtn_2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:albumBtn_2];
    
    beforeLb = [[UILabel alloc]initWithFrame:CGRectMake((leftView.frame.size.width - 50)/2, 300, 50, 50)];
    [beforeLb setBackgroundColor:[UIColor blackColor]];
    beforeLb.clipsToBounds = YES;
    beforeLb.layer.cornerRadius = 9;
    beforeLb.layer.borderWidth = 1;
    [beforeLb setText:@"전"];
    [beforeLb setTextAlignment:NSTextAlignmentCenter];
    [beforeLb setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [beforeLb setTextColor:[UIColor whiteColor]];
    [leftImgView addSubview:beforeLb];
    [beforeLb setHidden:YES];
    
    afterLb = [[UILabel alloc]initWithFrame:CGRectMake((rightView.frame.size.width - 50)/2, 300, 50, 50)];
    [afterLb setBackgroundColor:[UIColor blackColor]];
    afterLb.clipsToBounds = YES;
    afterLb.layer.cornerRadius = 5;
    afterLb.layer.borderWidth = 1;
    [afterLb setText:@"후"];
    [afterLb setTextAlignment:NSTextAlignmentCenter];
    [afterLb setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [afterLb setTextColor:[UIColor whiteColor]];
    [rightImgView addSubview:afterLb];
    [afterLb setHidden:YES];
    
    saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(leftView.frame) + 50, bgView.frame.size.width - 32, 40)];
    [saveBtn setTitle:@"저장" forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:13]];
    [saveBtn setBackgroundColor:[UIColor blackColor]];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.layer.borderWidth = 1;
    saveBtn.layer.cornerRadius = 5;
    [saveBtn setEnabled:NO];
    [saveBtn setTag:SAVE];
    [saveBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:saveBtn];
    
    [self leftViewHidden:YES];
    [self rightViewHidden:YES];
}

- (void)btnAction:(UIButton *)sender
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (sender.tag == CAMERA_1) {
        
        if (status == AVAuthorizationStatusAuthorized) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            [picker setAllowsEditing:YES];
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (granted) {
                        
                        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                        [picker setDelegate:self];
                        [picker setAllowsEditing:YES];
                        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                        
                        [self presentViewController:picker animated:YES completion:nil];
                        
                    }else{
                        
                        
                    }
                    
                });
            }];
            
        }
        
    }else if (sender.tag == CAMERA_2){
        
        if (status == AVAuthorizationStatusAuthorized) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            [picker setAllowsEditing:YES];
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (granted) {
                        
                        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                        [picker setDelegate:self];
                        [picker setAllowsEditing:YES];
                        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                        
                        [self presentViewController:picker animated:YES completion:nil];
                        
                    }else{
                        
                        
                    }
                    
                });
            }];
            
        }
        
    }else if (sender.tag ==  ALBUM_1){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setDelegate:self];
        [picker setAllowsEditing:YES];
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if (sender.tag == ALBUM_2){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setDelegate:self];
        [picker setAllowsEditing:YES];
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if (sender.tag == ADD_1){
        
        [addBtn_1 setHidden:YES];
        [self leftViewHidden:NO];
        
    }else if (sender.tag == ADD_2){
        
        [addBtn_2 setHidden:YES];
        [self rightViewHidden:NO];
        
    }else if (sender.tag == SAVE){
        if (firstImg != nil && secondImg != nil) {
            UIImageWriteToSavedPhotosAlbum (firstImg, nil, nil , nil);
            UIImageWriteToSavedPhotosAlbum (secondImg, nil, nil , nil);
            
            DebugLog(@"Photo Save Success!");
        }
    }
    
}

#pragma mark - imagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    UIImage *selectImg = info[UIImagePickerControllerEditedImage];
    
    [leftImgView setHidden:NO];
    [rightImgView setHidden:NO];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        if (leftImgView.image == nil) {
            
            isBefore^=YES;
            [self leftViewHidden:YES];
            [leftImgView setImage:selectImg];
            [beforeLb setHidden:NO];
            firstImg = selectImg;
            
        }else if(rightImgView.image == nil && leftImgView != nil){
            
            isAfter ^= YES;
            [self rightViewHidden:YES];
            [rightImgView setImage:selectImg];
            [afterLb setHidden:NO];
            secondImg = selectImg;
        }
        
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
        if (leftImgView.image == nil) {
            
            isBefore^=YES;
            [self leftViewHidden:YES];
            [leftImgView setImage:selectImg];
            [beforeLb setHidden:NO];
            firstImg = selectImg;
            
        }else if(rightImgView.image == nil && leftImgView != nil){
            
            isAfter ^= YES;
            [self rightViewHidden:YES];
            [rightImgView setImage:selectImg];
            [afterLb setHidden:NO];
            secondImg = selectImg;
        }
    }
    
    if (isBefore == YES && isAfter == YES) {
        [saveBtn setEnabled:YES];
        [saveBtn setBackgroundColor:[UIColor whiteColor]];
        [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [saveBtn setEnabled:NO];
        [saveBtn setBackgroundColor:[UIColor blackColor]];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) image:(UIImage*) image didFinishedSavingWithError:(NSError*)error contextInfo:(void*)contenxtInfo
{
    if (error) {
        DebugLog(@"error: %@", [error localizedDescription]);
    } else {
        DebugLog(@"saved");
    }
}

- (void)leftViewHidden:(BOOL)isHidden{

    [cameraView_1 setHidden:isHidden];
    [cameraBtn_1 setHidden:isHidden];
    [cameraLb_1 setHidden:isHidden];
    [albumBtn_1 setHidden:isHidden];
}

- (void)rightViewHidden:(BOOL)isHidden{

    [cameraView_2 setHidden:isHidden];
    [cameraBtn_2 setHidden:isHidden];
    [cameraLb_2 setHidden:isHidden];
    [albumBtn_2 setHidden:isHidden];

}

@end
