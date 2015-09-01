//
//  ViewController.m
//  ImageWithFilter
//
//  Created by Jack Lapin on 23.07.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>



@interface ViewController ()

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) NSMutableArray *capturedImages;

@end

@implementation ViewController

bool somethingToSave;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    somethingToSave = false;
    self.saveButton.enabled = false;
    self.capturedImages = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadImageFromLibrary:(id)sender {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (self.imageView.isAnimating)
    {
        [self.imageView stopAnimating];
    }
    
    if (self.capturedImages.count > 0)
    {
        [self.capturedImages removeAllObjects];
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (CGImageRef) setImageRefWithFilterNumber : (int) value {
  
    CIImage *inputImage = [[CIImage alloc] initWithCGImage:[self.imageView.image CGImage]];
    CIContext* context = [CIContext contextWithOptions:nil];
    CGImageRef imgRef = [context createCGImage:inputImage fromRect:inputImage.extent];
    
    if (value == 1) {
        CIFilter * adjustmentFilter = [CIFilter filterWithName:@"CISepiaTone"];
        [adjustmentFilter setDefaults];
        [adjustmentFilter setValue:inputImage forKey:@"inputImage"];
        [adjustmentFilter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputIntensity"];
        
        CIImage *outputImage = [adjustmentFilter valueForKey:@"outputImage"];
        
        imgRef = [context createCGImage:outputImage fromRect:outputImage.extent] ;
    }
    else if (value == 2) {
        CIFilter * adjustmentFilter = [CIFilter filterWithName:@"CISepiaTone"];
        [adjustmentFilter setDefaults];
        [adjustmentFilter setValue:inputImage forKey:@"inputImage"];
        [adjustmentFilter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputIntensity"];
        
        CIImage *outputImage = [adjustmentFilter valueForKey:@"outputImage"];
        
        imgRef = [context createCGImage:outputImage fromRect:outputImage.extent] ;
        
    }
    else
    {
        
    }
    
    return imgRef;
}

- (IBAction)applyFilter:(id)sender {
    UIImageOrientation originalOrientation = self.imageView.image.imageOrientation;
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:@"Select filter"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* sepia = [UIAlertAction
                            actionWithTitle:@"Sepia"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                CGImageRef  imgRef = [self setImageRefWithFilterNumber : 1];
                                UIImage* newImage = [[UIImage alloc] initWithCGImage:imgRef scale:1.0 orientation:originalOrientation];
                                self.imageView.image = newImage;
                                
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];
    UIAlertAction* blur = [UIAlertAction
                            actionWithTitle:@"Blur"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                CGImageRef  imgRef = [self setImageRefWithFilterNumber : 1];
                                UIImage* newImage = [[UIImage alloc] initWithCGImage:imgRef scale:1.0 orientation:originalOrientation];
                                self.imageView.image = newImage;
                                
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];

    UIAlertAction* exposureAdjust = [UIAlertAction
                            actionWithTitle:@"Exposure Adjust"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                CGImageRef  imgRef = [self setImageRefWithFilterNumber : 1];
                                UIImage* newImage = [[UIImage alloc] initWithCGImage:imgRef scale:1.0 orientation:originalOrientation];
                                self.imageView.image = newImage;
                                
                                [view dismissViewControllerAnimated:YES completion:nil];
                                
                            }];

    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:sepia];
    [view addAction:blur];
    [view addAction:exposureAdjust];

    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
    
    
    
    
    
    
    somethingToSave = true;
    self.saveButton.enabled = true;
    
}

- (IBAction)saveImage:(id)sender {
    
    if (somethingToSave) {
        
        CIImage *saveToSave = [[CIImage alloc] initWithCGImage:[self.imageView.image CGImage]];
        // 2
        CIContext *softwareContext = [CIContext
                                      contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
        // 3
        CGImageRef cgImg = [softwareContext createCGImage:saveToSave
                                                 fromRect:[saveToSave extent]];
        
        if ([[UIDevice currentDevice].systemVersion intValue] < 9) {
            
            ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
            [library writeImageToSavedPhotosAlbum:cgImg
                                         metadata:[saveToSave properties]
                                  completionBlock:^(NSURL *assetURL, NSError *error) {
                                      // 5
                                      CGImageRelease(cgImg);
                                  }];
        }
        else {
            
        }
        
        
        
        
        //    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@""
        //                                                        message:@"Changes saved!"
        //                                                       delegate:self
        //                                              cancelButtonTitle:nil
        //                                              otherButtonTitles:nil];
        //    saveAlert.transform = CGAffineTransformMake(1.0f, 0.5f, 0.0f, 1.0f, 0.0f, 0.0f);
        //    [saveAlert performSelector:@selector(dismissWithClickedButtonIndex:animated:)
        //                    withObject:nil
        //                    afterDelay:1.0f];
        //    [saveAlert show];
        //
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Changes saved"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        somethingToSave = false;
    }
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    self.imageView.image = image;
}
@end
