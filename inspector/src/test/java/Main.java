/**
 *
 * @author outofmemory.cn
 */
public class Main {

    public void getCurrentUser() {

        String currentUser = System.getProperty("user.name");
        System.out.println("Current user is " + currentUser);
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        new Main().getCurrentUser();
    }
}