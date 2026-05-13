# Changelog

本项目所有重大变更都会记录在此文件中。

格式参考 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，版本号遵循 [SemVer](https://semver.org/lang/zh-CN/)。

---

## [2.3.0] - 2026-05-13

> 全面评估 + 阶段 1-4 优化 + Skills 体系 + 需求冲突修复 + prompts 删除 + "AI Coding" → "Spec Coding"

### Added
- **`scripts/`** — 6 个 Doc Lint 脚本 + GitHub Actions CI（check-traceability / check-numbering / check-references / check-tables / check-stats / check-ac-coverage）
- **`tasks/追溯矩阵.csv`** — 统一的 BR→EX→AC→任务→API 全链路追溯（SSOT，88 行）
- **`.kiro/skills/`** — 7 个 Kiro Skills（flutter-dev / h5-dev / admin-dev / backend-dev / db-design / test-qa / spec-writer）
- **`.claude/skills/`** — 6 个 Claude Code Skills（flutter-dev / h5-dev / admin-dev / backend-dev / db-design / test-qa）
- **`CLAUDE.md`** — 重建为 Claude Code 自动加载入口
- **`design/UI设计.md`** — 从 standard/UI设计规范.md 拆出业务组件 + 页面模板
- **`design/错误码.md`** — 34 个错误码完整注册表
- **`.github/workflows/doc-lint.yml`** — GitHub Actions CI

### Changed
- **全局术语**："AI Coding" → "Spec Coding"
- **目录重命名**：`spec/` → `requirement/`、`plan/` → `design/`
- **design/ 文件重命名**：`部署拓扑.md` → `部署设计.md`、`权限码.md` → `权限设计.md`
- **`design/权限设计.md`** — 角色表新增"作者"角色 + "端"列 + 角色矩阵扩展
- **`design/错误码.md`** — 新增成功码说明（code: 0）
- **`design/*.md`** — 章节结构对齐 Kiro design.md 风格（Overview/Architecture/Key Decisions...）
- **`index/spec-index.yaml`** → 根目录 `spec-index.yaml`（删除 index/ 目录）
- **`spec-index.yaml`** — prompts 段替换为 skills 段
- **`requirement/00-需求总览.md`** — 修复 OQ-03 采纳规则；版本号统一；§5 模块链接修正；删除 GR-PERM-02；审核规则改为 UOP 人工审核；GR-TIME-01 统一时间格式
- **`requirement/modules/05.02`** — 标题约束 5-200→5-400；回答预览 3行→2行；时间格式 360天→7天
- **`requirement/modules/05.04`** — API 回答列表改为 cursor 分页；E-06 富文本→纯文本
- **`requirement/modules/05.05`** — 删除搜索"浏览数加成"排序因子
- **`requirement/modules/05.06`** — 新增"回答被采纳→通知回答者"触发场景
- **`requirement/modules/05.07`** — 车型筛选改回单下拉；删除"浏览次数"列；编号废弃说明
- **`requirement/功能结构.md`** — 视频 5MB→50MB；时间格式统一；新增采纳通知
- **`standard/安全基线.md`** — 富文本→纯文本；XSS 防护简化
- **`standard/技术架构.md`** — 移除"富文本"选型理由；§13 改为 Skill 调用
- **所有文档** — 补齐 YAML front matter（29/30 文件覆盖）
- **README.md** — 统计数字更新（BR 88/EX 40/AC 63）；目录树更新；Skill 驱动使用方式

### Removed
- **`prompts/`** — 9 个文件（已被 `.kiro/skills/` 和 `.claude/skills/` 替代）
- **`requirement/需求追溯.md`** — 合并到 `tasks/追溯矩阵.csv`
- **`tasks/AC-任务映射.csv`** — 合并到 `tasks/追溯矩阵.csv`
- **`index/` 目录** — `spec-index.yaml` 移到根目录
- **`CONTRIBUTING.md`** — 合并到 README
- **`GR-PERM-02`** — "无权限不显示入口"规则移除
- **GR-CONTENT-05 富文本白名单** — 改为"纯文本+换行，全部 HTML 转义"

### Fixed
- BR-5.4-03 与 OQ-03 采纳规则矛盾（统一为"单采纳"）
- 需求追溯矩阵 3 条脏数据 + 7 条缺失 BR
- 5.7 模块编号串号（BR-5.7-05/06 废弃说明）
- README 统计数字过时（76→88 BR）
- Obsidian 表格缺空行问题（全局修复）
- 05.02 标题约束 5-200→5-400
- 05.04 API 回答列表分页方式矛盾

---

## [2.1.0] - 2026-05-12

> 一致性修复 + CLAUDE.md/CONTRIBUTING.md 合并删除 + plan/ 子文档完善 + standard/ 安全基线完善。

### Added
- **`plan/权限码.md`** — 从技术方案 §5 独立，19 条 Permission Code 完整注册表 + 角色矩阵 + 实现约定（SSOT）
- **`plan/数据模型.md`** — 从技术方案 §2 独立，7 实体 ER + 字段详表 + 索引策略 + 状态机（SSOT）
- **`plan/部署拓扑.md`** — 从技术方案 §3 独立，拓扑图 + 容量规划 + 扩缩容 + 上线 Checklist（SSOT）
- **`standard/安全基线.md`** — 从占位升级为完整文档（11 章：认证/数据安全/注入防护/文件上传/接口安全/日志审计/依赖安全/密钥管理/事件响应）
- **`README.md`** 新增 `## AI 工作指引` 章节（合并自 CLAUDE.md：仓库性质/文档分层/文档约定/AI 快速入口）
- **`index/spec-index.yaml`** 新增 `ai_focus_sections` 字段（每个模块标注 AI 生成代码时最关键的章节）

### Changed
- **`plan/技术方案.md`** — 改为索引式，§2/§3/§5 各保留摘要 + 链接到子文档；版本升至 2.0.0
- **`spec/00-需求总览.md`** — 修复 OQ-03 结论（"多采纳"→"单采纳"）；版本号统一为 1.4.0 / 2026-05-11；§5 模块链接修正为 `modules/` 相对路径
- **`tasks/任务清单.md`** — TOOL-04/05/06 路径从 `prd/` 修正为 `spec/`
- **`README.md`** — 合并 CONTRIBUTING.md 内容到"变更与维护"章节；合并 CLAUDE.md 内容到"AI 工作指引"章节；Permission Code 计数 20→19；目录树移除 CLAUDE.md
- **`index/spec-index.yaml`** — 版本升至 2.0.0
- **`standard/技术架构.md`** — §10 添加安全基线独立文档引用；修正旧路径引用
- **`standard/UI设计规范.md`** — 修正关联文档路径
- **`standard/PRD-TEMPLATE.md`** — 修正原型图路径模板

### Removed
- **`CLAUDE.md`** — 内容已合并到 README.md（开发人员不一定使用 Claude）
- **`CONTRIBUTING.md`** — 内容已合并到 README.md "变更与维护"章节
- **`plan/permission.md`** — 英文占位文件，替换为 `plan/权限码.md`
- **`plan/data-model.md`** — 英文占位文件，替换为 `plan/数据模型.md`
- **`plan/deployment.md`** — 英文占位文件，替换为 `plan/部署拓扑.md`
- **`standard/security-baseline.md`** — 英文占位文件，替换为 `standard/安全基线.md`

### Fixed
- BR-5.4-03 与 OQ-03 采纳规则矛盾（统一为"单采纳"）
- `spec/00-需求总览.md` front matter 与正文版本号不一致
- `tasks/任务清单.md` 中 3 处残留 `prd/` 旧路径
- `spec/00-需求总览.md` §5 模块索引链接失效
- README 项目统计 Permission Code 计数错误（20→19）

---

## [2.0.0] - 2026-05-12

> 目录结构重构。按文档分层理论（L1 组织级 / L2 项目级 / L3 模块级 / L4 任务级）重新组织全部文件，目录名统一英文，文件名保持中文。新增机器可读索引、贡献指南、安全基线占位。

### Added
- **`index/spec-index.yaml`** — 机器可读的模块索引（AI 可一次读入建立全局视图）
- **`standard/security-baseline.md`** — 安全基线占位文件
- **`plan/permission.md`** — Permission Code 注册表占位
- **`plan/data-model.md`** — 数据模型 ER 占位
- **`plan/deployment.md`** — 部署拓扑占位
- **`.gitignore`** — 忽略 .DS_Store、编辑器临时文件

### Changed (Breaking — 目录结构)
- `requirement/00-需求总览.md` → `spec/00-需求总览.md`
- `requirement/05.*.md` → `spec/modules/05.*.md`
- `requirement/多语言文本.md` → `spec/多语言文本.md`
- `requirement/需求追溯.md` → `spec/需求追溯.md`
- `requirement/demo/*` → `spec/demo/*`
- `source/功能结构.md` → `spec/功能结构.md`
- `source/global/技术架构.md` → `standard/技术架构.md`
- `source/global/UI设计规范.md` → `standard/UI设计规范.md`
- `source/PRD-TEMPLATE.md` → `standard/PRD-TEMPLATE.md`
- `source/global/assets/architecture/*` → `asset/architecture/*`
- `source/global/assets/ui-specification/*` → `asset/ui-spec/*`
- `source/prototype/*` → `asset/prototype/*`
- `source/业务流程.png` + `source/页面流程.png` → `asset/flowchart/*`
- `技术方案.md` → `plan/技术方案.md`
- `任务清单.md` → `tasks/任务清单.md`
- **所有 PRD / prompts / README / CLAUDE.md 中的交叉引用路径**已同步更新
- **README.md** 完全重写，反映新目录结构
- **CLAUDE.md** 完全重写，新增文档分层说明和 AI 快速入口

### Removed
- `source/` 目录（内容已分散到 `standard/`、`spec/`、`asset/`）
- `requirement/` 目录（内容已迁入 `spec/`）

---

## [1.4.0] - 2026-05-11

> 按功能结构文档统一所有 PRD 需求描述，修正原型路径，删除问题管理（管理后台）的发表问题功能，新增 5.9 用户管理（管理后台）模块。

### Added
- **`prd/00-需求总览.md`**：新增 `5.9 用户管理（管理后台）` 模块，功能结构与 `source/功能结构.md` 同步；模块总数 8 → 9

### Changed
- **`prd/05.01-圈子管理(管理后台).md`**：封面图改为必填；功能启用选项更新（回复 / 图片 / 视频 / 选择车辆 / 车辆累计公里数）；权限术语统一（"所有用户"→"全部用户"、"车主用户"→"车主"、"停用"→"禁用"）；新增 `follow_up_roles`（追问权限）字段
- **`prd/05.02-圈子首页.md`**：统计数字格式改为千分号（如 1.2k → 1,200）；回答预览规则更新为"最多2条，已采纳优先，时间倒序"
- **`prd/05.03-问题发布.md`**：标题限制统一为 5-400 字符（原 5-200）；视频大小限制统一为 ≤5MB（原 50MB）
- **`prd/05.04-问题详情.md`**：时间显示改为相对时间；删除权限仅限作者（去除管理员）
- **`prd/05.05-搜索.md`**：过滤条件改为"审核通过且公开状态为公开"；ES 排序规则更新（365 天衰减至 0.5，增加 `slop: 2`）
- **`prd/05.06-消息通知.md`**：官方号回答触发时机改为"审核通过后"（原"回答问题时"）
- **`prd/05.07-问题管理（管理后台）.md`**：操作列新增设为公开/取消公开/取消热门；筛选项修正（"标题/内容"→"标题"、"发布时间"→"创建时间"）
- **`prd/05.08-回答管理（管理后台）.md`**：回复人昵称搜索改为精确搜索；操作列和批量操作新增"推送 UOP"
- **`README.md`**：文档结构树更新为实际目录结构，模块数 8 → 9
- **所有 PRD 原型图片路径**：`../assets/prototype/` → `source/prototype/`
- **文档目录引用**：批量修正 23 个 markdown 文件中的 `docs/` 路径为实际路径
- **`CLAUDE.md`**：文件结构树新增 `05.09-用户管理（管理后台）.md`；架构概览平台层增加 5.9；技术栈增加 5.9；任务数 84 → 87
- **`README.md`**：文档结构树新增 `05.09-用户管理（管理后台）.md`；标准开发路径更新为 `05.01~05.09`；客户端实现技术分布增加 5.9；项目统计 Permission Code 21 → 20，开发任务数 89 → 87

### Removed
- **`prd/05.07-问题管理（管理后台）.md`**：
  - 删除页面 B（问题新建/编辑/查看抽屉）及全部元素 `E-B-01~E-B-11`
  - 删除发表问题/代发功能及对应 `BR-5.7-05`、`BR-5.7-06`、`AC-5.7-10`
  - 删除 API `POST /api/v1/admin/questions`
  - 删除 Permission Code `question:post-on-behalf:any`
- **`prd/05.01-圈子管理(管理后台).md`**：删除 `publishable_types`（可发布内容类型）和 `post_settings`（发表设置项）字段
- **`技术方案.md`**：更新为 v1.1.0（scope 扩展至 5.1~5.9）；ER 图 Group 表删除 `publishable_types`，新增 `background_color` 和 `follow_up_roles`；Permission Code 删除 `question:post-on-behalf:any`，更新 `answer:accept:own` 备注
- **`任务清单.md`**：v1.4.1；新增 5.9 用户管理（管理后台）模块 4 个任务（USER-01~04）；删除 QM-06 代发问题；更新 QM-03/05、QPOST-01、QLIST-08、QDETAIL-04 等任务描述；合计任务数 84 → 87
- **`prd/00-需求总览.md`**：核心业务流程图补充"公开状态为公开时前端可见"和"采纳后关闭追问入口"

### Added
- **`prd/05.09-用户管理（管理后台）.md`** — 新增用户管理后台 PRD，含用户列表/详情/设为官方号/UOP 同步官方号功能、API 契约及验收标准
- **`requirement/demo/admin-dashboard.html`** — 新增用户管理页面（筛选/表格/设为官方号弹窗/取消官方号二次确认）

### Changed
- **`requirement/demo/demo.html`** — App Demo 保真度提升：
  - 圈子首页：统计数字改为千分号格式（12,000 / 1,200,000）；回答预览改为最多2条、已采纳优先；时间改为相对时间格式
  - 提问页：标题限制提示改为 5-400 字符；视频大小提示改为 ≤5MB
  - 问题详情页：时间改为相对时间；仅展示1条采纳；采纳后隐藏追问入口和底部回复栏
  - 搜索页：结果时间改为相对时间格式
  - 消息通知页：通知内容改为官方号回答审核通过后触发模板
- **`requirement/demo/admin-dashboard.html`** — 管理后台 Demo 保真度提升：
  - 问题管理：删除发布问题按钮和编辑抽屉；筛选项"标题/内容"→"标题"、"发布时间"→"创建时间"；新增公开状态筛选项；操作列新增设为公开/取消公开/推送到UOP；批量操作新增推送到UOP
  - 回答管理：回复人昵称搜索改为"精确搜索"；操作列和批量操作新增"推送UOP"
  - 圈子配置：删除可发布内容类型和发表设置项；新增追问权限字段；功能启用选项更新

---

## [1.3.3] - 2026-05-09

> 基于更新后的 `prd/00-需求总览.md` 功能结构，同步修改所有相关模块 PRD，确保总览与模块文档一致。

### Changed
- **`prd/00-需求总览.md`**：功能结构（§2.1/§2.2）重写，细化各模块能力点；Tab 名称中文化（Hot→最热，Newest→最新）；采纳规则改为单采纳；回答排序改为已采纳优先；图片/视频限制改为合计≤9个；新增官方号 GAC 图标、分享条件、翻译语言检测、赞/踩防抖等细节
- **`prd/05.01-圈子管理(管理后台).md`**：名称约束 50→200 字符，描述 500→1000 字符，封面 5MB→3MB；发表设置项文案同步；列表字段增加背景颜色
- **`prd/05.02-圈子首页.md`**：Tab 名称中文化；BR-5.2-01 增加"且公开"过滤；时间格式细化；新增 BR-5.2-07/08/09（访问权限提示、最新回答展示、提问按钮权限检查）
- **`prd/05.03-问题发布.md`**：标题上限 200→400 字符；图片/视频限制改为合计≤9个（视频≤5MB）；新增上传交互（取消/移除/预览）和发表按钮状态规则；BR 编号重组
- **`prd/05.04-问题详情.md`**：BR-5.4-01 排序改为已采纳优先；BR-5.4-03 可多采纳→仅单采纳；新增 BR-5.4-14~20（N Items、赞/踩防抖、Reply 前缀、翻译检测、分享条件、cursor 10条/页、底部回复入口）
- **`prd/05.06-消息通知.md`**：移除清空按钮及对应 API/AC/EX；触发场景去掉"回答被采纳"通知
- **`prd/05.07-问题管理（管理后台）.md`**：功能概述增加发表问题；列表字段新增排序序号/内容/图片/视频/公开状态/采纳状态/推送状态/回复数；筛选项扩充至 15 维；新增查看回复弹窗、设为热门、推送到UOP；批量操作增加排序和推送到UOP
- **`prd/05.08-回答管理（管理后台）.md`**：列表字段去掉 UOP 同步状态列，拆分问题ID/父回答ID，回复人增加头像；筛选项去掉父回复ID/UOP同步状态，增加回复人手机/邮箱
- **`prd/05.02-问题浏览.md` → `05.02-圈子首页.md`**：文件重命名，文档内标题从"问题浏览（首页）"改为"圈子首页"；同步更新所有交叉引用（README.md、00-需求总览.md、任务清单.md、需求追溯.md、技术方案.md、技术架构.md、各模块依赖功能、Flutter页面.md、CHANGELOG历史条目）
- **各模块 front matter**：`updated` 统一更新为 2026-05-09

## [1.3.2] - 2026-05-07

> 问题描述字数上限规则补全。

### Changed
- **`prd/05.03-问题发布.md`**：BR-5.3-02 描述字段从"无字数上限"改为"最多 10,000 字符"，适配泰语等组合字符语言；E-05 约束列同步更新，增加字数计数器交互说明；新增 EX-5.3-11（描述过长边界场景）；5.3.6 数据对象与 5.3.10 DTO 注释同步加约束
- **`prd/需求追溯.md`**：BR-5.3-02 行更新关联 EX-5.3-11 与 DTO 校验备注

---

## [1.3.1] - 2026-04-28

> AI Coding 文档质量修复版。修复评估发现的 7 项内容/逻辑问题，提升 AI 消费准确性。

### Fixed
- **`global/技术架构.md`**：错误码体系补充 `4007: CONTENT_SENSITIVE`（内容包含敏感词），解决 05.03 与 6xxx 审核段冲突
- **`prd/05.03-问题发布.md`**：敏感词校验 API 样例错误码 `6001` → `4007`，与错误码体系对齐；BR-5.3-12 补充 OSS 上传策略（并行3张、进度显示、Post时只提交URL）
- **`prd/05.04-问题详情.md`**：
  - 元素编号冲突修复：回答区域 `E-01~E-14` → `E-A-01~E-A-14`，嵌套回复 `E-01~E-E-08` → `E-B-01~E-B-08`
  - BR-5.4-04 补充数据层实现细节（唯一键 `(user_id, answer_id)` + `vote_type` 更新策略 + 计数增量计算）
  - 5.4.10 API 契约表补充遗漏的 `POST /api/v1/content/check`（敏感词校验）
  - 新增 BR-5.4-16：嵌套回复仅支持一层（回答 → 回复），`parent_id` 仅指向顶层回答，不形成链式嵌套
- **`prd/05.02-问题浏览.md`**：5.2.7 状态转换表补充 `Rejected → Deleted` 行；新增被驳回问题的可见性说明（仅作者可见、不显示编辑入口、保留30天后清理）
- **`任务清单.md`**：基于"项目已上线、engineer-online 为新增模块"的前提，重构阶段一任务结构
  - 原 19 个基础设施任务 → 精简为 14 个（已有能力确认 6 + 新服务/骨架 6 + 业务组件 2）
  - 新增 `INF-CHECK-01~06`（确认现有 Flutter/H5/后台/后端/组件库覆盖度）
  - 新增 `INF-NEW-01~05`（community-service 骨架、Compose/K8s 增量配置、模块目录/路由/菜单初始化）
  - 删除重复建设任务：Flutter/H5/后台工程初始化、网络层、JSBridge、Design Token、原子组件库、通用组件等
  - 下游任务依赖同步更新（`INF-09` → `INF-CHECK-04`、`INF-14` → `INF-CHECK-06`、`INF-07` → `INF-CHECK-02` 等）
  - AUDIT-04 表述从"集成内容审核系统"改为"对接 UOP 内容审核接口"
  - OPS-01 表述从"配置生产环境"改为"community-service 接入现有生产环境"
  - 总任务数：89 → 84

---

## [1.3.0] - 2026-04-27

> 命名与目录治理 + 文档分层重构。`Circle → Group`、`管理后台 CMS → 运营管理后台`；新增 `技术方案.md` 作为「项目级技术架构」与「模块 PRD」之间的需求级方案层；`prd/产品脑图.md` 与 `prd/产品架构.md` 内容并入 `prd/00-需求总览.md`；文档整体迁入 `docs/` 分层目录。

### Added
- **`技术方案.md`** — 当前需求集合（5.1~5.8）的技术方案文档（新建文档层）
  - 承接原 `00-需求总览.md` / `产品架构.md` 中偏技术的内容：§4 含字段类型 ER、§6 部署拓扑、§7 技术决策
  - 文档边界：
    - 项目级（年）→ `global/技术架构.md`：技术栈、规范、基础设施
    - **需求级（季）→ `技术方案.md`**：本次需求的字段类型、部署细节、技术决策
    - 模块级（迭代）→ `prd/05.x-*.md`：BR/EX/AC/API
    - 产品视角 → `prd/00-需求总览.md`：角色、流程、产品决策
  - README 阅读顺序新增第 4 步 `技术方案.md`

### Changed
- **实体英文命名**：`Circle` 系列全部改为 `Group`
  - 实体类：`Circle` → `Group`，`CircleTranslation` → `GroupTranslation`
  - DB 表：`t_community_circle` → `t_community_group`，`t_community_circle_translation` → `t_community_group_translation`
  - 字段：`circle_id` → `group_id`，`circleId` → `groupId`
  - API 路径：`/api/v1/circles` → `/api/v1/groups`、`/api/v1/admin/circles` → `/api/v1/admin/groups`
  - Permission Code：`circle:view:any` → `group:view:any`，`circle:manage:any` → `group:manage:any`
  - 错误码常量：`CIRCLE_NOT_FOUND` → `GROUP_NOT_FOUND` 等 4 项
  - 任务编号：`CIRCLE-01~06` → `GROUP-01~06`
  - DTO/VO/Service/Controller 类名一并 `Circle*` → `Group*`
  - Redis Key 模式：`circle:config:` / `circle:permissions:` → `group:config:` / `group:permissions:`
  - 中文术语「圈子」保留不变（用户可见展示）；后端 / 技术命名全部 `group`
- **运营管理后台命名统一**：
  - 「管理后台 CMS」/「Web CMS」/「后台 CMS」/「CMS 后台」→ `运营管理后台`
  - 「GAC CMS」→ `GAC 运营管理后台`
  - 目录约定：`apps/cms-admin/` → `apps/operation-admin/`
  - Mermaid 节点 ID 保留 `CMS` 作内部标识；显示标签全部更新
- **`prd/00-需求总览.md` 合并产品架构与产品脑图内容**：
  - 移除字段类型：ER 图保留实体关系与业务字段速览（如 `review_status`、`is_accepted`），字段类型的完整 ER 迁至 `技术方案.md`
  - 移除 §6 部署拓扑（迁至 `技术方案.md`）
  - §7 关键决策摘要拆分为「产品决策」（保留：Q&A 形态、角色双轨、UOP 审核、多市场、采纳机制、浏览策略）与「技术决策」（迁至 `技术方案.md`）
  - §3 业务流程 sequence 图：`community-service` → `后端服务`、`UOP 审核平台` → `审核平台（UOP）`、`FCM 推送` → `推送服务（FCM）`
  - **新增 §2 功能结构**：合并自 `prd/产品脑图.md`，按平台层 / 业务层组织 8 个模块的能力点
  - 顶部新增「文档边界」说明，并标注本文不涉及技术栈/部署/字段类型
  - 文档版本：1.0.0 → 1.2.0
- README：阅读顺序中 `00-需求总览.md` 描述更新为「架构图 / 功能结构树 / 角色 / 流程 / 决策」；目录树移除 `产品脑图.md` 行

### Moved
- 文档整体迁入 `docs/` 目录，按职能分层：
  - `global/` — 跨项目复用规范：`技术架构.md`、`UI设计规范.md`、技术架构图
  - `requirements/engineer-online/` — Engineer Online 需求集：
    - `prd/` — 功能模块 PRD（ 00-需求总览 / 05.01~05.08 / 需求追溯）
    - `prompts/` — AI Coding Prompt 模板（原 `prompt/` → `prompts/`）
    - `任务清单.md`、`多语言文本.md`、`技术方案.md`
  - `_archive/` — 历史会话记录
- `prd/assets/` → `requirements/engineer-online/assets/prototype/`
- `prd/角色提示词/` → `requirements/engineer-online/prompts/`

### Renamed
- `prompt/后端服务.md` → `prompts/后端接口与服务.md`
  - 原文件名易被误读为"仅 Service 层"，实际内容已覆盖 Controller（接口层）
  - 文件内 `# Prompt: 后端 Service 生成` → `# Prompt: 后端接口与服务生成`
  - README / prompts/README / global/技术架构 内引用同步更新
- `prd/国际化文本.md` → `prd/多语言文本.md`
  - "国际化"为技术术语（i18n），改为"多语言文本"对非技术读者更直观
  - 文件内标题：`# Engineer Online — 国际化文本清单（i18n Keys）` → `# Engineer Online — 多语言文本清单（i18n Keys）`
  - 16 处引用同步更新（README 4 + 技术架构 3 + 任务清单 2 + 5 个 prompt 模板 + 自身标题）
  - 技术上下文中的"国际化 / i18n / intl + ARB"等术语保留不变（仅展示名变化）

### Removed
- `prd/产品脑图.md` — 90% 内容（角色 / 数据实体 / 全局规则 / NFR / 外部依赖）与 `00-需求总览.md` 及 `产品架构.md` 重复；唯一独有的功能树已合并至 `00-需求总览.md` §2

### Fixed
- README 文档结构树更新到新的目录层级
- 文档版本号同步至 `1.3.0`（ 00-需求总览 / README / 任务清单）
- `prd/00-需求总览.md` 关键产品决策表中「采纳机制」由"单采纳"修正为"多采纳（提问者可采纳多条），采纳后不可追问"（依据 BR-5.4-03 / BR-5.4-12 / OQ-03）

---

## [1.2.0] - 2026-04-26

> 客户端架构与品牌精确化。明确 GAC APP 名称、确认 Flutter 原生 + H5 详情页拆分、架构图改 Mermaid、文件名中文化。

### Changed
- **App 命名统一**：`AION App` / `GAC AION App` 等历史写法全部替换为 `GAC APP`（保留 `AION V` 等车型表述）
- **客户端架构精确化**：
  - 5.2 / 5.3 / 5.5 / 5.6 → **Flutter 原生**
  - 5.4 → **H5 WebView**（仅此一页）
  - 5.1 / 5.7 / 5.8 → 运营管理后台（不变）
  - 各 PRD 模块 front matter 新增 `render_tech` 字段
  - 各 PRD 模块 5.x.1 功能概述新增「实现技术」行
- **00-需求总览.md**
  - 4.1 信息架构树状图加 🧩 / 🌐 图标区分 Flutter 原生 / H5 WebView
  - 5 节模块索引表新增「实现技术」列
- **技术架构.md**
  - **1.1 架构全景**：从 ASCII 改 Mermaid（含分层、客户端拆分、外部依赖、配色）
  - 1.2 技术选型矩阵：拆分「移动端 Flutter」「移动端 H5（仅 5.4）」「后台前端」「跨端集成」
  - 第 3 章前端规范：新增章节顶部「客户端承载方式」表，3.1 改为 Flutter 规范，3.2 改为仅 5.4 H5 规范，3.3 为 运营管理后台
  - 第 8 章 JSBridge：明确仅适用于 5.4 H5 详情页
  - 第 13 章 AI Coding 示例：拆为 Flutter 原生页面、H5 详情页两类
- **UI设计规范.md**
  - 顶部新增「0. 跨技术栈说明」章节，明确 Design Token 三端共享、组件规格在 Flutter / H5 / 运营管理后台 各自实现
- **角色提示词/**
  - 拆分 `H5详情页.md` 与 `Flutter页面.md`，各自针对承载方式
  - `prompt/README.md` 索引表新增"适用模块"列

### Added
- `prompts/Flutter页面.md` — Flutter 原生页面生成 prompt（覆盖 5.2/5.3/5.5/5.6）

### Renamed
> 文件名统一中文（除 `README.md` / `CHANGELOG.md` / `PRD-TEMPLATE.md` 外）。所有交叉引用已同步更新。

| 旧路径 | 新路径 |
|--------|--------|
| `tech-architecture.md` | `技术架构.md` |
| `ui-spec.md` | `UI设计规范.md` |
| `task.md` | `任务清单.md` |
| `prd/i18n-keys.md` | `多语言文本.md` |
| `prd/traceability.md` | `需求追溯.md` |
| `prd/product-architecture.md` | `prd/产品架构.md` |
| `prd/product-mindmap.md` | `prd/产品脑图.md` |
| `prd/prompts/` | `prompts/` |
| `prd/prompts/h5-page.md` | `prompts/H5详情页.md` |
| `prd/prompts/operation-admin-page.md` | `prompts/管理后台页面.md` |
| `prd/prompts/backend-service.md` | `prompts/后端接口与服务.md` |
| `prd/prompts/backend-database.md` | `prompts/数据库设计.md` |
| `prd/prompts/test-case.md` | `prompts/测试用例.md` |
| `prd/prompts/api-mock.md` | `prompts/API模拟数据.md` |

---

## [1.1.0] - 2026-04-26

> AI Coding 一致性增强版。修复 P0 一致性问题、补全模块元数据与 API 样例、新增 Permission Code / i18n / Prompt 模板 / Traceability。

### Changed
- **00-需求总览.md**
  - 关闭 OQ-01~06、08、09（图片 ≤5MB / 视频 ≤50MB / 多采纳 / UOP 三级审核 / Google Translate / 仅车主可提问 / 不主动关闭问题 / 富文本白名单）
  - 新增术语：SIA、广播组、技术主管、SSA、FCM
  - 权限矩阵补充 OFFICIAL_ENGINEER / OFFICIAL_PM 子类型说明
  - 新增 3.4 节 Permission Code 列表（resource:action:scope 三段式）
  - 新增 5.1 节模块依赖图（Mermaid）
  - 新增 RR-04（官方号子类型权限等价）、RR-05（跨圈子角色独立）
  - GR-PAGE-01 明确移动端使用 cursor 分页
  - GR-CONTENT-02/03 落实图片视频限制
  - GR-CONTENT-05 新增富文本白名单规则
  - 评审清单扩充至 9 项
- **PRD-TEMPLATE.md**
  - 新增多页面（页面 A/B/C）支持，元素编号 `E-A-01` 形式
  - P2/P3 必填项增加 5.x.5 异常处理
  - API 契约 5.x.10 新增 sample payload 槽位
  - 新增模块级 YAML front matter 模板
  - 新增 3.4 Permission Code 模板章节
  - 新增附录 B Traceability Matrix 模板
- **05.01~05.08**
  - 全部加上 YAML front matter（module/title/priority/layer/depends_on/entities/apis/permission_codes/updated）
  - 文件顶部新增原型图 markdown 引用
  - 「原型链接」字段从纯文件名升级为 markdown 链接（`./assets/xxx.png`）
- **05.02 问题浏览**：API 切换 cursor 分页 + 添加 sample payload
- **05.03 问题发布**：BR-5.3-03 落实图片大小，BR-5.3-11/12 新增视频和 OSS 直传规则；EX 重整为 10 条；新增 sample payload
- **05.04 详情与回答**：新增 sample payload（详情/投票/采纳/翻译）
- **05.05 搜索**：BR-5.5-07 加 ES + MySQL 降级；EX-5.5-04/05 新增；新增 sample payload
- **05.06 消息通知**：cursor 分页 + sample payload
- **05.07 问题管理**：新增 5.7.10 API 契约 + sample payload
- **05.08 回答管理**：状态机拆分为审核状态机 + 推送状态机 + 状态组合矩阵；新增 5.8.10 API + sample payload

### Added
- `多语言文本.md` — 中/英/泰三语 UI 文本字典
- `需求追溯.md` — BR ↔ EX ↔ AC ↔ 任务 ↔ API 追溯矩阵
- `prompts/README.md` — Prompt 模板索引
- `prompts/H5详情页.md` — H5 移动端页面生成 prompt
- `prompts/管理后台页面.md` — 管理后台页面生成 prompt
- `prompts/后端服务.md` — 后端 Service 生成 prompt
- `prompts/数据库设计.md` — 数据库 Schema 生成 prompt
- `prompts/测试用例.md` — 测试用例生成 prompt
- `prompts/API模拟数据.md` — API Mock 数据集生成 prompt
- `assets/architecture/` 目录 — 移入技术架构图
- `_archive/` 目录 — 归档历史会话记录与备份

### Fixed
- `prd/产品架构.md` 内容已合并至 `prd/00-需求总览.md`；`prd/产品脑图.md` 已删除
- 文件名前导 0（`05.01-xxx.md`）与文档内部编号（`5.1`）的差异在 00-需求总览中明确说明
- 技术架构 与 PRD 在图片/视频大小、cursor 分页、ES 引擎等参数上达成一致
- Answer 实体的双状态字段（review_status / push_status）现以独立状态机表示
- BR-5.4-13/14/15 等新增条目对应的 Open Questions 已关闭

### Moved
- `session-log-2026-04-25.md` → `_archive/session-log-2026-04-25.md`
- `prd/assets/服务端技术架构图.png` → `assets/architecture/服务端技术架构图.png`
- `prd/assets/管理后台前端技术架构图.png` → `assets/architecture/管理后台前端技术架构图.png`
- `prd/assets/规范1备份.png` → `_archive/规范1备份.png`

---

## [1.0.0] - 2026-04-25

### Added
- 初始版本：8 个功能模块 PRD（5.1~5.8）
- PRD 模板（PRD-TEMPLATE.md）
- 技术架构文档（技术架构.md）
- UI 设计规范（UI设计规范.md）
- 开发任务清单（任务清单.md）
- 8 张原型截图（assets/）
- README 文档索引
