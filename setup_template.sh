#!/bin/bash

# Mac初期構築用のテンプレートファイル作成スクリプト
# Usage: ./setup_template.sh

set -e

log_info() {
    echo -e "\033[32m[INFO]\033[0m $1"
}

create_directory_structure() {
    log_info "ディレクトリ構造を作成しています..."
    
    mkdir -p packages
    mkdir -p config
    mkdir -p dotfiles
    
    log_info "ディレクトリ構造を作成しました"
}

create_brewfile() {
    if [[ ! -f "packages/Brewfile" ]]; then
        log_info "packages/Brewfile を作成しています..."
        
        cat > packages/Brewfile << 'EOF'
# Homebrewでインストールするパッケージを指定
# Usage: brew bundle --file=packages/Brewfile

# tap "homebrew/cask"

# 基本的なCLIツール
# brew "git"
# brew "curl"
# brew "wget"
# brew "tree"
# brew "jq"

# エディタ
# brew "vim"

# シェル
# brew "zsh"

# 開発ツール（必要に応じてコメントアウト）
# brew "npm"
# brew "docker"
# brew "node"
# brew "python@3.11"

# GUIアプリケーション
# cask "google-chrome"
# cask "iterm2"
# cask "alfred"
# cask "sublime-text"
# cask "visual-studio-code"
# cask "intellij-idea"
# cask "sourcetree"
# cask "docker-desktop"
# cask "dbeaver-community"
# cask "postman"

# フォント
# cask "font-source-code-pro"
# cask "font-jetbrains-mono"

# 必要に応じて以下を追加/削除してください
# cask "slack"
# cask "discord"
# cask "gather"
# cask "1password"
# cask "notion"
EOF
        
        log_info "packages/Brewfile を作成しました"
    else
        log_info "packages/Brewfile は既に存在します"
    fi
}

create_system_preferences() {
    if [[ ! -f "config/system_preferences.sh" ]]; then
        log_info "config/system_preferences.sh を作成しています..."
        
        cat > config/system_preferences.sh << 'EOF'
#!/bin/bash

# macOS システム設定の自動化
echo "システム設定を適用しています..."

# Dockのサイズを小さくする
# defaults write com.apple.dock tilesize -int 36

# Dockを自動で隠す
# defaults write com.apple.dock autohide -bool true

# 拡張子を表示
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 隠しファイルを表示　※注意：有効にするとPCの動作が重くなる可能性があります
# defaults write com.apple.finder AppleShowAllFiles -bool false

# パスバーを表示
# defaults write com.apple.finder ShowPathbar -bool true

# ゴミ箱を空にする時のダイアログを無効化
# defaults write com.apple.finder WarnOnEmptyTrash -bool false

# 未確認ファイルを開く時の警告を無効化
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# スクリーンショットの保存場所を~/Screenshots に変更
# mkdir -p ~/Screenshots
# defaults write com.apple.screencapture location -string "~/Screenshots"

# トラックパッドの移動速度（0.0〜3.0、デフォルトは0.875、推奨範囲は0.5〜2.0）※注意：早いとPCの動作が重くなる可能性があります
# defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.0

# トラックパッドのスクロール速度（0.0〜3.0、デフォルトは0.875、推奨範囲は0.3〜1.5）※注意：早いとPCの動作が重くなる可能性があります
# defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 1.5

# トラックパッドのクリック感度（0〜2、0=軽い、2=しっかり）
# defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
# defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

# マウスの移動速度（-1.0〜3.0、デフォルトは2.5、推奨範囲は1.0〜3.0）※注意：早いとPCの動作が重くなる可能性があります
# defaults write NSGlobalDomain com.apple.mouse.scaling -float 3.0

# マウスのスクロール速度（0.0〜3.0、デフォルトは0.875）
# defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 3.0

# マウスのダブルクリック間隔（ミリ秒、デフォルトは500）
# defaults write NSGlobalDomain com.apple.mouse.doubleClickThreshold -float 0.5

# キーのリピート速度を高速化（120〜2、デフォルトは6、推奨範囲は2:30ms,6:100ms,12:200ms,120:2000ms）※注意：早いとPCの動作が重くなる可能性があります
# defaults write NSGlobalDomain KeyRepeat -int 12
# キーのリピート速度を高速化（120〜15、デフォルトは25、推奨範囲は15:225ms,25:375ms,35:525ms,120:1800ms）※注意：早いとPCの動作が重くなる可能性があります
# defaults write NSGlobalDomain InitialKeyRepeat -int 35

# メニューバーを自動的に隠す
# defaults write NSGlobalDomain _HIHideMenuBar -bool true

# サイドバーのアイコンサイズを変更（1=小、2=中、3=大）
# defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# ダークモードを有効化
# defaults write NSGlobalDomain AppleInterfaceStyle Dark

# 3本指のドラッグを有効（アクセシビリティの設定）
# defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
# defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# スクリーンショットの保存フォルダを変更
# defaults write com.apple.screencapture location ~/Downloads/

# スクリーンショットの保存ファイル形式を変更
# defaults write com.apple.screencapture type png

# スクリーンショットの撮影時のサムネイル表示を無効化
# defaults write com.apple.screencapture show-thumbnail -bool false

# ウィンドウキャプチャ時のドロップシャドウを無効化
# defaults write com.apple.screencapture disable-shadow -bool true

echo "システム設定の適用が完了しました"

# 設定を反映
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
EOF
        
        chmod +x config/system_preferences.sh
        log_info "config/system_preferences.sh を作成しました"
    else
        log_info "config/system_preferences.sh は既に存在します"
    fi
}

create_dev_setup() {
    if [[ ! -f "config/dev_setup.sh" ]]; then
        log_info "config/dev_setup.sh を作成しています..."
        
        cat > config/dev_setup.sh << 'EOF'
#!/bin/bash

# 開発環境のセットアップ
echo "開発環境をセットアップしています..."

# Git設定（必要に応じて編集）
# git config --global user.name "Your Name"
# git config --global user.email "your.email@example.com"

# Node.js（必要な場合）
if command -v node >/dev/null 2>&1; then
    echo "Node.js version: $(node --version)"
    
    # グローバルパッケージのインストール例
    # npm install -g yarn
    # npm install -g pnpm
    # npm install -g @vue/cli
    # npm install -g create-react-app
    # npm install -g @anthropic-ai/claude-code
fi

# claude（必要な場合）
if command -v claude >/dev/null 2>&1; then
    echo "claude version: $(claude --version)"
    
    # 設定変更
    # claude config set --global preferredNotifChannel terminal_bell
fi

# Python（必要な場合）
if command -v python3 >/dev/null 2>&1; then
    echo "Python3 version: $(python3 --version)"
    
    # pipの最新化
    # python3 -m pip install --upgrade pip
    
    # よく使うパッケージのインストール例
    # pip3 install requests numpy pandas matplotlib
fi

# SSH鍵の生成（必要な場合）
# if [[ ! -f ~/.ssh/id_rsa ]]; then
#     ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
#     eval "$(ssh-agent -s)"
#     ssh-add ~/.ssh/id_rsa
# fi

echo "開発環境のセットアップが完了しました"
EOF
        
        chmod +x config/dev_setup.sh
        log_info "config/dev_setup.sh を作成しました"
    else
        log_info "config/dev_setup.sh は既に存在します"
    fi
}

create_sample_dotfiles() {
    log_info "サンプル dotfiles を作成しています..."
    
    # .zshrc サンプル
    if [[ ! -f "dotfiles/.zshrc" ]]; then
        cat > dotfiles/.zshrc << 'EOF'
# Zsh設定ファイル

# History設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt hist_ignore_dups

# 補完機能
autoload -U compinit
compinit

# Starship プロンプト（インストールされている場合）
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# Aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

# 環境変数
export EDITOR=vim
export LANG=en_US.UTF-8

# Homebrew（Apple Silicon Mac用）
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
EOF
        log_info "dotfiles/.zshrc を作成しました"
    fi
    
    # .gitconfig サンプル
    if [[ ! -f "dotfiles/.gitconfig" ]]; then
        cat > dotfiles/.gitconfig << 'EOF'
[user]
    # name = Your Name
    # email = your.email@example.com

[core]
    editor = vim
    autocrlf = input

[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    df = diff
    lg = log --oneline --graph --all

[push]
    default = simple

[pull]
    rebase = false
EOF
        log_info "dotfiles/.gitconfig を作成しました（user情報は編集が必要）"
    fi
}

create_readme() {
    if [[ ! -f "README.md" ]]; then
        log_info "README.md を作成しています..."
        
        cat > README.md << 'EOF'
# Mac初期構築自動化

このリポジトリは、新しいMacの初期構築を自動化するためのスクリプト集です。

## 使い方

1. このリポジトリをクローンまたはダウンロード
2. 設定ファイルを編集（必要に応じて）
3. セットアップスクリプトを実行

```bash
# 実行権限を付与
chmod +x setup.sh

# セットアップ実行
./setup.sh
```

## ファイル構成

```
.
├── setup.sh                    # メインのセットアップスクリプト
├── setup_template.sh           # テンプレートファイル作成スクリプト
├── packages/
│   └── Brewfile                # Homebrewでインストールするパッケージ
├── config/
│   ├── system_preferences.sh   # macOSのシステム設定
│   └── dev_setup.sh            # 開発環境のセットアップ
├── dotfiles/
│   ├── .zshrc                  # Zsh設定
│   └── .gitconfig              # Git設定
└── README.md
```

## カスタマイズ

### パッケージの追加/削除
`packages/Brewfile` を編集してください。

### システム設定の変更
`config/system_preferences.sh` を編集してください。

### dotfiles の追加
`dotfiles/` ディレクトリに設定ファイルを追加してください。

## 注意事項

- 初回実行時は管理者パスワードの入力が必要な場合があります
- 一部の設定は再起動後に有効になります
- 既存の設定ファイルはバックアップされます（`.backup` 拡張子付き）
EOF
        
        log_info "README.md を作成しました"
    else
        log_info "README.md は既に存在します"
    fi
}

main() {
    log_info "Mac初期構築用のテンプレートを作成します..."
    
    create_directory_structure
    create_brewfile
    create_system_preferences
    create_dev_setup
    create_sample_dotfiles
    create_readme
    
    log_info "テンプレートの作成が完了しました！"
    echo ""
    echo "次のステップ："
    echo "1. packages/Brewfile を編集してインストールしたいパッケージを指定"
    echo "2. config/system_preferences.sh を編集してシステム設定を調整"
    echo "3. dotfiles/ にお好みの設定ファイルを配置"
    echo "4. ./setup.sh を実行して初期構築を開始"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi