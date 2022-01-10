package by.epam.tc.web.controller.impl;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.epam.tc.web.controller.Command;
import by.epam.tc.web.entity.stay.Booking;
import by.epam.tc.web.service.ServiceFactory;

public class SubmitBookingCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
		LocalDate fromDate = LocalDate.parse(request.getParameter("fromDate"));
		LocalDate toDate = LocalDate.parse(request.getParameter("toDate"));
		int guestsNumber = Integer.parseInt(request.getParameter("guestsNumber"));
		int roomNumber = -1;
		if(request.getParameter("roomNumber")!=null) {
			roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
		}
		try {
			if(request.getParameter("bookingId")!=null) {
				int id = Integer.parseInt(request.getParameter("bookingId"));
				Booking booking = ServiceFactory.getInstance().getStaysService().getBookingById(id);
				booking.setFromDate(fromDate);
				booking.setToDate(toDate);
				booking.setGuestsCount(guestsNumber);
				if(roomNumber>0) {
					booking.setRoomNumber(roomNumber);
				}
				booking.setApproved(true);
				booking.setApproveDate(LocalDate.now());
				ServiceFactory.getInstance().getStaysService().updateBooking(id, booking);
			}else {
				String userLogin = (String)request.getSession().getAttribute("login");
				ServiceFactory.getInstance().getStaysService().addBooking(
						userLogin, fromDate, toDate, guestsNumber, roomNumber);
			}			
		} catch (Exception e) {
			// TODO: handle exception
		}		
		response.sendRedirect("Controller?command=GO_TO_BOOKINGS_PAGE");
	}
	
}
