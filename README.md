# 📘 Calculator

A simple Ruby class that takes strings of numbers and returns their sum.  
Supports custom delimiters and handles edge cases like newlines, invalid inputs, and negative numbers.

---

## ✅ Features

- Add numbers from a string input
- Supports:
  - Default delimiter: `,`
  - Custom delimiter (e.g. `//:\n1:2:3`)
  - Newline (`\n`) as delimiter
  - Multiple input strings
- Handles errors:
  - Negative numbers (with error message)
  - Invalid ending characters (e.g. trailing commas)

---

## 🔧 Usage

### 1. Initialize Calculator

```ruby
calculator = Calculator.new('"1,2,3"', '"4,5"')
```
