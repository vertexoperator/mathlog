  <script src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
  <script type="text/x-mathjax-config">
    MathJax.Hub.Config({
        HTML: ["input/TeX","output/HTML-CSS"],
        TeX: { extensions: ["AMSmath.js","AMSsymbols.js"],
               equationNumbers: { autoNumber: "AMS" } },
        extensions: ["tex2jax.js"],
        jax: ["input/TeX","output/HTML-CSS"],
        tex2jax: { inlineMath: [ ['$','$'], ["\\(","\\)"] ],
                   displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
                   processEscapes: true },
        "HTML-CSS": { availableFonts: ["TeX"],
                      linebreaks: { automatic: true } }
    });  </script>


## 目標 ##
* 最も薄い線形代数の説明を書くこと(30ページ以内を想定)

* 行列の基本変形とか排除する。線形代数を行列環の理論として始めて、正方行列を基本に据える。非正方行列や、ベクトルは、後で付加的な概念として導入する

* Gaussの消去法も排除する。数値計算に於いて実用的でなく、原理的な説明/証明のための道具としては煩雑すぎる

* 数値計算の手法を説明する。QR分解、LU分解、特異値分解(量子力学でSchmidt分解と呼ばれるものと、ほぼ同じ)は実用上重要であるし、岩澤分解(QR分解)、Bruhat分解(LU分解)のような純粋数学でも重要な概念の特別な場合と見なすことができる。これらの概念は、群論的に理解されるのが正しいように思う

* 特異値分解は、$U(n) \times U(m)$あるいは$O(n) \times O(m)$の非正方行列への作用に関する標準形を
計算していると言える。行列の階数/rankは、$GL(n) \times GL(m)$の非正方行列への作用に関する標準形>として解釈できることを説明する

* とはいえ、数値計算の話は、原理的には同等のアルゴリズムで計算量のオーダーが等しくても、定数倍の速度差があるとか、数値安定性が違う(例えば、QR分解では、Gram-Schmidt直交化よりHouseholder変換がいい)など評価の軸が色々あり、更には、実装の差によって、数百倍の速度差が出る場合もある(例えば、行列の積は、そのまま実装したものは遅すぎて通常使い物にならない)けど、そういったdetailは省略する(前者は、数値解析とか、そういう分野で扱うべき。後者は、数学の問題ですらない)

* 偏微分方程式数値解法や機械学習に於いては、大規模疎行列の計算も重要になる(例えば、Gauss-Seidel法など)。これらは、数学としては、それほど面白くないようであるけど、実用上は重要なので、簡単に説明する
\
\


## 行列環の理論(1) ##
\
\




## 行列環の理論(2) 行列式と逆行列 ##
正方行列$A$に対して、$AX=XA=I$を満たす$X$を$A$の逆行列と呼ぶ。正方行列$A$に対して、$X$と$Y$がそれぞれ$A$の逆行列であるとする(つまり、$AX=XA=AY=YA=I$)と、$X = (YA)X = Y(AX) = Y$なので、逆行列は一意に定まる。これを$A^{-1}$と書く。また逆行列を持つ時、正則行列と呼ぶ\


整数環で、一般に逆元が存在するとは限らないのと同様、行列環でも、逆行列が一般に存在するとは限らない。例えば  
$\left( \begin{matrix} 1 & 0 \\ 0 & 0  \end{matrix} \right)$\
には逆行列が存在しないことを直接証明できる。一般に、2行2列の行列について  
$\left( \begin{matrix} a & b \\ c & d \end{matrix} \right) \left( \begin{matrix} d & -b \\ -c & a \end{matrix} \right) = (ad-bc) \left( \begin{matrix} 1 & 0 \\ 0 & 1  \end{matrix} \right)$\
が計算できる。従って、$ad-bc \neq 0$の時\
$\left( \begin{matrix} a & b \\ c & d \end{matrix} \right)$\
には逆行列\
$\dfrac{1}{ad-bc} \left( \begin{matrix} d & -b \\ -c & a \end{matrix} \right)$\
が存在する(現時点では、$ad -bc = 0$の時、逆行列が存在しないとは言えてない)


同様に、3行3列の行列について\
$\left( \begin{matrix} a_1 & a_2 & a_3 \\ b_1 & b_2 & b_3 \\ c_1 & c_2 & c_3 \end{matrix} \right)$ $\left( \begin{matrix} b_2 c_3-b_3 c_2 & a_3 c_2 - a_2 c_3 & a_2 b_3 - a_3 b_2 \\ b_3 c_1 - b_1 c_3 & a_1 c_3 - a_3 c_1 & a_3 b_1 - a_3 b_1 \\ b_1 c_2 - b_2 c_1 & a_2 c_1 - a_1 c_2 & a_1 b_2 - a_2 b_1 \end{matrix} \right) = d I$\
$d = a_1 b_2 c_3 + a_2 b_3 c_1 + a_3 b_1 c_2 - a_1 b_3 c_2 - a_2 b_1 c_3 - a_3 b_2 c_1$\
が計算できる。$d \neq 0$であれば、逆行列が存在する。これらの計算は、一般の$n$行$n$列に一般化できる



[**定義**]集合$\{1,\cdots,n\}$から$\{1,\cdots,n\}$への全単射の集合を$S_n$と書く

[**定義**]$A = \displaystyle \sum_{i,j=1}^n a_{ij} e_{ij}$に対して、$det(A) = \displaystyle \sum_{w \in S_n} sgn(w) \displaystyle \prod_{i=1}^{n} a_{i w(i)}$を行列式と呼ぶ


**命題**: $det(AB)=det(A)det(B)$  
[**証明**]  

直接計算  

[**以上**]  


以上より、$AX=XA=1$であれば$det(AX)=det(A)det(X)=1$なので、逆行列が存在するならば、$det(A) \neq 0$でないといけない。
逆に、一般の$n$行$n$列の行列$A$に対して、$det(A) \neq 0$の時に、逆行列が存在することを確認したい。2行2列,3行3列の場合は、直接逆行列を構成したので、これを一般化する\


[**命題(Cramerの公式)**]$A = \displaystyle \sum_{i,j=1}^n a_{ij} e_{ij}$に対して\
$\widetilde{A} = \displaystyle \sum _{i,j}  (\displaystyle \sum_{w \in S_n ,w(i)=j} sgn(w) \displaystyle \prod_{r=1,r \neq i}^{n} a_{r w(r)}) e_{ji}$\
は$A \widetilde{A} = \widetilde{A} A = det(A) I$を満たす。$\widetilde{A}$を余因子行列と呼ぶ\
[**証明**]  
直接計算

[**以上**]



以上をまとめて、次の結果を得る  
[**命題**]$n$行$n$列の正方行列$A$について、次の4条件は同値  
(1)左逆元$X$が存在する;$XA=I$  
(2)右逆元$Y$が存在する;$AY=I$  
(3)$det(A) \neq 0$  
(4)逆行列$A^{-1}$が存在する  
**証明**:  
(1)=>(3).$det(XA) = det(X) det(A) = 1$より、$det(A) \neq 0$  
(2)=>(3).$det(AY) = det(A) det(Y) = 1$より、$det(A) \neq 0$  
(3)=>(4).Cramerの公式による  
(4)=>(1),(2).明らか
 
[**以上**]  



[**命題**]$n$行$n$列の行列環$M_n(k)$の環自己同型$\phi:M_n(k) \to M_n(k)$は内部的;$\exists p , \forall x,\phi(x)=p^{-1}xp$  
[証明]  
$e_{ij}$を行列単位として、$f_{ij}=\phi(e_{ij})$とする。\
このとき、$\displaystyle \sum_{k=1}^{n} f_{kk} = \phi(I) = I$なので、各$1 \leq t \leq n$に対して、$f_{tt} = \displaystyle \sum_{i,j} \alpha_{tij} e_{ij}$と置くと、$\displaystyle \sum_{s=1}^n \alpha_{tss} = 1$となる。明らかに$t,s$を、$\alpha_{tss} \neq 0$と選ぶことができる\
この時\
$P = \displaystyle \sum_{k=1}^n e_{ks} f_{tk}$\
$Q = \displaystyle \sum_{k=1}^n f_{kt} e_{sk}$\
と置くと、
$e_{ij} P = \displaystyle \sum_{k=1}^n \delta_{jk} e_{is} f_{tk} = e_{is} f_{tj}$\
$P f_{ij} = \displaystyle \sum_{k=1}^n e_{ks} \phi(e_{tk} e_{ij}) = \displaystyle \sum_{k=1}^n \delta_{ik} e_{ks} f_{tj} = e_{is} f_{tj}$\
なので$e_{ij} P = P f_{ij}$\
\
また\
$PQ = (\displaystyle \sum_{p=1}^n e_{ps} f_{tp})(\displaystyle \sum_{q=1}^n f_{qt} e_{sq})=\displaystyle \sum_{k=1}^n e_{ks} f_{tt} e_{sk} = \displaystyle \sum_{i,j,k} \alpha_{tij} e_{ks} e_{ij} e_{sk} = \displaystyle \sum_{i,j,k} \delta_{is} \delta_{js} \alpha_{tij} e_{kk} = \alpha_{tss} \displaystyle \sum_{k=1}^n e_{kk} = \alpha_{tss} I$\
であるけども、$\alpha_{tss} \neq 0$だったので、$P$は可逆。従って、\
$\phi(x) = P^{-1} x P$\
となる。  
[**以上**]  

通常の線形代数の教科書では、$x \mapsto P^{-1} x P$は相似変換という名前で、ややad hocに導入されるけど、行列環の環同型は全て相似変換で与えられる。これは、もう少し一般的な状況で、Skolem-Noetherの定理として知られている\




## 行列環の理論(3) Jordan分解とスペクトル分解 ##
以下、多項式$p(x) = p_n x^n + \cdots + p_0$と行列$A$に対して、$p(A) = p_n A^n + \cdots + p_0 I$とする(多項式$x+1$に対して$A+1$は意味を持たないので、$A+I$などとするということ)\


[**命題(Cayley-Hamiltonの定理)**]多項式$p(x)=det(xI-A)$に対して$p(A)=0$が成り立つ  
[**証明**]  

FIXME

[**以上**]  



[**命題(Jordan分解)**]  
$A \in Mat(n,\mathbf{C})$に対して、次のような分解が存在する  
[**証明**]  
$f(x) = det(xI-A)$が$f(x)=\prod_{i=1}^M (x - \lambda_i)^{a_i}$と因数分解できるとすると\
$1 = \displaystyle \sum_{i=1}^M q_i(x) \displaystyle \prod_{j:j \neq i} (x-\lambda_j)^{a_j}$\
を満たす多項式$q_i(x)$が存在する\
$p_i(x) = q_i(x) \displaystyle \prod_{j:j\neq i}(x-\lambda_j)^{a_j} \quad (i=1,\cdots,M)$\
と置くと、\
$1 = \displaystyle \sum_{i=1}^M p_i(x)$\
$x = \displaystyle \sum_{i=1}^M \lambda_i p_i(x) + \displaystyle \sum_{i=1}^M (x-\lambda_i)p_i(x)$\
であり、因数を見ると\
$((x-\lambda_i)p_i(x))^{a_i} = 0 \mod f(x)$\
$p_i(x) p_j(x) = 0  \mod f(x) \quad (i \neq j)$\
はすぐ分かる。従って$P_i=p_i(A)$は\
$P_i P_j = 0 \quad (i \neq j)$\
$\displaystyle \sum_{i=1}^n P_i = I$\
を満たす。後者の式の両辺に$P_i$をかけると\
$P_i = \displaystyle \sum_{j=1}^M P_i P_j = P_i^2$\
より$P_i$は冪等元  
  
また$N_i = (A-\lambda_i)P_i$とすると、$N_i^{a_i} = 0$で、\
$A = \displaystyle \sum_{i=1}^M \lambda_i P_i + \displaystyle \sum_{i=1}^M N_i$\

[**以上**]  


Jordan分解の証明は、多項式が一次式の積に分解できることを利用しているので、実数係数では一般にはダメで、複素係数で考える必要がある。また、上の定理の証明で、$f(x)$は$f(A)=0$を満たす、自明でない(最高次係数が1の)多項式であれば、何でもよい。Jordan分解で、$\displaystyle \sum_{i=1}^M \lambda_i P_i$の部分を、半単純成分と呼び、$\displaystyle \sum_{i=1}^M N_i$の部分を冪零成分と呼ぶ。冪等元は射影と呼ばれることもある。冪等元という言い方は、代数的色彩があり、射影と言う言い方は、解析的色合いがある\


冪等元$p$が2つの0でない冪等元$p_i,p_j$の和で書けない時、原始冪等元と呼ぶ。原始冪等元$p_i$が、$I = \displaystyle \sum_{i=1}^n p_i$ , $p_i p_j=0(i \neq j)$を満たす時、単位行列の原始直交冪等元分解と呼ぶ。例えば行列単位$E_{ii}$は原始冪等元で、$I = \sum_{i=1}^n E_{ii}$は原始直交冪等元分解を与える\


単位行列の原始直交冪等元分解は、必ず行列のサイズ$n$個の原始冪等元の和になる。また、冪等元は必ずいくつかの原始冪等元の和で書ける。これらのことと、Jordan分解を通じて、単位行列の原始直交冪等元分解$I = \displaystyle \sum_{i=1}^n p_i$が与えられる。一方、単位行列の原始直交冪等元分解$I = \displaystyle \sum_{i=1}^n p_i$に対しては、適当な環同型$\phi : Mat(n,k) \to Mat(n,k)$が存在して、$\phi(p_i) = E_{ii}$とできる。従って、もし、行列$A$のJordan分解で、冪零成分がなければ、適当な環同型$\phi$によって$\phi(A)$を対角行列にすることができる。これを対角化と呼ぶ(冪零成分がない場合、Jordan分解ををスペクトル分解と呼ぶこともある)。\


[注釈]単位行列の原始直交冪等元分解$I = \displaystyle \sum_{i=1}^n p_i$に対して$\phi(p_i) = E_{ii}$を満たす環同型$\phi:Mat(n,k) \to Mat(n,k)$が存在することの証明は、環の言葉だけでできる気もするけど思いつかない。ベクトルを使ってよければ、$P_i v_i = v_i$を満たす0でない$v_i$が定数倍を除いて決まるので、これを並べて正則変換を作ることができるのだけど..\
\
\


## ベクトル空間論 ##
[**TODO:ベクトル空間の定義**]\
[**TODO:一次独立・一次従属・基底の定義**]\



[**命題**]ベクトル空間$V$に対して、$v_1 , \cdots , v_n$と$w_1 , \cdots , w_m$が共に基底である時、$n=m$が成り立つ。この時、$n=m$をベクトル空間$V$の次元と呼んで$dim(V)$と書く  
[**証明**]  
より一般に、$\{v_1 , \cdots , v_h \}$がベクトル空間$W \subset V$を生成し、$S = \{ u_1 , \cdots , u_k \} \subset W$が一次独立である時、$k \leq h$が成り立つことを$h$に関する帰納法で示す\
これが言えれば明らかに$n \leq m$かつ$m \leq n$なので$m=n$\
(1)$h=0$の時、$V=\{ \mathbf{0} \}$なので、$S=\{ \mathbf{0} \}$であるか$S=\phi$であるけども、前者
は、一次独立でない。従って$k=0 \leq h$\
\
(2)$h=r-1$まで正しいとして、$h=r$の時を示す。$S \subset W$なので\
$u_i = \displaystyle \sum_{j=1}^r a_{ij} v_j \quad (i=1,\cdots ,k)$\
と書ける。$a_{ir} =0 \quad (i=1 , \cdots , k)$の時、$S$は、$\{v_1 , \cdots , v_{r-1} \}$で生成される部分空間に含まれているので、帰納法の仮定より、$k \leq r-1 \leq h$\
\
\
今度は、ある$1 \leq p \leq k$に対して、$a_{pr} \neq 0$であるとする。$p=k$として、一般性を失わない。この>時\
$w_i = u_i - \dfrac{a_{ir}}{a_{kr}} u_k \quad (i=1,\cdots,k-1)$\
とすると、$w_i$は$\{ v_1 , \cdots , v_{r-1} \}$の生成する部分空間に含まれている。また\
$\mathbf{0} = c_1 w_1 + \cdots + c_{k-1} w_{k-1} = c_1 u_1 + \cdots c_{k-1} u_{k-1} - \dfrac{\sum c_i a_{ir}}{a_{kr}}u_{k} \Leftrightarrow c_1 = \cdots c_{k-1} = \sum c_{i}a_{ir} =0$\
で、$w_{1} , \cdots , w_{k-1}$は一次独立。帰納法の仮定より、$k-1 \leq r-1$なので$k \leq r=h$  

[**以上**]  


一般には、ベクトル空間は、有限個の基底を持つとは限らない。世の中には、無限個の基底で生成されるベクトル空間も存在する。例えば、多項式の集合は、$1,x,x^2,\cdots$を基底とするベクトル空間となっている。
また、実数の集合$\mathbf{R}$は、有理数体$\mathbf{Q}$上のベクトル空間になっている。(無限個の)基底が存在することは選択公理を使えば証明できるけど、具体的に、どういう実数が基底になってるか計算することはできない。こういうのは、具体的な計算の役には全然立たない病的な例ではある



[**命題**]任意の自然数$n$に対して、$n$次元ベクトル空間が存在する  
[**証明**]  
$V=\mathbf{K}^n$と置けばいい\

[**以上**]


最初から、$\mathbf{K}^n$だけを扱えばよさそうなものであるのに、わざわざ、抽象的なベクトル空間の定義を導入する理由は、例えば、多項式$x,\cdots,x^n$の一次結合も$n$次元ベクトル空間となるけど、この2つのベクトル空間は等しくないし、線形同型ではあるけども、標準的な線形同型写像が一意に決まるわけでもない。こういう、色々な$n$次元ベクトル空間が数学では出てくるので、抽象的な定義を採用している。このへんは、こうしておくと、後々説明を節約できるという程度の話ではある\



[**TODO:線形準同型の定義**]  
[**TODO:$End(V)$に環構造が入ることの説明**]  



[**命題**]$n$次元ベクトル空間$V$に対して、環同型$Mat(n,\mathbf{K}) \simeq End(V)$が成り立つ  
[**証明**]  
以下、$V$の基底$v_1,\cdots,v_n$を一つ固定する\
$\Phi : Mat(n,\mathbf{K}) \to End(V)$を、$v = c_1v_1 + \cdots + c_n v_n$に対して\
$\Phi(\displaystyle \sum_{i,j} a_{ij} E_{ij}) (v) = \displaystyle \sum_{i,j} p_{ij} c_j v_i$\
で定義する\
\
また、$f \in End(V)$とすると、各$f(v_i)$は$v_i$の一次結合で書けるので\
$f(v_i) = \displaystyle \sum_{j=1}^n b_{ij} v_j$\
となる$b_{ij} \in \mathbf{K}$が存在する。このような$f$に対して、$\Psi:End(V) \to Mat(n,\mathbf{K})$を\
$\Psi(f) = \displaystyle \sum_{i,j} b_{ij} E_{ij}$\
と定義する。$\Psi$と$\Phi$は逆写像で、共に環準同型を与えていることは、容易に確認できる\

[**以上**]


この環同型は、$V$の基底の取り方に依存していて、標準的な同型が存在するわけではない。但し、上のようにして作った2つの同型$f,g:Mat(n,\mathbf{K}) \to End(V)$の間には、適当な環同型$\phi:Mat(n,\mathbf{K}) \to Mat(n,\mathbf{K})$によって、$f \circ \phi = g$という関係が成立する(prove)。

環同型$Mat(n,\mathbf{K}) \simeq End(V)$の取り方に依存して結果が変わる命題というのは、あまりないので、しばしば$P \in Mat(n,\mathbf{K})$と$v \in V$に対して、適当な環同型$f:Mat(n,\mathbf{K}) \to End(V)$を指定して、$f(P)(v) \in V$と書く代わりに、$Pv \in V$と書いたりする。
あるいは、$Mat(n,\mathbf{K})$がベクトル空間$V$に作用していると言ったら、暗黙のうちに適当な環同型$f:Mat(n,\mathbf{K}) \to End(V)$を指定していると思う\



[**TODO:KernelとImage,行列の階数**]  
[**TODO:固有値と固有ベクトル**]  
[**TODO:計量ベクトル空間**]  
[**TODO:正規直交基底**]  
[**TODO:直交変換とユニタリ変換**]  
\



## QR分解 ##
**命題(QR分解)**:  
(1)$P \in GL(n,\mathbf{R})$に対して、$P=QR$を満たす$Q \in O(n)$と正則上三角行列$R \in GL(n,\mathbf{R})$が存在する  
(2)$P \in GL(n,\mathbf{C})$に対して、$P=QR$を満たす$Q \in U(n)$と正則上三角行列$R \in GL(n,\mathbf{C}$が存在する  
[**証明**]

(1)$P$が$n$次元計量ベクトル空間$V$に作用しているとして、$e_1,\cdots e_n$を正規直交基底とする。$v_i = P e_i$と置いて、$v_1 , \cdots v_n$をGram-Schmidtの直交化法によって直交化する\
(2)も同様

[**以上**]


上三角行列や直交変換・ユニタリ変換の逆行列は、Cramerの公式に頼らなくても、容易に計算できるので、$P^{-1}=R^{-1} Q^{-1}$によって逆行列が簡単に分かる\


[注釈]QR分解は$R$の対角成分を正になるようにすると、一意に定まる。正則でない場合も同様の分解は可能であるけども、一意性はなくなる\


[**TODO:QR分解を使って固有値を計算する方法**]\
\
\



## 特異値分解 ##





