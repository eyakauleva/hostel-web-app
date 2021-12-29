<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Sign Up</title>

    <style>
    
        body{
            background: url("images/bg.jpg") no-repeat;
            background-size: cover;
            margin: 0;
            padding: 0;
            font-family: sans-serif;            
        }
        
        .container{
            background: rgba(255,255,255,0.8);
            display: flex;
            flex-direction: column;
        }
        
        .menu{
            background-color: #DEB887;
            border: 3px outset black;  
            height: 6vh; 
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
            box-sizing: border-box; 
        }        
                
        .tabs{
            display: flex;
            flex-direction: row;
            align-items: center;
            margin: 0 3em 0 3em;
        }
        
        .tabs div {
            margin: 0 2.5em;
            width: auto;
        }
        
        .main{
            flex-grow: 1;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }
        
        .form{
            padding: 3em 4em;
            padding-bottom: 0;
            background-color: rgba(255,255,255,0.5);
            background-color:rgba(255, 228, 181, 1);
            border: 2px solid black;
            border-radius: 10px;
        } 
        
        .submit_button{
            font-size: 16px;
            border: 0;
            padding: 0.5em 1em;
            background-color: #CD853F;            
        }
        
        .menu a{
            text-decoration: none;
            color: black;
        }
        
        form select{
            font-size: 14px;
            border: 0;
            padding: 0.5em 1em;
            background-color: #CD853F;
        }
        
        .error{
        	color:red;
        }    
    
    </style> 
    
    
    <fmt:setLocale value="${sessionScope.language}"/>
	<fmt:setBundle basename="prop" var="lang"/>
	<fmt:message bundle="${lang}" key="menu.main" var="main" />
	<fmt:message bundle="${lang}" key="menu.rooms" var="rooms" />
	<fmt:message bundle="${lang}" key="menu.photos" var="photos" />
	<fmt:message bundle="${lang}" key="menu.contacts" var="contacts" />
	<fmt:message bundle="${lang}" key="menu.my_account" var="my_account" />
	<fmt:message bundle="${lang}" key="menu.sign_in" var="sign_in" />
	<fmt:message bundle="${lang}" key="menu.sign_up" var="sign_up" />
	<fmt:message bundle="${lang}" key="menu.log_out" var="log_out" />
	<fmt:message bundle="${lang}" key="menu.ru" var="ru" />
	<fmt:message bundle="${lang}" key="menu.en" var="en" />
	<fmt:message bundle="${lang}" key="main.welcome_to" var="welcome_to" />
	<fmt:message bundle="${lang}" key="main.hostel_Samartia" var="hostel_Samartia" /> 
	<fmt:message bundle="${lang}" key="logination.login" var="login_word" /> 
	<fmt:message bundle="${lang}" key="logination.password" var="password_word" /> 
	<fmt:message bundle="${lang}" key="logination.back" var="back" /> 
	<fmt:message bundle="${lang}" key="registration.registration" var="registration" />
	<fmt:message bundle="${lang}" key="registration.name" var="name_word" />
	<fmt:message bundle="${lang}" key="registration.photo" var="photo_word" />
	<fmt:message bundle="${lang}" key="registration.surname" var="surname_word" />
	<fmt:message bundle="${lang}" key="registration.passport_id" var="passport_id_word" />
	<fmt:message bundle="${lang}" key="registration.date_of_birth" var="date_of_birth_word" />
	<fmt:message bundle="${lang}" key="registration.country" var="country_word" />
	<fmt:message bundle="${lang}" key="registration.phone_number" var="phone_number_word" />
	<fmt:message bundle="${lang}" key="registration.email" var="email_word" />
      
    
</head>
<body>

    <div class="container">
    
        <div class="menu">

            <div class="tabs" style="justify-content: flex-start">
                <div><a href="Controller?command=GO_TO_WELCOME_PAGE"><c:out value="${main}"/></a></div>|
                <div><c:out value="${rooms}"/></div>|
                <div><c:out value="${photos}"/></div>|
                <div><c:out value="${contacts}"/></div>|
                <c:if test="${not empty sessionScope.login}" >
                    <div><a href="Controller?command=GO_TO_MY_ACCOUNT_PAGE"><c:out value="${my_account}"/></a></div>
                </c:if>                
            </div>

            <div class="tabs" style="justify-content: flex-end">
                <form>
                    <input type="hidden" name="command" value="ChangeLanguage" >
                    <select name="language" onchange="submit()">
                            <option value="ru" ${language == 'ru' ? 'selected' : ''}><c:out value="${ru}"/></option>
                            <option value="en" ${language == 'en' ? 'selected' : ''}><c:out value="${en}"/></option>
                    </select>  
                </form>
                <c:choose>
        			<c:when test="${empty role}">
		        		<div><a href="Controller?command=GO_TO_LOGINATION_PAGE"><c:out value="${sign_in}"/></a></div>|
		        		<div><a href="Controller?command=GO_TO_REGISTRATION_PAGE"><c:out value="${sign_up}"/></a></div>
        			</c:when>
        			<c:otherwise>
        				<div><a href="Controller?command=GO_TO_WELCOME_PAGE&logOut=true"><c:out value="${log_out}"/></a></div>|
        			</c:otherwise>
        		</c:choose>
            </div>

        </div>

        <div class="main">            
                      
            <div class="form">
            
                <form action="Controller" method="post">
                <table>
                    <tr>
                        <td><h2><c:out value="${registration}"/>:</h2><br></td>
                        <td><input type="hidden" name="command" value="Registration" /></td>
                    </tr>

                    <tr>
                        <td><c:out value="${login_word}"/>:<br><br></td>
                        <td><input type="text" name="login" value = ""/><br><br></td>
                    </tr>
                    <tr>
                        <td><c:out value="${password_word}"/>:<br><br><br></td>
                        <td><input type="password" name="password" value = ""/><br><br><br></td>
                    </tr>
                    
                    		<c:choose>
                                <c:when test="${create eq 'admin'}">
                                    <tr>
                                        <td><c:out value="${name_word}"/>:<br><br></td>
                                        <td><input type="text" name="name" value = ""/><br><br></td>
                                    </tr>
                                    <tr>
                                        <td><c:out value="${photo_word}"/>:<br><br></td>
                                        <td><input type="text" name="photo" value = ""/><br><br></td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td><c:out value="${name_word}"/>:<br><br></td>
                                        <td><input type="text" name="name" value = ""/><br><br></td>
                                    </tr>
                                    <tr>
                                        <td><c:out value="${surname_word}"/>:<br><br></td>
                                        <td><input type="text" name="surname" value = ""/><br><br></td>
                                    </tr>
                                    <tr>
                                        <td><c:out value="${passport_id_word}"/>:<br><br></td>
                                        <td><input type="text" name="passportId" value = ""/><br><br></td>
                                    </tr>
                                    <tr>
                                        <td><c:out value="${date_of_birth_word}"/>:<br><br></td>
                                        <td><input type="text" name="dateOfBith" value = "2000-01-01"/><br><br></td>
                                    </tr>
                                    <tr>
                                        <td><c:out value="${country_word}"/>:<br><br></td>
                                        <td><input type="text" name="country" value = "Belarus"/><br><br></td>
                                    </tr>
                                    <tr>
                                        <td><c:out value="${phone_number_word}"/>:<br><br></td>
                                        <td><input type="text" name="phone" value = "+4546"/><br><br></td>
                                    </tr>
                                    <tr>
                                        <td><c:out value="${email_word}"/>:<br><br></td>
                                        <td><input type="text" name="email" value = "a@gmail.com"/><br><br></td>
                                    </tr>	
                                </c:otherwise>
                            </c:choose>

                    <tr>
                        <td><input class="submit_button" type="submit" value="${sign_up}"/><br><br><br></td>
                        <td></td>
                    </tr>

                    <tr>
                        <td><a href="Controller?command=GO_TO_WELCOME_PAGE"><c:out value="${back}"/></a><br><br></td>
                        <td></td>
                    </tr>
                </table>
               </form>  
            	<p class="error"><c:out value="${param.errorMessage}" /></p>
	        	<br>
            </div>
            

        </div>  
    
    </div>

</body>
</html>