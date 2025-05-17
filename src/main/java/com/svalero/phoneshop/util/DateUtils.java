package com.svalero.phoneshop.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {


    private final static String DATE_PATTERN = "dd/MM/yyyy";

    public static String format(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        return sdf.format(date);
    }
}

