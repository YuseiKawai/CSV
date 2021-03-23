---
title: none
author: yusei
marp: true
theme: smoke01
---
<style scoped>
table {
    font-size: 20px;
    background: rgb(230,230,230);
    color: rbg(100,100,100);
    width: 80%;
    margin-top:0.5em;
    border: solid 0.1px pink;
}

th {
     background-color: #b7e2ec8a;
     color:rgb(100,100,100);
     font-size:20px
}
td {
    background: rgb(230,230,230)
}


</style>

![bg](background.png)
## 1-1.言語処理
①のTableを、②のTableに変換したい。
コードとその結果を示してください。

table①
|  郵便番号 | 住所  |
|---|---|
| 111-1111  | 東京都あいうえ区1-1-1  |
|222-2222|かきくけ市2-2-2京都府|
|333-3333|3-3-3北海道さしすせ群|

table②
|  郵便番号 | 都道府県市町村  |番地|
|---|---|---|
| 111-1111  | 東京都あいうえ区  |1-1-1|
|222-2222|京都府かきくけ市|2-2-2|
|333-3333|北海道さしすせ群|3-3-3|

---
<style scoped>
section {
    font-size:28px;
}

table {
    font-size: 25px;
    background: rgb(230,230,230);
    color: rbg(100,100,100);
    width: 80%;
}
th{
     background-color: #b7e2ec8a;
     color:rgb(100,100,100);
}
tr{
    background: rgb(230,230,230)
}
tr:nth-child(1){
backgroud:gb(230,230,230);
}
</style>

## 1-2.表現
![bg](background.png)

下の表に示すコロナ感染者を都道府県ごとに日本地図上にマッピングしたい。
コードとその結果を示してください。

Table_都道府県ごとの累積感染者数
| 都道府県  | Covid-19 累積感染者数（人）  |
|---|---|
| 岩手県  | 1,000  |
| 東京都  |  3,000,000 |
|  京都府 | 50,000  |
---

<style scoped>
section{
    font-size: 20px;
}
table {
    font-size: 18px;
    background: rgb(230,230,230);
    color: rbg(100,100,100);
    width: 80%;
    margin-bottom:2em;
}
th{
     background-color: #b7e2ec8a;
     color:rgb(100,100,100);
     font-size:18px;
     font-weight:500;
}
tr{
    background: rgb(230,230,230);
}

</style>
![bg](background.png)
## 2. 費用対効果
臨床試験にて以下の結果を得ました。

**--結果--**
"既存医療技術Ａ" を用いて介入治療した場合、適当に抽出した5人の患者の薬剤治療費は
1ヶ月あたり "table-A" であった。

"新医療技術Ｂ" をを用いて介入治療した場合、適当に抽出した5人の患者の薬剤治療費は
1ヶ月あたり "table-B" であった。

**-- Talbe-A（上）とTable-B（下） --**
|  技術A | 患者_01  |患者_02| 患者_03  |患者_04| 患者_05  |
|---|---|---|---|---|---|
| 薬剤費（万円） |60|80|50|90|40|

|  技術B | 患者_06  |患者_07| 患者_08  |患者_09| 患者_10  |
|---|---|---|---|---|---|
| 薬剤費（万円） |80|40|50|40|50|

既存技術Ａと新技術Ｂで臨床的アウトカムに差はない場合、5年（60ヶ月）後にどの程度薬剤費の差額が発生していると予測できるでしょうか？ 確率的感度分析の結果を教えてください。

---
<style scoped>
section{
    font-size:27px;
}
</style>

![bg](background.png)
## 3. アプリ実装
当社はとある疾患を判別するための画像診断装置を製造販売しています。
>本装置はある部位のX線画像を取得するもので、医師はその画像から疾患の有無とその進行度を判断するものである。

しかし、他社の参入により市場が飽和してきたため、当社は画像診断装置に以下の追加機能を実装することにしました。

**-- 追加機能詳細 --**
患者情報と画像データをもとに、医学専門家へ **"疾患の有無と進行度の可能性"** を示唆する情報を提供する。

当社が本機能を実装するには、どのような課題があり、どう解決していけば良いでしょうか？

---



