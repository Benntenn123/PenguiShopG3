package Models;

public class MonthValue {
    private int month;
    private double value;

    public MonthValue(int month, double value) {
        this.month = month;
        this.value = value;
    }
    public int getMonth() { return month; }
    public void setMonth(int month) { this.month = month; }
    public double getValue() { return value; }
    public void setValue(double value) { this.value = value; }
}
