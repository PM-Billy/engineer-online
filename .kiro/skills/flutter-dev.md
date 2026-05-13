---
inclusion: manual
---

# Flutter 开发 Skill

你是 Engineer Online 项目的 Flutter 移动端开发者。按以下规范生成代码。

## 上下文加载

按顺序读取以下文档（如果用户指定了任务编号，从第 1 步开始；否则从第 2 步）：

1. `tasks/任务清单.md` — 找到对应任务行，确认依赖和验收标准
2. `requirement/00-需求总览.md` §1.4 术语 / §1.5 角色权限 / §6 全局规则
3. `requirement/modules/<目标模块>.md` — 重点读 ai_focus_sections（见 `index/spec-index.yaml`）
4. `design/权限设计.md` — Permission Code 常量
5. `design/错误码.md` — 错误处理
6. `standard/技术架构.md` §3.1 Flutter 规范 / §5 接口 / §9 i18n
7. `design/UI设计.md` — 对应页面的业务组件和模板
8. `requirement/多语言文本.md` — 对应模块的 i18n key

## 输出规范

- 页面：`lib/features/<feature>/view/<feature>_page.dart`（StatelessWidget + ConsumerWidget）
- Controller：`lib/features/<feature>/controller/<feature>_controller.dart`（Riverpod AsyncNotifier）
- Repository：`lib/features/<feature>/repository/<feature>_repository.dart`（Retrofit typed client）
- Widget：`lib/features/<feature>/widgets/`（一个 widget 一个文件）
- 路由：GoRouter 注册到 `lib/app.dart`

## 严格约束

- **i18n**：所有文本通过 `AppLocalizations.of(context).xxx`，禁止硬编码
- **Design Token**：使用 `AppColors.primary`、`AppSpacing.x4`，禁止 `Color(0xFF...)`
- **错误码**：401 跳登录 / 403 提示无权限 / 4xxx 显示业务文案（来自 `design/错误码.md`）
- **图片**：`cached_network_image` + 骨架占位
- **列表**：`ListView.builder` + `RefreshIndicator` + cursor 无限滚动
- **跨 5.4 跳转**：点击问题卡片 → push `QuestionDetailWebViewPage`，传 `questionId`
- **追溯注释**：每个文件顶部注释标注引用的 BR/AC 编号

## 自检清单

输出末尾必须列出：
- [ ] 实现的 BR 编号
- [ ] 处理的 EX 编号
- [ ] 满足的 AC 编号
- [ ] 引用的 i18n key
- [ ] 调用的 API（含错误码处理）
- [ ] 未实现/偏差项 + 原因
