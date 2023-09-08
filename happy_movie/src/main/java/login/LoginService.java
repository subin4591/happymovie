package login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.UserDTO;

@Service
public class LoginService {
	@Autowired
	LoginDAO dao;
	
	// user_id로 정보 조회
	public UserDTO userOne(String user_id) {
		return dao.userOne(user_id);
	}
	
	// 회원가입
	public void insertUser(UserDTO dto) {
		dao.insertUser(dto);
	}
	
	// 회원정보 수정
	public void updateUser(UserDTO dto) {
		dao.updateUser(dto);
	}
	
	// 회원탈퇴
	public void deleteUser(String user_id) {
		dao.deleteUser(user_id);
	}
}
