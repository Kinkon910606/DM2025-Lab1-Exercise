# Terminal Commands for Virtual Environment Setup

## 生成終端機指令 (Terminal Commands)

以下是創建新的虛擬環境並從 `pyproject.toml` 安裝依賴項的完整終端機指令：

### 方法 1: 標準 Python venv（推薦）

```bash
# 1. 檢查 Python 版本
python3 --version

# 2. 創建虛擬環境
python3 -m venv dm2025-lab1-venv

# 3. 啟動虛擬環境
source dm2025-lab1-venv/bin/activate

# 4. 升級 pip
pip install --upgrade pip

# 5. 安裝依賴項
pip install jupyter>=1.1.1 matplotlib>=3.9.4 nltk>=3.9.1 numpy>=2.0.2 pami>=2025.7.3.1 pandas>=2.3.2 plotly>=6.3.0 scikit-learn>=1.6.1 seaborn>=0.13.2 umap-learn>=0.5.9.post2 wordcloud>=1.9.3
```

### 方法 2: 使用自動化腳本

```bash
# 運行自動化設置腳本
chmod +x setup_venv_simple.sh
./setup_venv_simple.sh
```

### 方法 3: 一行命令創建和安裝

```bash
python3 -m venv dm2025-lab1-venv && source dm2025-lab1-venv/bin/activate && pip install --upgrade pip && pip install jupyter matplotlib nltk numpy pami pandas plotly scikit-learn seaborn umap-learn wordcloud
```

## 日常使用指令

### 啟動虛擬環境
```bash
source dm2025-lab1-venv/bin/activate
```

### 關閉虛擬環境
```bash
deactivate
```

### 運行 Jupyter Notebook
```bash
source dm2025-lab1-venv/bin/activate
jupyter notebook
```

### 運行主程式
```bash
source dm2025-lab1-venv/bin/activate
python main.py
```

### 檢查已安裝的套件
```bash
pip list
```

### 安裝額外套件
```bash
pip install 套件名稱
```

## Windows 用戶指令

如果您使用 Windows，請使用以下指令：

```cmd
# 創建虛擬環境
python -m venv dm2025-lab1-venv

# 啟動虛擬環境
dm2025-lab1-venv\Scripts\activate

# 升級 pip
pip install --upgrade pip

# 安裝依賴項
pip install jupyter>=1.1.1 matplotlib>=3.9.4 nltk>=3.9.1 numpy>=2.0.2 pami>=2025.7.3.1 pandas>=2.3.2 plotly>=6.3.0 scikit-learn>=1.6.1 seaborn>=0.13.2 umap-learn>=0.5.9.post2 wordcloud>=1.9.3
```

## 備選方案：使用 uv (如果可用)

```bash
# 安裝 uv (如果尚未安裝)
curl -LsSf https://astral.sh/uv/install.sh | sh

# 創建虛擬環境
uv venv dm2025-lab1-venv

# 啟動環境
source dm2025-lab1-venv/bin/activate

# 安裝依賴項
uv pip install -e .
```

## 故障排除

### Python 版本問題
```bash
# 檢查 Python 版本
python3 --version

# 如果版本不符合要求 (>=3.9, <3.13)，請安裝適當版本
```

### 權限問題
```bash
# 如果遇到權限錯誤
chmod +x setup_venv_simple.sh
```

### 重新創建環境
```bash
# 刪除現有環境
rm -rf dm2025-lab1-venv

# 重新創建
python3 -m venv dm2025-lab1-venv
source dm2025-lab1-venv/bin/activate
pip install --upgrade pip
pip install jupyter matplotlib nltk numpy pami pandas plotly scikit-learn seaborn umap-learn wordcloud
```

### 網路連接問題
```bash
# 如果 PyPI 連接超時，可以使用鏡像源
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ jupyter matplotlib nltk numpy pami pandas plotly scikit-learn seaborn umap-learn wordcloud
```

## 專案依賴項說明

本專案包含以下主要依賴項：
- **jupyter**: 交互式筆記本環境
- **matplotlib**: 數據可視化庫
- **nltk**: 自然語言處理工具包
- **numpy**: 數值計算庫
- **pami**: 模式挖掘算法庫
- **pandas**: 數據分析庫
- **plotly**: 交互式圖表庫
- **scikit-learn**: 機器學習庫
- **seaborn**: 統計數據可視化
- **umap-learn**: 降維算法
- **wordcloud**: 詞雲生成工具

這些依賴項會在運行安裝指令時自動安裝。