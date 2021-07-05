---
title: "AOJの「ITP I」40問をPythonで解いた"
date: 2020-08-04T03:38:58+09:00
lang: ja
tags:
- python
- coder
---

## はじめに

コーディングの腕をもっと磨きたいなと思ったので、以下の記事を参考に始めてみた

- https://qiita.com/e869120/items/f1c6f98364d1443148b3

> 全部で 44 問ありますが、最後の 4 問は競プロとはあまり関係ないので、ITP1_1-A から ITP1_10-D までの 40 問を解くことをお勧めします。

まずは最初におすすめされた、AOJのITP1_1-A から ITP1_10-D までの 40 問を解いてみた
無料でこのサービスが提供されてるの素晴らしい
標準入力、出力の整形が少し手間取ったけど、あとは愚直に解いていった

- http://judge.u-aizu.ac.jp/onlinejudge/

感想としては、

- やってみたら、意外と楽しい。特に自分で諦めずに試行錯誤して、オンラインで一発でACもらえるとめちゃくちゃ嬉しい
- テストケースに通る、すなわち正しい、それが書けたら達成感がある
- 何かしらのお題に沿って、コードを書くという動機ができるので、書くことに慣れたい場合も有用そう

togglで時間計測しながら、やって見直してみたら15h46m 費やしていた。大体1問25mくらい

![統計](/posts/2020-08-04/images/1.png)
![統計](/posts/2020-08-04/images/2.png)

次の目標、

- AtCoder で水色を目指す!!!
- データ構造周りや、アルゴリズム周りはまだまだ弱いのでそこらへんを抑えていきたい

当面は、以下の２つに投資していきます

- 機械学習だけに縛られない、SWEとしてスキル底上げ
- 機械学習関係の確固たる基礎知識と実装力

以下に自分が書いた回答例を放流しておきます。

***

## Rule

- 15分試行錯誤しても、緒がわからない場合は諦める
- わからなかったとき、もっと上手な書き方は以下を参考にしました
- https://qiita.com/cmtennis1042/items/5f1e7f071081176e857f

## ITP1_1_A:   Hello World

```python
print('Hello world')
```

## ITP1_1_B:   X Cubic

```python
x = input()
print(x ** 3)
```

## ITP1_1_C:   Rectangle

```python
a, b = map(int, input().split())
print(a*b, 2*(a+b))
```

## ITP1_1_D:   Watch

```python
second = int(input())
print(second//(60**2),':',(second%(60**2))//60,':',second%60,sep='')
```

`//` は整数の商を算出する

## ITP1_2_A:   Small, Large, or Equal

```python
a, b = map(int, input().split())
if a > b:
    print("a > b")
elif a == b:
    print("a == b")
elif a < b:
    print("a < b")
```

## ITP1_2_B:   Range

```python
a, b, c = map(int, input().split())
if a < b and b < c:
    print("Yes")
else:
    print("No")
```

## ITP1_2_C:   Sorting Three Numbers

```python
l = list(map(int, input().split()))
l.sort()
print(l[0],l[1],l[2], sep=' ')
#best
print(*three_numbers)
```

## ITP1_2_D:   Circle in a Rectangle

```python
w,h,x,y,r = map(int, input().split())
if (x+r) > w or (x-r) < 0 or (y+r)>h or (y-r) <0:
    print("No")
else:
    print("Yes")
```

一発で通って、めちゃくちゃ興奮した!!

## ITP1_3_A:   Print Many Hello World

```python
[print("Hello World") for _ in range(1000)]
```

##　ITP1_3_B:   Print Test Cases

```python
a = []
while True:
    n = int(input())
    if n == 0:
        break
    else:
        a.append(n)
[print(f'Case {i+1}: {num}') for i, num in enumerate(a)]
```

## ITP1_3_C:   Swapping Two Numbers

```python
pairs = []
while True:
    a, b = map(int,input().split())
    if (a, b) == (0, 0):
        break
    else:
        pairs.append([a, b])
for pair in pairs:
    pair.sort()
    print(*pair)
```

## ITP1_3_D:   How Many Divisors?

```python
a, b, c = map(int, input().split())
cnt = 0
for i in range(b - a + 1):
    if c % (a+i) == 0:
        cnt += 1
print(cnt)
# Best

for k in range(a,b+1):
    if c%k==0:
        cnt+=1
print(cnt)
```

## ITP1_4_A:   A / B Problem

```python
a, b = map(int, input().split())
print('%i %i %-5f' % (a//b, a%b, a/b))
```

## ITP1_4_B:   Circle

```python
import math
r = float(input())
print('%-5f %-5f' % (math.pi*r*r, 2* math.pi * r))
```

## ITP1_4_C:   Simple Calculator

'''python
while True:
    a, op, b = input().split()
    a, b = map(int, [a, b])
    if op == '?':
        break
    elif op == "+":
        print(a+b)
    elif op == "-":
        print(a-b)
    elif op == "*":
        print(a*b)
    elif op == "/":
        print(a//b)
'''

## ITP1_4_D:   Min, Max and Sum	

'''python
n = int(input())
a = list(map(int, input().split()))
print(min(a), max(a), sum(a))
'''

## ITP1_5_A:   Print a Rectangle

```python
a = []
while True:
    h, w = map(int, input().split())
    if (h, w ) == (0, 0):
        break
    else:
        a.append([h,w])

for pair in a:
    for i in range(pair[0]):
        print("#" * pair[1])
    print('')

#Best
while True:
    h, w = map(int, input().split())
    if (h, w) == (0, 0):
        break
    [print('#'*w) for i in range(h)]
    print()
```

## ITP1_5_B:   Print a Frame

```python
while True:
    h, w = map(int, input().split())
    if (h, w) == (0, 0):
        break
    else:
        for i in range(h):
            if i == 0:
                print('#' * w, sep='')
            elif i == (h-1):
                print('#' * w)
                print()
            else:
                print(f"#", "." * (w - 2), "#", sep='')
```

## ITP1_5_C:   Print a Chessboard


```python
while True:
    h, w = map(int, input().split())
    if (h, w) == (0, 0):
        break
    else:
        for i in range(h):
            line = ''
            if i % 2 == 0:
                for j in range(w):
                    if j % 2 == 0:
                        line+='#'
                    else:
                        line+='.'
            else:
                for j in range(w):
                    if j % 2 == 0:
                        line+='.'
                    else:
                        line+='#'
            print(line)
        print()
```

## ITP1_5_D:   Structured Programming

C++のコードで3がつくものというロジックが読めなかった。。。10で割ってあまりが3だけだと、`31` とかがエッジケースで通らなかった。。

```python
n = int(input())
l = ''
for i in range(1,n+1):
    if i % 3 == 0:
        l+=' '+str(i)
    elif i % 10 == 3:
        l+=' '+str(i)
print(l)

# AC
N=int(input())
for i in range(1,N+1):
    if i%3==0 or "3" in str(i):
        print(" {}".format(i),end="")
print()
```

## ITP1_6_A:   Reversing Numbers

```python
n = int(input())
a = list(map(int, input().split()))
print(*reversed(a))
```

## ITP1_6_B:   Finding Missing Cards

```python
all_cards = [(s, n) for s in ['S', 'H', 'C', 'D'] for n in range(1, 14)]

n = int(input())
hold_cards = []
for i in range(n):
    suit, num = input().split()
    num = int(num)
    hold_cards.append((suit, num))
for card in all_cards:
    if card not in set(hold_cards):
        print(*card)
```

`in` は`O(n)`なので注意が必要

## ITP1_6_C:   Official House

```python
n = int(input())
pos = []
pairs = {}
for i in range(n):
    b,f,r,v = map(int, input().split())
    pos.append((b,f,r))
    pairs[(b,f,r)] = int(v)
values = [[[0 for _ in range(10)] for _ in range(3)] for _ in range(4)]
# 4 buildings
for b in range(4):
    # 3 floors
    for f in range(3):
        # 10 rooms
        for r in range(10):
            if (b + 1, f + 1, r + 1) in set(pos):
                print(pairs[(b+1, f+1, r+1)])
                values[b][f][r] += pairs[(b+1, f+1, r+1)]
for b in range(4):
    # 3 floors
    for f in range(3):
        # 10 rooms
        print(' ',end='')
        print(*values[b][f])
    if b != 3:
        print('#'*20)
# modify
n = int(input())
inputs = [list(map(int, input().split())) for _ in range(n)]
values = [[[0 for _ in range(10)] for _ in range(3)] for _ in range(4)]
for i in inputs:
    values[i[0]-1][i[1]-1][i[2]-1] += i[3]
for b in range(4):
    for f in range(3):
        print(' ', end='')
        print(*values[b][f])
    if b != 3:
        print('#'*20)
```

入力時に、`位置情報:値` をpairで持つ辞書を作って全部屋をforで回して、マッチした時にその部屋の値を変更していくようにした。
1つめのtest caseは成功したが、２つ目のtest caseで同じ位置情報が入力された時に、辞書の`key`が上書きされてうまく動かなくなった。
解決法として、入力値を全てリストで保持、その入力値を使って、直接その要素の値を逐次計算するようにした

## ITP1_6_D:   Matrix Vector Multiplication

```python
n, m = map(int, input().split())
mat = [list(map(int, input().split())) for _ in range(n)]
vec = [int(input()) for _ in range(m)]
ans = [0]*n
for i, row in enumerate(mat):
    for j in range(m):
        ans[i] += row[j] * vec[j]
[print(ans[i]) for i in range(n)]
```

## ITP1_7_A:   Grading

```python
while True:
    m,f,r = map(int, input().split())
    if (m, f, r) == (-1, -1, -1):
        break
    if m == -1 or f == -1 or (m+f) < 30:
        print('F')
    elif (m+f) >= 80:
        print('A')
    elif 80 > (m+f) >= 65:
        print('B')
    elif 65 > (m+f) >= 50:
        print('C')
    elif 50 > (m+f) >= 30:
        if r >= 50:
            print('C')
        else:
            print('D')
```

## ITP1_7_B:   How many ways?

全探索で探索してみたけど、O(N^3)かかるかつ、選択されたものが再度選択されてしまう。set()で扱っても、探索候補からキューとして扱わないといけないことには気づいたがどう扱えばいいか考えつかず断念
その後、回答例を見ると、たしかにループで、外側とかぶらないように変数管理すればうまく重複排除できることに気がついた...!

```python
while True:
    n, x = map(int, input().split())
    if (n, x) == (0, 0):
        break
    cnt = 0
    for i in range(1, n + 1):
            for j in range(i+1, n + 1):
                    for k in range(j+1, n + 1):
                        if i + j + k == x:
                            cnt+=1
    print(cnt)
```

## ITP1_7_C:   Spreadsheet

```python
r, c = map(int, input().split())
table = [list(map(int, input().split())) for _ in range(r)]
c_sum = [0]*c
for i in range(r):
    for j in range(c):
        c_sum[j] += table[i][j]
for i in table:
    print(*i, end=' ')
    print(sum(i))
print(*c_sum, end=' ')
print(sum(c_sum))
```

## ITP1_7_D:   Matrix Multiplication


```python
n, m, l = map(int, input().split())
mat_a = [list(map(int, input().split())) for _ in range(n)]
mat_b = [list(map(int, input().split())) for _ in range(m)]

for i in range(n):
    row = []
    for j in range(l):
        tmp = 0
        for k in range(m):
            tmp += mat_a[i][k]*mat_b[k][j]
        row.append(tmp)
    print(*row)
```


## ITP1_8_A:   Toggling Cases

```python
input_str = input()

for i in input_str:
    if i.islower():
        print(i.upper(), end='')
    else:
        print(i.lower(), end='')
print()
```

## ITP1_8_B:   Sum of Numbers

```python
while True:
    a = input()
    if a == '0':
        break
    print(sum(list(map(int, list(a)))))
```

## ITP1_8_C:   Counting Characters

入力が複数行で何行入力されるか不明な場合は、`sys.stdin.read()`を使う

https://qiita.com/kyuna/items/8ee8916c2f4e36321a1c#1-%E3%81%BE%E3%81%A8%E3%82%81

`readline()`だと一行ずつ読み込む

```python
import sys
s = sys.stdin.read().lower()
a = {chr(i): 0 for i in range(ord('a'), ord('z')+1)}
for i in s:
    if ord(i) in range(ord('a'), ord('z')+1):
        a[i] += 1
[print(f'{k} : {v}') for k, v in a.items()]
```

## 	ITP1_8_D:   Ring

```python
s = input()
p = input()
s = s * 2
if s.find(p) != -1:
    print('Yes')
else:
    print('No')
```

## ITP1_9_A:   Finding a Word

```python
w = input()
sentents = ''
while True:
    s = input()
    if s == 'END_OF_TEXT':
        break
    sentents += s + ' '
print(sentents.lower().split().count(w))
```

## ITP1_9_B:   Shuffle

```python
while True:
    d = input()
    if d == '-':
        break
    m = int(input())
    h = [int(input()) for _ in range(m)]
    for i in h:
        d = d[i:] + d[:i]
    print(d)
```

## 	ITP1_9_C:   Card Game

```python
n = int(input())
cards = [input().split() for _ in range(n)]
p_t = 0
p_h = 0
for card in cards:
    if card[0] == card[1]:
        p_t += 1
        p_h += 1
    elif card[0] > card[1]:
        p_t += 3
    else:
        p_h += 3
print(p_t, p_h)
```

## 	ITP1_9_D:   Transformation

- スライス表記で、`l[start:end:step]`を理解できるとかける
- `end` の記法が前から違和感あったんだけど、 @reto_nayuta さんにしていただいた説明がとてもわかり易かった!! 感謝

```
1-start というより 0-start exclusive、つまり [start, end) の右半開区間と解釈するのが自然かと
・i から長さ k 取る→a[i, i+k]
・i を境界に2つに分ける（二分探索等）→a[:i], a[i:]
・range の挙動とも一致→a[i:j] == [a[k] for k in range(i, j)]（R/Ruby/pandas/Rust は arr[range] 記法）
```

https://twitter.com/reto_nayuta/status/1290125805167632385

```python
s = input()
n = int(input())
orders = [input().split() for _ in range(n)]
for order in orders:
    a, b = map(int, order[1:3])
    if order[0] == 'print':
        print(s[a:b+1])
    elif order[0] == 'replace':
        s = s[0:a] + order[3] + s[b+1:]
    elif order[0] == 'reverse':
        s = s[0:a] + s[a:b+1][::-1] + s[b + 1:]
```

## ITP1_10_D:   Distance II

```python
import math
x1, y1, x2, y2 = map(float, input().split())
print(math.hypot(x2 - x1, y2 - y1))
```

## ITP1_10_B:   Triangle

```python
import math
a, b, C = map(float, input().split())
theta = math.radians(C)
h = b*math.sin(theta)
S = (a*h)/2
c = math.sqrt(a**2+b**2-2*a*b*math.cos(theta))
L = a+b+c
print(S, L, h, sep="\n")
```

## ITP1_10_C:   Standard Deviation

```python
import math
while True:
    n = int(input())
    if n == 0:
        break
    s = list(map(float, input().split()))
    m = sum(s) / n
    print(math.sqrt((sum([(i - m)** 2 for i in s]) / n)))
```

## ITP1_10_D:   Distance II

チェビシェフ距離、学生の頃を思い出して懐かしかった。
`zip`できれいに書けた

```python
n = int(input())
x = list(map(int, input().split()))
y = list(map(int, input().split()))
print(sum([abs(x-y) for x, y  in zip(x, y)]))
print(sum([abs(x - y) ** 2 for x, y  in zip(x, y)]) ** (1/2) )
print(sum([abs(x - y) ** 3 for x, y  in zip(x, y)]) ** (1/3) )
print(max([abs(x-y) for x, y  in zip(x, y)]))
```