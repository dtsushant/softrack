package softrack

import org.apache.commons.lang.RandomStringUtils
import com.softrack.User

class UserService {

    //MailService mailService;
    def grailsApplication;
    def userRecovery;

    def changePassword(User user, String newPasswd) {
        user.password = newPasswd;
        user.passwordExpired = false
        user.save();
    }

    def changePassword(Long userId, String newPasswdOne, String newPasswdTwo) {
        User user = User.get(userId);
        if (newPasswdOne != newPasswdTwo) {
            flash.message = "Passwords do not match";
            return;
        } else if (newPasswdOne.toLowerCase() =~ user.username.toLowerCase()) {
            flash.message = "Too easy password. Make sure you didn't use any of your employee information";
            return;
        } else {
            user.password = newPasswdOne;
            user.save();
        }
    }

    def resetPassword(Long userId, String newPasswdOne, String newPasswdTwo) {
        User user = User.get(userId);
        if (newPasswdOne != newPasswdTwo) {
            flash.message = "Passwords do not match";
            return;
        } else if (newPasswdOne.toLowerCase() =~ user.username.toLowerCase()) {
            flash.message = "Too easy password. Make sure you didn't use any of your employee information";
            return;
        } else {
            user.password = newPasswdOne;
            user.save();
            flash.message = "Password updated successfully"
        }
    }

    /*def forgotPassword(String emailAddress, String baseUrl) {
        def userInstance = User.findByUsername(emailAddress);
        if (!userInstance) {
            return
        }

        def userRecoveryInstance = UserRecovery.findByUser(userInstance)

        println userRecoveryInstance

        if (userRecoveryInstance)
        {
            userRecoveryInstance.delete(flush: true)
        }

        try {
            String charset = (('A'..'Z') + ('0'..'9')).join();
            Integer length = 36;
            String tokenPrefix = RandomStringUtils.random(length, charset.toCharArray());
            String tokenSuffix = (new Date().toString() + emailAddress).encodeAsSHA256();
            String token = tokenPrefix + tokenSuffix;
            String url = baseUrl + "/login/reset/?token=" + token;
            UserRecovery userRecovery1 = new UserRecovery();
            userRecovery1.user = userInstance;
            userRecovery1.resetToken = token;
            userRecovery1.expiryDate = new Date().next();
            userRecovery1.save()
            try {
                sendMail
                        {
                            to emailAddress
                            subject "Password Reset"
                            multipart false
                            body(view: "/email/reset",
                                    model: [username: userInstance.username, reset_url: url]
                            )

                        }
            }
            catch (Exception e) {
                flash.message = 'Problem Sending email'
            }
        }
        catch (Exception e) {
            flash.message = "Unexpected error occurred. Please try again later."
        }
    }

    def resetPassword(String token) {
        UserRecovery userRecovery = UserRecovery.findByResetToken(token);
        if (userRecovery == null) {
            return null;
        } else {
            return User.get(userRecovery.userId);
        }
    }*/

    Boolean validatePassword(password) {
        (password != null) && (password ==~ /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[\W])(?=.*[\d]).*$/)
    }
}
