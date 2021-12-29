package by.epam.tc.web.service.impl;

import by.epam.tc.web.dao.DAOException;
import by.epam.tc.web.dao.DAOFactory;
import by.epam.tc.web.dao.UserDAO;
import by.epam.tc.web.entity.user.Admin;
import by.epam.tc.web.entity.user.Client;
import by.epam.tc.web.entity.user.User;
import by.epam.tc.web.service.ServiceException;
import by.epam.tc.web.service.UserService;

public class UserServiceImpl implements UserService {
	
	private final UserDAO userDAO;
	
	public UserServiceImpl() throws ServiceException {
		try {
			userDAO = DAOFactory.getInstance().getUserDAO();
		} catch (DAOException e) {
			throw new ServiceException(e);
		}
	}
	
    @Override
    public User signIn(String login, String password) throws ServiceException {    	
    	User user = null;
    	try {
    		
    		user = userDAO.findUserByLoginAndPassword(login, password);
    		password = null;
    		
		} catch (DAOException e) {
			throw new ServiceException(e);
		} 
    	return user;
    }
    
    
    @Override
	public Admin signUp(Admin admin) throws ServiceException {
    	int userId = 0;
    	try {
    		userId = userDAO.addUser(admin); 
    		admin.setUserId(userId);
    	}catch (DAOException e) {
    		throw new ServiceException(e);
		}    
    	return admin;
	}

	@Override
    public Client signUp(Client client) throws ServiceException{
		int clientId = 0;
    	try {    		
    		clientId = userDAO.addUserClient(client);
    		client.setClientId(clientId);
    	}catch (DAOException e) {
    		throw new ServiceException(e);
		}    
    	return client;
    }
	
	@Override
	public Admin edit(Admin admin, String login) throws ServiceException {    	
    	try {
    		int userId = userDAO.getUserId(login);
    		userDAO.updateUser(userId, admin);
    		userDAO.updateAdmin(userId, admin);
    	}catch (DAOException e) {
    		throw new ServiceException(e);
		}    
    	return admin;
	}
	
	@Override
	public Client edit(Client client, String login, String passportId) throws ServiceException{
    	try {
    		int userId = userDAO.getUserId(login);
    		userDAO.updateUser(userId, client);
    		int clientId = userDAO.getClientId(passportId);
    		userDAO.updateClient(clientId, client);
    	}catch (DAOException e) {
    		throw new ServiceException(e);
		}    
    	return client;
    }
	
	@Override
	public void editPassword(String login, String password) throws ServiceException{
		try {
			userDAO.updatePassword(login, password);
			password = null;
		} catch (DAOException e) {
			throw new ServiceException(e);
		}
	}
	
	@Override
	public Admin findAdminByLogin(String login) throws ServiceException{
		Admin admin = null;
		try {
			admin = userDAO.findAdminByLogin(login);
		}catch (DAOException e) {
    		throw new ServiceException(e);
		}    
    	return admin;
	}
	
	@Override
	public Client findClientByLogin(String login) throws ServiceException{
		Client client = null;
		try {
			client = userDAO.findClientByLogin(login);
		}catch (DAOException e) {
    		throw new ServiceException(e);
		}    
    	return client;
	}
	
	@Override
	public void deleteAccount(String login) throws ServiceException{
		try {
			int userId = userDAO.getUserId(login);
			userDAO.deleteUser(userId);
		} catch (DAOException e) {
			throw new ServiceException(e);
		}
	}
}
