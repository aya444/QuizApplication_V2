package com.aya.quizservice.model.dto;

import lombok.Data;

@Data
public class QuizInputDto {
    String category;
    Integer numOfQuestions;
    String title;
}
