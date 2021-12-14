//
//  ViewController.m
//  TestEmoticonSending
//
//  Created by active on 2020/08/03.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSTextAttachment *textAttachment;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _Input.delegate = self;
    textAttachment = [[NSTextAttachment alloc] init];
  //  {kEmoticonTitle:@"/번개/",kEmoticonImg:@"lightning"}
    NSLog(@"@@@@ aaaa  %f,%f,%f,%f",_Input.textContainerInset.bottom,_Input.textContainerInset.left,_Input.textContainerInset.right,_Input.textContainerInset.top);
    
    
    NSAttributedString *k =[[NSAttributedString alloc] initWithString:@"hh\ndd"];
    NSAttributedString * m = [k attributedSubstringFromRange:NSMakeRange(2, 1)];
    if([m.string isEqual:@"\n"]){
        NSLog(@"dskjkf");
    }

}

- (void)textViewDidChange:(UITextView *)textView{
    [self EmoticonIntheEdits:@"/ㅋㅋ/" switchImage:[UIImage imageNamed:@"yellow.png"]];
    NSLog(@"w? %@",_Input.attributedText);
    
}
-(UIImage *)imageToimage:(UIImage *)image scaledTosize:(CGSize)newSize{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)EmoticonIntheEdits:(NSString*)Textword switchImage:(UIImage*)EmoImg{
    //NSString *nowText = _Input.attributedText;
    UIFont *font =  [ UIFont systemFontOfSize:16.f ];
    NSDictionary *attrdict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
   
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithAttributedString:_Input.attributedText];
        [attributedString addAttributes: attrdict range:NSMakeRange(0, _Input.attributedText.length)];
    
    //여기까지가 텍스트 사이즈 그대로 가져오기
    textAttachment.image =[self imageToimage:EmoImg scaledTosize:CGSizeMake(20,20)];
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSAttributedString *replace = attrStringWithImage;// [[NSAttributedString alloc] initWithString:@"/ㅋㅋ/"];
    while ([attributedString.mutableString containsString:Textword]) {//지정 문자가 있으면
        NSRange range =[attributedString.mutableString rangeOfString:Textword];
        [attributedString replaceCharactersInRange:range withAttributedString:replace];//바꿔라
    }
    _Input.attributedText = attributedString;
    NSLog(@"#   %f,%f",[attributedString size].width,[attributedString size].height);
    NSLog(@"#   %f,%f",[@"가" sizeWithAttributes:@{NSFontAttributeName: font}].width,[@"가" sizeWithAttributes:@{NSFontAttributeName: font}].height);
    //특정 문자 이미지로 전환
    
    
}
//사이즈가 0일경우는 알아서 걸러라
-(NSString*)RestorationEmoImgtoText:(NSString*)Textword attach:(NSTextAttachment*)NSAttach{
    
    NSString __block *total = @"";
    for (int i = 0 ; i< _Input.attributedText.length; i++) {
        NSAttributedString *changeText = [_Input.attributedText attributedSubstringFromRange:NSMakeRange(i, 1)];
        [changeText enumerateAttributesInRange:NSMakeRange(0,1) options:0 usingBlock:^(NSDictionary *attributes, NSRange range, BOOL *stop){
            NSString *v;
            NSObject* x= [attributes valueForKey:@"NSAttachment"];
            NSTextAttachment * l = x;
            NSLog(@"%@  kkksiidojfos",l.image);
            if(l.image == NSAttach.image){
                NSLog(@"???");
            }
            if(x){//이거 뭔가 좀 이상하다
    //            if(NSAttach == x){
    //                NSLog(@"같음?");//이거 통함
    //            }
                ;
                v=Textword;
                if(v==nil){
                    v=@"";
                }
            }else{
                v=changeText.string;
            }
            total = [NSString stringWithFormat:@"%@%@",total,v];
        }];
  
    }
    
    return total;//이미지->텍스트
}


- (IBAction)Convert:(id)sender {
    //전송버튼을 눌렀을 때
   
    if(_Input.attributedText.length>0){
        //전환
        NSLog(@"_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_");
        _Output.text = [self RestorationEmoImgtoText:@"/ㅋㅋ/" attach:textAttachment];
    }
}
@end
