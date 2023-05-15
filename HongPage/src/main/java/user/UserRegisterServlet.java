package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		String userName = request.getParameter("userName");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userAge = request.getParameter("userAge");
		response.getWriter().write(register(userID, userPassword, userName, userAge, userGender, userEmail) + "");
	}
	
	public int register(String userID, String userPassword, String userName, String userAge, String userGender,String userEmail) {
		User user = new User();
		try {
			user.setUserID(userID);
			user.setUserPassword(userPassword);
			user.setUserName(userName);
			user.setUserGender(userGender);
			user.setUserEmail(userEmail);
			user.setUserAge(Integer.parseInt(userAge));

		} catch (Exception e) {
			return 0;
		}		
		return new UserDAOa().register(user);
	}

}
