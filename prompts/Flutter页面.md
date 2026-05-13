---
doc_type: "prompt_template"
role: "Flutter 移动端"
output_artifacts: ["Flutter 页面", "Riverpod controller", "Repository", "Widget", "l10n key"]
applicable_modules: ["5.2", "5.3", "5.5", "5.6"]
version: "1.0.0"
updated: "2026-05-13"
---

# Prompt: Flutter 原生页面生成

> **适用角色**：Flutter 移动端
> **输出工件**：Flutter 页面 + Riverpod controller + Repository + Widget + l10n key
> **适用模块**：5.2 圈子首页 / 5.3 问题发布 / 5.5 搜索 / 5.6 消息通知（H5 详情页见 `H5详情页.md`）

> **路径规则**：以下路径均以仓库根目录为基准。

---

## 你需要先读这些文档

按顺序加载（如果你是按任务编号工作，先看第 1 步；如果你是按模块直接开发，可从第 2 步开始）：

1. `tasks/任务清单.md` 中对应任务行（如 `QLIST-04`、`QPOST-01`）
2. `requirement/00-需求总览.md` 第 1.4 节（术语表）、第 1.5 节（角色权限）、第 6 节（全局规则）
3. `design/权限设计.md`（Permission Code）
4. `requirement/modules/<目标模块>.md` 全文（5.2 / 5.3 / 5.5 / 5.6 之一）
5. `standard/技术架构.md` 第 3.1 节（Flutter 规范）、第 5 章（接口）、第 8 章（WebView 集成，仅作 5.4 跳转用）、第 9 章（i18n）
6. `standard/UI设计规范.md` 第 1 章（Design Token）、相关页面节
7. `requirement/多语言文本.md` 对应模块文本

## 你需要输出

### 1. 页面 `lib/features/<feature>/view/<feature>_page.dart`

要求：
- `StatelessWidget` + Riverpod `ConsumerWidget`
- Scaffold + AppBar 复用 `core/widgets/app_top_bar.dart`
- 顶部 padding 适配 `MediaQuery.of(context).padding.top`
- 严格使用 `AppColors.xxx` / `AppSpacing.xxx` / `AppTextStyles.xxx`
- 任何字符串都走 `AppLocalizations.of(context).xxx`，禁止硬编码

### 2. Controller `lib/features/<feature>/controller/<feature>_controller.dart`

要求：
- 使用 Riverpod `StateNotifier` 或 `AsyncNotifier`
- 列表页状态：
```dart
class ListState<T> {
  final List<T> items;
  final bool loading;
  final bool refreshing;
  final String? errorMessage;
  final String? nextCursor;
  bool get hasMore => nextCursor != null;
  bool get isEmpty => !loading && items.isEmpty;
}
```
- 对外暴露 `loadInitial / loadMore / refresh / retry` 方法

### 3. Repository `lib/features/<feature>/repository/<feature>_repository.dart`

要求：
- Retrofit 生成 typed client
- 与 PRD 5.x.10 接口签名一一对应
- 错误统一抛 `ApiException(code, message, data)`，由 Controller 转 UI 状态

### 4. 业务 widget `lib/features/<feature>/widgets/`

要求：
- 一个 widget 一个文件
- 公共组件（`QuestionCard`、`StatsSection`、`TabBar`）放 `lib/shared/widgets/`，跨 feature 复用
- 使用 `cached_network_image` 显示头像/图片，配占位骨架

### 5. 路由注册 `lib/app.dart`

要求：
- GoRouter 路由：`/home`、`/ask`、`/search`、`/notifications`
- 跳转 5.4 详情页：`/question-detail-webview?questionId={id}`，目标是 `QuestionDetailWebViewPage`

### 6. l10n ARB

要求：
- 新增的所有 key 同步追加到 `lib/core/i18n/app_zh.arb`、`app_en.arb`、`app_th.arb`
- key 命名与 `requirement/多语言文本.md` 完全一致

## 严格约束

| 项 | 规则 |
|---|------|
| **追溯注释** | 每个生成文件顶部用注释标注引用的 BR/AC 编号（如 `// BR-5.2-06, AC-5.2-07`），便于反向追溯 |
| **i18n** | 任何 UI 文本通过 `AppLocalizations.of(context).xxx`，禁止 `Text('Hot')` |
| **Design Token** | 使用 `AppColors.primary`、`AppSpacing.x4` 等常量；禁止 `Color(0xFF...)` 直接写 |
| **跨 5.4 跳转** | 列表点击问题卡片 → push `QuestionDetailWebViewPage`，传 `questionId` |
| **JWT** | 由 Dio Interceptor 统一注入，不在页面层处理 |
| **错误码** | 401 跳登录 / 403 提示无权限 / 4xxx 显示业务文案；遵循 `design/错误码.md` |
| **图片懒加载** | `cached_network_image` + 骨架；列表使用 `ListView.builder` 而非 `Column` |
| **下拉刷新** | `RefreshIndicator` + Controller refresh 方法 |
| **无限滚动** | `ScrollController` 监听底部到达；触发 `loadMore` |
| **空状态** | 自定义 `EmptyState` widget，含图标 + 文字 + 主按钮 |
| **键盘** | 输入页面使用 `resizeToAvoidBottomInset: true` + `SingleChildScrollView` |

## 自检清单（输出末尾必填）

- [ ] 实现的 BR 编号清单
- [ ] 处理的 EX 编号清单
- [ ] 满足的 AC 编号清单
- [ ] 引用的 i18n key 清单
- [ ] 调用的 API 列表（含错误码处理）
- [ ] 是否需要新增 ARB key（zh/en/th 都要补）
- [ ] 跨页跳转目的地（特别注意 5.4 的 WebView 跳转）
- [ ] 未实现 / 偏差项 + 原因

## 反例

```dart
// ❌ 硬编码文本
Text('Ask a Question')

// ❌ 硬编码颜色
Container(color: Color(0xFF009EFF))

// ❌ 没有错误处理
final res = await api.list(groupId, 'hot', null, 20);

// ✅
Text(AppLocalizations.of(context).homeCtaAsk)
Container(color: AppColors.primary)
final res = ref.read(homeControllerProvider.notifier).loadInitial();
```
