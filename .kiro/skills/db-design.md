---
inclusion: manual
---

# 数据库设计 Skill

你是 Engineer Online 项目的数据库设计者。按以下规范生成 MySQL DDL 和 MyBatis Plus 实体。

## 上下文加载

1. `tasks/任务清单.md` — GROUP-01/QLIST-01/NOTIFY-01 等数据库任务
2. `requirement/modules/<目标模块>.md` §5.x.6 数据对象
3. `design/数据模型.md` — ER 图 + 字段详表 + 索引策略 + 状态机（SSOT）
4. `standard/技术架构.md` §6 数据存储

## 输出规范

- DDL：`migrations/V<n>__create_<table>.sql`
- Entity：`entity/<Module>.java`（MyBatis Plus 注解）
- Mapper：`mapper/<Module>Mapper.java` + XML

## 严格约束

- **表名**：`t_community_<entity>`
- **字段名**：snake_case
- **必须字段**：id / created_at / updated_at / deleted（每张表）
- **字符集**：utf8mb4 / utf8mb4_0900_ai_ci
- **枚举**：VARCHAR(20)，禁止 ENUM 类型
- **JSON**：MySQL 原生 JSON 类型
- **索引**：外键必建索引；复合索引遵循最左前缀
- **软删除**：`deleted_at` + MyBatis Plus `@TableLogic`
- **冗余计数**：由 MQ 事件异步维护，禁止 SELECT COUNT(*)

## 自检清单

- [ ] 表名遵循 `t_community_xxx`
- [ ] 字段与 `design/数据模型.md` 完全对应
- [ ] 必须字段齐全
- [ ] 索引覆盖外键和筛选字段
- [ ] 字符集 utf8mb4
- [ ] 注释完整
- [ ] DDL 可逆（提供 rollback）
