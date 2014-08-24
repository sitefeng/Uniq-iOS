//
//  JPGlobal.m
//  JumpPad
//
//  Created by Si Te Feng on 2014-05-14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPGlobal.h"
#import "JPDashlet.h"


@implementation JPGlobal


+ (instancetype)instance
{
    static JPGlobal* _instance = nil;
    @synchronized(self)
    {
        if(_instance == nil)
            _instance = [[JPGlobal alloc] init];
    }
    
    return _instance;
}


+ (NSString*)monthStringWithInt: (int)month
{
    
    switch (month)
    {
        case 1:
            return @"January";
        case 2:
            return @"February";
        case 3:
            return @"March";
        case 4:
            return @"April";
        case 5:
            return @"May";
        case 6:
            return @"June";
        case 7:
            return @"July";
        case 8:
            return @"August";
        case 9:
            return @"September";
        case 10:
            return @"October";
        case 11:
            return @"November";
        case 12:
            return @"December";
        default:
            return @"-----";

    }

}


+ (NSString*)ratingStringWithIndex: (NSInteger)index
{
    switch (index)
    {
        case 0:
            return @"Difficulty";
        case 1:
            return @"Professors";
        case 2:
            return @"Schedule Packedness";
        case 3:
            return @"Classmates";
        case 4:
            return @"Social Enjoyment";
        case 5:
            return @"Study Environment";
        default:
            return @"";
            
    }
    
}



+ (NSString*)schoolYearStringWithInteger: (NSUInteger)year
{
    NSArray* schoolYearsInString = @[@"First Year",@"Second Year",@"Third Year",@"Fourth Year"];
    return schoolYearsInString[year-1];
}

+ (NSString*)paragraphStringWithName: (NSString*)name
{
    NSString* textParagraphString = @"Information not available at the moment";
    
    if([name isEqualToString: @"About"])
    {
        textParagraphString = @"Overview:\nAll of us who went through the painful college application process can remember just how hard it was to select the right programs from thousands of choices and making sure each one of the applications was submitted on time. Is it really necessary to go through so much anxiety and effort? At Uniq, we are creating the next generation mobile college application guide specifically made for high school students. The app can save an enormous amount of time by delivering the exact information that students are looking for with just a few taps.\n\nOur Mobile App Solution: \nUniq is a unique mobile application(appropriately named) for iOS and Android that brings the college researching and application process into one unified app. It allows high school students to explore and compare schools and programs within seconds. Uniq will use your information and adapt to what you value most in a school or program to provide personal recommendations, notifications, and deadlines alerts to guide you through the application process. With Uniq, students can significantly improve the quality of their college research while using less time than traditional methods.\n\n\nTHIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n\nCopyright (c) 2013-2014, Uniq.\nAll rights reserved.";
    }
    else if([name isEqual: @"Special Thanks"])
    {
        textParagraphString = @"Thanks to everyone who provided valuable feedbacks along the way. All source code used within the app are either developed for Uniq or from open sourced repositories and cannot be used without a written permission from the authors. \n\nWe like to thank the following people for their websites/artworks/libraries/code snippets:\n\n - Nick Lockwood and his AsyncImageView, available on Github: https://github.com/nicklockwood/AsyncImageView\n\n - Core Plot open sourced graph plotting library\n\n - XYFeng and his XYPieChart\n\n - Pierre Dulac and his DPMeterView\n\n - Wonil Kim (@wonkim99) and RPRadarChart\n\n - Javier Berlana (@jberlana) and JBParallaxCell\n\n - Thomas Winkler and SFGaugeView\n\n - luyf and VolumeBar\n\n - Tony Million and Reachability\n\n - 谢凯伟 and DXAlertView\n\n - Christian Di Lorenzo and LDProgressView \n\n - Brian Stormont (Stormy Productions) for his AutoScrollLabel\n\n - Sam Vermette for the SVStatusHUD\n\n - Ash Furrow for the TLTileSlider\n\nAbove all, thank you for using this app. Contact us at technochimera@gmail.com for any questions, suggestions, or concerns. Alternatively, tap on Contact Us from Settings.\n\nSincerely,\nUniq Team\nJune 14, 2014\n ";
    }

    return textParagraphString;
}


+ (void)openURL: (NSURL*)url
{
    if(url)
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot Open URL" message:@"Link is currently broken, please try again later. You may report this bug to us under 'Settings', and we'll resolve this issue as soon as possible." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
    }
}


+ (NSInteger)itemIdWithDashletUid: (NSUInteger)dashletUid type: (JPDashletType)type
{
    //XXX-XX-XXXXX
    NSInteger itemId = 0;
    
    if(JPDashletTypeProgram == type)
    {
        itemId = dashletUid % 100000;
    }
    else if(JPDashletTypeFaculty == type)
    {
        itemId = (dashletUid / 100000) % 100;
    }
    else //school
    {
        itemId = dashletUid / 10000000;
    }
    
    return itemId;
}

+ (NSInteger)itemIdWithDashletUid: (NSUInteger)dashletUid
{
    NSInteger programId = dashletUid % 100000;
    NSInteger facultyId = (dashletUid / 100000) % 100;
//    NSInteger schoolId  = dashletUid / 10000000;
    
    JPDashletType type = -1;
    
    if(facultyId == 0)
        type = JPDashletTypeSchool;
    else if(programId == 0)
        type = JPDashletTypeFaculty;
    else
        type = JPDashletTypeProgram;
    
    return [self itemIdWithDashletUid:dashletUid type:type];
}



UIImage* imageFromView(UIView *view)
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



@end
