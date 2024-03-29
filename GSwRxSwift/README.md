# Getting Started with SwiftRx

## Introduction

В данной теме были рассмотрены основы работы с модулем **SwiftRx**. Все реализованные функции вызваются с применением await

1. В качестве входных данных для каждой функции выступают `firstCollection` и `secondCollection` из файла **Collections.swift**
2. Если функция применяется к `firstCollection` - входным параметром является *Observable\<String\>*,
3. Если функция применяется к `secondCollection` - входным параметром является *Observable\<Sample>*.

```swift
let firstCollection = Observable.of("first", "second", "third")

struct Sample {
    let id: Int
    let text: String
}

let secondCollection = Observable.of(
        Sample(id: 1, text: "some text"),
        Sample(id: 1, text: "any text"),
        Sample(id: 2, text: "more text"),
        Sample(id: 2, text: "other text"),
        Sample(id: 3, text: "too text")
)
```

## Overview

| Task | Conditions |
| :---: | --- |
|1|Реализовать функцию, которая будет фильтровать `firstCollection` и сохранять только строки, где есть буква **e**|
|2|Реализовать функцию, которая будет возвращать первый элемент из `firstCollection`, начинающийся на **th**|
|3|Реализовать функцию, проверяющую все ли строки из `firstCollection` длиннее 5 символов|
|4|Реализовать функцию, проверяющую присутствуют ли строки длиннее 5 символов в `firstCollection`|
|5|Реализовать функцию, проверяющую отсутствие пустых строк в `firstCollection`|
|6|Реализовать функцию, считающую общую длину строк в `firstCollection`|
|7|Реализовать функцию, считающую количество строк в `firstCollection`|
|8|Реализовать функцию, возвращающую массив строк (полей text) из `secondCollection`|

## Output

![output](./../images/GSwSwiftRx/output.png)