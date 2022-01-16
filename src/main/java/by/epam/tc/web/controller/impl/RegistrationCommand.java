package by.epam.tc.web.controller.impl;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import by.epam.tc.web.controller.Command;
import by.epam.tc.web.controller.constant.Constant;
import by.epam.tc.web.entity.user.Admin;
import by.epam.tc.web.entity.user.Client;
import by.epam.tc.web.entity.user.Role;
import by.epam.tc.web.service.*;

public class RegistrationCommand implements Command{
	private static final Logger logger = LogManager.getLogger(by.epam.tc.web.controller.impl.RegistrationCommand.class);
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		Client client = null;
		Admin admin = null;	
		
		try {
			String login = request.getParameter(Constant.Utility.LOGIN);
			String password = request.getParameter(Constant.Utility.PASSWORD);		
			String passportId = request.getParameter(Constant.Utility.PASSPORT_ID);
			
			if(passportId != null) { 
				String name = request.getParameter(Constant.Utility.NAME);
				String surname = request.getParameter(Constant.Utility.SURNAME);
				LocalDate dateOfBith = LocalDate.parse(request.getParameter(Constant.Utility.DATE_OF_BIRTH));
				String country = request.getParameter(Constant.Utility.COUNTRY);
				String phone = request.getParameter(Constant.Utility.PHONE);
				String email = request.getParameter(Constant.Utility.EMAIL);				
				client = new Client(login, password, name, surname, passportId, dateOfBith, 
						country, phone, email);
				password = null;
				client = ServiceFactory.getInstance().getUserService().signUp(client);
				request.getSession().setAttribute(Constant.Utility.ROLE, Role.CLIENT.toString());
				request.getSession().setAttribute(Constant.Utility.LOGIN, login);
			}
			else {
				String name = request.getParameter(Constant.Utility.NAME);
				String photo = request.getParameter(Constant.Utility.PHOTO);				
				admin = new Admin(login, password, name, photo);
				password = null;
				admin = ServiceFactory.getInstance().getUserService().signUp(admin);
				request.getSession().setAttribute(Constant.Utility.ROLE, Role.ADMIN.toString());
				request.getSession().setAttribute(Constant.Utility.LOGIN, login);
			}			
			response.sendRedirect(Constant.Redirect.TO_ACCOUNT_PAGE);
		} catch (ServiceException e) {
			logger.error("error while registration", e);
			response.sendRedirect(Constant.Redirect.TO_ERROR_PAGE);
		}
	}
}
