<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="6" lg="8" sm="10" cols="12">
        <v-card class="mx-auto">
          <v-toolbar
            color="cyan darken-1"
            dark
            flat
          >
            <v-toolbar-title>
              About
            </v-toolbar-title>
          </v-toolbar>
          <v-card-text id="about-text">
            <h1>アプリの概要</h1>
            <p class="mt-5">『ガジェコミ！』はガジェット好きが集まれるSNS型のWebアプリケーションです。</p>
            <p>簡単に言ってしまえば『Twitterクローン』に近いものなので、SNSに必要な機能を重点的に実装済み。</p>
            <p>スマホ利用を想定しているのでモバイルからも気軽にお試し下さい！（ゲストログイン有ります）</p>
            <p><a href="https://gadget-community.com">サイトURL</a></p>
            <p><a href="https://github.com/kuromitsu0104/gadget-app">GitHubリポジトリ</a></p>
            <h3 class="mt-5">トップページ</h3>
            <v-img class="mt-5" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/d49a4b2d-00dc-3492-0b07-f61d540f7586.png"/>
            <h3 class="mt-5">レスポンシブ対応</h3>
            <p class="mt-5">スマホ利用を想定したUI設計。</p>
            <v-img class="mt-5" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/ad9c516a-6424-d08c-37c5-e565d33861b3.gif" max-width="50%"/>
            <h3 class="mt-5">Ajax処理</h3>
            <p class="mt-5">ネストした要素でもAjaxで動作します。</p>
            <p class="mt-5">例）『コメントアイコンをタップ → コメント欄を表示 → 既にあるコメントに返信』</p>
            <v-img class="mt-5" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/bf395ffa-3d25-6d3e-a842-9a3414a1a138.gif"/>
            <p class="mt-5">例）『コメントを削除』</p>
            <v-img class="mt-5" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/541375a5-43db-2963-673f-c2e448cf90cf.gif"/>
            <h1 class="mt-5">ポートフォリオに使用した技術</h1>
            <h3 class="mt-5">各バージョン</h3>
            <ul class="mt-5 ml-5">
              <li>Ruby 2.7.1</li>
              <li>Rails 6.0.3.4</li>
              <li>nuxt 2.14.6</li>
              <li>@nuxtjs/vuetify 1.11.2</li>
              <li>Docker 19.03.13</li>
              <li>docker-compose 1.274</li>
              <li>Terraform 0.14.3</li>
            </ul>
            <h3 class="mt-5">フロントエンド</h3>
            <v-simple-table class="ma-5">
              <thead>
                <tr>
                  <th>名称</th>
                  <th>説明</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Nuxt.js (SSR mode)</td>
                  <td>フロントエンドフレームワーク</td>
                </tr>
                <tr>
                  <td>Vuetify</td>
                  <td>UIコンポーネント</td>
                </tr>
                <tr>
                  <td>Firebase Authentication</td>
                  <td>JWTを用いたログイン・ログアウト</td>
                </tr>
              </tbody>
            </v-simple-table>
            <ul class="mt-5 ml-5">
              <li>Vuetifyコンポーネントを導入することで、スマホ利用を想定したレスポンシブデザインを実現。</li>
              <li>Vuexストアでステート管理。</li>
              <li>個人情報（メールアドレス・パスワード）は、外部API（Firebase Authentication）に保存する仕組みで、外部APIで発行されるJWTをSession Storageに保存してログイン・ログアウト機能を実装しました。</li>
              <li>未ログイン状態でアクセスして欲しくないページ（ /users/editなど ）へのアクセス対策には、Nuxt.jsのmiddlewareを活用することで自動的にリダイレクトするようにしました。</li>
              <li>ログイン状態でアクセスして欲しくないページ （ログインページ, 新規作成ページ） へのアクセスも同じくリダイレクトします。</li>
            </ul>
            <h3 class="mt-5">バックエンド</h3>
            <v-simple-table class="ma-5">
              <thead>
                <tr>
                  <th>名称</th>
                  <th>説明</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Rails (API mode)</td>
                  <td>APIサーバーとして利用</td>
                </tr>
                <tr>
                  <td>PostgreSQL</td>
                  <td>データベース</td>
                </tr>
              </tbody>
            </v-simple-table>
            <ul class="mt-5 ml-5">
              <li>RailsはAPIサーバーとして利用しており、フロントエンドコンテナからのリクエストに対してJSONデータを返しています。</li>
              <li>画像データはActiveStorage経由でS3バケットに保存。</li>
              <li>その他のデータはRDSに保存。</li>
              <li>個人情報（メールアドレス・パスワード）は外部API（Firebase Authentication）に保存しているので、バックエンド側にセンシティブな情報を保存しない仕組みです。</li>
            </ul>
            <h3 class="mt-5">テストコード</h3>
            <v-simple-table class="ma-5">
              <thead>
                <tr>
                  <th>名称</th>
                  <th>説明</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Jest</td>
                  <td>フロントエンドテスト, Vuexストアの動作を少しだけ</td>
                </tr>
                <tr>
                  <td>RSpec</td>
                  <td>バックエンドテスト, バリデーションとアソシエーションのテストのみ</td>
                </tr>
              </tbody>
            </v-simple-table>
            <ul class="mt-5 ml-5">
              <li>CodePipelineのTestステージで実行するテストコードです。</li>
            </ul>
            <h3 class="mt-5">インフラ</h3>
            <v-simple-table class="ma-5">
              <thead>
                <tr>
                  <th>名称</th>
                  <th>説明</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>ECS Fargate</td>
                  <td>サーバーレスな本番環境, オートスケール</td>
                </tr>
                <tr>
                  <td>CodePipeline</td>
                  <td>CI/CD環境</td>
                </tr>
                <tr>
                  <td>RDS</td>
                  <td>本番用DB（PostgreSQL）</td>
                </tr>
                <tr>
                  <td>Docker, Docker-compose</td>
                  <td>コンテナ環境</td>
                </tr>
                <tr>
                  <td>Github</td>
                  <td>バージョン管理</td>
                </tr>
                <tr>
                  <td>Terraform</td>
                  <td>本番用インフラをコード管理</td>
                </tr>
              </tbody>
            </v-simple-table>
            <ul class="mt-5 ml-5">
              <li>ローカル開発環境からデプロイまで一貫してDockerを使用。</li>
              <li>ALBを通すことで常時SSL通信化。</li>
              <li>CodePipelineは、 『Sourceステージ => Testステージ => Buildステージ => Deployステージ』の順で実行され、Testステージで問題が発生した場合は当該ソースでのDeployは実行されません。</li>
              <li>本番環境の環境変数については SSM で管理。『システム環境変数 => Terraform => SSM => 各AWSサービス』というフローで環境変数を受け渡しています。 </li>
            </ul>
            <h3 class="mt-5">インフラ構成図</h3>
            <p class="mt-5">インフラの全体像をまとめたものがこちら。</p>
            <p>RDSにはPostgreSQLを採用し、画像を除いたデータを保管。</p>
            <p>画像データはS3に保管しています。</p>
            <v-img class="mt-5" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/4b873df7-3103-702f-2db7-273f6bd43149.png"/>
            <h3 class="mt-5">ER図</h3>
            <p class="mt-5">一貫性のあるテーブル名称を意識しました。</p>
            <v-img class="mt-5" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/5e990b5c-9302-9d78-26f0-c3de6a09ae25.png"/>
            <h1 class="mt-5">アプリの機能紹介</h1>
            <h3 class="mt-5">0. 機能一覧</h3>
            <v-simple-table class="ma-5">
              <thead>
                <tr>
                  <th>機能名</th>
                  <th>説明</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>ユーザー機能</td>
                  <td>新規登録、登録内容変更、アバター登録、ログイン、ログアウト、フォロー</td>
                </tr>
                <tr>
                  <td>つぶやき機能</td>
                  <td>投稿、編集、削除、画像複数枚登録</td>
                </tr>
                <tr>
                  <td>つぶやきコメント機能</td>
                  <td>つぶやきに対してコメント投稿、コメントへのリプライ投稿、削除、画像複数枚登録</td>
                </tr>
                <tr>
                  <td>つぶやきいいね機能</td>
                  <td>つぶやきをいいねできる、マイページのいいねタブにいいねしたつぶやきを一覧表示</td>
                </tr>
                <tr>
                  <td>掲示板機能</td>
                  <td>質問掲示板、雑談掲示板の作成、編集、削除、画像複数枚登録</td>
                </tr>
                <tr>
                  <td>掲示板コメント機能</td>
                  <td>掲示板に対してコメント投稿、コメントへのリプライ投稿、削除、画像複数枚登録</td>
                </tr>
                <tr>
                  <td>私物ガジェット機能</td>
                  <td>登録、編集、削除、画像複数枚登録</td>
                </tr>
                <tr>
                  <td>フィード機能</td>
                  <td>つぶやき新着表示、タイムライン表示、タグフィード表示</td>
                </tr>
                <tr>
                  <td>タグ管理機能</td>
                  <td>つぶやき・掲示板・私物ガジェットにはタグを登録可能、タグをタップしてタグ詳細ページを表示、タグ詳細ページではタグを含むコンテンツを表示</td>
                </tr>
                <tr>
                  <td>検索機能</td>
                  <td>各コンテンツを検索可能</td>
                </tr>
                <tr>
                  <td>通知機能</td>
                  <td>つぶやきにいいね・コメント、掲示板にコメント、他ユーザーからフォローされると通知を表示</td>
                </tr>
                <tr>
                  <td>管理者モード</td>
                  <td>Godmode のトグルスイッチをONにすると、一時的に管理者権限が有効化、各コンテンツの削除メニューが表示される</td>
                </tr>
              </tbody>
            </v-simple-table>
            <h3 class="mt-5">1. ユーザー機能</h3>
            <h4 class="mt-5">登録・編集・削除</h4>
            <p class="mt-5">メールアドレスとパスワードを入力するだけでアカウント作成できます。</p>
            <p>メールアドレス確認機能は未実装。</p>
            <p>VeeValidateを使用してフォームにバリデーションを設定しています。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9365c676-c632-f40c-c4dd-ddbdaa308781.gif" alt="user_create.gif"/>
            <p class="mt-5">詳細設定ページで登録情報を編集できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/ed2d448e-9eb8-0d2e-e359-80d501380078.gif" alt="user_edit.gif"/>
            <p class="mt-5">ユーザーにはアバターを設定できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/7859aef6-382d-f5f1-dfaa-5d2e8775a39a.gif" alt="user_avatar.gif"/>
            <p class="mt-5">アバター画像は各コンテンツで表示されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/f5187e9a-fecf-33ba-9a65-4c5a19fa46df.png" alt="user_avatar_view.png"/>
            <h3 class="mt-5">2. つぶやき機能</h3>
            <h4 class="mt-5">投稿・編集・削除</h4>
            <p class="mt-5">つぶやき作成は即時反映されます。
            <v-img class="mt-5" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/ed23f37a-b7e4-31ce-5142-391c8fb2e4f2.gif" alt="post_create.gif"/>
            <p class="mt-5">つぶやき編集は即時反映されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9011bbdf-29d2-8e8c-76ad-8b400fa4303f.gif" alt="post_edit.gif"/>
            <p class="mt-5">つぶやき削除は即時反映されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/524b41ae-9d54-4385-a9dc-8516ecf1cc60.gif" alt="post_delete.gif"/>
            <h4 class="mt-5" id="タグ付け">タグ付け</h4>
            <p class="mt-5">つぶやきにはタグを複数登録できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/c9744119-500e-926a-eefb-3ac5bde096a5.gif" alt="post_tag.gif"/>
            <h4 class="mt-5">コメント</h4>
            <p class="mt-5">つぶやきにはコメントすることができます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9af196ee-4fc8-5c5e-ba57-6d77bc58b370.gif" alt="post_comment_create.gif"/>
            <p class="mt-5">コメントに返信できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/02edb77b-eccc-2c06-6c92-6ffad73842da.gif" alt="post_comment_reply.gif"/>
            <p class="mt-5">コメントは削除のみ可能です。編集機能はありません。</p>
            <p>親コメントを削除すると子コメントも削除されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/7f2ca317-b031-8ec2-7526-7929527b1d2a.gif" alt="post_comment_delete.gif"/>
            <h4 class="mt-5">いいね</h4>
            <p class="mt-5">つぶやきにいいねできます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/93615f3a-f987-6a89-3b8f-5d9531dc48ff.gif" alt="post_like.gif"/>
            <h3 class="mt-5">3. 掲示板機能</h3>
            <h4 class="mt-5">作成・編集・削除</h4>
            <p class="mt-5">掲示板作成は即時反映されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/4decc163-1f94-1c88-2245-6a77c68fea3e.gif" alt="board_create.gif"/>
            <p class="mt-5">掲示板編集は即時反映されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/3d0fc81a-c490-ef01-c3a1-94a561d67dcb.gif" alt="board_edit.gif"/>
            <p class="mt-5">掲示板削除は即時反映されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9ab687d6-18f1-bd52-98ce-4e55740d1063.gif" alt="board_delete.gif"/>
            <h4 class="mt-5">タグ付け</h4>
            <p class="mt-5">掲示板にはタグを複数登録できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/17db3839-b6c3-3d05-6285-107e470b75cf.gif" alt="board_tag.gif"/>
            <h4 class="mt-5">掲示板タイプ</h4>
            <p class="mt-5">『雑談』『質問』を選択できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a6220c6a-4c42-70ea-41a4-cc5eecb2f418.gif" alt="board_type.gif"/>
            <h4 class="mt-5">コメント</h4>
            <p class="mt-5">掲示板にはコメントすることができます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/ad3be049-a611-9809-80bc-edb5bbf42326.gif" alt="board_comment.gif"/>
            <p class="mt-5">コメントに返信できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/1456c34b-c0bf-72e4-6e4f-360b6769e1a1.gif" alt="board_comment_reply.gif"/>
            <p class="mt-5">コメントは削除のみ可能です。編集機能はありません。</p>
            <p>親コメントを削除すると子コメントも削除されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/b8a87e3f-f82b-0818-814a-795a8fd12777.gif" alt="board_comment_delete.gif"/>
            <h3 class="mt-5">4. 私物ガジェット機能</h3>
            <h4 class="mt-5">登録・編集・削除</h4>
            <p class="mt-5">自分の私物ガジェットやお気に入りアイテムを登録できます。</p>
            <p>登録したガジェットは一覧ページでは『みんなのガジェット』として新着表示されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a61f5080-4a0b-94b6-3070-3d3ce2bcc441.gif" alt="gadget_create.gif"/>
            <p class="mt-5">ガジェット編集は即時反映されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/0d4f2f5b-eb13-68d8-bd01-f85dbf3b1f87.gif" alt="gadget_edit.gif"/>
            <p class="mt-5">ガジェット削除は即時反映されます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/3371f318-6be2-0be4-226a-9d933e072a05.gif" alt="gadget_delete.gif"/>
            <h4 class="mt-5">タグ付け</h4>
            <p class="mt-5">私物ガジェットにはタグを複数登録できます。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/eb1235f3-a0c9-5df7-17a5-fe5368de4000.gif" alt="gadget_tag.gif"/>
            <h3 class="mt-5">5. フィード機能</h3>
            <p class="mt-5">つぶやきを一覧表示します。</p>
            <p>無限スクロールで順次読み込みます。</p>
            <p class="mt-5">＜タブによって表示する内容が異なります＞</p>
            <ul>
              <li>新着順 = 全てのつぶやきを新着順で表示</li>
              <li>タイムライン = フォロー済みユーザーのつぶやきのみ新着順で表示</li>
              <li>タグフィード = フォロー済みタグを含むつぶやきのみ新着順で表示</li>
            </ul>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/17205179-4ec2-0213-e85d-b5f353ecb2d6.gif" alt="feed_new.gif"/>
            <h3 class="mt-5">6. タグ管理機能</h3>
            <p class="mt-5">タグをフォローすることができます。
            タグフィードに表示したいタグをフォローします。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/c52e25f3-04e8-cf4a-2fdb-5f426eb8fe80.gif" alt="tag_follow.gif"/>
            <p class="mt-5">つぶやき・掲示板・私物ガジェットはタグ付けすることができます。
            タグをタップするとタグ詳細ページに遷移し、タグを含むつぶやき・掲示板・私物ガジェット・フォローしているユーザーの一覧を表示します。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/de80ed94-7a9a-3539-5bd0-289f736e1bec.gif" alt="tag_show.gif"/>
            <h3 class="mt-5">7. 検索機能</h3>
            <p class="mt-5">検索ページでは、検索フォームに入力した内容に合わせて結果がリアルタイムに表示される機能を実装しております。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a1a27342-7bee-e1e0-9fef-70d8e7c677ab.gif" alt="search.gif"/>
            <h3 class="mt-5">8. 通知機能</h3>
            <p class="mt-5">つぶやき・掲示板・ユーザーフォローにおいて、イベントが発生すると通知が表示されます。</p>
            <h4 class="mt-5">新着通知</h4>
            <p class="mt-5">新しい通知が発生すると、ヘッダー内のベルアイコンにバッジが表示されます。
            タップすると新しい通知がリスト表示され、通知をタップするとイベント発生元へ画面遷移します。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/8112aa0c-0e04-1bb8-458d-73fdf5f3c300.gif" alt="notices.gif"/>
            <h5 class="mt-5">通知一覧</h5>
            <p class="mt-5">通知一覧をタップすると一覧ページへ画面遷移します。
            通知一覧ページでは、今まで受け取った全ての通知を表示します。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/76777320-8764-9c52-a9ff-838322ac8478.gif" alt="notices_index.gif"/>
            <h3 class="mt-5">9. ゲストユーザー機能</h3>
            <p class="mt-5">ユーザー専用機能を簡単に利用できるように、ゲストユーザーログイン機能を実装しています。</p>
            <p>『ゲストユーザーとしてログイン』をタップするだけです。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a8a6ef72-8463-bc11-c726-3f51cf1adfef.gif" alt="guest_loggin.gif"/>
            <p class="mt-5">未ログイン状態でユーザー専用機能にアクセスすると、ゲストユーザーログインを促すダイアログを表示するようにしております。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/51983e7b-5c7b-fa73-e7ee-4f913ddfc927.gif" alt="guest_loggin_support.gif"/>
            <h3 class="mt-5">10. God mode</h3>
            <p class="mt-5">一時的に管理者権限を有効にするモードです。（管理者という概念が存在することを確認して頂くためのモードです。）</p>
            <p>DB内 の Userモデルの adminカラム の true/false で 各ユーザーの管理者権限を管理しておりますが、God modeではVuexストアの値を一時的に変更して管理者権限を有効化しています。（DB上には保存されないのでブラウザ再読み込みでfalseに戻ります。）</p>
            <p>つぶやき・掲示板・私物ガジェットにはそれぞれ『管理メニュー』が設定されており、作成者本人にのみ表示される仕組みです。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/62c2cfb0-72f9-7397-4d54-a369c5cf54a1.png" alt="スクリーンショット 2021-01-29 21.04.32.png"/>
            <p class="mt-5">God mode を有効化にすると他のユーザーが作成したコンテンツでも『管理メニュー』を表示するようになり、『削除のみ』実行可能となります。</p>
            <v-img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/c2654eac-2261-cbe4-072c-fbda8c81234c.gif" alt="admin_mode.gif"/>
            <h1 class="mt-5">関連リンク</h1>
            <ul class="mt-5 ml-5">
              <li>
                <p><a href="https://twitter.com/kuroweb_net">Twitter</a></p>
              </li>
              <li>
                <p><a href="https://github.com/kuromitsu0104/gadget-app">GitHub</a></p>
              </li>
            </ul>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
export default {
  
}
</script>
<style scoped>
#about-text {
  font-size: 1em
}
</style>