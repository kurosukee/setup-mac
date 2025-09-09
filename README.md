# このリポジトリについて

新しいMacの初期構築を自動化するためのスクリプト集です。

# ファイル構成

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

# 使い方

## テンプレート作成

### 実行権限を付与
```bash
chmod +x setup_template.sh
```

### テンプレート作成実行
```bash
./setup_template.sh
```

## 設定ファイルを編集（必要に応じて）

### パッケージの追加/削除
`packages/Brewfile` を編集してください。

### システム設定の変更
`config/system_preferences.sh` を編集してください。

### 開発環境のセットアップの変更
`config/dev_setup.sh` を編集してください。

### dotfiles の追加
`dotfiles/` ディレクトリの設定ファイルを必要に応じて追加・変更・削除してください。

## 初期構築実行

### 実行権限を付与
```bash
chmod +x setup.sh
```

### セットアップ実行
```bash
./setup.sh
```

# 注意事項

- 初回実行時は管理者パスワードの入力が必要な場合があります
- 一部の設定は再起動後に有効になります
- 既存の設定ファイルはバックアップされます（`.backup` 拡張子付き）
