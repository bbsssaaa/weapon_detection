#  Система распознавания оружия

##  Цель
Система для обнаружения и классификации оружия (ножи и огнестрельное оружие) в реальном времени.  
Разработана на основе YOLOv8 с использованием кастомного датасета.

##  Архитектура модели
В качестве базовой архитектуры использовалась YOLOv8n (nano):
- Лёгкая и быстрая версия YOLOv8
- Оптимизирована для работы в реальном времени (30+ FPS)
- Использовалась как для базовой модели (Before Knife Boost), так и для улучшенной (After Knife Boost)

## Классы
- Knife – все виды ножей  
- Gun – пистолеты, винтовки и другое огнестрельное оружие

## Спецификация Датасета
- Источник: Open Images  
- Баланс классов:

| Split        | Knife | Gun   | Всего |
|--------------|-------|-------|-------|
| Train (75.4%)|  2545 |  5938 | 8 483 |
| Val (16.4%)  |  554  |  1294 | 1 848 |
| Test (8.2%)  |   277 |   648 |   925 |
|    ИТОГО     | 3,376 | 7,880 | 11,256|

## Технический Подход
- Базовая архитектура: YOLOv8n  
- Дообучение на кастомном датасете  
- Гиперпараметры: см. `hyp_knife.yaml`  
- Метрики: `mAP@0.5`, `Precision`, `Recall` 


---

## Запуск

### 1. Установка окружения
#### Требования к окружению
- Python 3.11.9
- NVIDIA CUDA 11.8
- NVIDIA драйвер >= 520.xx


<pre>
powershell:

python -m venv weapon-det-env

./weapon-det-env/Scripts/Activate.ps1

pip install -r requirements.txt  
</pre>
```ВАЖНО!```  
Вручную установите необходимую версию torch, torchvision:  
<pre>
powershell:

pip install torch==2.1.2+cu118 torchvision==0.16.2+cu118 --index-url https://download.pytorch.org/whl/cu118
</pre>

```ВАЖНО!```
Скачивая репозиторий, вам будет достпна только демонстрация результатов на основе модели (сэмплы видео лежат в **samples/**, результаты в **runs/demo**) и экпорт моделей, так как локально нет полного датасета.  




### 2. Обучение
<pre>
powershell:

./scripts/train_before.ps1

./scripts/train_after.ps1  
</pre>

### 3. Валидация  
<pre>
powershell:

./scripts/val_before.ps1

./scripts/val_after.ps1

./scripts/val_both.ps1   # сравнение before/after  
</pre>
### 4. Демонстрация 
<pre>
powershell:

./scripts/predict_before_knife.ps1  

./scripts/predict_after_knife.ps1  

./scripts/predict_before_weapon.ps1  

./scripts/predict_after_weapon.ps1  
</pre>

### 5. Экспорт моделей
<pre>
powershell:

scripts\export_before.ps1  

scripts\export_after.ps1  
</pre>

## Результаты
**mAP@0.5 (After Knife Boost):** >85%  
**Скорость:** 30+ FPS (NVIDIA RTX 3060 Laptop GPU)  
**Ложные срабатывания:** <5%  
Улучшение по классу knife подтверждено сравнением (runs/reports/)

## Формат Вывода  
**"knife"  
"gun"**