# AI Coding Prompt 模板集

> 按角色组织的 prompt 模板，用于让 AI 根据 PRD/技术架构/UI 规范生成对应工件。每个模板自带「上下文加载策略 / 输入文档 / 输出格式 / 自检清单」，可直接复制粘贴。

> **路径解析规则**：以下路径均以仓库根目录为基准，默认写完整路径（如 `requirement/00-需求总览.md`），避免 AI 因当前工作目录不同而误读。

> **推荐用法**：开发人员先在 `tasks/任务清单.md` 中找到自己的任务，再打开对应 PRD 和支撑文档，最后来这里选择合适的 Prompt 模板。

## 目录

| 文件 | 适用角色 | 输出工件 | 适用模块 |
|------|---------|---------|---------|
| [工程初始化.md](工程初始化.md) | Flutter / H5 / 后台 / 后端 / DevOps | 可运行脚手架 + 基础配置 | INF 类基础设施任务 |
| [Flutter页面.md](Flutter页面.md) | Flutter 前端 | Flutter 原生页面 + Riverpod | 5.2 / 5.3 / 5.5 / 5.6 |
| [H5详情页.md](H5详情页.md) | H5 前端 | Vue 3 + NuxtJS + Vant 详情页 | **仅 5.4** |
| [管理后台页面.md](管理后台页面.md) | 后台前端 | Vue 3 + Ant Design Vue 页面 | 5.1 / 5.7 / 5.8 / 5.9 |
| [后端接口与服务.md](后端接口与服务.md) | 后端 | Spring Boot Controller + Service | 全部 |
| [数据库设计.md](数据库设计.md) | 后端 | MySQL DDL + MyBatis Plus 实体 | 全部 |
| [测试用例.md](测试用例.md) | 测试 | E2E + 单元测试 | 全部 |
| [API模拟数据.md](API模拟数据.md) | 前后端联调 | Mock Server 数据集 | 全部 |

## 使用通则

### 1. 上下文加载策略（按角色精简）

每个角色只需加载与自己相关的文档。不要给 AI 塞全部文档——上下文窗口浪费会降低生成质量。

#### 🧩 Flutter 前端（5.2/5.3/5.5/5.6）

**必读**：
1. `tasks/任务清单.md` 对应任务行
2. `requirement/00-需求总览.md` §1.4 术语 / §1.5 角色权限 / §6 全局规则
3. `requirement/modules/05.x-xxx.md` 全文
4. `standard/技术架构.md` §3.1 Flutter / §5 接口 / §9 i18n
5. `standard/UI设计规范.md` §1 Design Token
6. `design/UI设计.md` 对应页面章节
7. `design/错误码.md`（错误处理）
8. `requirement/多语言文本.md` 对应模块

**可跳过**：`design/数据模型.md` / `design/部署设计.md` / `standard/安全基线.md`

#### 🌐 H5 前端（仅 5.4）

**必读**：
1. `tasks/任务清单.md` 对应任务行
2. `requirement/00-需求总览.md` §1.4/1.5/6
3. `requirement/modules/05.04-问题详情.md` 全文
4. `standard/技术架构.md` §3.2 H5 / §5 接口 / §8 JSBridge / §9 i18n
5. `standard/UI设计规范.md` §1 Design Token
6. `design/UI设计.md` §3.3 问题详情页
7. `design/错误码.md`
8. `requirement/多语言文本.md` §1+§4

**可跳过**：`design/数据模型.md` / `design/部署设计.md`

#### 💻 后台前端（5.1/5.7/5.8/5.9）

**必读**：
1. `tasks/任务清单.md` 对应任务行
2. `requirement/00-需求总览.md` §1.5 角色权限 / §6
3. `requirement/modules/05.x-xxx.md` 全文
4. `standard/技术架构.md` §3.3 后台前端 / §5 / §10.2 脱敏
5. `standard/UI设计规范.md` §1 Design Token
6. `design/UI设计.md` §3.6 运营管理后台
7. `design/权限设计.md`（前端 v-permission）
8. `design/错误码.md`
9. `requirement/多语言文本.md` §7 后台

#### ⚙️ Java 后端（全部模块）

**必读**：
1. `tasks/任务清单.md` 对应任务行
2. `requirement/00-需求总览.md` §1.4/1.5/6
3. `requirement/modules/05.x-xxx.md`（重点 §5.x.4 BR / §5.x.5 EX / §5.x.6 数据对象 / §5.x.7 状态机 / §5.x.10 API）
4. `design/数据模型.md`（字段类型 ER + 索引 + 状态机）
5. `design/权限设计.md`（Permission Code + 角色矩阵）
6. `design/错误码.md`（异常处理）
7. `standard/技术架构.md` §4 后端 / §5 接口 / §6 数据存储 / §7 消息事件
8. `standard/安全基线.md`（重点 §1 认证 / §3 注入防护）

**可跳过**：`standard/UI设计规范.md` / `design/UI设计.md`

#### 🧪 测试 / QA

**必读**：
1. `tasks/任务清单.md` 对应任务行
2. `requirement/modules/05.x-xxx.md`（重点 §5.x.4 BR / §5.x.5 EX / §5.x.9 AC）
3. `tasks/追溯矩阵.csv`（BR ↔ AC 映射）
4. `design/错误码.md`
5. `standard/技术架构.md` §11 性能目标

### 2. AI 关注章节（节省 context）

`spec-index.yaml` 为每个模块标注了 `ai_focus_sections`——AI 生成代码时最关键的章节。例如：
- 模块 5.4 的关键章节：5.4.2（页面元素）/ 5.4.4（BR）/ 5.4.5（EX）/ 5.4.6（数据对象）/ 5.4.7（状态机）/ 5.4.10（API）

如果上下文预算紧张，只读 `ai_focus_sections` 标注的章节即可。

### 3. 输出契约

- **代码风格**：严格遵循 `standard/技术架构.md` 编码规范（含命名、目录结构）
- **类型定义**：复用 PRD 数据对象的字段名（`snake_case` 后端 / `camelCase` 前端）
- **错误码**：使用 `design/错误码.md` 中的常量名，禁止硬编码数字
- **Permission Code**：使用 `design/权限设计.md` 中的常量，禁止裸字符串
- **i18n**：禁止硬编码 UI 文本，必须用 `requirement/多语言文本.md` 定义的 key
- **文件头注释**：AI 生成的每个文件顶部必须标注引用的 BR/AC 编号，便于反向追溯

### 4. 自检清单

每个 prompt 末尾要求 AI 完成自检：
- 列出引用了 PRD 哪些 BR / EX / AC 编号
- 列出使用的 Permission Code 和错误码
- 列出未实现的需求项（如有）
- 列出与 PRD 偏差并说明原因（如有）

### 5. 与人工的边界

- AI 完成首版后，人工 review 关键路径（鉴权、状态转换、外部依赖调用）
- AI 不应擅自补充 PRD 未规定的字段或行为；遇到歧义，列入"开放问题"等待澄清

### 6. 上下文窗口预算

| 任务规模 | 推荐输入文档量 | 模型选择 |
|---------|--------------|---------|
| 单组件/单接口 | 单个 5.x + ai_focus_sections | Sonnet |
| 单页面/多接口 | 5.x 全文 + 00-需求总览 + design/相关 | Sonnet / Opus |
| 跨模块联调 | 多个 5.x + 全部全局文档 | Opus |

---

## Prompt 调用方式

### 按任务驱动（推荐，对齐 Kiro Spec 工作流）

```
请按 `prompts/H5详情页.md` 的指引，完成任务 QDETAIL-05。
- 先读 `tasks/任务清单.md` 中 QDETAIL-05 这一行，确认输入文档和验收标准
- 按 prompt 的"必读文档"清单加载上下文
- 完成后输出自检清单（BR/EX/AC 覆盖情况）
```

### 按模块驱动

```
请按 `prompts/H5详情页.md` 的指引，为模块 5.4（问题详情）生成 H5 页面代码。
- 只生成 Vue 3 单文件组件 + Pinia store
- 不要执行 npm install 或运行项目
- 完成后输出自检清单
```

### 脚手架初始化

```
请按 `prompts/工程初始化.md` 的指引，完成任务 INF-03（初始化后端微服务）。
- 先阅读 `tasks/任务清单.md` 中 INF-03 这一行
- 再按模板要求补看相关技术文档
- 只搭建工程骨架和基础配置
- 完成后输出自检清单
```
