package com.financial.system;

public class FinancialForecast {

    // Recursive method to calculate future value
    public static double calculateFutureValue(double principal, double rate, int years) {
        if (years == 0) {
            return principal;
        }
        return calculateFutureValue(principal * (1 + rate), rate, years - 1);
    }

    public static void main(String[] args) {
        double initialInvestment = 10000;  // Initial amount
        double annualGrowthRate = 0.07;    // 7% annual growth
        int forecastYears = 5;             // Forecast for 5 years

        double futureValue = calculateFutureValue(initialInvestment, annualGrowthRate, forecastYears);
        System.out.printf("Future value after %d years: %.2f\n", forecastYears, futureValue);
    }
}
