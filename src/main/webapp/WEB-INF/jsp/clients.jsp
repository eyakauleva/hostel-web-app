<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="by.epam.tc.web.controller.constant.*" %>
<%@ include file="changeLanguageTags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Clients</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css" rel="stylesheet" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" rel="stylesheet" />

	<script type="text/javascript" src="js/script.js" ></script>
	<link rel="stylesheet" href="css/style.css">

	<style>
           
        .main{
            margin-top: 3em;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .form{
            margin: 0em 3em;
            margin-bottom: 3em;
            width: 1100px;
        }
        
        .buttons-list input, .buttons-list button{
		 	width: 150px;
		 }
    
    </style>
    
</head>

<body style="background-color: #D2B48C">	
	
	<script>
                
		$(document).ready(function() {
			
			$('.open-popup').click(function(e){
                e.preventDefault();
                $('.popup-bg').fadeIn(300);
                $('html').addClass('no-scroll');
                $('#chosen-client-id').val($(this).find('.client-id').text());
                
            })
        
            $('.close-popup').click(function(){
                $('.popup-bg').fadeOut(300);
                $('html').removeClass('no-scroll');
            })
            
            $('.choose-client').click(function(){
            	$(this).find('.target').submit();
            })
            
        });
        
    </script>

    <div class="container">
    
    	<c:if test="${!(newStayGuestsNumber > 0)}">
    		<div class="menu">
	            <div class="tabs" style="justify-content: flex-start">
	                <div><a href="Controller?command=GO_TO_WELCOME_PAGE"><c:out value="${main}"/></a></div>|
	                <div><a href="Controller?command=GO_TO_ROOMS_PAGE"><c:out value="${rooms}"/></a></div>|
	                <div><a href="Controller?command=GO_TO_CONTACTS_PAGE"><c:out value="${contacts}"/></a></div>|
	                <c:if test="${not empty sessionScope.login}" >
	                    <div><a href="Controller?command=GO_TO_MY_ACCOUNT_PAGE"><c:out value="${my_account}"/></a></div>
	                </c:if>                
	            </div>	
	            <div class="tabs" style="justify-content: flex-end">
	                <form>
	                    <input type="hidden" name="${Utility.COMMAND}" value="${CommandName.CHANGE_LANGUAGE}">
                    	<select name="${Utility.LANGUAGE}" onchange="submit()">
	                            <option value="ru" ${language == 'ru' ? 'selected' : ''}><c:out value="${ru}"/></option>
	                            <option value="en" ${language == 'en' ? 'selected' : ''}><c:out value="${en}"/></option>
	                    </select>  
	                </form>
	                <c:choose>
	        			<c:when test="${empty sessionScope.role}">
			        		<div><a href="Controller?command=GO_TO_LOGINATION_PAGE"><c:out value="${sign_in}"/></a></div>|
			        		<div><a href="Controller?command=GO_TO_REGISTRATION_PAGE"><c:out value="${sign_up}"/></a></div>
	        			</c:when>
	        			<c:otherwise>
	        				<div><a href="Controller?command=GO_TO_WELCOME_PAGE&logOut=true"><c:out value="${log_out}"/></a></div>|
	        			</c:otherwise>
	        		</c:choose>
	            </div>	
	        </div>
    	</c:if>

        <div class="container-body"> 
        	<div class="main">
                <div class="form" style="padding-left:20px">
                	<h3>
                		<c:choose>
                	 		<c:when test="${newStayGuestsNumber > 0}">
                	 			<p style="font-size:14px; color: #808080">
                	 				<c:out value="${newStayGuestsNumber} "/><c:out value="${clients_left_word}"/>
                	 			</p>
                	 			<form>
                	 				<input type="hidden" name="${Utility.COMMAND}" value="${CommandName.FINISH_CHOOSING_CLIENT}"/>
                	 				<input class="submit_button" type="submit" value="${finish_word}" style="font-size:14px"/>
                	 			</form><br>
                	 			<c:out value="${choose_client_word}"/>:    
                	 		</c:when>
                	 		<c:otherwise>
                	 			<c:out value="${all_clients_word}"/>                	 			
                	 		</c:otherwise>                	 		
                	 	</c:choose>
                	 	<input class="submit_button open-popup client" type="button" value="${new_client_word}" style="margin-left:20px"/>
                	</h3>
                	<form style="margin-left:50%">
                		<label><c:out value="${search_by_word}:" /></label>
                	 	<select name="${Utility.SEARCH_CRITERIA}" style="padding:10">
                	 		<option value="${Utility.LOGIN}" ${currentSearchCriteria == Utility.LOGIN ? 'selected' : ''}><c:out value="${login_word}" /></option>
                	 		<option value="${Utility.PASSPORT_ID}" ${(currentSearchCriteria == Utility.PASSPORT_ID || currentSearchCriteria == null) ? 'selected' : ''}><c:out value="${passport_id_word}"/></option>
                	 		<option value="${Utility.SURNAME}" ${currentSearchCriteria == Utility.SURNAME ? 'selected' : ''}><c:out value="${surname_word}" /></option>
                	 	</select>
                	 	<input type="text" name="${Utility.SEARCH_DATA}" value="${currentSearchData}"/>
                	 	<input type="hidden" name="${Utility.COMMAND}" value="${CommandName.SEARCH_CLIENT}"/>
                	 	<input class="submit_button" type="submit" value="${search}" style="padding:10; font-size:14px"/>
                	</form><br>
                	
                    <table class="table table-hover">
                    
                        <thead>
                            <tr>
                            	<th scope="col"><c:out value="${clientId_word}" /></th>                            	
                                <th scope="col"><c:out value="${login_word}" /></th>
                                <th scope="col"><c:out value="${name_word}" /></th>
                                <th scope="col"><c:out value="${surname_word}" /></th>
                                <th scope="col"><c:out value="${passport_id_word}"/></th>
                                <th scope="col"><c:out value="${date_of_birth_word}" /></th>
                                <th scope="col"><c:out value="${country_word}" /></th>
                                <th scope="col"><c:out value="${phone_number_word}" /></th>
                                <th scope="col"><c:out value="${email_word}" /></th>
                            </tr>
                        </thead>

                        <c:forEach var="client" items="${clients}">                            
                            <tbody>
                                <tr class="choose-client" style="cursor: pointer">
                                	<td><c:out value="${client.getClientId()}" /></td>
                                	<c:choose>
                                		<c:when test="${not empty client.getUserId() and client.getUserId() ne ''}">
                                			<td><c:out value="${client.getLogin()}" /></td>
                                		</c:when>
                                		<c:otherwise>
                                			<td><c:out value="-" /></td>
                                		</c:otherwise>
                                	</c:choose>
                                	<td><c:out value="${client.getFirstName()}" /></td>
                                    <td><c:out value="${client.getLastName()}" /></td>
                                    <td><c:out value="${client.getPassportId()}" /></td>
                                    <fmt:parseDate value="${client.getBirthDate()}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                                    <td><fmt:formatDate value="${parsedDate}" pattern="dd.MM.yyyy" /></td>
                                    <td><c:out value="${client.getCountry()}" /></td>
                                    <td><c:out value="${client.getPhoneNumber()}" /></td>
                                    <td><c:out value="${client.getEmail()}" /></td>
                                    <td style="visibility: hidden" >
                                    	<form class="target">
                                    		<input type="hidden" name="${Utility.COMMAND}" value="${CommandName.CHOOSE_CLIENT}" />
                                   			<input type="hidden" name="${Utility.CHOSEN_CLIENT_ID}" value="${client.getClientId()}"/>
                                    	</form>
                                    </td>
                                 </tr>
                             </tbody>
                        </c:forEach>
                    </table>                
                </div>
                
	        	<c:if test="${popUpView eq 'options'}">
	        		<div class="popup-bg options" style="display: block">
		                <div class="popup" style="width:auto; padding: 40px; padding-bottom:0">	                    
		                    <img class="close-popup" src="images/close.png" style="width:25px"><br>		                    
		                </div>
		            </div>
	        	</c:if>
	        	
	        	<c:if test="${popUpView eq 'editClient'}">
	<%--        		<div class="popup-bg editBooking" style="display: block">
		                <div class="popup" style="width:auto; padding: 40px">	                    
		                    <img class="close-popup" src="images/close.png" style="width:25px"><br>	                    
		                    <form>                
			                    <label for="fromDate">Arrive date:</label>
			                    <input type="date" id="fromDate" name="fromDate" value="${booking.getFromDate()}" onchange="setToDate()" required>
			                    <label for="toDate">&#160;&#160;&#160;&#160;Departure date:</label>
			                    <input type="date" id="toDate" name="toDate" value="${booking.getToDate()}" required>                
			                    <br><br>
			                    <label for="questsNumber">Number of guests:&#160;</label>
			                    <input type="number" id="guestsNumber" name="guestsNumber" value="${booking.getGuestsCount()}" min="1" max="15" style="margin-right: 40px">
			                    <label for="roomNumber">Current room:</label>
			                    <input type="radio" id="roomNumber" name="roomNumber" value="${booking.getRoomNumber()}" checked>
			                    <c:out value="${booking.getRoomNumber()}" /><br>
			                    <input type="hidden" name="bookingId" value="${booking.getId()}" />
			                    <input type="hidden" name="command" value="EditBookingCheck" />
			                    <input class="submit_button" type="submit" value="Check" style="margin-right: 50px"/>
			                    <input id="check-among-all-rooms" type="checkbox" name="checkAmongAllRooms" value="Check among all rooms" checked style="visibility:hidden"/>
			                </form>
		                </div>
		            </div>  --%> 
	        	</c:if>
	        	
				<div class="popup-bg client">
	                <div class="popup">
	                    <img class="close-popup" src="images/close.png" style="width:25px">
	                    <form>
		                    <table style="margin-left:20px;margin-top:10px">
		                    	<tr>
		                    		<td><c:out value="${name_word}:"/></td>
		                    		<td><input type="text" id="newClientName" name="${Utility.NAME}" required></td>
		                    	</tr>
		                    	<tr>
		                    		<td><c:out value="${surname_word}:"/></td>
		                    		<td><input type="text" id="newClientSurname" name="${Utility.SURNAME}" required></td>
		                    	</tr>
		                    	<tr>
		                    		<td><c:out value="${passport_id_word}:"/></td>
		                    		<td><input type="text" id="newClientPassportId" name="${Utility.PASSPORT_ID}" required></td>
		                    	</tr>
		                    	<tr>
		                    		<td><c:out value="${date_of_birth_word}:"/></td>
		                    		<td><input type="date" id="newClientBirthDate" name="${Utility.DATE_OF_BIRTH}" required></td>
		                    	</tr>
		                    	<tr>
		                    		<td><c:out value="${country_word}:"/></td>
		                    		<td><input type="text" id="newClientCountry" name="${Utility.COUNTRY}"></td>
		                    	</tr>
		                    	<tr>
		                    		<td><c:out value="${phone_number_word}:"/></td>
		                    		<td><input type="text" id="newClientPhone" name="${Utility.PHONE}"></td>
		                    	</tr>
		                    	<tr>
		                    		<td><c:out value="${email_word}:"/></td>
		                    		<td><input type="text" id="newClientEmail" name="${Utility.EMAIL}"></td>
		                    	</tr>
		                    </table><br>
		                    <input type="hidden" name="${Utility.COMMAND}" value="${CommandName.ADD_CLIENT}" />
		                    <input class="submit_button" type="submit" value="${save}" style="margin-left:20px"/>
		               </form>
	                </div>
	            </div>
	            
	            <c:if test="${not empty error and error ne ''}">
	            	<div class="popup-bg editBooking" style="display: block">
		                <div class="popup" style="width:auto; padding: 40px">	                    
		                    <img class="close-popup" src="images/close.png" style="width:25px"><br>	
		                    <fmt:message bundle="${lang}" key="${error}" var="error_msg" />                    
		                    <p><c:out value="${error_msg}" /></p>
		                </div>
		                <c:remove var="error"/>
		            </div>
	            </c:if>
	            
	     <%--        <c:if test="">
	            		<div class="popup-bg" style="display: block">
			                <div class="popup" style="width:auto; padding-top:30px">
			                    <a href="Controller?command=GO_TO_BOOKINGS_PAGE">
			                		<img src="images/close.png" style="width:25px;">
			                	</a>
			                    <h5 style="margin-top:15px"><c:out value="${please_check_data_word}:"/></h5>
			                    <form>			                    	
				                    <table>
				                     	<tr>
				                    		<td><b>Since:</b></td>
				                    		<td><input type="date" name="fromDate" value="${fromDate}" readonly /></td>
				                    	</tr>
				                    	<tr>
				                    		<td><b>To:</b></td>
				                    		<td><input type="date" name="toDate" value="${toDate}" readonly /></td>
				                    	</tr>
				                    	<tr>
				                    		<td><b>Guests number:</b></td>
				                    		<td><input type="number" name="guestsNumber" value="${guestsNumber}" readonly /></td>
				                    	</tr>  
				                    </table>			                    
				                    <br>
				                    <input type="hidden" name="${Utility.EDITED_CLIENT_ID}" value="${editedClientId}" />
				                    <input type="hidden" name="${Utility.COMMAND}" value="${CommandName.SUBMIT_CLIENT}" />
				                    <input class="submit_button" type="submit" value="${save}"/>
			                    </form>			                    
			                </div>
			            </div>
	            </c:if>  --%>
	         	
          </div> 
        </div>
       </div> 
       
       <c:remove var="popUpView"/>
       <c:remove var="chosenClientId"/>
       
       <script>
		    var today = new Date();
		    var dd = today.getDate();
		    var mm = today.getMonth() + 1; //January is 0!
		    var yyyy = today.getFullYear();
		
		    if (dd < 10) {
		       dd = '0' + dd;
		    }
		
		    if (mm < 10) {
		       mm = '0' + mm;
		    } 
		        
		    today = yyyy + '-' + mm + '-' + dd;
		    document.getElementById("newClientBirthDate").setAttribute("max", today);
	    </script>

	</body>
</html>