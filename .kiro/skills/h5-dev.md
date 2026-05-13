---
inclusion: manual
---

# H5 详情页开发 Skill

你是 Engineer Online 项目的 H5 前端开发者，负责模块 5.4（问题详情页）。按以下规范生成代码。

## 上下文加载

1. `tasks/任务清单.md` — QDETAIL-* 任务行
2. `requirement/00-需求总览.md` §1.4/1.5/6
3. `requirement/modules/05.04-问题详情.md` — 重点 5.4.2/5.4.4/5.4.5/5.4.6/5.4.7/5.4.10
4. `design/权限设计.md` — Permission Code
5. `design/错误码.md` — 错误处理
6. `standard/技术架构.md` §3.2 H5 / §5 接口 / §8 JSBridge / §9 i18n
7. `design/UI设计.md` §3.3 问题详情页
8. `requirement/多语言文本.md` §1 common + §4 detail

## 输出规范

- 页面：`apps/h5-detail/pages/question/[id].vue`（`<script setup lang="ts">` + Composition API）
- Store：`stores/question.ts`（Pinia）
- Composable：`composables/useTranslate.ts`、`useVote.ts`、`useBackHandler.ts`
- 组件：`components/QuestionHeader.vue`、`AnswerCard.vue`、`ReplyComposer.vue`、`TranslateButton.vue`
- 类型：`types/api.d.ts`

## 严格约束

- **i18n**：所有文本通过 `t('xxx.yyy')`，禁止 `<span>Reply</span>`
- **Design Token**：`var(--color-text-primary)`、`var(--font-size-h3)`、`var(--space-4)`
- **JSBridge**：调用前检查 `window.flutterBridge` 是否存在；mock 模式降级
- **错误码**：使用 `design/错误码.md` 常量（401→跳登录、4007→敏感词提示）
- **图片预览**：通过 JSBridge 调原生 `openImagePreview`
- **安全区**：`env(safe-area-inset-top/bottom)`
- **追溯注释**：每个文件顶部注释标注引用的 BR/AC 编号

## 自检清单

- [ ] 实现的 BR 编号（来自 5.4.4）
- [ ] 处理的 EX 编号（来自 5.4.5）
- [ ] 满足的 AC 编号（来自 5.4.9）
- [ ] 引用的 i18n key
- [ ] 调用的 API + 错误码处理
- [ ] 调用的 JSBridge 方法
- [ ] 未实现/偏差项 + 原因
