package com.aya.quizservice.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "quiz", schema = "quiz_schema")
public class Quiz {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", insertable = false, nullable = false)
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @ElementCollection
    @CollectionTable(
            name = "quiz_questions_ids",
            schema = "quiz_schema",
            joinColumns = @JoinColumn(name = "quiz_id")
    )
    @Column(name = "questions_ids")
    private List<Integer> questionsIds;
}
