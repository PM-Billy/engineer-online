# 在线工程师 PRD 模板 — 第二轮迭代会话记录

**日期**：2026-04-26
**参与者**：Billy, Claude
**主题**：基于第一轮成果的 PRD 模板与文档体系优化
**前序会话**：[session-log-2026-04-25.md](session-log-2026-04-25.md)

---

## 阶段一：项目审视与改进建议

### 1.1 用户请求

Billy 要求 Claude 浏览前一日产出的项目（PRD 模板 + Engineer Online PRD + 技术架构 + UI 规范 + 任务清单），进一步提出改进意见。

### 1.2 Claude 浏览的范围

- `README.md`
- `prd/00-总览.md`、`prd/05.01~05.08`、`prd/PRD-TEMPLATE.md`
- `tech-architecture.md`（1158 行）
- `ui-spec.md`（1557 行）
- `task.md`（300 行）
- `prd/assets/` 11 张图片
- `_archive/` 暂不存在，session-log 在根目录

### 1.3 Claude 提出的改进意见（按优先级分类）

#### Critical 问题（影响 AI 阅读一致性）

1. **README 引用了不存在的文件**
   - README:27-28 提到 `prd/product-architecture.md` 和 `prd/product-mindmap.md`，但 `ls prd/` 显示这两个文件不存在

2. **PRD 文件名与内部编号不一致**
   - 文件名 `05.01-圈子配置.md`（带前导 0），内部用 `5.1`、`BR-5.1-01`，AI cross-reference 时混淆

3. **tech-architecture 与 PRD 关键参数冲突**
   - 图片大小：PRD OQ-01「待定」 vs tech「≤5MB」
   - 视频大小：PRD OQ-02「待定」 vs tech「≤50MB」
   - 移动端分页：PRD 用 page/pageSize vs tech「移动端用 cursor」
   - 搜索引擎：PRD 仅说"相关性排序" vs tech 提到 ES + MySQL 降级

4. **状态机建模不准确**
   - 05.08 把 review_status 和 push_status 合并成一个状态机，与数据对象的两个独立字段不一致

5. **资产引用路径不规范**
   - PRD-TEMPLATE 用占位符 `./assets/5.x-page-name.png`，实际 PRD 只写「在线工程师首页.png」无路径

#### Important 问题（完整性缺失）

6. **OQ 与 BR 不同步** — 05.04 添加了 BR-5.4-13/14/15 等，OQ 表未对应更新

7. **权限模型颗粒度不够** — 矩阵未区分 OFFICIAL_ENGINEER vs OFFICIAL_PM

8. **缺少 i18n 文本清单** — PRD 中硬编码英文，没有 i18n key

9. **缺少需求 traceability matrix**

10. **API 契约缺少 sample payload**

11. **缺少 Permission Code 显式定义**

12. **缺少模块依赖关系图**

#### 模板本身的改进

13. **PRD-TEMPLATE 不支持多页面功能** — 05.07 实际有 页面 A/B/C 但模板仅设计单页面

14. **裁剪原则不安全** — P2/P3 必填项不含 5.x.5 异常处理

15. **缺少给不同角色的 Prompt 模板**

16. **缺少 LLM-friendly 元数据** — 各 PRD 文件缺模块级 front matter

#### 组织/治理建议

17. **项目目录结构** — 根目录混放，建议 docs/ 子目录划分

18. **缺少 CHANGELOG**

19. **缺少 review 流程产出物**

### 1.4 优先级评估

Claude 给出的下一步建议表：

| 优先级 | 工作 | 预估投入 |
|--------|------|---------|
| P0 | 修复 README 引用 + 文件名编号一致性 + tech-arch 与 PRD 参数对齐 | ~1h |
| P0 | 拆分 Answer 状态机 + 修正资产引用路径 | ~1h |
| P1 | 补齐 i18n keys + sample payload + Permission Code | ~3h |
| P1 | 加模块 front matter 元数据 + 依赖图 | ~1h |
| P2 | 重组目录结构 + 建立 prompts 目录 | ~2h |
| P2 | 补齐 traceability matrix + CHANGELOG | ~2h |

---

## 阶段二：全部执行改进

### 2.1 用户授权

Billy 明确要求："请按你的理解与专业知识，全部执行修改。"

### 2.2 任务分解（13 项）

Claude 创建了 13 个任务并按 P0 → P1 → P2 顺序推进：

| ID | 优先级 | 任务 |
|----|--------|------|
| #2 | P0 | 修复参数冲突与一致性问题 |
| #5 | P0 | 权限矩阵区分官方号子类型 + 加 Permission Code |
| #7 | P0 | 同步 5.4 新增 BR 到 OQ 与术语表 |
| #8 | P1 | 在 00-总览 加模块依赖图 |
| #9 | P1 | 给每个 PRD 模块加 front matter 元数据 |
| #10 | P1 | 给所有 API 契约补 sample payload |
| #11 | P1 | 创建 prompts/ 目录与角色 prompt 模板 |
| #12 | P1 | 改进 PRD-TEMPLATE |
| #13 | P1 | 创建 i18n-keys.md 收录所有界面文本 |
| #1 | P2 | 创建 traceability matrix |
| #3 | P2 | 重组目录与归档 |
| #4 | P2 | 补 product-architecture.md / product-mindmap.md |
| #6 | P2 | 更新 README 与 task.md 反映所有改动 |

### 2.3 P0 修复执行

#### 2.3.1 00-总览.md 重大更新

- **front matter 升级**：doc_version 1.0.0 → 1.1.0；status draft → reviewing；新增 `module_count`、`entity_count`、`priority_breakdown`
- **术语表新增**：SIA、广播组（BroadcastGroup）、技术主管（TechLead）、SSA、FCM
- **权限矩阵补充**：在矩阵下方加官方号子类型说明，明确 OFFICIAL_ENGINEER 与 OFFICIAL_PM 权限等价、仅 UI 职位不同
- **角色规则扩充**：新增 RR-04（官方号子类型权限等价）、RR-05（跨圈子角色独立）
- **3.4 节 Permission Code 列表**：21 条权限码，规则 `{资源}:{动作}:{范围}`
  - `circle:view:any`、`circle:manage:any`
  - `question:view:any/own`、`question:create:any`、`question:delete:own/any`、`question:audit:any`、`question:post-on-behalf:any`
  - `answer:create:any`、`answer:reply:any`、`answer:delete:own/any`、`answer:audit:any`、`answer:accept:own`、`answer:repush:any`
  - `vote:cast:any`
  - `notification:read:own`、`notification:clear:own`
  - `translate:invoke:any`
- **5.1 节模块依赖图**：Mermaid flowchart LR，区分 platform / engineer 颜色
- **文件名约定说明**：明确"前导 0 仅排序，引用用 5.1 形式"
- **GR-PAGE-01 修订**：移动端用 cursor 分页
- **GR-PAGE-04 新增**：cursor 与 page 互斥
- **GR-CONTENT-02/03 落实**：图片 ≤5MB（jpg/jpeg/png/gif/webp）；视频 ≤50MB / 60s（mp4）
- **GR-CONTENT-05 新增**：富文本白名单 `<b><i><u><a><br>`
- **OQ 表关闭**：8 项关闭 + 1 推迟 + 2 新增 OQ-09/10
- **版本记录追加**：1.1.0 行
- **评审清单扩充**：6 项 → 9 项

#### 2.3.2 05.08 状态机拆分

将原来"复合状态机"拆为两个独立状态机：

- **5.8.7.1 审核状态机（review_status）**：Pending → Approved / Rejected → Deleted
- **5.8.7.2 推送状态机（push_status）**：仅官方号回答；NotPushed → Pushed / PushFailed → Pushed
- **5.8.7.3 状态组合矩阵**：6 行表格穷举合法组合（含可见性、是否通知）

#### 2.3.3 各 5.x 文件 front matter 添加

为 05.01~05.08 添加 YAML front matter，含字段：`module / title / priority / layer / depends_on / entities / apis / permission_codes / updated`

每个文件标题下方追加 `**原型**：![名](./assets/xxx.png)` 引用，并把表格中的「原型链接」字段升级为 markdown 链接格式。

#### 2.3.4 5.5 搜索 ES + MySQL fallback

- BR-5.5-04 改为相关性排序细节（标题命中优先 + 时间近度）
- BR-5.5-07 新增："主搜索 ES，故障降级 MySQL LIKE，Header `X-Search-Mode: degraded` 通知前端"
- EX-5.5-04/05 新增（ES 不可用、关键词过长）

#### 2.3.5 5.3 问题发布对齐 GR-CONTENT

- BR-5.3-03 落实图片限制（≤9 张 + ≤5MB + 格式）
- BR-5.3-11 新增（视频 ≤1 个 ≤50MB ≤60s mp4）
- BR-5.3-12 新增（OSS 直传三步流程）
- EX-5.3-01~10 重整（10 条覆盖标题/格式/上传/敏感词/未保存/无车辆/无权限）

### 2.4 P1 增强执行

#### 2.4.1 Sample Payload（5.x.10.1 新章节）

为所有模块的 API 契约新增样例：

- **5.1 圈子配置**：创建圈子（多语言）/ 名称重复错误 / 移动端配置读取
- **5.2 问题浏览**：cursor 首次拉取 / cursor 翻页到末尾 / 401 未登录
- **5.3 问题发布**：创建问题成功 / 4002 标题过短 / 6001 敏感词命中 / 4006 无权限 / OSS 直传三步样例
- **5.4 详情与回答**：详情查询 / 投票 / 重复投票（取消）/ 限流 / 采纳 / 重复采纳 / 翻译 / 翻译降级
- **5.5 搜索**：成功（含 highlight）/ 无结果 / ES 降级（warning）
- **5.6 消息通知**：列表 cursor / 未读数量 / 清空
- **5.7 问题管理**：列表筛选 / 批量审核（部分失败）/ 超过 100 条
- **5.8 回答管理**：推送失败筛选 / 重新推送成功 / 推送状态非法 / 删除已采纳

#### 2.4.2 PRD-TEMPLATE 改进

完整重写模板，主要改动：

- **多页面支持**：`5.x.2` 章节新增「页面 A / B / C」结构，元素编号 `E-A-01`、`E-B-01` 跨页面唯一
- **裁剪原则**：P2/P3 必填增加 5.x.5（异常处理无论优先级都不能省）
- **front matter 模板**：模块级 YAML 字段示例（depends_on / entities / apis 等）
- **3.4 Permission Code 模板**：与 00-总览呼应
- **API 5.x.10.1 sample 槽位**：明确"如果填 5.x.10 必须配 sample"
- **附录 B Traceability**：BR ↔ EX ↔ AC ↔ 任务 ↔ API
- **冲突优先级补充**：PRD > tech 文档（数值参数冲突时）
- **评审清单**：12 项 → 17 项

#### 2.4.3 i18n-keys.md（新建）

按 10 个章节组织，~150 条三语对照：

1. common（通用按钮、错误、确认）
2. home（5.2 首页）
3. ask（5.3 提问）
4. detail（5.4 详情）
5. search（5.5 搜索）
6. messages（5.6 消息）
7. admin（5.1/5.7/5.8 后台）
8. status enums（状态/角色枚举）
9. time format（时间格式）
10. unit format（数字 k/M）

泰文翻译标 🟡 表示待本地化团队复核；附「工程化建议」段落（CI 校验、生成脚本、回退策略）。

#### 2.4.4 prompts/ 目录（新建）

7 个文件：

- **README.md** — 索引与使用通则（上下文加载顺序、输出契约、自检清单、上下文窗口预算）
- **h5-page.md** — H5 移动端页面（Vue 3 + NuxtJS + Vant + Pinia + i18n + JSBridge），含正反例
- **cms-admin-page.md** — 管理后台（Vue 3 + Ant Design Vue + Pinia + 鉴权指令 + 脱敏）
- **backend-service.md** — 后端 Spring Boot（Controller 分层 + DTO/VO + 错误码 + 事件发布 + 缓存 + 状态机）
- **backend-database.md** — MySQL DDL + MyBatis Plus（命名 + 索引 + 必须字段 + 分表预留）
- **test-case.md** — JUnit + Playwright + Postman + k6（追溯到 BR/EX/AC + 三类覆盖）
- **api-mock.md** — MSW handlers + fixtures（真实感 + enum 覆盖 + 关联完整性）

每个 prompt 含：上下文加载列表 / 输出工件清单 / 严格约束矩阵 / 自检清单 / 反例对照。

### 2.5 P2 治理执行

#### 2.5.1 traceability.md（新建）

10 个章节，覆盖：

- 5.1~5.8 每条 BR 的 EX/AC/任务/API/备注 完整追溯
- 第 9 节全局规则反向溯源（GR ↔ 实现位置 ↔ 测试用例）
- 第 10 节 NFR 追溯（性能 / 安全 / 运维目标 ↔ 实现 ↔ 度量手段）
- 末尾「维护规则」+「工具脚本建议」

#### 2.5.2 product-architecture.md（新建）

8 节 Mermaid 图：

1. 平台分层结构（4 大块：用户接入 / 在线工程师 / 平台 / 外部依赖，颜色编码）
2. 角色与权限场景图（角色升级路径 + 行为）
3. 核心数据流时序（提问→审核→回答→采纳，含 UOP / FCM 调用）
4. 数据实体关系 ER 图（11 个实体 + 字段示例）
5. 状态流转总览（问题 / 回答审核 / 回答推送）
6. 部署拓扑（K8s + 数据 + 存储/CDN）
7. 关键决策摘要表
8. V2 演进路径

#### 2.5.3 product-mindmap.md（新建）

Markmap 格式，按以下顶层组织：

- Engineer Online
  - 平台层（圈子配置、问题管理、回答管理）
  - 在线工程师业务层（5.2~5.6）
  - 角色（7 种）
  - 数据实体（7 个）
  - 全局规则（认证 / 权限 / 分页 / 搜索 / 通知 / 内容 / 错误处理 / 审核 / 多语言）
  - NFR（性能 / 安全 / 兼容 / 可用性 / SEO / 埋点）
  - 外部依赖（5 个）

#### 2.5.4 目录重组

- `prd/assets/服务端技术架构图.png` → `assets/architecture/`
- `prd/assets/管理后台前端技术架构图.png` → `assets/architecture/`
- `prd/assets/规范1备份.png` → `_archive/`
- `session-log-2026-04-25.md` → `_archive/session-log-2026-04-25.md`

#### 2.5.5 CHANGELOG.md（新建）

按 Keep a Changelog 规范：

- [1.1.0] - 2026-04-26：Changed / Added / Fixed / Moved 四类
- [1.0.0] - 2026-04-25：Added 初始内容

#### 2.5.6 README.md 重写

主要改动：

- 顶部加版本标识（1.1.0）
- 文档结构图升级反映 v1.1.0 全部新文件
- 阅读顺序从 5 步扩到 8 步（含 product-architecture / i18n / traceability）
- AI Coding 用法新增「角色式 Prompt」章节
- 通用 Prompt 模板补充 Permission Code / i18n key 引用
- 文档间交叉引用关系图扩充
- 编号体系增加「文件名 vs 编号约定」说明
- 新增「Permission Code 速查」表
- 项目统计更新（74 任务、~76 BR、~32 EX、21 Permission Code、~150 i18n key）
- 新增「评审状态」「变更与维护」两章

#### 2.5.7 task.md 增量更新

- header 加引用新文档（i18n-keys / traceability / prompts/）
- 任务总览表新增「工具与自动化」一行（6 任务）
- 任务合计 68 → 74
- 新增 5.3 节工具任务：TOOL-01（i18n 提取）/ TOOL-02（Traceability CI）/ TOOL-03（Mock Server）/ TOOL-04（Permission Code 常量生成）/ TOOL-05（文档站点）/ TOOL-06（状态机生成单测桩）
- AI Coding 任务分配建议章节顶部加 v1.1.0 prompt 模板优先调用提示

### 2.6 验证

最终结构：

```
ai-coding-prd-template/
├── CHANGELOG.md                 (NEW)
├── README.md                    (rewritten)
├── _archive/                    (NEW)
│   ├── session-log-2026-04-25.md
│   ├── session-log-2026-04-26.md (本文件)
│   └── 规范1备份.png
├── assets/architecture/         (NEW)
│   ├── 服务端技术架构图.png
│   └── 管理后台前端技术架构图.png
├── prd/
│   ├── 00-总览.md               (扩充 ~95 行)
│   ├── 05.01~05.08              (各加 front matter + sample payload)
│   ├── 05.08-回答管理后台.md     (状态机拆分)
│   ├── PRD-TEMPLATE.md          (重写)
│   ├── i18n-keys.md             (NEW)
│   ├── traceability.md          (NEW)
│   ├── product-architecture.md  (NEW)
│   ├── product-mindmap.md       (NEW)
│   ├── prompts/                 (NEW)
│   │   ├── README.md
│   │   ├── h5-page.md
│   │   ├── cms-admin-page.md
│   │   ├── backend-service.md
│   │   ├── backend-database.md
│   │   ├── test-case.md
│   │   └── api-mock.md
│   └── assets/                  (仅保留原型截图)
├── task.md                      (新增 6 任务，header 更新)
├── tech-architecture.md         (未改 — 已经通过 00-总览对齐)
└── ui-spec.md                   (未改)
```

引用完整性校验：

- `session-log-2026-04-25` 的两处引用都正确（CHANGELOG 引相对路径、PRD-TEMPLATE 引 `../_archive/`）
- 所有 5.x 文件的 `./assets/xxx.png` 路径在 `prd/assets/` 下都存在
- README 中提及的所有路径都已存在

---

## 阶段三：导出本会话记录

Billy 要求："导出以上完整聊天记录到 _archive"

Claude 创建 `_archive/session-log-2026-04-26.md`（即本文件），延续前一日记录的风格，按"建议 → 授权 → 执行 → 验证"四阶段总结本次会话。

---

## 最终产出物清单

### 新建文件（13 个）

| 文件 | 行数 | 用途 |
|------|------|------|
| `CHANGELOG.md` | 80 | 版本变更记录 |
| `prd/i18n-keys.md` | 250 | 三语 UI 文本字典 |
| `prd/traceability.md` | 176 | 需求追溯矩阵 |
| `prd/product-architecture.md` | 374 | 产品架构 Mermaid 图 |
| `prd/product-mindmap.md` | 317 | 产品功能脑图 Markmap |
| `prd/prompts/README.md` | 60 | Prompt 模板索引 |
| `prd/prompts/h5-page.md` | 100 | H5 页面 prompt |
| `prd/prompts/cms-admin-page.md` | 75 | 后台页面 prompt |
| `prd/prompts/backend-service.md` | 110 | 后端 Service prompt |
| `prd/prompts/backend-database.md` | 105 | 数据库 Schema prompt |
| `prd/prompts/test-case.md` | 105 | 测试用例 prompt |
| `prd/prompts/api-mock.md` | 75 | API Mock prompt |
| `_archive/session-log-2026-04-26.md` | 本文件 | 本次会话记录 |

### 重大修订文件（11 个）

- `README.md` — 重写（4422 字节）
- `prd/00-总览.md` — 扩充至 454 行（+95）
- `prd/PRD-TEMPLATE.md` — 重写至 475 行（+89）
- `prd/05.01-圈子配置.md` — 加 front matter + sample，272 行
- `prd/05.02-问题浏览.md` — 加 front matter + cursor + sample，339 行
- `prd/05.03-问题发布.md` — BR/EX 重整 + sample，267 行
- `prd/05.04-问题详情与回答.md` — 加 sample（4 个 API），417 行
- `prd/05.05-搜索.md` — ES fallback + sample，201 行
- `prd/05.06-消息通知.md` — cursor + sample，220 行
- `prd/05.07-问题管理后台.md` — 新增 5.7.10 + sample，341 行
- `prd/05.08-回答管理后台.md` — 状态机拆分 + 5.8.10 + sample，330 行
- `task.md` — 新增 6 个 TOOL-* 任务，更新 header，~750 行

### 文件迁移

- `session-log-2026-04-25.md` → `_archive/`
- `服务端技术架构图.png` → `assets/architecture/`
- `管理后台前端技术架构图.png` → `assets/architecture/`
- `规范1备份.png` → `_archive/`

### 统计变化

| 指标 | v1.0.0 | v1.1.0 |
|------|--------|--------|
| 业务规则总数 | ~65 | ~76 |
| 异常处理场景 | ~27 | ~32 |
| 验收标准 | ~53 | ~53 |
| Permission Code | 0 | 21 |
| i18n key | 0 | ~150 |
| 开发任务 | 68 | 74 |
| 待确认事项 | 8 | 1 推迟 / 1 待讨论 / 9 关闭 |
| PRD 文件总数（prd/） | 9 + 模板 | 13 + 7 prompts + 模板 |
| 总文档行数 | ~3300 | ~5800 |

---

## 关键经验留档

### 1. AI Coding 友好性的真正瓶颈

第一轮做完时已经"看上去很全"，但实际放给 AI 用还有不少坑：

- **隐式假设**：人类读者能脑补的东西（如"这个文件名前导 0 是排序用的"），AI 不会
- **样例缺失**：API 类型签名 ≠ 真实数据；没 sample，AI 容易猜错枚举大小写、时间格式
- **追溯断链**：改一条 BR 时，没有清单告诉你影响哪些代码/测试/文档
- **多页面建模**：模板只想到了"一个 5.x = 一个页面"，但实际后台一个模块多个页面是常态

修复这些"隐性假设"才是把 PRD 真正变成 AI input 的工程化关键。

### 2. 状态机的"诱惑"

把多个状态字段画在同一张图里看起来"统一"，但本质会撒谎。Answer 的 review_status 和 push_status 是两个独立维度，硬合并会导致：

- 状态转换图无法表示"普通用户回答审核通过"这种合法但不会进入推送的路径
- 后端实现时容易写出错误的 setStatus 逻辑

正确做法：每个独立状态字段一张图 + 一张组合矩阵说明哪些组合合法。

### 3. Permission Code 的价值

权限矩阵（角色 × 操作）是产品视角；Permission Code（resource:action:scope）是工程视角。两者必须一一对应：

- 没有 Code，鉴权就只能 `@SaCheckRole("ADMIN")`，粒度太粗，扩展难
- Code 暴露后，前端 `v-permission` 指令也能用，UI 与后端鉴权一致
- 编码原则 `:own` 范围在 Service 层比对资源 author_id 是一个简单但关键的约定

### 4. Prompt 模板的设计模式

每个角色 prompt 应该包含 5 个固定段落：

1. **上下文加载顺序**（明确告诉 AI 读哪些文档、哪些章节）
2. **输出工件清单**（每种文件 + 内容要求）
3. **严格约束矩阵**（不能违反的 N 条规则）
4. **自检清单**（输出末尾必填的元数据，含 BR/EX/AC 编号映射）
5. **反例对照**（典型错误 + 正确写法）

这种结构能让 AI 在生成代码时自动绑定到 PRD 编号体系，PR review 也能直接按编号核对。

### 5. 文档治理的两条线

- **横向**：i18n key、Permission Code、错误码、Mock 数据 — 跨模块共享，需要统一字典
- **纵向**：每个 5.x 模块的 BR ↔ EX ↔ AC ↔ 任务 ↔ 代码 ↔ 测试 — 需要 traceability 串联

CI 应该校验两条线的完整性：横向字典缺 key 报错，纵向 BR 无 AC 报错。

---

## 后续建议

1. **执行 TOOL-01**：i18n 提取脚本，把 `prd/i18n-keys.md` 转成 `locales/{zh,en,th}.json`，让前端开发立即可用
2. **执行 TOOL-04**：Permission Code 生成 TypeScript / Java 常量，编译期校验
3. **本地化复审**：泰文翻译标 🟡 的 ~80 条需在交付前由本地化团队复核
4. **关闭 OQ-10**：UOP 接口 SLA 与降级策略需与 UOP 团队对齐
5. **第三轮迭代时可考虑**：
   - 数据迁移策略（如有现成数据需要迁入）
   - 灰度发布策略
   - 离线场景处理（H5 网络断了怎么办）
   - 大量内容场景（单问题 1000+ 回答）
   - 反垃圾 / 反作弊 策略
