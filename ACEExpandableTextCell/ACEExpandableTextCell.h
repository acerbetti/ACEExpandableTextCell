//  ACEExpandableTextCell.h
//
// Copyright (c) 2014 Stefano Acerbetti
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


#import "SZTextView.h"

@protocol ACEExpandableTableViewDelegate <UITableViewDelegate, UITextViewDelegate>

@required
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)tableView:(UITableView *)tableView textViewDidChangeSelection:(UITextView*)textView;
- (void)tableView:(UITableView *)tableView textViewDidEndEditing:(UITextView*)textView;
@end

#pragma mark -

@interface ACEExpandableTextCell : UITableViewCell

@property (nonatomic, weak) UITableView *expandableTableView;
@property (nonatomic, strong, readonly) SZTextView *textView;

@property (nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic, strong) NSString *text;

-(void)updateTextViewHeight; // Call to update the textView height (useful for viewdidload)

@end

#pragma mark -

@interface UITableView (ACEExpandableTextCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (ACEExpandableTextCell *)expandableTextCellWithId:(NSString *)cellId;

@end
