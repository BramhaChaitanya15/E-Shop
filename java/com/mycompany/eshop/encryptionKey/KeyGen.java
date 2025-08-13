package com.mycompany.eshop.encryptionKey;

import java.security.Key;
import javax.crypto.spec.SecretKeySpec;

public class KeyGen {
    //ALGORITHM is used to store the algorithm name
    public static final String ALGORITHM = "AES";
    //keyValue stores the 16 digit key generation value
    public static final byte[] keyValue = "1234567891234567".getBytes();
    
    //function to generate encryption key
    public static Key generateKey() throws Exception {
        Key key = new SecretKeySpec(keyValue, ALGORITHM);
        return key;
    }
}
