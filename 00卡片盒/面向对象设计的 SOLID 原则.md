---
title: 面向对象设计的 SOLID 原则
tags: [card]
created: 2025-06-07T13:14:14
updated: 2025-06-09T08:17:23
---

# 面向对象设计的 SOLID 原则

SOLID 原则：单一职责原则、开闭原则、里氏替换原则、接口隔离原则、依赖倒置原则

## 单一职责原则 (Single Responsibility Principle, SRP)
每个类应该只有一个引起它变化的原因，即一个类只负责一项职责。

## 开闭原则 (Open-Closed Principle, OCP)
软件实体（类、模块、函数等）应该对扩展开放，对修改关闭。

## 里氏替换原则 (Liskov Substitution Principle, LSP)
子类型必须能够替换它们的基类型，而不影响程序的正确性。

## 接口隔离原则 (Interface Segregation Principle, ISP)
客户端不应该被迫依赖它们不使用的接口，应该将臃肿的接口拆分成更小更具体的接口。

## 依赖倒置原则 (Dependency Inversion Principle, DIP)
高层模块不应该依赖低层模块，两者都应该依赖抽象；抽象不应该依赖细节，细节应该依赖抽象。

用一个实际的案例，贯穿解释 SOLID 原则

# 电商订单系统案例解析 SOLID 原则

## 案例背景
我们设计一个电商平台的订单处理系统，通过这个案例来展示如何应用 SOLID 原则。

## 1. 单一职责原则应用

### 原始设计问题

```java
class OrderProcessor {
    public void process(Order order) {
        // 验证订单
        // 计算价格
        // 保存到数据库
        // 发送邮件通知
    }
}
```

### 重构后设计

```java
class OrderValidator {
    public void validate(Order order) { /*...*/ }
}

class PriceCalculator {
    public void calculate(Order order) { /*...*/ }
}

class OrderRepository {
    public void save(Order order) { /*...*/ }
}

class NotificationService {
    public void sendEmail(Order order) { /*...*/ }
}
```

每个类只负责一个明确的功能，修改验证逻辑不会影响价格计算等其他功能。

## 2. 开闭原则应用

### 支付方式扩展

```java
interface PaymentMethod {
    void processPayment(double amount);
}

class CreditCardPayment implements PaymentMethod {
    public void processPayment(double amount) { /*...*/ }
}

class PayPalPayment implements PaymentMethod {
    public void processPayment(double amount) { /*...*/ }
}

class PaymentProcessor {
    public void process(PaymentMethod method, double amount) {
        method.processPayment(amount);
    }
}
```

当需要新增支付方式 (如加密货币) 时，只需新增实现类而不需修改现有代码。

## 3. 里氏替换原则应用

### 折扣策略设计

```java
abstract class DiscountStrategy {
    abstract double applyDiscount(double originalPrice);
}

class PercentageDiscount extends DiscountStrategy {
    public double applyDiscount(double originalPrice) {
        return originalPrice * 0.9; // 10%折扣
    }
}

class FixedAmountDiscount extends DiscountStrategy {
    public double applyDiscount(double originalPrice) {
        return originalPrice - 50; // 固定减50
    }
}
```

任何 DiscountStrategy 的子类都可以互换使用，不会破坏原有逻辑。

## 4. 接口隔离原则应用

### 订单接口拆分

```java
// 不好的设计
interface OrderOperations {
    void createOrder();
    void updateOrder();
    void deleteOrder();
    void printInvoice();
    void generateReport();
}

// 好的设计
interface OrderCRUD {
    void createOrder();
    void updateOrder();
    void deleteOrder();
}

interface OrderPrinting {
    void printInvoice();
}

interface OrderReporting {
    void generateReport();
}
```

客户端只需依赖它们实际需要的接口，避免被迫实现不需要的方法。

## 5. 依赖倒置原则应用

### 订单存储设计

```java
interface OrderStorage {
    void save(Order order);
    Order findById(String id);
}

class DatabaseOrderStorage implements OrderStorage {
    public void save(Order order) { /*...*/ }
    public Order findById(String id) { /*...*/ }
}

class OrderService {
    private OrderStorage storage;
    
    public OrderService(OrderStorage storage) {
        this.storage = storage;
    }
    
    public void processOrder(Order order) {
        storage.save(order);
    }
}
```

高层 OrderService 依赖抽象的 OrderStorage 接口，而不是具体的数据库实现，便于切换存储方式。

## 综合应用效果

通过遵循 SOLID 原则，我们的订单系统获得了：
- 更清晰的职责划分
- 更好的可扩展性
- 更强的可维护性
- 更高的代码复用率
- 更松散的耦合度

这些原则共同作用，使系统能够更灵活地应对需求变化，同时保持代码的整洁和可理解性。
