package com.aya.questionservice.controller;


import com.aya.questionservice.model.dto.QuestionInputDto;
import com.aya.questionservice.model.dto.QuestionOutputDto;
import com.aya.questionservice.model.entity.Response;
import com.aya.questionservice.service.QuestionService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("question")
public class QuestionController {

    private final QuestionService questionService;

    @Autowired
    private QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @GetMapping("all")
    public ResponseEntity<List<QuestionOutputDto>> getAllQuestions() {
        List<QuestionOutputDto> questions = questionService.getAllQuestions();
        return new ResponseEntity<>(questions, HttpStatus.OK);
    }

    @GetMapping("category/{cat}")
    public ResponseEntity<List<QuestionOutputDto>> getQuestionsByCategory(@PathVariable("cat") @NotNull String category) {
        List<QuestionOutputDto> questions = questionService.getQuestionsByCategory(category);
        return new ResponseEntity<>(questions, HttpStatus.OK);
    }

    @PostMapping("add")
    public ResponseEntity<QuestionOutputDto> addQuestions(@RequestBody @Valid QuestionInputDto questionInputDto) {
        QuestionOutputDto question = questionService.createQuestion(questionInputDto);
        return new ResponseEntity<>(question, HttpStatus.CREATED);
    }

    @PutMapping("/edit/{id}")
    public ResponseEntity<QuestionOutputDto> editQuestion(@PathVariable @NotNull Integer id, @RequestBody @Valid QuestionInputDto updatedQuestionInputDto) {
        QuestionOutputDto updatedQuestion = questionService.editQuestion(id, updatedQuestionInputDto);
        return new ResponseEntity<>(updatedQuestion, HttpStatus.OK);
    }

    @DeleteMapping("delete/{id}")
    public ResponseEntity<String> deleteQuestion(@PathVariable @NotNull Integer id) {
        questionService.deleteQuestion(id);
        return new ResponseEntity<>("Question with id " + id + " is successfully deleted!", HttpStatus.OK);
    }

    @GetMapping("generate-questions")
    public ResponseEntity<List<Integer>> getQuestionsForQuiz(@RequestParam String category, @RequestParam Integer numOfQuestions) {
        List<Integer> questionIds = questionService.getQuestionsForQuiz(category, numOfQuestions);
        return new ResponseEntity<>(questionIds, HttpStatus.OK);
    }

    @PostMapping("get-questions")
    public ResponseEntity<List<QuestionOutputDto>> getQuestionsById(@RequestBody List<Integer> questionIds) {
        List<QuestionOutputDto> questions = questionService.getQuestionsById(questionIds);
        return new ResponseEntity<>(questions, HttpStatus.OK);
    }

    @PostMapping("get-results")
    public ResponseEntity<Integer> getResult(@RequestBody @Valid List<Response> responseList) {
        Integer result = questionService.calculateResults(responseList);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
