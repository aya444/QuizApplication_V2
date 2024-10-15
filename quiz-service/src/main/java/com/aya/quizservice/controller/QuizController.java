package com.aya.quizservice.controller;


import com.aya.quizservice.model.dto.QuestionOutputDto;
import com.aya.quizservice.model.dto.QuizInputDto;
import com.aya.quizservice.model.dto.QuizOutputDto;
import com.aya.quizservice.model.entity.Response;
import com.aya.quizservice.service.QuizService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("quiz")
public class QuizController {

    private final QuizService quizService;

    @Autowired
    public QuizController(QuizService quizService) {
        this.quizService = quizService;
    }

    @PostMapping("add")
    public ResponseEntity<String> createQuiz(@RequestBody @Valid QuizInputDto quizInputDto) {
        quizService.createQuiz(quizInputDto.getCategory(), quizInputDto.getNumOfQuestions(), quizInputDto.getTitle());
        return new ResponseEntity<>("Quiz Created!", HttpStatus.CREATED);
    }

    @GetMapping("all")
    public ResponseEntity<List<QuizOutputDto>> getAllQuizzes() {
        List<QuizOutputDto> quizOutputDtoList = quizService.getAllQuizzes();
        return new ResponseEntity<>(quizOutputDtoList, HttpStatus.OK);
    }

    @GetMapping("get-quiz-questions/{id}")
    public ResponseEntity<List<QuestionOutputDto>> getQuizQuestionsById(@PathVariable @NotNull Integer id) {
        List<QuestionOutputDto> questions = quizService.getQuizQuestions(id);
        return new ResponseEntity<>(questions, HttpStatus.OK);

    }

    @PostMapping("submit/{id}")
    public ResponseEntity<String> getResult(@PathVariable @NotNull Integer id, @RequestBody @Valid List<Response> responseList) {
        String result = quizService.calculateResults(id, responseList);
        return new ResponseEntity<>("The result is " + result + "!", HttpStatus.OK);
    }
}
