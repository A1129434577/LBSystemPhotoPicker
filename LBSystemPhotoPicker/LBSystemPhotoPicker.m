//
//  LBSystemPhotoPicker.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/26.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBSystemPhotoPicker.h"


@interface LBSystemPhotoPicker()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,assign)BOOL animated;

@property (nonatomic,copy, nullable) void (^ imagePickerDidShowCompletion)(void);
@property (nonatomic,weak)UIViewController *viewController;
@property (nonatomic,strong)UIAlertController *imagePickerActionsheet;
@end
@implementation LBSystemPhotoPicker
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imagePickerActionsheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [self.imagePickerActionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
        
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        self.imagePicker = imagePicker;
    }
    return self;
}
-(void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle{
    _modalPresentationStyle = modalPresentationStyle;
    self.imagePicker.modalPresentationStyle = modalPresentationStyle;
}
-(void)addImagePickerSourceType:(UIImagePickerControllerSourceType)sourceType title:(NSString *)title{
    
    [_imagePickerActionsheet addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                self.didFinishPickingMedia?
                self.didFinishPickingMedia(nil,@"您的设备不支持相册"):NULL;
                return;
            }else if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized
                      && [PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusNotDetermined){
                self.didFinishPickingMedia?
                self.didFinishPickingMedia(nil,@"相册权限受限,请在隐私设置中启用相册访问"):NULL;
                return;
            }
        }
        
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                self.didFinishPickingMedia?
                self.didFinishPickingMedia(nil,@"您的设备不支持相机"):NULL;
                return;
            }else if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] != AVAuthorizationStatusAuthorized
                      && [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] !=  AVAuthorizationStatusNotDetermined) {
                self.didFinishPickingMedia?
                self.didFinishPickingMedia(nil,@"相机调用受限,请在隐私设置中启用相机访问"):NULL;
                return;
            }
        }
        
        self.imagePicker.sourceType = sourceType;
        [self.viewController presentViewController:self.imagePicker animated:self.animated completion:self.imagePickerDidShowCompletion];
    }]];
}
-(void)showInViewController:(UIViewController *)viewController animated:(BOOL)flag completion:(void (^ _Nullable)(void))completion{
    _animated = flag;
    _imagePickerDidShowCompletion = completion;
    _viewController = viewController;
    
    if (self.onlySourceType) {
        self.imagePicker.sourceType = self.onlySourceType.integerValue;
        [self.viewController presentViewController:self.imagePicker animated:flag completion:self.imagePickerDidShowCompletion];
    }else{
        [viewController presentViewController:self.imagePickerActionsheet animated:YES completion:NULL];
    }
}

#pragma mark PhotoSelectButtonDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.didFinishPickingMedia?
    self.didFinishPickingMedia(info,nil):NULL;
    
    //    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //    NSData * imageData = UIImageJPEGRepresentation(image,1.0);
    //    while ([imageData length]/1024 > 400) {
    //        imageData = UIImageJPEGRepresentation([UIImage imageWithData:imageData], 0.1);
    //    }
}

@end
