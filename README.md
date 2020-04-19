# Merchant Story

このリポジトリにあるファイルは、 [商人物語*あきんどものがたり](http://www.geocities.co.jp/Playtown-Bingo/8587/) からダウンロードできる
`商人物語システム 05-03-30 ＋ ワールドアトラスアイテムセット` に以下の変更を加えたものです。

* ファイルの文字コードを Shift_JIS から UTF-8 に変更
* ファイルの改行コードを CRLF から LF に変更
* 軽微なバグの修正

プログラムに含まれる画像や音楽は無断での再配布が禁止されているので、このリポジトリには付属していません。

そのため画像や音楽に関しては、公式サイトよりダウンロードできるプログラムからマージしてください。<sup>[1](#note1)</sup>

付属のシェルスクリプト `merge.sh` を使うと、マージを自動化することができます。

## Development

```
$ git clone https://github.com/halmics/merchant-story.git
$ cd merchant-story
$ docker-compose up -d --build
```

## FAQ

### データ初期化をすると以下のようなエラーが発生してしまう

```
index.cgi の実行により発生。(2017/12/19 04:38:59)
「../common/towndata.cgi」の 2行目付近に原因があるようです。<br>このファイルを特に改変していない場合は別なファイルにエラーがあります。
文法ミスです。「"」「'」「;」「}」などのつけ忘れであることが多いです。
syntax error at ../common/towndata.cgi line 2, near &quot;{}&quot;<br>Compilation failed in require at ../program/inc-func.cgi line 20.<br>
```

---

Apache の suEXEC が有効になっている関係で環境変数が読み込めなくり、ハッシュ変数 `$Tname` のキーが空になってしまうことが原因です。

適切な設定を施すか、 suEXEC を無効化することで回避できます。

<small id="note1">1. 2019/03/31 Yahoo!ジオシティーズのサービス終了に伴い公式サイトが閉鎖してしまったため、現在プログラムはダウンロードできません。</small>
