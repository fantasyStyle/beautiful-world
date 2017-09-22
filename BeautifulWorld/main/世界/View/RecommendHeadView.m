

#import "RecommendHeadView.h"

@interface RecommendHeadView ()



@property (strong, nonatomic) IBOutlet UIImageView *LineView;

@end

@implementation RecommendHeadView

-(id)init
{
    self=[[[NSBundle mainBundle]loadNibNamed:@"RecommendHeadView" owner:nil options:nil] firstObject];
    
    if (self) {
        
       self.LineView.layer.cornerRadius=5;
       self.LineView.layer.masksToBounds=YES;
        self.Title.text=@"精品赏析";
        self.more.text = @"全部";
        
    }
    
    return self;
}

@end
