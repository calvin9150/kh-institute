package com.vaccine.dao;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

import com.vaccine.controller.PersonController;
import com.vaccine.vo.Person;

public class PersonDao {
	public static ArrayList<Person> persons;
	
	public boolean insertPerson(Person person) {
		boolean flag = true;
		
		persons = new ArrayList<Person>();
		persons.add(person);
		
		return flag;
	}
	
	public ArrayList<Person> searchAll() {
		
		return persons;
	}
	
	public void fileSave(ArrayList<Person> persons) {
		try(ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("person.txt"))){
			oos.writeObject(persons);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ObjectInputStream fileRead() throws ClassNotFoundException {
		PersonController pc = new PersonController();
		try(ObjectInputStream ois = new ObjectInputStream(new FileInputStream("person.txt"))){	
			persons = (ArrayList<Person>) ois.readObject();
			for(int i=0; i<persons.size();i++) {
				System.out.println(persons.get(i));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	} 

}
