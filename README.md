# LXFDrawBoard
多功能小画板

## Usage


**LXFDrawBoardDelegate**

返回需要添加的描述

```objc
- (NSString *)LXFDrawBoard:(LXFDrawBoard *)drawBoard textForDescLabel:(UILabel *)descLabel;
```

当添加或修改描述时调用

```objc
- (void)LXFDrawBoard:(LXFDrawBoard *)drawBoard clickDescLabel:(UILabel *)descLabel;
```



## 笔刷
铅笔 LXFPencilBrush
![image](https://github.com/LinXunFeng/LXFDrawBoard/raw/master/Screenshots/铅笔.gif)

箭头 LXFArrowBrush
![image](https://github.com/LinXunFeng/LXFDrawBoard/raw/master/Screenshots/箭头.gif)

直线 LXFLineBrush
![image](https://github.com/LinXunFeng/LXFDrawBoard/raw/master/Screenshots/直线.gif)

文本 LXFTextBrush
![image](https://github.com/LinXunFeng/LXFDrawBoard/raw/master/Screenshots/文本.gif)

矩形 LXFRectangleBrush
![image](https://github.com/LinXunFeng/LXFDrawBoard/raw/master/Screenshots/矩形.gif)

马赛克 LXFMosaicBrush
![image](https://github.com/LinXunFeng/LXFDrawBoard/raw/master/Screenshots/马赛克.gif)

撤销与反撤销
![image](https://github.com/LinXunFeng/LXFDrawBoard/raw/master/Screenshots/撤销与反撤销.gif)

