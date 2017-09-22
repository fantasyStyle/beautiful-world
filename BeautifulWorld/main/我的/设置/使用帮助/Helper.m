

#import "Helper.h"

@implementation Helper

+ (void)startAnimation:(UIImageView *)view Up:(BOOL)up complete:(void(^)())block
{
    if (up) {
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeRotation(M_PI/2);
        } completion:^(BOOL finished) {
            if (block) {
                block();
            }
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            if (block) {
                block();
            }
        }];
    }
    
}

//+ (float)calculateRowHeight
//{
//    TagModel *model = [TagModel getInstance];
//    
//    NSInteger total = model.TagArr.count;
//
//    NSInteger rows = (total / COLUMN) + ((total % COLUMN) > 0 ? 1 : 0);
//    
//    return  (float)ROWHEIHT * rows + ROWSPACE * (rows + 1);
//
//}
@end
