<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

# FPGA_jump_game

## 前言
如果你需要使用这个项目仓库的话，请先在你的vscode下载git graph插件，你可以在网上查看教程，学会如何把这个项目下载到本地，以及如何使用git graph这个插件。

你可以参考https://zhuanlan.zhihu.com/p/6522301675 这篇文章，学会使用vivado的tcl命令来构建vivado工程和生成项目重构文件。

例如 想要利用tcl文件生成vivado工程，你需要先cd到vivado_prj文件夹内，你需要修改成你的本地路径。
![alt text](./pictures/image.png){width=70%}
另一方面，你需要把tcl文件中的srogin_dir改成本地的路径
![alt text](./pictures/image-1.png){width=70%}
然后在vivado命令行中执行下述指令，就可以生成vivado工程了。其中"../"代表上一级目录
![alt text](./pictures/image-2.png){width=70%}
执行之后就可以在vivado_prj生成vivado工程了。

## 现阶段进度

2025.06.01 
现在wechat_jump_fsm的仿真结果正常，如下图所示
![alt text](./pictures/wechat_jump_fsm_wave.png){width=70%}
<i class="fas fa-exclamation-triangle" style="color: red;"></i> 但是，每个阶段的持续时间需要根据实际情况进行调整，这要等到下板的时候才能确定。

