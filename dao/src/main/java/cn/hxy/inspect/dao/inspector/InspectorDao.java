package cn.hxy.inspect.dao.inspector;

import cn.hxy.inspect.dao.util.DataConnection;
import cn.hxy.inspect.entity.inspector.Inspector;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

public class InspectorDao {

    private final static Logger logger = LoggerFactory.getLogger(InspectorDao.class);

    public List<Inspector> selectAll() throws IOException {

        SqlSession sqlSession = DataConnection.getSqlSession();
        List<Inspector> goodsList = sqlSession.selectList("Inspector.selectAll");
        logger.info("质检员查询结果条数" + goodsList.size());
        sqlSession.commit();
        sqlSession.close();
        return goodsList;


    }

    public Inspector findInspectorByTel(String tel) {
        // TODO Auto-generated method stub
        SqlSession sqlSession = null;
        try {
            sqlSession = DataConnection.getSqlSession();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Inspector user = sqlSession.selectOne("Inspector.findUserByNumber", tel);
        sqlSession.commit();//清空缓存
        sqlSession.close();
        return user;
    }

    public Inspector findInspectorById(String id) throws IOException {
        SqlSession sqlSession = DataConnection.getSqlSession();
        Inspector user = sqlSession.selectOne("Inspector.findInspectorById", id);
        sqlSession.commit();//清空缓存
        sqlSession.close();
        return user;
    }

    public int insert(Inspector user) throws IOException {
        SqlSession sqlSession = DataConnection.getSqlSession();
        int flag = sqlSession.insert("Inspector.insert", user);
        sqlSession.commit();
        sqlSession.close();
        logger.info("插入后结果：" + flag);
        return flag;
    }


    public boolean update(Inspector user) {
        // TODO Auto-generated method stub
        SqlSession sqlSession = null;
        try {
            sqlSession = DataConnection.getSqlSession();
        } catch (IOException e) {
            e.printStackTrace();
        }
        int flag = sqlSession.update("Inspector.update", user);
        logger.info("更新用户的信息：" + flag);
        sqlSession.commit();// 清空缓存
        sqlSession.close();
        return flag > 0; //这和customer 接口不一致呀

    }


}
