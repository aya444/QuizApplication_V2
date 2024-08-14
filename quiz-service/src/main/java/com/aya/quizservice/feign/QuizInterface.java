package com.aya.quizservice.feign;

import com.aya.quizservice.model.dto.QuestionOutputDto;
import com.aya.quizservice.model.entity.Response;
import jakarta.validation.Valid;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient("QUESTION-SERVICE")
public interface QuizInterface {
    @GetMapping("question/generate-questions")
    ResponseEntity<List<Integer>> getQuestionsForQuiz(@RequestParam String category, @RequestParam Integer numOfQuestions);

    @PostMapping("question/get-questions")
    ResponseEntity<List<QuestionOutputDto>> getQuestionsById(@RequestBody List<Integer> questionIds);

    @PostMapping("question/get-results")
    ResponseEntity<Integer> getResult(@RequestBody @Valid List<Response> responseList);
}