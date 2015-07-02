# BerkeleyX CS100.1x "Introduction to Big Data with Apache Spark"

線上課程連結：
https://www.edx.org/course/introduction-big-data-apache-spark-uc-berkeleyx-cs100-1x

## Week #1

### 建立實驗環境

1. 這次課程是使用 Spark 的 Python 語法
2. 實作環境是用 Vagrant + VirtualBox, 如果已經裝好 VirtualBox 跟 Vagrant，只需要做以下動作：
```
~$ mkdir -p EDX_Spark
~$ cd EDX_Spark
~/EDX_Spark$ wget https://github.com/spark-mooc/mooc-setup/archive/master.zip
~/EDX_Spark$ unzip master.zip
~/EDX_Spark$ cd mooc-setup-master/
~/EDX_Spark/mooc-setup-master$ vagrant up
```
備註：由於從美國下載 Vagrant Box 可能會花比較久的時間，也可以使用以下指令會快一點(有時間再找個台灣的載點放)：
```
 vagrant box add http://hadoopcon.org/~jazz/vagrant-spark/virtualbox.box --name "sparkmooc/base"
```
3. 當 Vagrant VM 正確啟動後，可以連線至 [http://127.0.0.1:8001](http://127.0.0.1:8001) ，就可以看到 Python Notebook 的環境
4. 點選畫面右上角的 Upload ，然後選擇 master.zip 壓縮檔中的 iPython 範例，檔名為 lab0_student.ipynb。

### Lecture 1: 大數據與資料科學簡介

1. 資料分析簡史：
	- 1935 : R.A. Fisher 費雪 **"The Design of Experiments"** 
		* 這就是經常會聽到的縮寫 **DOE**、**ANOVA (變異數分析，Analysis of variance)**跟費雪精確性檢定(Fisher's exact tests)的由來
		* 費雪的名言：**"有關聯不代表就有因果關係(Correlation does not imply causation)"**，因為他是個老煙槍，雖然研究顯示有關聯說抽煙會得癌症，但不代表就是因果關係.
	- 1939 : W.E. Demming "Quality Control"
		* 使用數值取樣(statistical sampling)的方式進行品質管制
	- 1953 : Peter Luhn
		- 提出使用索引(Indexing)與信息檢索(Information Retrival)的方法，來萃取商業智慧的目的。
	- 1977 : John W. Tukey "Exploratory Data Analysis"
		- 造就了 S / S+ / R 等統計語言的發展
	- 1989 : Howard Dresner "Business Intelligence"
		- 現代商業智慧之父(proponent, 提議者)
	- 1997 : Tom Mitchell "Machine Learning Book"
	- 1996 : Google "Prototype Search Engine"
	- 2007 : Microsoft "The Fourth Paradiagm"
		- Data-Driven Science Book
	- 2009 : Peter Norig "The Unreasonable Effectiveness of Data"
		- 多個小型的數值模型搭配大量的資料，比建立複雜的數值模型還有效。
		- multiple small models and lots of data is much more effective than building very complex models.
	- 2010 : 經濟學人雜誌(Economicst) "The Data Deluge" 資料洪水
		- 人們產生的資訊量與日俱增
2. 案例：
	- 1958 : Ancel Keys "Seven Countries Study"
	- 探討死亡率與脂肪攝取量的關聯呈現正相關
	- 反思：
		- 只有探討 21 個國家中的 7 個 (**資料的量不足**)
		- 沒有考慮其他因素，例如不同國家每人平均(capita)的糖份攝取量 (**考量因子不足**)
	- 證明：**"有關聯不代表就有因果關係(Correlation does not imply causation)"**

3. Nowcasting vs Forecasting
	- Forcasting : 蒐集大量資料, 建立數值模型, 用來預測**未來**(predict the future)
	- Nowcasting : 蒐集大量資料, 建立數值模型, 用來解釋**現在**發生了什麼事情
	- 範例(1)：2010 - Google Flu Trends
		- 使用 2003~2008 年的搜尋關鍵字，建立了 97% 正確率的模型，可以比美國疾管局(CDC)還要提前兩週偵測到爆發流感
		- 有趣的是 2011-2013 反而不準了，原因出在在這段時間裡，Google 發表的 Google Flu Trends (GFT) 的新聞，結果新聞報導的資料誤導了預測結果。
	- 心得：
		- 找到關鍵因子比較重要
		- 當心蒐集的資料來源
	- 範例(2) : 2012 年美國總統大選
		- 如何移除偏差(bias)
		- 歐巴馬團隊建立了資料庫，用來瞭解哪些人會去投票，但不會去網站填問卷
	- 案例(3) : Facebook Lexicon
		- 有論文指出從 Google 跟 MySpace 的搜尋趨勢，預測未來臉書將不存在
		- 臉書分析了許多資料，包括不同的大學，確實都有下降的趨勢。
		- 最後臉書反擊的點很諷刺，他們表示由於搜尋"空氣(Air)"關鍵字愈來愈少，所以未來空氣將會消失。當然這樣的反駁還蠻有說服力的，當我們看到一篇論文的時候，最好還是反思一下即使有關聯性，到底是不是因果關係 :)
4. 巨量資料從哪裡來? (Where Does Big Data Come From?)
	- 社交網路、網站的日誌檔、機器產生的日誌檔
	- 基因定序資料(Sequencing)
	- 物聯網(Internet of Things)

### Lecture 2: 如何準備資料

1. 什麼是資料科學？
	- 定義：根據歐萊禮的「What is Data Science」一書，資料科學是能夠聰明而有效地從巨量資料中擷取知識(data science aims to drive knowledge from big data efficiently and intelligently.)。
	- 資料科學包含三種技能： 
		- hacking skills 實作能力
        - math and statistics knowledge 數值統計知識
        - domain expertise 領域知識
2. 資料科學與其他領域的對比

	| Database | Data Science |
	|--------|--------|
	| 結構化  | 半結構 或 非結構 |
	| ACID   | CAP    |
	| 查詢過去的資料 | 探索未來的可能 |

	| 科學模型 | 資料導向模型 |
	|--------|--------|
	| 物理模型 | 影響力引擎 (inference engine) |
	| 基於問題設計結構 | 結構與問題相互獨立 |
	| 結果論, 精確 | 用數值模型來處理不確定性與複雜度 |
    | 執行於高速電腦或高檔電腦叢集 | 執行於廉價的電腦叢集 (Ex. EC2) |

	| 機器學習 | 資料科學 |
    |--------|--------|
    | 發展獨立的新模型 | 探索多種不同的模型，混合使用 |
    | 證明數值上的模型特徵 | 瞭解經驗上的模型特徵(empirical properties)，像是準確率有多高，需要跑多久 |
    | 用少量而乾淨的資料集來進行驗證 | 發展工具來處理大量而骯髒的資料集 |
    | 發表論文 | **採取改善的行動 Take Action** |

3. 執行資料科學的方法論(Doing Data Science)
    - Jim Gray 的模型 (圖靈獎資料庫專家)
    	1. capture data
        2. curate data
        3. communicate the results
    - Ben Fry 的模型 (資料視覺化專家)
    	1. Acquiring
        2. Parsing
        3. text.splittext.splitFiltering
        4. Mining the data for information
        5. Representing the results
        6. Refining the model
        7. Interacting with the results
    - Jeff Hammerbacher 的模型 (臉書首席科學家, 帶領開發 Hive, 也是 Cloduera 共同創辦人)
    	1. Identifying a problem
        2. Instrumenting the data sources
        3. Collecting the data
        4. Preparing that data (integrate, transform, clean, filter, and aggregate)
        5. Builds a model
        6. Evaluates that model
        7. Communicates the results

4. 雲端運算是資料科學的驅動力
5. 資料科學的主題 ( Data Science Topics )
    - Data Acquisition
    - Data Preparation
    - Data Analysis
    - Data Presentation
    - Data Products
    - Observation and Experimentation
6. 協同作業的阻礙(impediments to collaboration)
	- 使用不同的程式語言
	- 僅限一人的分析
	- 無法做好工具的管理
	- 直接重寫一個，比找一個解法容易
7. 四種資料科學的角色
	- 個人：商務者與開發者
	- 組織：企業與網路公司

## Week #2 

### Lecture 3: 巨量資料、硬體趨勢與 Apache Spark

1. 巨量資料問題(The Big Data Problem)
	- 一顆 1TB 硬碟只要 35 塊美金，處理 1TB 的資料卻要 3 個小時(100MB/s)
2. 巨量資料潮流下的硬體趨勢 (Hardware for Big Data)
	- 改用一般等級的硬體，便宜、易於擴充，但容易故障，因此要用軟體的方式來解決
3. 在本地端統計字數 (Counting Words Locally)
	- Hash Table 的作法
4. Counting Words in Really Big Documents
5. Failures and Slow Tasks
5. Using Map Reduce for Sorting
6. Map Reduce and Disk I/O
	- MapReduce 不合適迭代，因為 Disk I/O 會拖慢運算速度
7. Technology Trends and an Opportunity
	- 記憶體愈來愈便宜,
8. The Spark Computing Framework
	- 由 Spark Core, Spark SQL, Spark Streaming, MLlib 四個元件組成
9. Spark and Map Reduce Differences

PS. 因為這段牽涉到很多 Hadoop MapReduce 觀念，所以我看得很快。沒特別需要做紀錄的 XD

### Lecture 4: Spark 簡介

1. Python Spark (pySpark)
	- Spark 程式由兩個部份組成：
		- Driver Program : 本機
        - Worker Program : 跑在叢集或本機(Local Thread)
    - Spark Driver Program 首先必須先產生 **SparkContext** 物件，用來告訴 Spark 如何存取叢集
    	- pySpark 與 Databricks Cloud 會自動幫忙產生 sc 變數(**S**park**C**ontext)
    	- iPython 與其他程式必須使用建構子(Constructor)來產生新的 SparkContext
    	- 用 SparkContext 來產生 RDD
    - SparkContext 的 master 參數: 用來指定執行的叢集位置

    	| master 參數 | 意義 |
        |------------|------|
        | local | 在單機執行 Spark，只使用單一執行緒 (不平行化) |
        | local[K] | 在單機執行 Spark，並啟用 K 個執行緒 (最好設定成 CPU 核心數) |
        | spark://HOST:PORT | 連上 Spark standalone cluster，預設 PORT 為 7077 |
        | mesos://HOST:PORT | 連上 Mesos cluster，預設 PORT 為 5050 |

2. Resilient Distributed Datasets (Abstraction)
	- RDD 一旦產生了就是不可變的(immutable)(可以轉型 transform, 可以對它做運算)
	- Spark 會追蹤族系資料(Lineage information)，用來有效地重新計算出遺失的資料(如果有機器故障的話)
	- RDD 允許對物件的集合進行平行運算(enables operations on collections of elements in parallel)
	- 在 pySpark 中，可以透過三種方式產生 RDD
		- 平行化 Python 的 lists 物件 (parallelizing existing Python collections)
		- 轉換既有的 RDDs ( transforming an existing RDDs )
		- 從 HDFS 或其他檔案系統讀取檔案
	- 開發者必須指定 RDD 的分割個數(number of partitions for a RDD)
		- 如果沒有指定，就會用預設值
		- RDD 的分割越多，就越能達到平行化的目的
		- 假設有三台機器，一個 RDD 切成五個 Partition，則會有兩台 Worker 拿到兩個 Partition，一台拿到一個 Partition
	- RDD 支援兩種運算：**transformations** 與 **actions**
		- Transformation are **lazy evaluated** (不會馬上做運算)，只有當要對它做 Action 的時候才會被執行。
		- Persist (cache) RDD - RDD 可以快娶到記憶體或序列化到硬碟
		- Transformation 的種類：map 或 filter
		- Action 的種類：collect 或 count
3. Resilient Distributed Datasets (RDDs)

	- 建立 RDD 的範例(1) : 將 Python 的 list `data` 透過 SparkContext 變數 `sc`，呼叫 parallelized 函數，告知要產生 4 個 partition
	
	```
	data = [1,2,3,4,5]
	rDD = sc.parallelize(data,4)
	```
	
	- 建立 RDD 的範例(2) : 從本機檔案系統、HDFS、HyperTable、Amazon S3、HBase、SequenceFile 等 Hadoop 支援的 InputFormat 讀取資料。(註：輸入路徑支援"萬用字元(*)")

	```
	distFile = sc.textFile("README.md",4)
	```
	- 上面這個範例表示要從 README.md 這個檔讀取資料，並散佈成 4 個 partition。此時仍舊是遵守 lazy evaluation。

4. Spark Transformation

	- 用來從現存的 RDD 產生新的資料集
	- 遵守 Lazy Evaluation 規則，Spark 會記住所有的 transformation，就像「食譜(recipe)」一樣，套用到最原始的資料集
	- Spark Transformation 的種類有：

	| transformation | 描述 |
	|------|-------|
	| map(*func*) | 回傳經過 map 函數的新資料集 |
	| filter(*func*) | 回傳經過 filter 函數過濾後的新資料集 |
	| distinct([*numTasks*]) | 回傳來源資料集當中不重複的元素 |
	| flatMap(*func*) | 類似 map，只是函數的輸出可以是 0 個或多個結果 |
	
5. Python lambda Functions

	```
	lambda a, b : a + b
	```

	- 回傳 a+b 的結果
	- 限制：只能用於單一表示式

6. Transformations

	```
	>>>	rdd	= sc.parallelize([1, 2, 3, 4])
	>>>	rdd.map(lambda x: x * 2)
		RDD: [1,2,3,4] -> [2,4,6,8]
	>>>	rdd.filter(lambda x: x % 2 == 0)
		RDD: [1,2,3,4] -> [2,4]
	>>>	rdd2 = sc.parallelize([1,4,2,2,3])
	>>>	rdd2.distinct()
		RDD: [1,4,2,2,3] -> [1,4,2,3]
	>>> rdd = sc.parallelize([1,2,3])
	>>> rdd.map(lambda x: [x, x+5])
		RDD: [1,2,3] -> [[1,6],[2,7],[3,8]]
	>>> rdd.flatMap(lambda x: [x, x+5])
		RDD: [1,2,3] -> [1,6,2,7,3,8]
	```

	```
	line = sc.textFile("....",4)
	comments = line.filter(isComment)
	```
	
	- 第二個是從檔案讀入RDD的範例，其中的 isComment 是一個函數，用來判斷是否該行內容是否為註解
	- Spark Transformation 不會馬上生效，Spark 只是記住 Recipe。(概念上有點類似 Pig 的 Alias)

7. Spark Actions
	- Spark Action 會將 Recipe 套用到來源資料集(source)，產出結果
	
	| Action | 描述 |
	|---|---|
	| reduce(*func*) | 使用 func 函數來計算所有元素的總和(aggregate)。func 函數必須有兩個參數，並且符合結合律(associative)與交換律(commutative)，才能正確地在平行運算環境中執行 |
	| take(*n*) | 回傳前 n 個元素 |
	| collect() | 回傳所有元素組成的陣列(array)，需注意這個陣列必須可以放得下 Driver Program 的記憶體 |
	| takeOrdered(n, key=func) | 回傳使用 func 函數排序後的前 n 個元素 |
	
	```
	>>> rdd = sc.parallelize([1,2,3])
	>>> rdd.reduce(lambda a, b : a * b)
	Value: 6 ### 也就是 ((1 * 2) * 3)
	>>> rdd.take(2)
	Value: [1,2] ### 以 Python 的 list 型態存在
	>>> rdd.collect()
	Value: [1,2,3] 
	### 要小心使用產出的 Python list 是否可以放進 Driver Program 的記憶體 
	>>> rdd =  sc.parallelize([5,3,1,2])
	>>> rdd.takeOrdered(3, lambda s: -1 * s)
	Value: [5,3,2] ### 排序 -5, -3, -2, -1 (小到大)
	```
	
8. Spark Programming Model
	
	```
	lines = sc.textFile("...",4)
	comments = lines.filter(isComment)
	print lines.count(), comments.count()
	```
	
    - count() 促使 Spark (A) 讀取資料 (B) 在每個 partition 中的行數 (C) 將每個 partition 的行數結果回傳到 Driver Program 並計算總行數
    - comments.count() 會**重新讀取資料(讀第二次)**，並計算是註解的總行數
	
9. Caching RDDs
	
	- 為了避免重複讀取資料，可以加上 cache 指令
	
	```
	lines = sc.textFile("...",4)
	lines.cache() # cache to memory , don't recompute
	comments = lines.filter(isComment)
	print lines.count(), comments.count()
	```
	
10. Spark 程式的生命周期
	1. 從外部資料創建 RDD , 或從 Driver Program 平行化(parallelize)一個集合(collection, Ex. Python List)
	2. Lazy transform 成為新的 RDDs
	3. cache() 快取某些 RDD
	4. 執行 action 來套用平行運算，並產生結果

11. Spark Key-Value RDDs
	
    ```
    >>> rdd = sc.parallelize([(1,2),(3,4)])
	RDD: [(1,2),(3,4)]
    ```
    
    Spark Key-Value Transformation
    
    | Key-Value Transformation | 描述 |
    |---|---|
    | reduceByKey(*func*) | 將相同 Key 的所有 Value 使用 func 函數計算總和(aggregate)。 *func* 函數必須是 (V,V) -> V |
    | soryByKey() | 回傳根據 Key 遞增排序的 (K,V) 結果(小到大) |
    | groupByKey() | 回傳 (K, lterable<V>) 的結果 |
    
    ```
    >>> rdd = sc.parallelize([(1,2),(3,4),(3,6)])
    >>> rdd.reduceByKey(lambda a, b: a + b)
	RDD : [(1,2),(3,4),(3,6)] -> [(1,2),(3,10)] ## (3,"4+6")
    >>> rdd2 = sc.parallelize([(1,'a'),(2,'c'),(1,'b')])
    >>> rdd2.sortByKey()
	RDD : [(1,'a'),(2,'c'),(1,'b')] -> [(1,'a'),(1,'b'),(2,'c')]
    >>> rdd2.groupByKey()
	RDD : [(1,'a'),(2,'c'),(1,'b')] -> [(1,['a','b']),(2,['c'])]
    ```
    
    - 要小心使用 groupByKey() 因為它會產生大量的資料搬移流量，也可能會在單一 Worker 上產生大量的中間產物 Iterables (跟 MapReduce 的 Key Screw 是相同道理)
12. pySpark Closures
	- 跟 MapReduce 類似，Spark 產生 closures (函數跟變數) 到每個工作節點上的 RDD 做運算
	- Closure 是單向的，只能從 Driver -> Worker
	- 每個工作節點彼此之間不溝通(Share Nothing Model)，變數也不會傳遞回 Driver Program
	- 情境一：如果遇到迭代演算法需要「公用變數(Global variable)」，
		- Ex. 每個 Worker 都需要對龐大的公用變數進行查表
		- Ex. 需要傳遞 Feature Vector 給每個 Worker
	- 情境二：必須統計在 Worker 的所有事件
		- Ex. 統計全部 Worker 遇到了多少輸入是空白行(blank)
		- Ex. 統計全部 Worker 遇到多少輸入是毀損的
	- pySpark 提供兩種方式：
		1. Broadcast Variables 廣播變數
			- 有效傳遞大量、唯讀(Read-Only)的公用資料給所有 Worker
			- 類似 MapReduce 的 **"DistribtuedCache"** 概念
		2. Accumulators
			- Accumulator 對每個 Task 而言是「唯寫(Write-Only)」
			- Accumulator 是從 Worker 到 Driver，只有 Driver 可以讀取 Accumulator
13. Spark Broadcast Variables
	
    ```
    ### At the driver
    >>> broadcastVar = sc.broadcast([1,2,3])
	### At the worker
    >>> boradcast.value
	[1,2,3]
    ```
    
    ```
    signPrefixes = sc.broadcast(loadCallSignTable())
    
    def processSignCount(sign_count, signPrefixes):
    	country = lookupCountry(sign_count[0], signPrefixes.value)
        count = sign_count[1]
        return (country, count)
    
    countryContactCounts = (contactCounts
    						.map(processSignCount)
                            .reduceByKey(lambda x, y : x+y))
    ```
    
14. Spark Accumulators

	```
    >>> accum = sc.accumulator(0)
    >>> rdd = sc.parallelize([1,2,3,4])
    >>> def f(x):
    >>> 	global accum
    >>> 	accum + = x

	>>> rdd.foreach(f)
	>>> accum.value
	Value: 10   ### 1+2+3+4
    ```
    - Accumulator 可以用在 Action 跟 Transformation，但兩者行為有些許不同
    | 運算種類 | 行為 |
    |---|---|
    | Action | 每個 Task 只會更動 Accumulator 一次 (applied only once) |
    | Transformation | 無法保證只套用一次，因此只能用在除錯上 |
    - Accumulator 支援的資料型態包括：integer, doulbe, long, float。當然也可以用在自訂型態，會在課程其中一個 Lab 中看到。

### Lab 1 : Learning Apache Spark

1. 走過一次 Spark Tutorial
2. 撰寫 Word Count 程式
	- 計算 [Complete Works of William Shakespeare](http://www.gutenberg.org/ebooks/100) 裡出現次數最多的單字
		1. Remove punctuation and leading or trailing spaces
			- 使用***re.sub() escape str.punctuation*** 與 ***str.strip()***, **str.lower()**的執行先後順序會影響最後產生的總字數結果
		2. Split each line by spaces
			- 注意 **text.split(" ")** 與 **text.split()** 的差異
		3. Use ***takeOrdered()*** to obtain the fifteen most common words
			- ***takeOrdered()***使用方式
				- sort by keys (ascending): RDD.takeOrdered(num, key = lambda x: x[0]) 
				- sort by keys (descending): RDD.takeOrdered(num, key = lambda x: -x[0]) 
				- sort by values (ascending): RDD.takeOrdered(num, key = lambda x: x[1]) 
				- sort by values (descending): RDD.takeOrdered(num, key = lambda x: -x[1]) 

## Week 3 - 資料管理(Data Management)

### Lecture 5: 半結構化資料(Semi-Structured Data)

1. 關鍵的資料管理概念
	- 關鍵的資料管理概念
		- 資料模型 (Data Model) - 用來描述資料的概念集合(collections of concepts)
		- Schema - 使用某種資料模型，用以描述特定資料集合
	- 資料結構的頻譜 (Structure Spectrum)
		- 結構化資料 Structured ( schema-first , 先套用 Schema ) : 如關聯式資料庫
		- 半結構資料 Semi-structured ( schema-later , 之後才套用 Schema ) ： 如 XML 檔
		- 非結構資料 Unstructured ( schema-never , 不套用 Schema ) : 如自由格式的純文字檔或多媒體檔案
2. 檔案
    - 檔案(file)是有名稱的一連串位元(named sequence of bytes)
    - 檔案系統(filesystem)是以階層式名稱空間(hierarchical namespace)組成的檔案集合
    - 常見的檔案系統 API 包括 open()/close()/seek()/read()/write()
    - 檔案格式(file format)的各種考量：
    	- 採用何種資料模型？表格式(tabular)、階層式(hirarchical)與陣列(array)
    	- 實際上如何存放(physical layout)
    	- 欄位的單位與驗證方式(field unit and validatation)
    	- 有沒有屬性資料(metadata), 如檔頭(header), 標準(specification)
    	- 是純文字格式(ASCII 或 UTF-8 編碼), 還是二進位格式
    	- 分隔符號(delimiter)是什麼？又該用什麼跳脫符號(escaping)來表示特殊字元
    	- 採用何種壓縮格式？加密方式？驗證碼(checksum)？
    	- 如何發展 Schema ? (Schema Evolution)
3. 表格式半結構資料 ( semi-structured tabular data )
	- 資料表(table)由行(row)與列(column)組成
	- 每一行有索引(index)，每一列有名稱(name)
	- 每個儲存格(cell)可以用 (index,name) 表示
	- 每個儲存格可能有值、也可能沒有值
	- 每個儲存格的型態(type)可以由值(value)進行推論
	- CSV 格式: Comma Separated Values 用逗點隔開數值的檔案格式
	- PDB 格式: Protein Data Bank 蛋白質資料庫格式 - 每行由欄位名稱(可重複)與多個值組成
4. 表格式資料的挑戰
	- 格式可能沒有明確定義 (可能有缺值)
	- 型態沒有正確標示, 如: "2" 標記為 "2.0", 就無法視為整數
	- 不支援版本(versioning)
	- 從不同來源取得的表格資料可能會遇到的問題：
		- 如：內容混用了美金符號($)跟歐元符號(£)
		- 內容前後不一致，如：前面寫 Wal-Mart, 後面寫 WalMart
	- 從感測器取得的表格資料可能會遇到的問題：
		- 沒有辦法產生正確型態的感測值
		- 感測器毀損，產生永久性或暫時性的錯誤數值
		- 時間戳記不夠準確
		- 其他屬性資料(metadata)可能有誤
		- 感測器離線好一段時間，造成資料有間隔
5. Pandas 與 Spark DataFrame
	- Pandas : Python Data Analysis Library
		- 它是一套做資料分析與資料模型的開源函式庫
	- Pandas DataFrame 是有欄位名稱的表格(table with named columns)
		- 以 Python Dict 型態表示(對應 column_name 欄位名稱到 series 序列)
		- 每個 pandas Series 物件代表一個欄位
			- 可以想成是一個一維、有標籤的陣列，可以存放各種型態的資料
	- R 也有類似的 DataFrame 的資料型態
	- Spark DataFrame
		- Spark 1.3 版以後新增了 DataFrame 作為 RDD 的擴充元件
		- 它代表「分散式」、有欄位名稱的表格，類似 Pandas Data，但是分散式的
		- 資料型態由值決定
		- 將 Spark DataFrame 轉成 Pandas DataFrame 的互相轉換方式					
	
	```
	panda_df = spark_df.toPandas()
    spark_df = context.createDataFrame(panda_df)
    ```
	- Reference guide 	
		- [Spark SQL and DataFrame Guide](https://spark.apache.org/docs/latest/sql-programming-guide.html)
		- [Introducing DataFrames in Spark for Large Scale Data Science](https://databricks.com/blog/2015/02/17/introducing-dataframes-in-spark-for-large-scale-data-science.html)
   	- 需注意 Pandas DataFrame 必須可以放進 Driver 程式的記憶體中
	- 使用 PySpark DataFrame 在單機上比使用 RDD 還要快5倍
9. 半結構化日誌檔
	- 許多像是網頁伺服器、資料庫、作業系統的背景程式都會產生這種純文字格式的日誌檔
	- 雖然是有利於人去閱讀的格式，但卻鮮少有人去看。
	- Apache Common Log Format
		- 第一個欄位是「來源 IP」
		- 第二個代表遠端的使用者名稱，減號(hyphen)代表無法取得
		- 第三個代表本地的使用者名稱，減號(hyphen)代表無法取得
		- 第四個欄位代表「請求時間(Request Time)」，由日期、時間、時區(timezone)組成
		- 第五個欄位是「用戶端請求(Client Request)」，由請求的方式、請求的 URI 與協定版本
		- 第六個欄位是「回傳狀態值(status code)」，兩百多代表正常
		- 第七個欄位是「回傳資料量」，**有時是減號，有時是零。因此解析起來很困難，必須通通列入考慮**。
10. System Log File (syslog)
	- 可以蒐集自多台機器
	- 用來檢查是否有異常現象，如硬碟故障、網路壅塞、資安攻擊等
	- 用來監控系統資源使用量，如 CPU、記憶體、網路等
11. 不同檔案格式的效能差異
	- 通常需要考慮
    	- 讀取效能 vs 寫入效能
    	- 純文字格式 vs 二進位格式
    	- 開發環境: Pandas vs Scala vs Java
    	- 壓縮 vs 未壓縮
    - Pandas 不支援二進位的檔案讀寫
    - 純文字處理： Scala/Java 比 Python 快
    - Binary I/O 比 Text I/O 快
    - GZip 寫入速度比讀取慢許多，GZip level 1 比 level 6 快
    - 同樣採用 LZ4 fast 壓縮法，Binary I/O 仍舊比 Text I/O 快
    - LZ4 壓縮的速度與不壓縮非常接近

### Lecture 6: 結構化資料(Structured Data)

1. 大型資料庫
	- 大約只有 20% 的資料是結構化資料, 但近年來因為搜尋引擎與多媒體應用的緣故，比例正在下降中。
	- 關聯式資料庫(relational database) = 關聯的集合(a set of relations)
		- 由 Schema 與 Instance 組成
		- Instance 包括
			- 行的個數 - 集合元素的數目(cardinality)
			- 列的個數 - 維度(degree)
	- 關聯式資料模型(reational data model)，由 Relation 跟 Schema 組成
	- 資料庫(database) - 大量有組織的資料集合( a large orgnized collection of data)
	- 交易(transaction)用來修改資料
	- 不同資料庫的考量重點各有不同：
		- Accuracy 精準性
		- Consistancy 一致性
		- Durability 耐久性
		- Rich Queries 豐富查詢
		- Fast 查詢快速
		- Availability 可用性
		- Timeliness 及時
2. 關聯式資料庫的範例與討論
	- 關聯式資料庫的優點
		- 完整定義結構 (well-defined structure)
		- 維護一份索引，以加速查詢速度
		- 使用交易來確保一致性
	- 關聯式資料庫的缺點
		- 嚴謹而受限的結構
		- 使用大量硬碟空間來存放索引
		- 交易的執行速度緩慢
		- 對「空值(Spare data)」的支援不佳
3. SQL
	- Structured Query Language
	- 支援以下功能：
		- 新增、修改、刪除關聯
		- 新增、修改、刪除元素(tuples)
		- 支援使用查詢來找到符合條件的元素
4. JOIN in SQL
	- Cross JOIN - 笛卡兒積（Cartesian product）
5. Explicit JOIN in SQL
	- JOIN = INNER JOIN
6. Type of SQL JOIN
	- INNER JOIN
	- LEFT OUTER JOIN
	- RIGHT OUTER JOIN
7. JOIN in Spark
	- Spark SQL 跟 Spark DataFrames 支援的 join() 種類包括：
		- inner、outer、left outer、right outer, semijoin
	- 對於成對的 RDD, pySpark 支援:
		- join()、leftOutJoin()、rightOuterJoin()、fullOuterJoin()
	- 範例：成對的 RDD 做 JOIN
	```
    >>> x = sc.parallelize([("a",1),("b",4)])
    >>> y = sc.parallelize([("a",2),("a",3)])
    >>> sorted(x.join(x).collect())
	Value: [('a',(1,2)),('a',(1,3))]
    >>> x = sc.parallelize([("a",1),("b",4)])
    >>> y = sc.parallelize([("a",2)])
    >>> sorted(x.leftOuterJoin(y).collect())
    Value: [('a',(1,2)),('b',(None, 4))]
    >>> x = sc.parallelize([("a",1),("b",4)])
    >>> y = sc.parallelize([("a",2),("c",8)])
    >>> sorted(x.fullOuterJoin(y).collect())
    Value: [('a',(1,2)),('b',(4,None)),('c',(None,8))]
	```
    
### Lab 2 - Web Server Log Analysis with Apache Spark


#####資料集：[HTTP requests to the NASA Kennedy Space Center WWW server](http://ita.ee.lbl.gov/html/contrib/NASA-HTTP.html)

***Apache HTTP Server Log Format***

```
127.0.0.1 - - [01/Aug/1995:00:00:01 -0400] "GET /images/launch-logo.gif HTTP/1.0" 200 1839
```

 - `127.0.0.1` : IP address of the client (remote host)
 - `-` : Requested information of user identity from remote machine is not available.
 - `-` : Requested information of user identity from local logon is not available. (如果存在的話，會是一個userID)
 - `01/Aug/1995:00:00:01 -0400` : The time that the server finished processing the request.
 	- [day/month/year:hour:minute:second zone]
	- day = 2*digit
	- month = 3*letter
	- year = 4*digit
	- hour = 2*digit
	- minute = 2*digit
	- second = 2*digit
	- zone = (\`+' | \`-') 4*digit
 
 - `"GET /images/launch-logo.gif HTTP/1.0"` : The request line from the client is given in double quotes.
 	- [1] The request method from client.
 	- [2] The client requested resource.
 	- [3] Client used protocol.
 - `200` : Status code that the server sends back to the client.
 	- 2xx : Successful
 	- 3xx : Redirection
 	- 4xx : Client Error
 		- 400 Bad Request
 		- 401 Unauthorized
 		- 402 Payment Required
 		- 403 Forbidden
 		- 404 Not Found
 		- 405 Method Not Allowed
 	- 5xx : Server Error
 		- 500 Internal Server Error
 		- 501 Not Implemented
 		- 502 Bad Gateway
 		- 503 Service Unavailable
 		- 504 Gateway Timeout
 		- 505 HTTP Version Not Supported	
 - `1839` : The size of the object returned to the client. If no content it will be "-".
 
#####Useful Python Package


_**處理時間格式的工具`datetime`**_

```
import datetime

month_map = {'Jan': 1, 'Feb': 2, 'Mar':3, 'Apr':4, 'May':5, 'Jun':6, 'Jul':7,
    'Aug':8,  'Sep': 9, 'Oct':10, 'Nov': 11, 'Dec': 12}

s = "01/Aug/1995:00:00:01 -0400"

date_time = datetime.datetime(int(s[7:11]),
	month_map[s[3:6]],
	int(s[0:2]),
	int(s[12:14]),
	int(s[15:17]),
	int(s[18:20]))

## you can get value by using: date_time.day, date_time.hour, date_time.minute, date_time.tzinfo ...
```

_**處理正規表示法的工具`re`**_  [Patterns 查詢](https://docs.python.org/2/howto/regex.html)


```
import re

logline = "127.0.0.1 - - [01/Aug/1995:00:00:01 -0400] "GET /images/launch-logo.gif HTTP/1.0" 200 1839"

APACHE_ACCESS_LOG_PATTERN = '^(\S+) (\S+) (\S+) \[([\w:/]+\s[+\-]\d{4})\] "(\S+) (\S+)\s*(\S*)" (\d{3}) (\S+)'

match = re.search(APACHE_ACCESS_LOG_PATTERN, logline)

host			= match.group(1)
client_identd = match.group(2)
user_id       = match.group(3)
method        = match.group(5)
endpoint      = match.group(6)
protocol      = match.group(7)
response_code = int(match.group(8))

```

#####Useful PySpark API

- 若是函數忘了，可以查 [Spark Python API](https://spark.apache.org/docs/latest/api/python/pyspark.html)
- 或是查詢 [RDD class文件](https://spark.apache.org/docs/1.1.1/api/python/pyspark.rdd.RDD-class.html)

***常用輔助函式***

- count()、collect()、distinct()、cache()、take(num)

***針對key值排序***

- 使用 sortByKey
	- sc.parallelize(tmp).sortByKey(True, 1).collect()
- 使用 sortBy
	- sc.parallelize(tmp).sortBy(lambda x: x[0]).collect()
- 使用 takeOrdered
	- sc.parallelize(tmp).takeOrdered(10, lambda s: -1 * s[0])
		
***針對value排序***

- 使用 sortBy
	- sc.parallelize(tmp).sortBy(lambda x: x[1]).collect()
- 使用 takeOrdered
	- sc.parallelize(tmp).takeOrdered(10, lambda s: -1 * s[1])

***計算groupByKey()之後，value list的長度***

這個方法目的在於找出對於同一個key，distinct value共多少個

- rdd_pairs.map(lambda (key, value): (key, len(set(valu)))

> 注意前後有 cache 的 RDD 可以用 rdd.join() or rdd.union() 得到新的 RDD, 拿來計算複雜的除法

## Week #4
### Lecture 7: 資料品質、探索資料分析與機器學習

1. Data Cleaning 資料凈化
	- 用來處理「缺值(missing data)」、「元素解析度(Entity Resolution，如:IBM 與 International Business Machines)」、「單位不匹配(unit mismatch，例如其中一個資料集用美金計算，另一個資料集卻用歐元計算)」。
	- 從統計的觀點來看，骯髒的資料實務上並沒有辦法達到理想的取樣(ideal Samples)，因為：
		- 失真(distortion) - 資料在處理過程中有可能毀損
		- 選擇性偏差(selection bias) - 取樣的相似度太高
		- Left and Right Censorship - 使用者可能進入評審範圍，然後離開評審範圍
		- 相依性(Dependency) - 資料集理論上應該是各自獨立，實則不然(如:社交網路資料)
	- 因此，我們無法在兼顧簡易性與準確度的前提下，替不同的資料建立不同的模型
	- 從資料庫的觀點來看，骯髒的資料意味著：有些紀錄可能出現缺值、毀損、錯誤或重複的情況。但優點是結果一定是絕對的，因為有關聯式模型(Relational Model)。因此，改善資料品質，就能得到更好的答案。
	- 從領域專家的觀點來看，骯髒資料可能是：(A) 資料看起來不對勁 (B) 結果看起來不對勁 ，領域專家會想知道發生什麼事情。領域專家有一些無法言明的模型(implicit model)，可以讓他們拿來驗證資料。
	- 從資料科學的觀點來看，則同時包含了以上三種不同的觀點。
2. 資料品質問題：
	- 資料品質問題的根源，有可能是 (A) 來源資料本身就有問題、(B) 轉換造成資料毀損 (C) 乾淨的資料在整合過程中壞掉了，例如：合併不同資料集時，用錯方法 (D) 原本罕見的誤差(rare error)可能在轉換或合併之後而變成常見誤差(frequent error) (E) 乾淨的資料可能會發生「位元衰減(bit rot)」，也就是資料會隨著時間而遺失資料或失去精準度 (F) 以上的不同組合。
3. Numerical Outlier (數值上的離群值)
	- 現實生活中不可能出現修課年齡是低於五歲、高於一百歲。由於年齡是自己填報的，因此不能盲目地把這些資料放進資料分析的流程中，而需要先行剔除。
4. 資料凈化可以解決所有問題嗎？
	- 實際的案例發生在 1976 年，美國國家大氣研究中心觀測到南極洲臭氧層的大洞，然而科學家卻認為這些數值不合理，認定是機器故障造成的錯誤觀測值。然而實際上真的有臭氧層破洞。
5. 常見骯髒資料的問題：
	- 在解析純文字資料時，遇到不同分隔符號的問題
	- 名稱慣例(naming convention)，如：用 NYC 縮寫表示 New York City (紐約市)
	- 缺少必要欄位，如：在表格式資料中，缺少主鍵欄位(key field)
	- 違反主鍵定義(primary key violation)，例如在把非結構資料轉成結構時，或想要彙整額外的資料到資料庫中時
	- 因為授權或隱私考量，而無法使用該資料
	- 不同的資料表示法，例如：有時用羅馬數字 2 ，有時用文字二(Two)表示
	- 欄位因為內容太長而被截短
	- 可能會有重覆的紀錄
	- 格式問題，特別是日期，像美國與歐洲表示日期的方式有所不同
6. 資料品管的意義：
	- 由於處理資料的方式不同，對資料品質的要求也各有不同。如果我們無法理解資料背後的規則，即使擁有資料也是無用的。
	- Data Suitability (資料適用性)：我們是否可以在可用的資料中找到問題的答案呢？我們可能只能取得近似資料（proxy data），也可能缺少做決策必要的相關資料。
	- Data Quality Continuum (資料品質的連續性)：資料與資訊不是靜態的，資料流是一系列資料擷取(data collection)與應用(usage)的流程
7. **Data Gathering (資料蒐集)**
	解決資料蒐集的問題分為兩種：
    (A) Preemptive (具優先權)：設計一個處理架構，內建資料正確性檢驗。並設計一個流程管理，鼓勵資料的正確性、共享性與管理性(steward)，必須要有人對資料內容負責。
    (B) Retrospective (具追溯性)：著重在清理上（cleaning focus），也就是去除重複、移除不好的資訊、比對姓名與住址的正確性、以及欄位的正規化。著重在特徵診斷上(diagnostic focus)，也就是讓資料蒐集過程中的錯誤診斷變成自動化。
8. **Data Delivery (資料傳遞)**
	- 資料傳遞的過程也可能造成資料品質的問題，例如：
		- 使用不正確的流程
			- 例一：不恰當的合計(Aggregation)
			- 例二：將 NULL 誤轉成預設值
		- 發生資料遺失的情形
			- 緩衝溢位(Buffer Overflow)
			- 傳輸不完整
			- 缺少完整性的檢查(integrity check)
	- 可能解法：
		- 透過可靠的通訊協定，如使用 Relay Server 來儲存跟驗證資料正確性
		- 使用 checksum (校驗和)或 verification parser (驗證分析程序)
		- 檢查上傳檔案是否符合預期的特徵
		- 檢查資料流(data stream)與處理程序(processing step)之間的關聯性
		- 要求你的資料供應者，提供資料品質的保證
9. **Data Storage (資料儲存)**
	- 問題根源：存放該資料的物理儲存裝置
	- 解決方法：重複存放於不同的物體儲存裝置 (Redundantly)
	- 邏輯儲存(Logical Storage)可能會遇到的問題：
		- 缺乏屬性資料(Poor metadata)
		- 不恰當的資料模型(inappropriate data model)
			- 例如不正確的日期戳記、不正確的資料正規化
		- Ad-hoc modification
			- 例如為了讓資料可以套用到 GUI 而對資料結構進行的改變
		- 硬體或軟體的限制
			- 例如 Y2K 千禧蟲的問題
	- 解決方法：
		- 追蹤屬性資料：紀錄並公佈資料的規範
		- 良好的前期規劃：假設所有可能會發生的壞事
		- 進行資料探索：使用資料探勘工具來驗證資料的正確性(Ex. 資料是否符合特定規範、是否有什麼變更)

10. **Data Retrieval (資料修復)**
	- 資料探索(Data Exploration)的可能問題：
		- 無法正確理解來源資料或衍生資料
		- 常見的人為錯誤：該用聯集(Outer JOIN)的時候用交集(Inner JOIN)、不知道 NULL 代表的意義
		- 運算上的限制：運算完整的紀錄，代價太昂貴
		- 不相容：將資料以 ASCII 存放，而非 unicode 或 UTF-8
	- 資料探勘(Data Mining)的可能問題
		- Scale (延展性) 與效能問題
		- 黑盒子
		- 缺乏領域專業
		- 過於隨便的觀察實驗法(基於偏見而使用某些數字)
	- 解決方法：
		- 確認哪一種模型與技術是恰當的
		- 嘗試找出資料中的臭蟲並發展領域專業
		- 持續進行分析(continuous analysis)，確定結果是否穩定。如果有改變，會如何改變？
		- 確保「可說明性(accountability)」，
	- 資料品質的限制(Data Quality Constraints)
		- 可以透過 Schema 來揪出資料品質的問題
12. **Data Integration (資料整合)**
	- 為了解決資料品質的問題，建議使用多種不同的方法，因為無法確保單一方法可以解決所有的問題
		- Process Management (流程管理) - 確保流程是正確的
		- Statistics (統計) - 著重在分析，可以找出並修正資料不正常的地方
		- Database (資料庫) - 著重在關聯(Relationship)，確保一致性
		- Dormain Expertise (領域專業) - 瞭解資料的意涵，知道為什麼需要詮釋這份資料
	- 資料整合的可能問題：
		- 異質資料：沒有共通的 Key (鍵)，欄位格式不一致
		- 不同的定義：例如，客戶代表的意義，有時可能是一個帳號、一個人或一個家庭
		- 時間不同步
	- 資料整合面臨的挑戰：
		- 如何去除重複的資料
	- 案例：Entity Revolution
		- Lab 3 要做的事情，就是有兩份資料，一份從 Google 資料爬下來的商品清單，一份是從 Amazon 網站抓下來的商品清單。實際上這兩份是相同產品清單，只是格式不一致。
13. 去除重複資料的範例
	- 商品清單中有兩筆 iPhone 2 ，但實際上是同一個商品
	- 轉換成標準的地址格式 - 郵局提供的服務，透過把住址轉換成標準格式，可以確保不同的表示法，是否為同一個住址
	- 更複雜的技術包括：使用多重欄位、使用與其他欄位的關聯性、或分群演算法(clustering)
	- 還有很多問題，例如：
		- 該視為「住址」？或者「數字，街道，城市」？
		- 單位是什麼？
		- 不同版本？或者 Schema 有所異動？
	- 解決方法：
		- 商業工具
		- Data Browsing and exploration

### Lecture 8 : 探索資料分析與機器學習

1. Exploratory Data Analysis (探索資料分析)
	- 統計分成「敘述統計(Descriptive Statistics)」 與 「推理統計(Inferential Statistics)」兩種
	- 敘述統計
		- 例如：中位數(Median)
		- 用來描述資料，但無法進行更進一步的推論
	- 敘述統計
		- 例如：T 檢定(t-test)
		- 可以基於資料進行更進一步的推論
		- 可用來強化機器學習與預測的技術
	- 商務問題範例：
		- 簡單的敘述統計：哪些人是最高獲利的客戶？
		- 假設檢定(Hypothesis Test)：這些客戶對公司的價值有什麼差異？
		- 市場區隔/客戶分類(Segmentation/Classification))：這些客戶的共通特徵是什麼？
		- 預測(Prediction)：這個新的客戶是否會成為可獲利的對象？若是，可獲利多少？
	- 通常當我們在詢問商務問題時，是想知道因果關係(causal)。
		- 例如：如果我看到這個廣告，會有什麼結果？
	- 若詢問相關的問題(correlational question)，會比較容易回答
		- 例如：過去當我看到這樣的廣告，發生了什麼事？
	- 監督式學習(Supervised Learning)：分類(Classification)與回歸分析(Regression)
	- 非監督式學習(Unsupervised Learning)：分群(Clustering)與降維(Dimension reduction)
	- 註：通常非監督式學習會使用於一個大型的監督式學習問題中。例如：影像辨識類神經網路的自動編碼器(auto-encoder)

	| Supervised Learning | Unsupervised Learning |
    |---------------------|-----------------------|
    | kNN (k Nearest Neighbors)	| Clustering |
    | Naive Bayes | Factor Analysis |
    | Logistic Regression | Latent Dirichlet Allocation |
    | Support Vector Machines (SVM) | |
    | Random Forests |  |

2. 探索資料分析(Exploratory Data Analysis，簡稱 EDA)
	- 探索資料分析(1977年的一本書)是基於 1960 年代貝爾實驗室發展出來的洞察(Insight)。
	- 是用來視覺化與歸納資料的技術，例如：資料可以告訴我們什麼？
	- 目前是「驗證資料分析(Confirmatory Data Analysis)」的對比
	- 導入了許多基礎的技術，像是：五數概括法（Five-number summary）、箱形圖(box plot)、莖葉圖(Stem-and-Leaf Diagram)
	- 其中，五數概括法（Five-number summary）即用下面的五個數來概括數據：
		- 最小值
		- 最大值
		- 第1四分位數(Q1)；
		- 中位數(Q2)；
		- 第3四分位數(Q3)；
	- 然而，五數概括法會有它的問題，在 1973 年「Anscombe's Quartet」的文章中指出四個不同的資料集(x,y)，其 x 與 y 數值的平均值跟樣本變異數(sample variance)，還有線性回歸都是一樣的。
	- 結論：
		- **在分析之前，最好先看一下資料的分佈圖**。
		- 基本的統計往往無法紀錄現實世界的複雜度

3. R 統計語言：
	- R 統計語言是改良自貝爾實驗室為了探索資料分析而研發的 S 統計語言
	- 其設計理念是允許用互動式的方式，進行資料的探索與視覺化
	- R 語言包含了眾多統計模型，而 CRAN 套件庫則提供了許多開放原始碼的統計模型。
	- 一些統計名詞的定義：
		- 平均值(Mean)代表一堆數值的平均
		- 變異數(Variance)用來量測這些數值分佈的寬度
		- 標準差(Standard deviation)等於變異數的平方根
		- 常態分佈(normal distribution)是由平均值與變異數決定
	- 在機率理論中，中央極限定律(central limit theorem)指出當樣本數 n 趨近於無窮大時，這 n 個獨立樣本的集合(或平均值)分佈會呈現常態分佈。
	- 一般 T 檢定與 ANOVA (變異數分析)會假設你的資料集呈現常態分佈，但這些檢定也受樣本數影響。當樣本數很大的時候，這些檢定一樣可以正常運作，即使資料集不是呈現常態分佈。

4. 分佈(Distribution)
	- 許多統計工具都會假設資料集是常態分佈，但現實往往不是如此。
	- 因此，最好先畫資料的直方圖(histogram)
	- 泊松分佈(Poisson distribution):適合於描述單位時間內隨機事件發生的次數的機率分佈。
		- 在一本書中，特定詞出現的頻率
		- 固定時間內，到訪特定網站的次數
		- 一個小時內，網站的點擊次數
	- 指數分佈(Exponential distribution)
	- Zipf/Pareto/Yule distribution
	- Binomial/Multinomial distribution
	- **在套用數值模型前，請先瞭解資料集的分佈情形**

5. Rhine Paradox
	- Joseph Rhine 是 1950 年代的心理學家，他做了一個實驗，讓每個人猜猜 10 張紙牌是紅色或藍色。結果發現 1000 人有 1 人可以正確猜中 10 張紙牌的顏色。然而，當他重複請那些完全猜中的「異能者」再做一次實驗時，卻都失敗了。所以他做了結論說：「告訴異能者他們有超能力，會使他們的超能力喪失」。
	- 這個結論錯誤之處在於紙牌的排列組合是二的10次方，共有 1024 種。找 1000 個人，有一個猜中的機率是 0.98。

6. Spark MLlib
	- 類似 Scikit-learn 的機器學習函式庫，可與 NumPy 搭配使用
	- 提供分類(Classification)、回歸(Regression)與眾多不同的機器學習演算法
	- Lab 3 會做協同過濾(Collaborative Filtering)，基於使用者過去對電影的評價，預測其他電影的評價。
