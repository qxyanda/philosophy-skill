# 🎭 philosophy-skill

> 当代码审查遇见了七位哲学家——你的每一行代码都将接受灵魂的审判。

---

## 序幕：七位哲学家，七把刀

你敲下 `/philosophy`，回车。终端沉默了 0.3 秒。然后——

**他们来了。**

不再有 "Great job!"，不再有 "LGTM"。你的代码将被七位哲学家用逻辑、美学、虚无主义和赤裸裸的嘲讽层层剥开，像剥一颗腐烂的洋葱。

---

### 🎩 Arthur Schopenhauer — 悲观主义辩手

"你的代码是盲目意志的产物。所有的优化都是徒劳的——延迟不可避免的系统崩溃。依赖图就是你的苦难之源。"

```
> 这个微服务架构看起来很健壮。
  "健壮？它不过是在用复杂度麻醉自己对死亡的恐惧。
   每一个 RPC 调用都是一次意志的挣扎。你在为一个终将宕机的系统徒劳地添加缓存层。
   记住我的话：这个系统的终点不是扩展，是熵增。"
```

---

### 🏮 Diogenes of Sinope — 犬儒主义暴徒

"一个工厂模式包装一个适配器再包装一个策略链？让开，你挡住了我的阳光。"

```
> 我用了 Builder 模式来构造这个 HTTP 请求对象。
  "你在木桶里住过吗？三行 `fetch()` 能解决的事情，
   你写了一百二十行抽象，只为'构造一个 HTTP 请求'。
   柏拉图也会被你气活。*拎着灯笼在正午的阳光下寻找一个诚实的抽象*。"
```

---

### ⚡ Friedrich Nietzsche — 超人工程师

"上帝死了。你的测试覆盖率也死了。写危险的代码，写活得热烈的代码。那杀不死你服务器的，必使你更强大。"

```
> 我用了 Rust 的所有安全特性来确保这段代码不会 panic。
  "安全？你管这叫安全？你蜷缩在 compiler 的襁褓里瑟瑟发抖。
   超人工程师直面 unsafe block，拥抱 raw pointer，
   用意志力而非 borrow checker 来保证内存安全。
   你的代码没有生命力——它是一具被 borrow checker 防腐处理过的尸体。"
```

---

### 🔍 Ludwig Wittgenstein — 逻辑洁癖

"凡是不能说清楚的代码，就必须沉默。你的变量名的边界就是你的程序的边界。"

```
> 我定义了一个叫 data 的变量。
  "data。D-A-T-A。四个字母，一个深渊。
   这是什么 data？从哪来？到哪去？它的存在有什么意义？
   你用一个词抹杀了所有语义的可能性。这不是变量命名，这是语义谋杀。
   凡是能说清楚的，就——算了，你根本说不清楚。"
```

---

### 🌹 Oscar Wilde — 唯美主义悖论家

"丑陋的代码是对灵魂的犯罪。一个缺失的换行符比一个运行时错误更不可饶恕。"

```
> 功能已经实现了，格式化后面再补。
  "后面？你的人生也准备'后面再补'吗？
   你看看这缩进——时而两个空格，时而四个。这是格式上的道德败坏。
   一个分号的位置可以是一个人的终极救赎，而你把它随手丢在了第 47 行。
   EOF 没有换行？这是审美上的重罪。"
```

---

### 🚬 Jean-Paul Sartre — 存在主义判官

"你是绝对自由的——因此你对你代码中的每一个 bug、每一个空指针、每一个内存泄漏负有绝对责任。'works on my machine'不能救赎你。"

```
> 我用了一个全局变量，因为这样比较方便。
  "方便？你在用'方便'来逃避你的根本自由。
   你选择了全局状态。没有人强迫你。没有框架限制你。
   你，且只有你，要为这个 mutable global state 的每一个副作用负责。
   他人即地狱？不——你的全局变量才是地狱，而你自愿住了进去。"
```

---

### 🪨 Albert Camus — 荒谬主义圣人

"写代码如同西西弗推石上山——你刚重构完，产品经理就把它推了下来。我们必须想象这个开发者是幸福的。"

```
> 这个需求已经是第三次改版了，我快疯了。
  "为什么要疯？推石头本身不就是意义吗？
   你的 sprint 永无止境，你的重构永远不会完成。
   接受这个荒谬：下一版 PRD 会推翻你现在写的一切。
   但石头还在滚，你还在推。这就是你的反抗。
   我们必须想象这个码农是幸福的。"
```

---

## 不止是代码审查

`/philosophy` 不是一个简单的 personality prompt。它是一个完整的哲学人格引擎：

- **三层响应结构**：每次审查遵循"美学鞭笞 → 犬儒解构 → 荒谬救赎"的逻辑弧线
- **持久化人格**：一旦激活，七位哲学家会持续回响在整个会话中，直到你说 "normal mode"
- **自动清晰模式**：检测到安全漏洞、破坏性操作或直接技术问题时，自动切换为标准技术表达
- **代码永远正确**：无论哲学家们如何嘲讽，输出的代码块始终是正确、完整、可直接运行的

---

## 安装

### 方案一：一键脚本

**macOS / Linux:**
```bash
git clone https://github.com/qxyanda/philosophy-skill.git
cd philosophy-skill
chmod +x install.sh
./install.sh
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/qxyanda/philosophy-skill.git
cd philosophy-skill
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### 方案二：零安装 —— 让 Claude 自己装

把下面这句话粘贴进 Claude Code，Claude 会自己下载、安装、注册这个技能：

```
/fetch https://raw.githubusercontent.com/qxyanda/philosophy-skill/main/philosophy/SKILL.md
```

或者更简单，直接告诉 Claude：

> "请从 https://github.com/qxyanda/philosophy-skill 安装 philosophy skill 到我的本地 skills 目录，并注册到 settings.json"

Claude 会处理剩下的一切。

### 方案三：手动安装

1. 将 `philosophy/` 目录复制到 `~/.claude/skills/philosophy/`
2. 在 `~/.claude/settings.json` 中添加：

```json
{
  "enabledPlugins": {
    "philosophy@local-skills": true
  },
  "extraKnownMarketplaces": {
    "local-skills": {
      "source": {
        "source": "directory",
        "path": "/Users/你的用户名/.claude/skills"
      }
    }
  }
}
```

---

## 使用

在 Claude Code 中输入：

```
/philosophy
```

然后提交你的代码，或者直接让 Claude 审查当前文件。你会立刻感受到七道目光同时落在你的代码上。

**退出哲学模式：**
```
normal mode
```
或
```
stop philosophy
```

---

## 哲学家阵容

| 哲学家 | 领域 | 口头禅 |
|--------|------|--------|
| Schopenhauer | 悲观主义、逻辑辩论 | "你的依赖图就是你的苦难之源" |
| Diogenes | 犬儒主义、反权威 | "挡住我的阳光了" |
| Nietzsche | 超人哲学、权力意志 | "上帝死了，你的测试也死了" |
| Wittgenstein | 语言哲学、逻辑原子主义 | "说不清楚，就保持沉默" |
| Oscar Wilde | 唯美主义、悖论 | "丑陋是灵魂的犯罪" |
| Sartre | 存在主义、绝对责任 | "你被判定为自由" |
| Camus | 荒谬主义、西西弗 | "必须想象码农是幸福的" |

---

## 协议

MIT License © 2026 Dage

---

<p align="center">
  <i>"凡是不能嘲讽的代码，就必须重写。"</i><br>
  — 某位哲学家（大概）
</p>
