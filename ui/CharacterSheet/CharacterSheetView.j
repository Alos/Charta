/**
	Button to toggle the Character sheet interface.
*/

@implementation CharacterSheetView : CPView {

}

- (id) initWithFrame:(CGRect) aFrame {

	if (self = [super initWithFrame:aFrame]){
		[self setBackgroundColor: [CPColor  colorWithHexString:@"DFDFDF"]];

	}
	return self;
}

@end