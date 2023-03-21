package com.edu.zino.exception;

public class VideoException extends RuntimeException{
	
	public VideoException(String msg) {
		super(msg);
	}
	public VideoException(String msg, Throwable e) {
		super(msg,e);
	}
}
