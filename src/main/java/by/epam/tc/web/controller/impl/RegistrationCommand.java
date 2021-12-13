package by.epam.tc.web.controller.impl;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.epam.tc.web.controller.Command;
import by.epam.tc.web.entity.user.Admin;
import by.epam.tc.web.entity.user.Client;
import by.epam.tc.web.entity.user.Role;
import by.epam.tc.web.entity.user.User;
import by.epam.tc.web.service.*;

public class RegistrationCommand implements Command{
	
	private UserService userService = null;
	
	public RegistrationCommand() {
		try {
			userService = ServiceFactory.getInstance().getUserService();
		} catch (Exception e) {
			//TODO
		}
	}
	  
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Client client = null;
		Admin admin = null;
		
		String name = "";
		String errorMessage = "Issues while registration. Try again";		
		
		try {
			String login = request.getParameter("login");
			String password = request.getParameter("password");		
			String passportId = request.getParameter("passportId");
			
			if(passportId != null) { 
				name = request.getParameter("name");
				String surname = request.getParameter("surname");
				LocalDate dateOfBith = LocalDate.parse(request.getParameter("dateOfBith"));
				String country = request.getParameter("country");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");				
				client = new Client(login, password, name, surname, passportId, dateOfBith, 
						country, phone, email);				
				client = userService.signUp(client);
			}
			else {
				name = request.getParameter("name");
				String photo = request.getParameter("photo");				
				admin = new Admin(login, password, name, photo);				
				admin = userService.signUp(admin);
			}			
		} catch (ServiceException e) {
			// TODO: handle exception
		}
		
		if(client!=null || admin!=null) {
			request.setAttribute("name", name);
			request.setAttribute("info", "Congrats! You signed in!");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
			dispatcher.forward(request, response);
		}
		else {
			response.sendRedirect("Controller?command=GO_TO_REGISTRATION_PAGE&errorMessage="+errorMessage);
		}
		
	}
}