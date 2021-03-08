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
          <v-card-text>
            <div class="content">
              <h3 class="content__title content__title_inner">アプリの概要</h3>
              <p class="content__text">
                『ガジェコミ！』はガジェット好きが集まれるSNS型のWebアプリケーションです。<br>
                <br>
                簡単に言ってしまえば『Twitterクローン』に近いものなので、SNSに必要な機能を重点的に実装済み。<br>
                <br>
                スマホ利用を想定しているのでモバイルからも気軽にお試し下さい！（ゲストログイン有ります）
              </p>
              <h3 class="content__title content__title_inner">ポートフォリオに使用した技術</h3>
              <h4 class="content__sub-title content__sub-title_inner">各バージョン</h4>
              <div class="content__bullet-list">
                <ul class="bullet-list">
                  <li class="bullet-list__item">Ruby 2.7.1</li>
                  <li class="bullet-list__item">Rails 6.0.3.4</li>
                  <li class="bullet-list__item">nuxt 2.14.6</li>
                  <li class="bullet-list__item">@nuxtjs/vuetify 1.11.2</li>
                  <li class="bullet-list__item">Docker 19.03.13</li>
                  <li class="bullet-list__item">docker-compose 1.274</li>
                  <li class="bullet-list__item">Terraform 0.14.3</li>
                </ul>
              </div>
              <h4 class="content__sub-title content__sub-title_inner">フロントエンド</h4>
              <div class="content__vertical-table">
                <table class="vertical-table__inner">
                  <thead class="vertical-table__headers">
                    <tr class="vertical-table__header-row">
                      <th class="vertical-table__header">名称</th>
                      <th class="vertical-table__header">説明</th>
                    </tr>
                  </thead>
                  <tbody class="vertical-table__body">
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Nuxt.js (SSR mode)</td>
                      <td class="vertical-table__text">フロントエンドフレームワーク</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Vuetify</td>
                      <td class="vertical-table__text">UIコンポーネント</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Firebase Authentication</td>
                      <td class="vertical-table__text">JWTを用いたログイン・ログアウト</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="content__bullet-list">
                <ul class="bullet-list bullet-list__inner">
                  <li class="bullet-list__item">Vuetifyコンポーネントを導入することで、スマホ利用を想定したレスポンシブデザインを実現。</li>
                  <li class="bullet-list__item">Vuexストアでステート管理。</li>
                  <li class="bullet-list__item">個人情報（パスワード）は、外部API（Firebase Authentication）に保存する仕組みで、外部APIで発行されるJWTをCookieに保存してログイン・ログアウト機能を実装しました。</li>
                  <li class="bullet-list__item">未ログイン状態でアクセスして欲しくないページ（ /users/editなど ）へのアクセス対策には、Nuxt.jsのmiddlewareを活用することで自動的にリダイレクトするようにしました。</li>
                  <li class="bullet-list__item">ログイン状態でアクセスして欲しくないページ （ログインページ, 新規作成ページ） へのアクセスも同じくリダイレクトします。</li>
                </ul>
              </div>
              <h4 class="content__sub-title content__sub-title_inner">バックエンド</h4>
              <div class="content__vertical-table">
                <table class="vertical-table__inner">
                  <thead class="vertical-table__headers">
                    <tr class="vertical-table__header-row">
                      <th class="vertical-table__header">名称</th>
                      <th class="vertical-table__header">説明</th>
                    </tr>
                  </thead>
                  <tbody class="vertical-table__body">
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Rails (API mode)</td>
                      <td class="vertical-table__text">APIサーバーとして利用</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">PostgreSQL</td>
                      <td class="vertical-table__text">データベース</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="content__bullet-list">
                <ul class="bullet-list bullet-list__inner">
                  <li class="bullet-list__item">RailsはAPIサーバーとして利用しており、フロントエンドコンテナからのリクエストに対してJSONデータを返しています。</li>
                  <li class="bullet-list__item">画像データはActiveStorage経由でS3バケットに保存。</li>
                  <li class="bullet-list__item">その他のデータはRDSに保存。</li>
                  <li class="bullet-list__item">個人情報（ログインパスワード）は外部API（Firebase Authentication）にのみ保存しており、バックエンド（Rails）には保存されません。</li>
                </ul>
              </div>
              <h4 class="content__sub-title content__sub-title_inner">テストコード</h4>
              <div class="content__vertical-table">
                <table class="vertical-table__inner">
                  <thead class="vertical-table__headers">
                    <tr class="vertical-table__header-row">
                      <th class="vertical-table__header">名称</th>
                      <th class="vertical-table__header">説明</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Jest</td>
                      <td class="vertical-table__text">フロントエンドテスト, Vuexストアの動作を少しだけ</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">RSpec</td>
                      <td class="vertical-table__text">バックエンドテスト, バリデーションとアソシエーションのテストのみ</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="content__bullet-list">
                <ul class="bullet-list bullet-list__inner">
                  <li class="bullet-list__item">CodePipelineのTestステージで実行するテストコードです。</li>
                </ul>
              </div>
              <h4 class="content__sub-title content__sub-title_inner">インフラ</h4>
              <div class="content__vertical-table">
                <table class="vertical-table__inner">
                  <thead class="vertical-table__headers">
                    <tr class="vertical-table__header-row">
                      <th class="vertical-table__header">名称</th>
                      <th class="vertical-table__header">説明</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">ECS Fargate</td>
                      <td class="vertical-table__text">サーバーレスな本番環境, オートスケール</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">CodePipeline</td>
                      <td class="vertical-table__text">CI/CD環境</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">RDS</td>
                      <td class="vertical-table__text">本番用DB（PostgreSQL）</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Docker, Docker-compose</td>
                      <td class="vertical-table__text">コンテナ環境</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Github</td>
                      <td class="vertical-table__text">バージョン管理</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">Terraform</td>
                      <td class="vertical-table__text">本番用インフラをコード管理</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="content__bullet-list">
                <ul class="bullet-list bullet-list__inner">
                  <li class="bullet-list__item">ローカル開発環境からデプロイまで一貫してDockerを使用。</li>
                  <li class="bullet-list__item">ALBを通すことで常時SSL通信化。</li>
                  <li class="bullet-list__item">CodePipelineは、 『Sourceステージ => Testステージ => Buildステージ => Deployステージ』の順で実行され、Testステージで問題が発生した場合は当該ソースでのDeployは実行されません。</li>
                  <li class="bullet-list__item">本番環境の環境変数については SSM で管理。『システム環境変数 => Terraform => SSM => 各AWSサービス』というフローで環境変数を受け渡しています。 </li>
                </ul>
              </div>
              <h4 class="content__sub-title content__sub-title_inner">インフラ構成図</h4>
              <p class="content__text">
                インフラの全体像をまとめたものがこちら。<br>
                RDSにはPostgreSQLを採用し、画像を除いたデータを保管。<br>
                画像データはS3に保管しています。
              </p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/4b873df7-3103-702f-2db7-273f6bd43149.png"/>
              <h4 class="content__sub-title content__sub-title_inner">ER図</h4>
              <p class="content__text">一貫性のあるテーブル名称を意識しました。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/5e990b5c-9302-9d78-26f0-c3de6a09ae25.png"/>
              <h3 class="content__title content__title_inner">アプリの機能紹介</h3>
              <h4 class="content__sub-title content__sub-title_inner">0. 機能一覧</h4>
              <div class="content__vertical-table">
                <table class="vertical-table__inner">
                  <thead class="vertical-table__headers">
                    <tr class="vertical-table__header-row">
                      <th class="vertical-table__header">機能名</th>
                      <th class="vertical-table__header">説明</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">ユーザー機能</td>
                      <td class="vertical-table__text">新規登録、登録内容変更、アバター登録、ログイン、ログアウト、フォロー</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">つぶやき機能</td>
                      <td class="vertical-table__text">投稿、編集、削除、画像複数枚登録</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">つぶやきコメント機能</td>
                      <td class="vertical-table__text">つぶやきに対してコメント投稿、コメントへのリプライ投稿、削除、画像複数枚登録</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">つぶやきいいね機能</td>
                      <td class="vertical-table__text">つぶやきをいいねできる、マイページのいいねタブにいいねしたつぶやきを一覧表示</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">掲示板機能</td>
                      <td class="vertical-table__text">質問掲示板、雑談掲示板の作成、編集、削除、画像複数枚登録</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">掲示板コメント機能</td>
                      <td class="vertical-table__text">掲示板に対してコメント投稿、コメントへのリプライ投稿、削除、画像複数枚登録</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">私物ガジェット機能</td>
                      <td class="vertical-table__text">登録、編集、削除、画像複数枚登録</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">フィード機能</td>
                      <td class="vertical-table__text">つぶやき新着表示、タイムライン表示、タグフィード表示</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">タグ管理機能</td>
                      <td class="vertical-table__text">つぶやき・掲示板・私物ガジェットにはタグを登録可能、タグをタップしてタグ詳細ページを表示、タグ詳細ページではタグを含むコンテンツを表示</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">検索機能</td>
                      <td class="vertical-table__text">各コンテンツを検索可能</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">通知機能</td>
                      <td class="vertical-table__text">つぶやきにいいね・コメント、掲示板にコメント、他ユーザーからフォローされると通知を表示</td>
                    </tr>
                    <tr class="vertical-table__body-row">
                      <td class="vertical-table__text">管理者モード</td>
                      <td class="vertical-table__text">Godmode のトグルスイッチをONにすると、一時的に管理者権限が有効化、各コンテンツの削除メニューが表示される</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <h4 class="content__sub-title content__sub-title_inner">1. ユーザー機能</h4>
              <h5 class="content__modest-title content__modest-title_inner">登録・編集・削除</h5>
              <p class="content__text">
                メールアドレスとパスワードを入力するだけでアカウント作成できます。<br>
                メールアドレス確認機能は未実装。<br>
                VeeValidateを使用してフォームにバリデーションを設定しています。
              </p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9365c676-c632-f40c-c4dd-ddbdaa308781.gif"/>
              <p class="content__text">詳細設定ページで登録情報を編集できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/ed2d448e-9eb8-0d2e-e359-80d501380078.gif"/>
              <p class="content__text">ユーザーにはアバターを設定できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/7859aef6-382d-f5f1-dfaa-5d2e8775a39a.gif"/>
              <p class="content__text">アバター画像は各コンテンツで表示されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/f5187e9a-fecf-33ba-9a65-4c5a19fa46df.png"/>
              <h4 class="content__sub-title content__sub-title_inner">2. つぶやき機能</h4>
              <h5 class="content__modest-title content__modest-title_inner">投稿・編集・削除</h5>
              <p class="content__text">つぶやき作成は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/ed23f37a-b7e4-31ce-5142-391c8fb2e4f2.gif"/>
              <p class="content__text">つぶやき編集は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9011bbdf-29d2-8e8c-76ad-8b400fa4303f.gif"/>
              <p class="content__text">つぶやき削除は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/524b41ae-9d54-4385-a9dc-8516ecf1cc60.gif"/>
              <h4 class="content__modest-title content__modest-title_inner" id="タグ付け">タグ付け</h4>
              <p class="content__text">つぶやきにはタグを複数登録できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/c9744119-500e-926a-eefb-3ac5bde096a5.gif"/>
              <h5 class="content__modest-title content__modest-title_inner">コメント</h5>
              <p class="content__text">つぶやきにはコメントすることができます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9af196ee-4fc8-5c5e-ba57-6d77bc58b370.gif"/>
              <p class="content__text">コメントに返信できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/02edb77b-eccc-2c06-6c92-6ffad73842da.gif"/>
              <p class="content__text">コメントは削除のみ可能です。編集機能はありません。</p>
              <p>親コメントを削除すると子コメントも削除されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/7f2ca317-b031-8ec2-7526-7929527b1d2a.gif"/>
              <h5 class="content__modest-title content__modest-title_inner">いいね</h5>
              <p class="content__text">つぶやきにいいねできます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/93615f3a-f987-6a89-3b8f-5d9531dc48ff.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">3. 掲示板機能</h4>
              <h5 class="content__modest-title content__modest-title_inner">作成・編集・削除</h5>
              <p class="content__text">掲示板作成は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/4decc163-1f94-1c88-2245-6a77c68fea3e.gif"/>
              <p class="content__text">掲示板編集は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/3d0fc81a-c490-ef01-c3a1-94a561d67dcb.gif"/>
              <p class="content__text">掲示板削除は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/9ab687d6-18f1-bd52-98ce-4e55740d1063.gif"/>
              <h5 class="content__modest-title content__modest-title_inner">タグ付け</h5>
              <p class="content__text">掲示板にはタグを複数登録できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/17db3839-b6c3-3d05-6285-107e470b75cf.gif"/>
              <h5 class="content__modest-title content__modest-title_inner">掲示板タイプ</h5>
              <p class="content__text">『雑談』『質問』を選択できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a6220c6a-4c42-70ea-41a4-cc5eecb2f418.gif"/>
              <h5 class="content__modest-title content__modest-title_inner">コメント</h5>
              <p class="content__text">掲示板にはコメントすることができます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/ad3be049-a611-9809-80bc-edb5bbf42326.gif"/>
              <p class="content__text">コメントに返信できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/1456c34b-c0bf-72e4-6e4f-360b6769e1a1.gif"/>
              <p class="content__text">コメントは削除のみ可能です。編集機能はありません。</p>
              <p>親コメントを削除すると子コメントも削除されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/b8a87e3f-f82b-0818-814a-795a8fd12777.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">4. 私物ガジェット機能</h4>
              <h5 class="content__modest-title content__modest-title_inner">登録・編集・削除</h5>
              <p class="content__text">自分の私物ガジェットやお気に入りアイテムを登録できます。</p>
              <p>登録したガジェットは一覧ページでは『みんなのガジェット』として新着表示されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a61f5080-4a0b-94b6-3070-3d3ce2bcc441.gif"/>
              <p class="content__text">ガジェット編集は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/0d4f2f5b-eb13-68d8-bd01-f85dbf3b1f87.gif"/>
              <p class="content__text">ガジェット削除は即時反映されます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/3371f318-6be2-0be4-226a-9d933e072a05.gif"/>
              <h5 class="content__modest-title content__modest-title_inner">タグ付け</h5>
              <p class="content__text">私物ガジェットにはタグを複数登録できます。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/eb1235f3-a0c9-5df7-17a5-fe5368de4000.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">5. フィード機能</h4>
              <p class="content__text">
                つぶやきを一覧表示します。<br>
                無限スクロールで順次読み込みます。<br>
                ※タブによって表示する内容が異なります
              </p>
              <div class="content__bullet-list">
                <ul class="bullet-list bullet-list__inner">
                  <li class="bullet-list__item">新着順 = 全てのつぶやきを新着順で表示</li>
                  <li class="bullet-list__item">タイムライン = フォロー済みユーザーのつぶやきのみ新着順で表示</li>
                  <li class="bullet-list__item">タグフィード = フォロー済みタグを含むつぶやきのみ新着順で表示</li>
                </ul>
              </div>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/17205179-4ec2-0213-e85d-b5f353ecb2d6.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">6. タグ管理機能</h4>
              <p class="content__text">タグをフォローすることができます。
              タグフィードに表示したいタグをフォローします。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/c52e25f3-04e8-cf4a-2fdb-5f426eb8fe80.gif"/>
              <p class="content__text">つぶやき・掲示板・私物ガジェットはタグ付けすることができます。
              タグをタップするとタグ詳細ページに遷移し、タグを含むつぶやき・掲示板・私物ガジェット・フォローしているユーザーの一覧を表示します。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/de80ed94-7a9a-3539-5bd0-289f736e1bec.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">7. 検索機能</h4>
              <p class="content__text">検索ページでは、検索フォームに入力した内容に合わせて結果がリアルタイムに表示される機能を実装しております。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a1a27342-7bee-e1e0-9fef-70d8e7c677ab.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">8. 通知機能</h4>
              <p class="content__text">つぶやき・掲示板・ユーザーフォローにおいて、イベントが発生すると通知が表示されます。</p>
              <h5 class="content__modest-title content__modest-title_inner">新着通知</h5>
              <p class="content__text">新しい通知が発生すると、ヘッダー内のベルアイコンにバッジが表示されます。
              タップすると新しい通知がリスト表示され、通知をタップするとイベント発生元へ画面遷移します。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/8112aa0c-0e04-1bb8-458d-73fdf5f3c300.gif"/>
              <h5 class="content__modest-title content__modest-title_inner">通知一覧</h5>
              <p class="content__text">通知一覧をタップすると一覧ページへ画面遷移します。
              通知一覧ページでは、今まで受け取った全ての通知を表示します。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/76777320-8764-9c52-a9ff-838322ac8478.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">9. ゲストユーザー機能</h4>
              <p class="content__text">ユーザー専用機能を簡単に利用できるように、ゲストユーザーログイン機能を実装しています。</p>
              <p>『ゲストユーザーとしてログイン』をタップするだけです。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/a8a6ef72-8463-bc11-c726-3f51cf1adfef.gif"/>
              <p class="content__text">未ログイン状態でユーザー専用機能にアクセスすると、ゲストユーザーログインを促すダイアログを表示するようにしております。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/51983e7b-5c7b-fa73-e7ee-4f913ddfc927.gif"/>
              <h4 class="content__sub-title content__sub-title_inner">10. God mode</h4>
              <p class="content__text">
                一時的に管理者権限を有効にするモードです。（管理者という概念が存在することを確認して頂くためのモードです。）<br>
                DB内 の Userモデルの adminカラム の true/false で 各ユーザーの管理者権限を管理しておりますが、God modeではVuexストアの値を一時的に変更して管理者権限を有効化しています。（DB上には保存されないのでブラウザ再読み込みでfalseに戻ります。）<br>
                つぶやき・掲示板・私物ガジェットにはそれぞれ『管理メニュー』が設定されており、作成者本人にのみ表示される仕組みです。
              </p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/62c2cfb0-72f9-7397-4d54-a369c5cf54a1.png"/>
              <p class="content__text">God mode を有効化にすると他のユーザーが作成したコンテンツでも『管理メニュー』を表示するようになり、『削除のみ』実行可能となります。</p>
              <v-img class="content__v-img_inner" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/290888/c2654eac-2261-cbe4-072c-fbda8c81234c.gif"/>
              <h3 class="content__title content__title_inner">関連リンク</h3>
              <div class="content__bullet-list">
                <ul class="bullet-list bullet-list__inner">
                  <li class="bullet-list__item">
                    <p><a href="https://twitter.com/kuroweb_net">Twitter</a></p>
                  </li>
                  <li class="bullet-list__item">
                    <p><a href="https://github.com/kuromitsu0104/gadget-app">GitHub</a></p>
                  </li>
                </ul>
              </div>
            </div>
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
.content__title {
  padding-bottom: 6px;
  border-bottom: 1px solid #000000;
  font-size: 1.25rem;
  font-weight: bold;
}
.content__title_inner {
  margin-bottom: 10px;
}

.content__sub-title {
  padding-left: 6px;
  border-left: 2px solid #000000;
  font-size: 1.0rem;
  font-weight: bold;
}
.content__sub-title_inner {
  margin-bottom: 10px;
}

.content__modest-title {
  color: #4e4e4e;
  font-size: .9rem;
  font-weight: bold;
}
.content__modest-title_inner {
  margin-bottom: 10px;
}

.bullet-list__inner {
  margin: 10px 0 10px 0;
}
.bullet-list__item {
  padding-left: .5em;
  margin-bottom: 10px;
}

.content__vertical-table {
  border: 1px solid #ddd;
  margin-bottom: 10px;
}
.vertical-table__inner {
  width: 100%;
  text-align: left;
  table-layout: fixed;
  border-spacing: 0px;
}
.vertical-table__header-row {
  background-color: #efefef;
}
.vertical-table__header {
  padding: 10px;
  border-right: 1px solid #ddd;
  border-bottom: 1px solid #ddd;
  font-weight: bold;
  vertical-align: middle;
}
.vertical-table__text {
  padding: 10px;
  border-right: 1px solid #ddd;
  border-bottom: 1px solid #ddd;
  vertical-align: middle;
}
.vertical-table__header:last-child,
.vertical-table__text:last-child {
  border-right-width: 0;
}
.vertical-table__body-row:last-child .vertical-table__text {
  border-bottom-width: 0;
}

.content__v-img_inner {
  margin-bottom: 10px;
}

@media screen and (max-width: 768px) {
  .content__vertical-table {
    border-right-width: 0;
    overflow-x: auto;
  }
  .vertical-table__inner {
    width: auto;
    min-width: 100%;
  }
  .vertical-table__header,
  .vertical-table__text {
    white-space: nowrap;
  }
  .vertical-table__header:last-child,
  .vertical-table__text:last-child {
    border-right-width: 1px;
  }
}

</style>