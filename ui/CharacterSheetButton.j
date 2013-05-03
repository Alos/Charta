/**
	Button to toggle the Character sheet interface.
*/

@implementation CharacterSheetButton : CPView{
	CPImage characterSheetImage;
	CPImageView characterSheetImageView;
}

- (id) initWithFrame:(CGRect) aFrame {

	if (self = [super initWithFrame:aFrame]){
		CPLog.trace("Creating character sheet");
		[self setBackgroundColor: [CPColor  colorWithHexString:@"DFDFDF"]];

		characterSheetImage = [[CPImage alloc] initWithContentsOfFile:[[CPBundle mainBundle] pathForResource:@"runner.png"] size:CGSizeMake(18, 25)];
		
		var width = CGRectGetWidth(aFrame);
		var height = CGRectGetHeight(aFrame);
		characterSheetImageView = [[CPImageView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
        [characterSheetImageView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [characterSheetImageView setImageScaling:CPScaleProportionally];
        [characterSheetImageView setHasShadow:NO];
        [characterSheetImageView setImage: characterSheetImage];
        [self addSubview:characterSheetImageView];

         var mShadowView = [[CPShadowView alloc] initWithFrame:CGRectMakeZero()];
    	[mShadowView setFrameForContentFrame:[self frame]];
    	[mShadowView setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    	[self addSubview:mShadowView];
    	//[self addSubview:mGraphicView];
	    //[mainContentView addSubview:contentView];
	}
	return self;
}

@end