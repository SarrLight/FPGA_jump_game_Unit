<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

# FPGA_jump_game

## 前言
如果你需要使用这个项目仓库的话，请先在你的vscode下载git graph插件，你可以在网上查看教程，学会如何把这个项目下载到本地，以及如何使用git graph这个插件。

你可以参考https://zhuanlan.zhihu.com/p/6522301675 这篇文章，学会使用vivado的tcl命令来构建vivado工程和生成项目重构文件。

例如 想要利用tcl文件生成vivado工程，你需要先cd到vivado_prj文件夹内，你需要修改成你的本地路径。

<img src="./pictures/image.png" width="70%">

另一方面，你需要把tcl文件中的srogin_dir改成本地的路径

<img src="./pictures/image-1.png" width="70%">

然后在vivado命令行中执行下述指令，就可以生成vivado工程了。其中"../"代表上一级目录

<img src="./pictures/image-2.png" width="70%">

执行之后就可以在vivado_prj生成vivado工程了。

## 现阶段进度

#### <i class="fas fa-calendar-alt" style="color: darkblue;"></i> 2025.06.04
4和5已经解决。下图是wechat_jump_fsm的仿真结果

<img src="./pictures/wechat_jump_fsm_wave_2.png" width="100%">

从图中的o_buzzer可以看出i_load_done出现一个高电平信号时，o_buzzer会有一段时间的方波信号，这段时间内蜂鸣器会发出声音。但是声音的频率可能需要根据下板的结果进行调整。

另一方面，这次我修改了Buzzer模块的代码，使其发出声音的频率能根据squeeze_man的大小变化快速发生改变，换句话就是降低了它们之间的延迟。然而，具体的效果还需要等到下板的时候看看。

#### <i class="fas fa-calendar-alt" style="color: darkblue;"></i> 2025.06.02

下板结果正常，但是存在一下几个问题：

1.随机生成的箱子2的位置还不太合适
2.有时候拨动开关没反应
3.现在小人会被锁定到箱子正中心，这一点需要改进
4.小人落到箱子上没有音效
5.游戏结束这四个字的图片还没有做蒙版(这个简单，只不过还没做)
6.我想的是应该刚开始显示跳一跳标题，玩家按键之后小人移动的指定位置并开始游戏。结束的时候玩家再次按键重新开始游戏(视频是使用了单独的复位键)

<img src="./pictures/download_result_6_2.png" width="50%">


#### <i class="fas fa-calendar-alt" style="color: darkblue;"></i> 2025.06.01 
现在wechat_jump_fsm的仿真结果正常，如下图所示
<img src="./pictures/wechat_jump_fsm_wave.png" width="70%">

<i class="fas fa-exclamation-triangle" style="color: red;"></i> 但是，每个阶段的持续时间需要根据实际情况进行调整，这要等到下板的时候才能确定。

