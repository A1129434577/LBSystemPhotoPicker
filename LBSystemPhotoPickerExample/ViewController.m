//
//  ViewController.m
//  LBSystemPhotoPickerExample
//
//  Created by 刘彬 on 2019/9/27.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBSystemPhotoPicker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showPhotoPicker];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self showPhotoPicker];
}
-(void)showPhotoPicker{
    LBSystemPhotoPicker *picker = [[LBSystemPhotoPicker alloc] init];
    [picker addImagePickerSourceType:UIImagePickerControllerSourceTypePhotoLibrary title:@"相册"];
    [picker addImagePickerSourceType:UIImagePickerControllerSourceTypeCamera title:@"相机"];
    picker.didFinishPickingMedia = ^(NSDictionary * _Nullable info, NSString * _Nullable errorDesc) {
        NSLog(@"%@",errorDesc);
    };
    [picker showInViewController:self];
}

@end
