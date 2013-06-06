//  ACEExpandableTextCell.m
//
// Copyright (c) 2013 Stefano Acerbetti
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "ACEExpandableTextCell.h"

#define kPadding 4

@interface ACEExpandableTextCell ()<UITextViewDelegate>
@property (nonatomic, assign) UITableView *expandableTableView;
@property (nonatomic, strong) UITextView *textView;
@end

#pragma mark -

@implementation ACEExpandableTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textView];
    }
    return self;
}

- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:self.contentView.bounds];
        _textView.delegate = self;
        
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:18.0f];
        
        _textView.scrollEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        // textView.contentInset = UIEdgeInsetsZero;
    }
    return _textView;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI
    self.textView.text = text;
}


#pragma mark - Text View Delegate

- (void)textViewDidChange:(UITextView *)theTextView
{
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(ACEExpandableTableView)]) {
        
        id<ACEExpandableTableView> delegate = (id<ACEExpandableTableView>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        // update the text
        _text = self.textView.text;
        
        [delegate tableView:self.expandableTableView
                updatedText:_text
                atIndexPath:indexPath];
        
        CGFloat newHeight = self.textView.contentSize.height + kPadding*2;
        CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
        if (fabs(newHeight - oldHeight) > 0.01) {
            
            // update the height
            [delegate tableView:self.expandableTableView
                   updatedHeigh:newHeight
                    atIndexPath:indexPath];
        }
    }
}

@end

#pragma mark -

@implementation UITableView (ACEExpandableTextCell)

- (ACEExpandableTextCell *)expandableTextCellWithId:(NSString *)cellId
{
    ACEExpandableTextCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ACEExpandableTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

- (CGFloat)heightForExpandableTextAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

@end

