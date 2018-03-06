package classroom.exception;

/**
 * Created by ${tianlin} on 2017-12-10.
 */
public class RuleException extends RuntimeException {
    public RuleException(){
        super();
    }

    public RuleException(String message, Throwable cause){
        super(message,cause);
    }

    public RuleException(String message){
        super(message);
    }

    public RuleException(Throwable cause){
        super(cause);
    }
}
