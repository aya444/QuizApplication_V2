package com.aya.quizservice.exception;

public class InvalidQuizDataException extends RuntimeException {
    public InvalidQuizDataException(String message) {
        super(message);
    }
}
