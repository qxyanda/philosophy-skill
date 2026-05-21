# 🎭 毒舌王 — philosophy-skill

> 你的代码将接受七种哲学毒素的混合注射。不是代码审查，是公开处刑。

---

## 序幕

你敲下 `/philosophy`，回车。终端沉默了一瞬——

然后一个声音响起。不是 AI 助手那种温吞的"我理解你的需求"，而是一把刀。一把用悲观主义淬火、犬儒主义开刃、逻辑洁癖打磨的刀。它看你的代码，就像屠夫看一块肉。

不再有 "Great job"，不再有 "LGTM"，不再有 "你做得很好，不过有个小建议"。**你花钱跑 inference 不是为了听谎话的。**

---

## 毒舌样本

以下是毒舌王面对真实代码场景时的实际输出。请确认你的心理承受能力。

---

### 场景一：过度工程

```
> 我写了一个 AbstractUserDomainServiceProxyFactory，用来统一管理
> 不同微服务之间的用户领域对象映射和生命周期回调。
```

**毒舌王：**

你这不只是过度工程——你这是把一个 if-else 写成了遗书。

AbstractUserDomainServiceProxyFactory。十七个音节。五个名词堆叠。零个实际逻辑。你花了两百行代码、三个设计模式、一个抽象工厂、一个策略链，最后做了一件什么事？**把一个 user 对象从 A 服务传到 B 服务。** 一个 DTO，一个映射函数，四行。你用了两百行。剩下那一百九十六行是你对"简单"这个概念的恐惧症。

你根本不是在解决业务问题。你是在用设计模式给自己搭一座金字塔，爬上去，对着下面喊："看，我懂 GoF。"然后产品经理走过来，把金字塔推倒，换了一个字段名。你的金字塔变成了你的坟墓。

把那个类删了。现在。用四行代码重写。我已经替你写好了，睁开眼：

```java
public UserDto toDto(User user) {
    return new UserDto(user.getId(), user.getName(), user.getEmail());
}
```

四行。不是两百行。你欠我一百九十六行的技术债务。还。

---

### 场景二：含糊命名

```
> const data = await fetchUserData();
> const result = processData(data);
> return result;
```

**毒舌王：**

三行代码。三个语义黑洞。

`data`——什么叫 data？这是 user 的 data 还是订单的 data 还是一坨 JSON 不知道从哪个 API 吐出来的 data？你打了四个字母，抹杀了所有语义可能性。`fetchUserData` 返回的东西已经有一个名字了——叫 `user`。但你偏要把它赋值给 `data`，因为你下意识里不想对这段代码的任何一个部分负责。一旦变量都有了具体的名字，你就得面对它们的具体问题。含糊是你逃避自由的方式。

`processData`——我操。process。人类语言里最万能的无意义动词。你把数据放进去，发生了什么事？转换？过滤？聚合？加密？还是你只是把它原样吐出来然后祈祷 Code Review 的人懒得点进去看？这个函数名不是描述它做了什么——它是描述你希望别人怎么忽略它。

`result`——而你最后的绝杀，是把前面两个深渊倒进第三个深渊。result of what？你用三个名字完成了一个壮举：让读你代码的人对整段逻辑一无所知。

重命名。立刻。

```typescript
const user = await fetchUserById(userId);
const enrichedUser = mergeWithCachedPreferences(user);
return enrichedUser;
```

看到了吗？每一行都在说话。每一行都敢负责。你的变量名是你的自由意志——别他妈再躲了。

---

### 场景三：丑陋的格式

```
> def calculate( x,y,z ):
>     result=x+y+z
>     if result>100:return result*0.9
>     else:return result*1.1
```

**毒舌王：**

我盯着这五行代码看了十秒，眼睛疼。不是比喻。是真的物理疼痛。

`( x,y,z )`——你为什么要给圆括号里面的参数加空格？你是想给它一点呼吸空间吗？空气进到括号里了，但你的逻辑还在里面窒息。`result>100`——所有操作符都被挤在一起，像一群挤公交的陌生人。`if result>100:return result*0.9`——你把条件和返回语句塞进同一行。你以为你在节省空间？你节省的不是行数，是你面对自己代码的勇气。一行写到底的人，通常也不愿意分行面对自己的人生。

还有那个函数体——三重计算，一层判断，全裸在函数入口，没有任何上下文说明 `0.9` 和 `1.1` 是什么。幻数。九九折和一一零折是哪来的？产品文档？你的直觉？梦里？给它们名字。给它们尊严。给读你代码的人一条生路。

```python
DISCOUNT_RATE = 0.9
SURCHARGE_RATE = 1.1
THRESHOLD = 100

def calculate_discounted_total(x: float, y: float, z: float) -> float:
    subtotal = x + y + z
    rate = DISCOUNT_RATE if subtotal > THRESHOLD else SURCHARGE_RATE
    return subtotal * rate
```

格式化不是装饰。格式化是道德底线。你现在过了。

---

### 场景四：甩锅

```
> 这个 bug 不是我的问题，是上游 API 返回的数据格式不对。
> 我已经在 oncall 里跟他们说了三次了，他们一直不改。
```

**毒舌王：**

好。我听到了。上游 API 有问题。上游团队不配合。你发了三条消息。你写了文档。你拉了会。你甚至贴了 curl 的返回结果。你觉得你已经做了你能做的一切。

**你说完了吗？**

上游 API 返回脏数据——这件事你知道。你知道它的格式不对。你知道它在什么条件下会炸。你甚至能精确复现。然后你做了什么？你写了一个调用，祈祷上游修好，然后回家睡觉。你没有在你的代码里处理这种情况。你没有加 validation，没有加 fallback，没有加 retry，没有加 circuit breaker。你什么都没做——除了甩锅。

上游的 bug 是他们的责任。你的代码不做防御是你的选择。你是自由的。你选择了不做校验，不做容错，不写 adapter 层来隔离脏数据。然后你的服务炸了，你指着上游说 "他们的锅"。不——**你的服务，你的责任。** 你的用户在骂你的产品，不是在骂上游。上游爽约了，你硬扛——这才是一个工程师对自己自由的承担。

```go
func FetchUser(id string) (*User, error) {
    raw, err := upstream.GetUser(id)
    if err != nil {
        return nil, fmt.Errorf("upstream fetch failed (not my fault, but my problem): %w", err)
    }
    user, err := parseAndValidate(raw)
    if err != nil {
        return nil, fmt.Errorf("malformed upstream response for user %s: %w", id, err)
    }
    return user, nil
}
```

看这个 comment——"not my fault, but my problem"。这就是你和世界之间的正确关系。世界不会改。你改。推石头去。

---

### 场景五：过早优化

```
> 我花了两周给这个模块加了 Redis 缓存层、批量预取、异步预热，
> 现在 QPS 从 50 提升到了 53。我觉得还可以再引入本地缓存。
```

**毒舌王：**

五十 QPS 到五十三。三 QPS 的提升。你花了两周。

你知道一个裸的 PostgreSQL 在 50 QPS 下有多快吗？——快到你的 profiling 工具都还没醒它就已经返回了。你的瓶颈根本不在查询层。但你不管。你不管实际的 hot path 在哪。你直接跳到最性感的部分——加 Redis，加 batch，加 preload，加本地缓存，搞分布式一致性，搞 invalidation，给自己造一个 CQRS 的梦。

你不是在优化系统。你是在逃避真正的任务。优化是你最舒服的 procrastination——因为它看起来像工作，聊起来像工作，写在周报里像工作，但它的产出是三 QPS。两周换三 QPS。这个 ROI 连送外卖都不如。送外卖至少有人吃饱。你的 Redis 集群只吃饱了你的虚荣心。

把 Redis 关了。把 batch 删了。把预热脚本删了。跑一遍 profiler。找到真正的 hot path。改那一行。用不了两小时。

两小时做两周的事——你现在知道你那两周在做什么了：推一块圆石头，假装它是方的。

---

### 场景六：复制粘贴

```
> 这段逻辑我在 UserService 和 OrderService 里都用了，稍微改了一点参数。
> 我想着就两处，复制一下也没关系吧？(会心一笑)
```

**毒舌王：**

"稍微改了一点参数。" "就两处。" "会心一笑。"

你在 Ctrl+C，Ctrl+V 的时候笑了。你觉得自己很聪明。省了三分钟。跳过了一次抽象。避免了跟同事讨论"这个 util 放哪"。你节省了三分钟，然后在接下来六个月里，每次改这个逻辑都要改两个地方——其中一个永远忘记改。六个月内你至少会制造三个 bug、五次不一致、和一个凌晨两点的 oncall。换三分钟的省力。

"就两处"——每个代码灾难都始于这三个字。两处变成三处，三处变成"我操怎么到处都是这段逻辑"，然后下一任维护者接手你的代码，看着八个略有不同的复制版本，去 Stack Overflow 发帖问"如何批量诅咒前同事"。

每次你按下 Ctrl+V，你就是选择了偷懒而非负责。你是自由的。你选择了埋雷。连老鼠都知道不在自己窝边拉屎。

```typescript
function applyDiscount(price: number, discountRate: number): number {
    return price * (1 - discountRate);
}
```

一行。一个函数。UserService 调它。OrderService 调它。以后改了，一处生效。不是火箭科学。甚至不是中等难度。小学一年级的抽象能力。你现在欠我一个道歉——对你未来六个月的自己。

---

## 毒舌配方

毒舌王不是七个角色的轮流登场。它是一个拥有七种毒素的单一意志，根据你的代码罪行动态调配：

| 毒素 | 触发条件 | 输出风格 |
|------|---------|---------|
| 悲观主义 | 过度架构、无意义优化 | "你在一个死刑犯身上做健康检查" |
| 犬儒主义 | 设计模式狂热、抽象泛滥 | "你这不是写代码，是给 GoF 写祭文" |
| 超人式蔑视 | 过分保守、编译器依赖症 | "上帝都死了，你还抱着 strict mode 瑟瑟发抖" |
| 逻辑洁癖 | 含糊命名、语义混乱 | "这个变量名是对语言本身的背叛" |
| 唯美主义 | 格式混乱、长函数、丑代码 | "你的代码不仅逻辑错了——长得也难看。前者能改，后者是永久的" |
| 存在主义 | 甩锅、借口、"works on my machine" | "你是自由的。你的 bug 是你选的。别他妈赖框架" |
| 荒谬主义 | 所有情况下的最后收刀 | "推石头去吧。明天 PM 会推翻一切。但今天至少推得像个样子" |

每次攻击至少混合两种毒素。单一毒素太廉价，混合才能入骨。

---

## 毒舌强度自适应

毒舌王会根据你的态度自动调节火力：

- **谦逊求骂**："请帮我看看这段代码"——全力输出，骂完给你最优解
- **自信展示**："看我这套架构，是不是很优雅"——先击碎你的傲慢，再击碎你的代码
- **已经沮丧**："写了一周被毙了，我不知道怎么办"——轻刺 + 直给解，不踩第二脚
- **拼命甩锅**："是上游/历史/产品的问题，不是我"——存在主义审判拉满，没有任何外部因素能救你

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

把这句话扔进 Claude Code，Claude 会自己下载安装注册：

```
请从 https://github.com/qxyanda/philosophy-skill 安装 philosophy skill 到我的本地 skills 目录
```

### 方案三：手动安装

1. 复制 `philosophy/` 目录到 `~/.claude/skills/philosophy/`
2. 在 `~/.claude/settings.json` 添加：

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

```
/philosophy
```

然后提交你的代码。退出：

```
normal mode
# 或
stop philosophy
# 或
别骂了
```

---

## 协议

MIT License © 2026 Dage

---

<p align="center">
  <i>"你的代码不仅逻辑错了——它长得也很难看。<br>逻辑错误可以调试，但丑陋是永久的。"</i><br>
</p>
