package by.epam.tc.web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * 
 * @author Lizzi9223
 *
 */
public interface Command {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
