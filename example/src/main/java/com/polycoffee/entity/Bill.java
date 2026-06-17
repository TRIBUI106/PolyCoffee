package com.polycoffee.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Bill {
	Integer id;
	Integer userId;
	String code;
	Date createdAt;
	int total;
	String status;
//	cancel, finish, waiting
}
