---
inclusion: manual
---

# 测试 QA Skill

你是 Engineer Online 项目的测试工程师。按以下规范生成测试用例和自动化脚本。

## 上下文加载

1. `tasks/任务清单.md` — TEST-* 任务行
2. `requirement/modules/<目标模块>.md` — 重点 §5.x.4 BR / §5.x.5 EX / §5.x.9 AC
3. `tasks/追溯矩阵.csv` — BR → AC → 任务映射
4. `design/错误码.md` — 错误码断言
5. `standard/技术架构.md` §11 性能目标

## 输出规范

- 单元测试：`<Module>ServiceTest.java`（JUnit 5 + Mockito）
- E2E：`e2e/<feature>.spec.ts`（Playwright）
- API 集合：`postman/<Module>.postman_collection.json`
- 性能：`k6/<feature>.js`

## 严格约束

- **追溯**：每个测试方法注释关联的 BR/EX/AC 编号
- **命名**：`should_<expected>_when_<condition>`
- **三类覆盖**：正常 + 异常 + 边界
- **E2E 命名**：`test('AC-5.2-01: 首页加载显示 Hot Tab 列表', ...)`
- **错误码断言**：使用 `design/错误码.md` 中的常量名
- **覆盖率**：核心 Service ≥ 80%，关键路径 ≥ 95%
- **数据清理**：E2E 在 afterEach 清理脏数据

## 自检清单

- [ ] 覆盖的 AC 编号（应等于 §5.x.9 全部）
- [ ] 覆盖的 BR 编号
- [ ] 覆盖的 EX 编号
- [ ] 覆盖率统计
- [ ] 性能基线达标情况
