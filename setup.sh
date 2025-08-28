#!/bin/bash

# Mac初期構築自動化スクリプト
# Usage: ./setup.sh

set -e

# 色付きログ用の関数
log_info() {
    echo -e "\033[32m[INFO]\033[0m $1"
}

log_warn() {
    echo -e "\033[33m[WARN]\033[0m $1"
}

log_error() {
    echo -e "\033[31m[ERROR]\033[0m $1"
}

# 設定ファイルの存在確認
check_config_files() {
    local missing_files=()
    
    if [[ ! -f "packages/Brewfile" ]]; then
        missing_files+=("packages/Brewfile")
    fi
    
    if [[ ! -f "config/system_preferences.sh" ]]; then
        missing_files+=("config/system_preferences.sh")
    fi
    
    if [[ ${#missing_files[@]} -gt 0 ]]; then
        log_error "以下の設定ファイルが見つかりません:"
        printf '%s\n' "${missing_files[@]}"
        log_info "setup_template.sh を実行してテンプレートファイルを作成してください"
        exit 1
    fi
}

# Homebrewのインストール
install_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        log_info "Homebrew は既にインストールされています"
        brew update
    else
        log_info "Homebrew をインストールしています..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Apple Silicon Macの場合、PATHを設定
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

# パッケージのインストール
install_packages() {
    log_info "Brewfile からパッケージをインストールしています..."
    if [[ -f "packages/Brewfile" ]]; then
        brew bundle --file=packages/Brewfile
        log_info "パッケージのインストールが完了しました"
    else
        log_warn "packages/Brewfile が見つかりません"
    fi
}

# システム設定の適用
apply_system_preferences() {
    log_info "システム設定を適用しています..."
    if [[ -f "config/system_preferences.sh" ]]; then
        bash config/system_preferences.sh
        log_info "システム設定の適用が完了しました"
    else
        log_warn "config/system_preferences.sh が見つかりません"
    fi
}

# dotfilesの設置
setup_dotfiles() {
    if [[ -d "dotfiles" ]]; then
        log_info "dotfiles を設置しています..."
        
        for file in dotfiles/.*; do
            if [[ -f "$file" ]]; then
                filename=$(basename "$file")
                if [[ "$filename" != "." && "$filename" != ".." ]]; then
                    if [[ -f "$HOME/$filename" ]]; then
                        log_warn "$HOME/$filename は既に存在します (バックアップを作成: $HOME/$filename.backup)"
                        cp "$HOME/$filename" "$HOME/$filename.backup"
                    fi
                    cp "$file" "$HOME/$filename"
                    log_info "$filename を $HOME に配置しました"
                fi
            fi
        done
    else
        log_info "dotfiles ディレクトリが見つかりません（スキップ）"
    fi
}

# 開発環境のセットアップ
setup_development_environment() {
    if [[ -f "config/dev_setup.sh" ]]; then
        log_info "開発環境をセットアップしています..."
        bash config/dev_setup.sh
    else
        log_info "config/dev_setup.sh が見つかりません（スキップ）"
    fi
}

# メイン実行
main() {
    log_info "Mac初期構築を開始します..."
    
    # 設定ファイルの確認
    check_config_files
    
    # Homebrewのインストール
    install_homebrew
    
    # パッケージのインストール
    install_packages
    
    # システム設定の適用
    apply_system_preferences
    
    # dotfilesの設置
    setup_dotfiles
    
    # 開発環境のセットアップ
    setup_development_environment
    
    log_info "Mac初期構築が完了しました！"
    log_warn "一部の設定を有効にするため、システムの再起動をお勧めします"
}

# スクリプトが直接実行された場合のみmainを実行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi