package com.aya.questionservice.exception;

public class InvalidQuestionDataException extends RuntimeException {
    public InvalidQuestionDataException(String message) {
        super(message);
    }
}
