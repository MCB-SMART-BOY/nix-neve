<div align="center">

# Nix Flake for Neve

[![Release](https://img.shields.io/github/v/release/MCB-SMART-BOY/neve?include_prereleases&color=blue)](https://github.com/MCB-SMART-BOY/neve/releases)
[![License: MPL-2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://github.com/MCB-SMART-BOY/Neve/blob/master/LICENSE)

*A pure functional language for system configuration and package management*

**[English](#english)** | **[中文](#中文)**

</div>

---

## English

### About

This is the official Nix flake for [Neve](https://github.com/MCB-SMART-BOY/Neve), a pure functional programming language designed for system configuration and package management.

### Supported Platforms

| Platform | Architecture | Status |
|:---------|:-------------|:-------|
| Linux | x86_64 | ✅ Supported |
| Linux | aarch64 | ✅ Supported |
| macOS | x86_64 (Intel) | ✅ Supported |
| macOS | aarch64 (Apple Silicon) | ✅ Supported |

### Installation

#### Try Without Installing

```bash
nix run github:MCB-SMART-BOY/nix-neve
```

#### Install to Profile

```bash
nix profile install github:MCB-SMART-BOY/nix-neve
```

#### Use in Your Flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neve.url = "github:MCB-SMART-BOY/nix-neve";
  };

  outputs = { self, nixpkgs, neve, ... }: {
    # Use in a NixOS configuration
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

    # Or in a development shell
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [
        neve.packages.x86_64-linux.default
      ];
    };
  };
}
```

#### Use in shell.nix (Legacy)

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  neve = (builtins.getFlake "github:MCB-SMART-BOY/nix-neve").packages.${pkgs.system}.default;
in
pkgs.mkShell {
  packages = [ neve ];
}
```

### Update

```bash
# Update the flake input
nix flake update github:MCB-SMART-BOY/nix-neve

# Or update your profile
nix profile upgrade neve
```

### Uninstall

```bash
nix profile remove neve
```

### Usage

```bash
neve repl              # Start interactive REPL
neve eval "1 + 2"      # Evaluate expression
neve run file.neve     # Run a file
neve doc               # View documentation
neve doc quickstart    # Quick start guide
```

### Quick Example

```bash
$ neve repl
neve> let greet = fn(name) `Hello, {name}!`
neve> greet("World")
"Hello, World!"
```

### Links

- [Neve Repository](https://github.com/MCB-SMART-BOY/Neve)
- [Documentation](https://github.com/MCB-SMART-BOY/Neve/tree/master/docs)
- [Issue Tracker](https://github.com/MCB-SMART-BOY/Neve/issues)
- [Releases](https://github.com/MCB-SMART-BOY/Neve/releases)

---

## 中文

### 关于

这是 [Neve](https://github.com/MCB-SMART-BOY/Neve) 的官方 Nix flake。Neve 是一门纯函数式编程语言，专为系统配置和包管理而设计。

### 支持平台

| 平台 | 架构 | 状态 |
|:-----|:-----|:-----|
| Linux | x86_64 | ✅ 支持 |
| Linux | aarch64 | ✅ 支持 |
| macOS | x86_64 (Intel) | ✅ 支持 |
| macOS | aarch64 (Apple Silicon) | ✅ 支持 |

### 安装

#### 试用（不安装）

```bash
nix run github:MCB-SMART-BOY/nix-neve
```

#### 安装到 Profile

```bash
nix profile install github:MCB-SMART-BOY/nix-neve
```

#### 在你的 Flake 中使用

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neve.url = "github:MCB-SMART-BOY/nix-neve";
  };

  outputs = { self, nixpkgs, neve, ... }: {
    # 在 NixOS 配置中使用
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

    # 或在开发 shell 中使用
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [
        neve.packages.x86_64-linux.default
      ];
    };
  };
}
```

#### 在 shell.nix 中使用（传统方式）

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  neve = (builtins.getFlake "github:MCB-SMART-BOY/nix-neve").packages.${pkgs.system}.default;
in
pkgs.mkShell {
  packages = [ neve ];
}
```

### 更新

```bash
# 更新 flake input
nix flake update github:MCB-SMART-BOY/nix-neve

# 或更新 profile
nix profile upgrade neve
```

### 卸载

```bash
nix profile remove neve
```

### 使用

```bash
neve repl              # 启动交互式 REPL
neve eval "1 + 2"      # 求值表达式
neve run file.neve     # 运行文件
neve doc               # 查看文档
neve doc quickstart    # 快速入门
```

### 快速示例

```bash
$ neve repl
neve> let greet = fn(name) `你好，{name}！`
neve> greet("世界")
"你好，世界！"
```

### 链接

- [Neve 仓库](https://github.com/MCB-SMART-BOY/Neve)
- [文档](https://github.com/MCB-SMART-BOY/Neve/tree/master/docs)
- [问题反馈](https://github.com/MCB-SMART-BOY/Neve/issues)
- [版本发布](https://github.com/MCB-SMART-BOY/Neve/releases)

---

<div align="center">

**[Neve](https://github.com/MCB-SMART-BOY/Neve)** · **[License: MPL-2.0](https://github.com/MCB-SMART-BOY/Neve/blob/master/LICENSE)**

</div>
