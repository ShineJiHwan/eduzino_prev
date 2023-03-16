package com.edu.zino.exception;

public class CartException extends RuntimeException{
	
	public CartException(String msg) {
		super(msg);
	}
	public CartException(String msg, Throwable e) {
		super(msg,e);
	}
}
