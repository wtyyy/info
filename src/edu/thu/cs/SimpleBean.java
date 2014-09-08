package edu.thu.cs;

public class SimpleBean {
	String first;
	String second;
	String operator;
	double result;


	public String getFirst() {
		return first;
	}


	public void setFirst(String first) {
		this.first = first;
	}


	public String getSecond() {
		return second;
	}


	public void setSecond(String second) {
		this.second = second;
	}


	public String getOperator() {
		return operator;
	}


	public void setOperator(String operator) {
		this.operator = operator;
	}


	public double getResult() {
		return result;
	}


	public void setResult(double result) {
		this.result = result;
	}


	public void calculate() {
		double one = Double.parseDouble(first);
		double two = Double.parseDouble(second);

		try {
			if (operator.equals("+"))
				result = one + two;
			else if (operator.equals("-"))
				result = one - two;
			else if (operator.equals("*"))
				result = one * two;
			else if (operator.equals("/"))
				result = one / two;
		} catch (Exception e) {
			System.out.print(e);
		}
	}
}