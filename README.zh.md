# xixu-me/tap

<!-- README-I18N:START -->

[English](./README.md) | **汉语**

<!-- README-I18N:END -->

一个由我维护的 [Homebrew](https://brew.sh) tap。

## 内容

此 tap 提供 formula 和 cask。当前定义见 [`Formula/`](./Formula/) 和 [`Casks/`](./Casks/)。

## 安装

如果要浏览或安装此 tap 中的多个软件包，可以先添加 tap：

```sh
brew tap xixu-me/tap
```

也可以直接使用完整名称安装 formula 或 cask：

```sh
brew install xixu-me/tap/<formula>
brew install --cask xixu-me/tap/<cask>
```

查看此 tap 提供的条目：

```sh
brew search xixu-me/tap/
```

## 信任与安全

Homebrew tap 定义是可执行的 Ruby 代码，可能以当前用户权限运行。使用前请检查 tap 内容，并优先只信任需要的软件包：

```sh
brew tap xixu-me/tap
brew trust --formula xixu-me/tap/<formula>
brew trust --cask xixu-me/tap/<cask>
```

使用上面的完整 formula 或 cask 名称安装时，只会信任对应的软件包。只有在你接受此 tap 当前及未来的所有软件包时，才应信任整个 tap：

```sh
brew trust xixu-me/tap
```

详情请参阅 Homebrew 的 [Taps 文档](https://docs.brew.sh/Taps) 和 [Tap Trust 文档](https://docs.brew.sh/Tap-Trust)。

> [!WARNING]
> 只有在你信任此 tap 的来源以及其中 formula 和 cask 所引用的上游项目时，才应使用它。

## 更新和移除 tap

Homebrew 会通过 `brew update` 更新已添加的仓库。显式刷新此 tap：

```sh
brew update
brew tap --repair
```

移除 tap 及其本地副本：

```sh
brew untap xixu-me/tap
```

移除 tap 不会卸载已经从其中安装的软件包。

## 开发

Formula 和 cask 分别位于 `Formula/` 和 `Casks/`。提交 Pull Request 前，请运行发生变化的定义对应的检查：

```sh
brew audit --strict --online xixu-me/tap/<formula>
brew test xixu-me/tap/<formula>
```

GitHub Actions 会在 push 和 Pull Request 时检查 tap 语法。Pull Request 还会审计、下载、安装并卸载发生变化的 cask。定时工作流会检查上游 formula 和 cask 的更新；经过审核的 Pull Request 可以发布 bottle。
