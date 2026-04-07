<div align="center">

# Nix Flake for Neve

[![Release](https://img.shields.io/github/v/release/MCB-SMART-BOY/neve?include_prereleases&color=blue)](https://github.com/MCB-SMART-BOY/neve/releases)
[![License: MPL-2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://github.com/MCB-SMART-BOY/Neve/blob/master/LICENSE)

*A standalone language for system configuration, reproducible builds, and structured shell automation*

</div>

---

## About / 关于

This is the official Nix flake for [Neve](https://github.com/MCB-SMART-BOY/Neve), a standalone language aimed at system configuration, reproducible builds, and structured shell automation.
这是 [Neve](https://github.com/MCB-SMART-BOY/Neve) 的官方 Nix flake。Neve 是一门独立语言，目标是把系统配置、可复现构建与结构化 shell 自动化放进同一套工具链里。

## Supported Platforms / 支持平台

| Platform / 平台 | Architecture / 架构 | Status / 状态 |
|:--|:--|:--|
| Linux | x86_64 | ✅ Supported / ✅ 支持 |
| Linux | aarch64 | ✅ Supported / ✅ 支持 |
| macOS | x86_64 (Intel) | ✅ Supported / ✅ 支持 |
| macOS | aarch64 (Apple Silicon) | ✅ Supported / ✅ 支持 |

## Installation / 安装

### Try Without Installing / 直接试用（不安装）

```bash
nix run github:MCB-SMART-BOY/nix-neve
```

### Install to Profile / 安装到 Profile

```bash
nix profile install github:MCB-SMART-BOY/nix-neve
```

### Use in Your Flake / 在你的 Flake 中使用

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neve.url = "github:MCB-SMART-BOY/nix-neve";
  };

  outputs = { self, nixpkgs, neve, ... }: {
    # Use in a NixOS configuration / 在 NixOS 配置中使用
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = [
            neve.packages.${pkgs.system}.default
          ];
        })
      ];
    };

    # Or in a development shell / 或在开发 shell 中使用
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [
        neve.packages.x86_64-linux.default
      ];
    };
  };
}
```

### Use in shell.nix (Legacy) / 在 shell.nix 中使用（传统方式）

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  neve = (builtins.getFlake "github:MCB-SMART-BOY/nix-neve").packages.${pkgs.system}.default;
in
pkgs.mkShell {
  packages = [ neve ];
}
```

## Update / 更新

```bash
# Update the flake input / 更新 flake input
nix flake update github:MCB-SMART-BOY/nix-neve

# Or update your profile / 或更新 profile
nix profile upgrade neve
```

## Uninstall / 卸载

```bash
nix profile remove neve
```

## Usage / 使用

```bash
neve repl              # Start interactive REPL / 启动交互式 REPL
neve eval "1 + 2"      # Evaluate expression / 求值表达式
neve run file.neve     # Run a file / 运行文件
neve doc               # View documentation / 查看文档
neve doc quickstart    # Quick start guide / 快速入门
```

## Quick Example / 快速示例

```bash
$ neve repl
neve> let greet = fn(name) `Hello, {name}!`
neve> greet("World")
"Hello, World!"
```

## Links / 链接

- [Neve Repository / 仓库](https://github.com/MCB-SMART-BOY/Neve)
- [Documentation / 文档](https://github.com/MCB-SMART-BOY/Neve/tree/master/docs)
- [Issue Tracker / 问题反馈](https://github.com/MCB-SMART-BOY/Neve/issues)
- [Releases / 版本发布](https://github.com/MCB-SMART-BOY/Neve/releases)

---

<div align="center">

**[Neve](https://github.com/MCB-SMART-BOY/Neve)** · **[License: MPL-2.0](https://github.com/MCB-SMART-BOY/Neve/blob/master/LICENSE)**

</div>
