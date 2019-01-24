package mybean;

import java.sql.*;
import java.util.*;

import dbcp.*;

public class SawonDao {
    
    private Connection con;//DB연결 객체를 담을 변수 선언
    private PreparedStatement pstmt;//쿼리 실행 객체를 담을 변수 선언
    private ResultSet rs;//DB에 쿼리 실행 후 그 결과 레코드를 담아올 객체를 담을 변수 선언
    private DBConnectionMgr pool;//DB커넥션풀 객체를 저장할 변수 선언
    
    //생성자를 통한 커넥션 풀 객체 얻어오기
    public SawonDao() {
        try {
            
            pool = DBConnectionMgr.getInstance();
            
        } catch (Exception err) {
            
            System.out.println("DB연결 객체 가져오기 실패 : " + err);
        
        }
    }
    
    /*DB로부터 모든 사원 레코드 목록 가져오는 getList메소드*/
    /*index.jsp(사원 목록 리스트 페이지)에서 요청한 검색기준 필드와 검색어를 넘겨받아,
    검색어가 없으면? 모든 세원 레코드를 검색하여 리스트에 뿌려준다.*/
    public ArrayList getList(String key, String text) {
        
        //가입된 사원 레코드들을 담을 컬렉션 객체
        ArrayList list = new ArrayList();
        
        //쿼리를 담을 변수
        String sql = "";
        
        try {
            
            //DB연결 -> 커넥션풀 객체 안에 있는 DB연결 connection객체 빌려온다.
            con = pool.getConnection();
            
            /*검색어가 입력되었는지 입력되지 않았는지 파악*/
            if(text == null || text.isEmpty()){//검색어가 입력되어 있지 않다면?
                
                sql = "select *from tblSawon";
                
            }else{//검색어가 입력 되었다면?
                
                //검색기준 필드가 검색어인 직원 레코드 모두 검색
                sql = "select * from tblSawon where " + key + " like '%" + text + "%'";
                
            }
            
            //미리 DB에 select쿼리문 문자열을 전송해 놓고
            pstmt = con.prepareStatement(sql);
            //select쿼리 실행하여 그 결과값 resultest객체 담아서 resultest객체 반환하여 저장
            rs = pstmt.executeQuery();
            
            //DB로부터 검색한 직원레코드들은 resultSet객체에 테이블 형식으로 담겨있다.
            //resultSet객체에 사원레코드가 존재하는 동안 반복
            while(rs.next()){
                
                //DTO객체 생성
                SawonDto dto = new SawonDto();
                //한사원 레코드 정보 DTO에 저장
                dto.setAddr(rs.getString("addr"));
                dto.setAge(rs.getInt("age"));
                dto.setDept(rs.getString("dept"));
                dto.setExtension(rs.getString("extension"));
                dto.setId(rs.getString("id"));
                dto.setName(rs.getString("name"));
                dto.setNo(rs.getInt("no"));
                dto.setPass(rs.getString("pass"));
                
                //한 사원 코드씩!!! 컬렉션 객체에 담기
                list.add(dto);
 
            }
 
        } catch (Exception err) {

            System.out.println("getList메소드에서 오류 : " + err);
            
        }finally {
            
            pool.freeConnection(con, pstmt, rs);
        
        }
        
        return list;//DB로부터 검색한 모든 사원 레코들은 list에 담겨 있으므로, 한번만 list를 반환하면 됨
        
    }
    
    //사원 추가 메소드
    public void setSawon(SawonDto dto) {
        
        //DB에 전달할 sql명령어 준비
        //insert
        String sql = "insert into tblSawon(id, name, pass, age, addr, extension, dept)" + "values(?,?,?,?,?,?,?)";
        
        try{
            
            //DB연결
            con = pool.getConnection();
            //미리 DB에 insert쿼리문 문자열을 전송해 놓고
            pstmt = con.prepareStatement(sql);
            //???????해당하는 추가할 값들을 DB에 전달
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getName());
            pstmt.setString(3, dto.getPass());
            pstmt.setInt(4, dto.getAge());
            pstmt.setString(5, dto.getAddr());
            pstmt.setString(6, dto.getExtension());
            pstmt.setString(7, dto.getDept());
            
            //insert쿼리 실행
            pstmt.executeUpdate();
            
        }catch (Exception err) {
            
            System.out.println("setSawon메소드에서 오류 : " + err);
            
        }finally {
            
            pool.freeConnection(con, pstmt);
            
        }
        
    }
    
    //사원 삭제 메소드
    public void delSawon(int no) {
        
        String sql = "delete from tblSawon where no=?";
        
        try {
            
            //pool안에 있는 DB연결 객체 빌려오기
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            pstmt.executeUpdate();
            
        } catch (Exception err) {
            
            System.out.println("delSawon메소드에서 오류 : " + err);
            
        }finally {
            
            pool.freeConnection(con, pstmt);
            
        }
        
    }
    
    //사원 수정을 위한 선택된 사원한명의 정보를 mdifySqwon.jsp에 뿌려주기 위해 리턴하는 메소드
    public SawonDto getSawon(int no) {
        
        String sql = "select *from tblSawon where no=?";
        SawonDto dto = new SawonDto();
        
        try {
            
            //pool안에 있는 DB연결 객체 빌려오기
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            //?값 셋팅
            pstmt.setInt(1, no);
            //DB에 select 실행 후 결과값 리턴 resultest객체에 담아서 resultest객체 자체를 반환 받음.
            rs = pstmt.executeQuery();
            
            //DB로부터 검색한 직원 레코드들은 resultSet객체에 테이블 형식으로 담겨있다.
            //resultSet 객체에 사원 레코드가 존재하는 동안 반복
            if(rs.next()){
                
                //한사원 레코드 정보 Dto에 저장
                dto.setAddr(rs.getString("addr"));
                dto.setAge(rs.getInt("age"));
                dto.setDept(rs.getString("dept"));
                dto.setExtension(rs.getString("extension"));
                dto.setId(rs.getString("id"));
                dto.setName(rs.getString("name"));
                dto.setNo(rs.getInt("no"));
                dto.setPass(rs.getString("pass"));
                
            }
            
        } catch (Exception err) {
            
            System.out.println("getSawon메소드에서 오류 : " + err);
        
        }finally {
            
            pool.freeConnection(con, pstmt, rs);
            
        }
        
        //수정할 사원번호에 대한 사원객체 전달
        return dto;
        
    }
    
    //사원 수정 메소드
    public void modifySawon(SawonDto dto) {
        
        String sql = "update tblSawon set id=?, name=?, pass=?, age=?, addr=?, extension=?, dept=? where no=?";
        
        try {
            
            con = pool.getConnection();
            pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getName());
            pstmt.setString(3, dto.getPass());
            pstmt.setInt(4, dto.getAge());
            pstmt.setString(5, dto.getAddr());
            pstmt.setString(6, dto.getExtension());
            pstmt.setString(7, dto.getDept());
            pstmt.setInt(8, dto.getNo());
           
            pstmt.executeUpdate();
            
        } catch (Exception err) {
            
            System.out.println("getSawon메소드에서 오류 : " + err);

        }finally {
            
            pool.freeConnection(con, pstmt);
            
        }
    }    
}
