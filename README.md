# 🏦 SelfBank — 个人成长银行

一个记录和可视化个人成长数据的全栈 Web 应用。像管理银行账户一样管理你的**时间**、**金钱**、**技能**和**产品**——每一分投入都有迹可循。

> 🌐 在线地址：[**selfbank.onrender.com**](https://selfbank.onrender.com/)

## ✨ 功能

- **🔐 用户系统**：邮箱注册/登录，数据按用户隔离，Session Cookie 认证
- **⏱️ 学习计时**：开始/结束计时，自动统计今日/本月/总计学习时长
- **💰 资金账户**：收入/支出记录，自动计算余额与月度汇总
- **🧠 技能账户**：技能名称、学习时长、熟练度管理
- **🚀 产品账户**：产品/项目成果追踪，记录完成日期与链接
- **📥 数据导入/导出**：JSON 格式一键备份与恢复，数据完全由你掌控
- **🌙 暗色主题**：现代化深色 UI，移动端响应式设计

## 🛠 技术栈

| 层级 | 技术 |
|------|------|
| 后端 | Python 3.10+, Flask, SQLAlchemy ORM |
| 数据库 | SQLite（本地开发）/ PostgreSQL（生产） |
| 前端 | 原生 HTML + CSS + JavaScript，Jinja2 模板 |
| 认证 | Flask-Login + Werkzeug 密码哈希 |
| WSGI | Gunicorn（生产环境） |
| 部署 | [Render](https://render.com) |

## 🚀 本地运行

### 1. 克隆项目

```bash
git clone git@github.com:boombosi/self-improvement.git
cd self-improvement
```

### 2. 创建虚拟环境并安装依赖

```bash
python -m venv venv

# Windows
venv\Scripts\activate

# macOS / Linux
source venv/bin/activate

pip install -r requirements.txt
```

### 3. 设置环境变量

在项目根目录创建 `.env` 文件：

```env
SECRET_KEY=your-random-secret-key
```

> `.env` 会被 `python-dotenv` 自动加载，无需手动 export。

### 4. 运行

```bash
python app.py
```

首次运行会自动创建 `dashboard.db` SQLite 数据库。访问 http://localhost:5000 即可使用。

## ☁️ 部署到 Render

本项目已部署在 Render 上：[selfbank.onrender.com](https://selfbank.onrender.com/)

### 自行部署步骤

1. **Fork 本仓库**到你的 GitHub
2. 登录 [Render](https://render.com)，点击 **New +** → **Web Service**
3. 连接你的 GitHub 仓库
4. 配置：
   - **Name**: `selfbank`（或其他你喜欢的名字）
   - **Environment**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `gunicorn app:app`
5. 在 **Environment Variables** 中添加：
   - `SECRET_KEY` — 随机字符串（必填）
   - `DATABASE_URL` — PostgreSQL 连接地址（Render 会自动提供）

> ✅ 生产环境使用 **PostgreSQL** 持久化数据。`app.py` 在 Gunicorn 导入时自动创建数据库表，无需手动迁移。

## 📁 项目结构

```
self-improvement/
├── app.py                 # Flask 主应用（模型、路由、API）
├── requirements.txt       # Python 依赖
├── .env                   # 本地环境变量（不入 git）
├── README.md
├── templates/
│   └── index.html         # 单页应用模板（Jinja2）
└── static/
    ├── style.css           # 暗色主题样式
    └── app.js              # 前端交互逻辑（AJAX）
```

## 📡 API 概览

所有数据 API 需登录认证（Session Cookie），前缀 `/api`。

### 认证

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/api/auth/register` | 注册（邮箱 + 密码 + 确认密码） |
| POST | `/api/auth/login` | 登录 |
| POST | `/api/auth/logout` | 退出 |
| GET | `/api/auth/me` | 当前用户信息 |

### 学习计时

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/api/study/start` | 开始学习，返回 session_id |
| POST | `/api/study/end` | 结束学习，传入 session_id |
| GET | `/api/study/stats` | 学习统计（今日/本月/总计） |
| GET | `/api/study/sessions` | 最近 10 条学习记录 |

### 资金账户

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/finance` | 资金记录列表 |
| POST | `/api/finance` | 添加资金记录 |
| PUT | `/api/finance/<id>` | 更新资金记录 |
| DELETE | `/api/finance/<id>` | 删除资金记录 |
| GET | `/api/finance/summary` | 资金汇总（余额/月收入/月支出） |

### 技能账户

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/skills` | 技能列表 |
| POST | `/api/skills` | 添加技能 |
| PUT | `/api/skills/<id>` | 更新技能 |
| DELETE | `/api/skills/<id>` | 删除技能 |

### 产品账户

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/products` | 产品列表 |
| POST | `/api/products` | 添加产品 |
| PUT | `/api/products/<id>` | 更新产品 |
| DELETE | `/api/products/<id>` | 删除产品 |

### 数据管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/export` | 导出所有数据（JSON） |
| POST | `/api/import` | 导入数据（JSON） |
| POST | `/api/clear` | 清空所有数据 |

## 📄 License

MIT
