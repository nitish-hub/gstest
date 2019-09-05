%dw 2.0

fun getGender(gender: String) 
             = if (gender == 'GIRL') 'Female' else if (gender == 'NON GIRL') 'Male' else null

fun getformatDate(dateString: String)
             = dateString as Date {format: 'MM-dd-yyyy'}  as String {format: 'MM-dd-yyyy'} 