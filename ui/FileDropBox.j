/**
Box where the user will be able to drop pictures for their characters
*/

@import "../DeepDropUpload/DCFileDropController.j"
@import "../DeepDropUpload/DCFileUploadManager.j"

@implementation FileDropBox : CPView {
	//The image that will be showing
	CPImageView image;
	//The overlay
    CPView      borderOverlay;
    //Regular border
    CPColor     normalBorder;
    //Border when a drop is happening
    CPColor     highlightBorder;
    //The controller that will handle the upload
    id          controller @accessors;
}

- (id) initWithFrame:(CGRect) aFrame{
	self = [super initWithFrame: aFrame];
	if(self){
		var bundle = [CPBundle mainBundle];
        //Setting up the regular border
        normalBorder = [CPColor colorWithPatternImage:[[CPNinePartImage alloc] initWithImageSlices:
                      [
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-0.png"] size:CGSizeMake(5.0, 5.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-1.png"] size:CGSizeMake(1.0, 5.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-2.png"] size:CGSizeMake(5.0, 5.0)],
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-3.png"] size:CGSizeMake(5.0, 2.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-4.png"] size:CGSizeMake(2.0, 2.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-5.png"] size:CGSizeMake(5.0, 5.0)],
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-6.png"] size:CGSizeMake(5.0, 5.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-7.png"] size:CGSizeMake(1.0, 5.0)],
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-8.png"] size:CGSizeMake(5.0, 5.0)]
                      ]]];
        borderOverlay = [[CPView alloc] initWithFrame:CGRectMake(5, 5, aFrame.size.width - 10, aFrame.size.height - 10)];
        [borderOverlay setBackgroundColor:normalBorder];


        //Place holder for the uploaded image
        var uploadImage = [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"upload.png"] size:CGSizeMake(200, 200)];
        image = [[CPImageView alloc] initWithFrame:CGRectMake(5,5,aFrame.size.width - 10, aFrame.size.height - 10)];
        [image setImage: uploadImage];
        [image setImageScaling:CPScaleNone];
        [self addSubview:image];


        [self addSubview:borderOverlay];

        //[self registerForDraggedTypes:["ItemImageAttachment"]];

        // activate the view as a drop zone for uploads
	    /*var fileDropUploadController = [[DCFileDropController alloc] initWithView:image 
		                                                             dropDelegate:self 
		                                                                uploadURL:[CPURL URLWithString:@"http://somepage.com/uploadImage"] 
		                                                            uploadManager:[DCFileUploadManager sharedManager]];

        [fileDropUploadController setValidFileTypes:["png","gif","jpg"]];*/
	}
	return self;
}

- (void)draggingEntered:(CPDraggingInfo)info
{
	CPLog.trace("draggingEntered");
    if (!highlightBorder)
    {
        var bundle = [CPBundle mainBundle];
         highlightBorder = [CPColor colorWithPatternImage:[[CPNinePartImage alloc] initWithImageSlices:
                      [
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-0.png"] size:CGSizeMake(9.0, 9.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-1.png"] size:CGSizeMake(2.0, 9.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-2.png"] size:CGSizeMake(8.0, 9.0)],
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-3.png"] size:CGSizeMake(9.0, 2.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-4.png"] size:CGSizeMake(2.0, 2.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-5.png"] size:CGSizeMake(8.0, 2.0)],
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-6.png"] size:CGSizeMake(9.0, 9.0)], 
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-7.png"] size:CGSizeMake(2.0, 9.0)],
                          [[CPImage alloc] initWithContentsOfFile:[bundle pathForResource:@"BorderCellView/ItemView-selected-8.png"] size:CGSizeMake(8.0, 9.0)]
                      ]]];
    }
    [borderOverlay setBackgroundColor:highlightBorder];
}

- (void)draggingExited:(CPDraggingInfo)info
{
    [borderOverlay setBackgroundColor:normalBorder];
}

- (void)imageDidLoad:(CPImage)anImage
{
    [self setImage:anImage];
}

- (void)performDragOperation:(CPDraggingInfo)info
{
	CPLog.trace("performDragOperation");
    [self draggingExited:info];

    var index = [[CPKeyedUnarchiver unarchiveObjectWithData:[[info draggingPasteboard] dataForType:"ItemImageAttachment"]] firstIndex],
        cv = [info draggingSource],
        imageData = [[cv content][index] data],
        theImage = [[CPImage alloc] initWithContentsOfFile:imageData];

    [theImage setDelegate:self];
}

/*
- (void)fileDropUploadController:(DCFileDropController)theController setState:(BOOL)visible
{
	CPLog.trace("filedropcontrollersetsate visible:" + visible);
	if (visible)
		[self draggingEntered:nil];
    else
		[self draggingExited:nil];
}
*/
/*
- (void)fileDropController:(DCFileUploadController)aController didBeginUpload:(DCFileUpload)anUpload
{
    [locationController setMainImageUpload:anUpload];
}
*/
- (void)setImage:(CPImage)anImage
{
    [anImage setSize:[self scaleImageWithSize:[anImage size]]];
    [image setImage:anImage];

}

- (CGSize)scaleImageWithSize:(CGSize)aSize
{
    var constrain = 135,
        height = aSize.height,
        width = aSize.width,
        ratio = MAX( constrain / width, constrain / height );

    width = ratio * width;
    height = ratio * height;

    return CGSizeMake(width, height);
}
@end
