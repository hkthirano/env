# env

- mac
  - [初心者向け：Zshの導入](https://qiita.com/iwaseasahi/items/a2b00b65ebd06785b443)
  - [1箇所コピペするだけでgitブランチ名を常に表示【.zshrc】](https://suwaru.tokyo/1%E7%AE%87%E6%89%80%E3%82%B3%E3%83%94%E3%83%9A%E3%81%99%E3%82%8B%E3%81%A0%E3%81%91%E3%81%A7git%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E5%90%8D%E3%82%92%E5%B8%B8%E3%81%AB%E8%A1%A8%E7%A4%BA%E3%80%90-zshrc/)

- ubuntu
  - [Linux OS ubuntu のlocale 設定](https://qiita.com/valzer0/items/d7166a27c156b0699655)
  - [Gitの補完やら、ブランチ名表示やらをbashでしようとしたらエラーが出る](https://qiita.com/gekkoukisi/items/22cc855700a19a2f2c20)

- pyenv
  ```sh
  git clone git://github.com/yyuu/pyenv.git ~/.pyenv
  
  vim ~/.bash_profile
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  source ~/.bash_profile
  ```
