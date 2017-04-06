package tools;

import javax.servlet.http.HttpServletRequest;


public class AMSErrorHandler {

	synchronized public static String handle(Object obj, Exception e , String errorMessageIfExceptionIsNull , String errorMessageIfNullPointerException) {
		AMSErrorHandler errorHandler = new AMSErrorHandler();
		String error = "";
		if (e != null) {
			if (e.getMessage() == null) {
				error = errorMessageIfNullPointerException;
			} else {
				error = errorHandler.handle(obj, e);
				if ("unhandled".equals(error)) {
					error = e.getMessage();
				}
			}
		} else {
			error = errorMessageIfExceptionIsNull;
		}
		e.printStackTrace();
		return error;
	}
	
	synchronized public static String handle(HttpServletRequest request, Object obj, Exception e , String errorMessageIfExceptionIsNull , String errorMessageIfNullPointerException) {
		String error = handle(obj, e, errorMessageIfExceptionIsNull, errorMessageIfNullPointerException);
		if (error.length() > 1000) {
			error = error.substring(0,999);
		}
		return error;
	}

	public String handle(Object obj, Exception e) {
		
		AMSErrorHandler errorHandler = new AMSErrorHandler();

		String className = obj.getClass().getCanonicalName();
		className = className.substring(className.lastIndexOf(".") + 1);
		
		String error = "";
		if ("OrderAction".equalsIgnoreCase(className)) {
			error = errorHandler.orderActionErrorHandle(e);
		} else if  ("AgentLocationAction".equalsIgnoreCase(className)) {
			error = errorHandler.agentLocationActionErrorHandle(e);
		} else if  ("BankAccountAction".equalsIgnoreCase(className)) {
			error = errorHandler.bankAccountActionErrorHandle(e);
		} else if  ("CosttypeAction".equalsIgnoreCase(className)) {
			error = errorHandler.costtypeActionErrorHandle(e);
		} else if  ("CreditAction".equalsIgnoreCase(className)) {
			error = errorHandler.creditActionErrorHandle(e);
		} else if  ("OrdercreditAction".equalsIgnoreCase(className)) {
			error = errorHandler.ordercreditActionErrorHandle(e);
		} else if  ("OrderficheAction".equalsIgnoreCase(className)) {
			error = errorHandler.orderficheActionErrorHandle(e);
		} else if  ("FicheAction".equalsIgnoreCase(className)) {
			error = errorHandler.ficheActionErrorHandle(e);
		} else if  ("OrderPursuitAction".equalsIgnoreCase(className)) {
			error = errorHandler.orderPursuitActionErrorHandle(e);
		} else if  ("UserAction".equalsIgnoreCase(className)) {
			error = errorHandler.userActionErrorHandle(e);
		} else if  ("ChangepasswordAction".equalsIgnoreCase(className)) {
			error = errorHandler.changePasswordActionErrorHandle(e);
		} else if  ("CustomerTurnoverAction".equalsIgnoreCase(className)) {
			error = errorHandler.customerTurnoverActionErrorHandle(e);
		} else if  ("CustomerQuotaAction".equalsIgnoreCase(className)) {
			error = errorHandler.customerQuotaActionErrorHandle(e);
		} else if  ("DailySaleAction".equalsIgnoreCase(className)) {
			error = errorHandler.dailySaleActionErrorHandle(e);
		} else if  ("ProductSaleAction".equalsIgnoreCase(className)) {
			error = errorHandler.productSaleActionErrorHandle(e);
		} else if  ("SellStatisticsAction".equalsIgnoreCase(className)) {
			error = errorHandler.sellStatisticsActionErrorHandle(e);
		} else if  ("RecConfirmAction".equalsIgnoreCase(className)) {
			error = errorHandler.recConfirmActionErrorHandle(e);
		} else {
			error = "unhandled";
		}
		return error;
	}

	public static void throwException(Object obj, Exception e) throws AMSException {
    	e.printStackTrace();
		String className = obj.getClass().getCanonicalName();
		className = className.substring(className.lastIndexOf(".") + 1);
		if ("MellatEPaymentWS".equalsIgnoreCase(className)) {
	    	if (e.getMessage().contains("java.net.UnknownHostException")) {
		    	throw new AMSException("ارتباط با بانک قطع شده است");
	    	} else {
	    		throw new AMSException(e.getMessage());
	    	}
		}
	}

	
	private String recConfirmActionErrorHandle(Exception e) {
		String error = "";
		if (e.getMessage().contains("کد مشتري صحيح نيست")) {
			error = "کد مشتري صحيح نيست";
		} else if (e.getMessage().contains("تاريخ صحيح نيست")) {
			error = "تاريخ صحيح نيست";
		} else if (e.getMessage().contains("کد مشتري وارد شده موجود نيست")) {
			error = "کد مشتري وارد شده موجود نيست";
		} else if (e.getMessage().contains("حواله اي با اين شماره وجود ندارد")) {
			error = "حواله اي با اين شماره وجود ندارد";
		} else if (e.getMessage().contains("�?قط آخرين درخواست يک مشتري براي يک �?رآورده قابل ويرايش و تغيير ميباشد")) {
			error = "�?قط آخرين درخواست يک مشتري براي يک �?رآورده قابل ويرايش و تغيير ميباشد";
		} else if (e.getMessage().contains("درخواست تائيد شده قابل ويرايش نيست")) {
			error = "درخواست تائيد شده قابل ويرايش نيست";
		} else if (e.getMessage().contains("�?قط آخرين درخواست يک مشتري براي يک �?رآورده قابل تائيد ميباشد")) {
			error = "�?قط آخرين درخواست يک مشتري براي يک �?رآورده قابل تائيد ميباشد";
		} else if (e.getMessage().contains("�?قط آخرين درخواست يک مشتري براي يک �?رآورده قابل تائيد ميباشد")) {
			error = "�?قط آخرين درخواست يک مشتري براي يک �?رآورده قابل تائيد ميباشد";
		} else if (e.getMessage().contains("اين درخواست قبلا در تاريخ")) {
			error = "اين درخواست قبلا تائيد شده است";
		} else {
			error = "unhandled";
		}
		return error;
	}


	public String orderActionErrorHandle(Exception e) {
		String error = "";
		if (e.getMessage().contains("لط�?ا قرارداد �?روش مشتري را  وارد نمائيد")) {
			error = "لط�?ا قرارداد �?روش مشتري را  وارد نمائيد";
		} else if (e.getMessage().contains("اشکال در اطلاعات �?يش ها : �?يش (ها(ي کا�?ي براي حواله انتخاب نشده است . لط�?ا بررسي شود")) {
			error = "اشکال در اطلاعات �?يش ها : �?يش هاي کا�?ي براي حواله انتخاب نشده است";
		} else if (e.getMessage().contains("لط�?ا مجوز مالي يا �?يش نقدي مربوط به حواله را وارد نمائيد")) {
			error = "لط�?ا مجوز مالي يا �?يش نقدي مربوط به حواله را وارد نمائيد";
		} else if (e.getMessage().contains("لط�?ا قرارداد حـمل مشتري را  وارد نمائيد")) {
			error = "لط�?ا قرارداد حـمل مشتري را  وارد نمائيد";
		} else if (e.getMessage().contains("اشکال در اطلاعات مجوز ها : مجوز (ها( کا�?ي براي حواله انتخاب نشده است . لط�?ا بررسي شود")) {
			error = "اشکال در اطلاعات مجوز ها : مجوزهای کا�?ي براي حواله انتخاب نشده است";
		} else if (e.getMessage().contains("مجوز انتخاب شده براي �?رآورده انتخاب شده در حواله نيست و همخواني ندارد")) {
			error = "مجوز انتخاب شده براي �?رآورده انتخاب شده در حواله نيست و همخواني ندارد";
		} else if (e.getMessage().contains("مانده سهمیه کمتر از مقدار حواله میباشد")) {
			error = "مانده سهمیه کمتر از مقدار حواله میباشد";
		} else if (e.getMessage().contains("اشکال در اطلاعات �?يش ها : �?يش (هاي مجزا( اضا�?ي براي حواله انتخاب شده است . لط�?ا بررسي شود")) {
			error = "اشکال در اطلاعات �?يش ها : �?يش هاي اضا�?ي براي حواله انتخاب شده است";
		} else if (e.getMessage().contains("اشکال در اطلاعات �?يش ها : �?يش (ها( اضا�?ي براي حواله انتخاب شده است . لط�?ا بررسي شود")) {
			error = "اشکال در اطلاعات �?يش ها : �?يش های اضا�?ي براي حواله انتخاب شده است";
		} else if (e.getMessage().contains("مشتري با مشخصات درخواست شده وجود ندارد")) {
			error = "مشتري با مشخصات درخواست شده وجود ندارد";
		} else if (e.getMessage().contains("شناسه حواله درخواست شده در بانک اطلاعاتي وجود ندارد")) {
			error = "شناسه حواله درخواست شده در بانک اطلاعاتي وجود ندارد";
		} else if (e.getMessage().contains("اشکال در اطلاعات �?يش ها : �?يش  مجزا(ها(ي کا�?ي براي حواله انتخاب نشده است . لط�?ا بررسي شود")) {
			error = "اشکال در اطلاعات �?يش ها : �?يش های مجزای کا�?ی برای حواله انتخاب نشده است";
		} else if (e.getMessage().contains("اطلاعات حساب بانکي يا کد شعبه و يا شماره حساب صحيح نميباشد")) {
			error = "اطلاعات حساب بانکي يا کد شعبه و يا شماره حساب صحيح نميباشد";
		} else if (e.getMessage().contains("Violation of UNIQUE KEY constraint 'U_Fiches_FicheNo_F_CustomerID'. Cannot insert duplicate key in object 'Fiches'.")) {
			error = "این �?یش قبلا ثبت شده است";
		} else if (e.getMessage().contains("مقدار حواله با ظر�?يتهاي تعيين شده براي مشتري همخواني ندارد")) {
			error = "مقدار حواله با ظر�?يتهاي تعيين شده براي مشتري همخواني ندارد";
		} else if (e.getMessage().contains("costsNotMatch")) {
			error = "عدم تطابق مبالغ هزینه ها";
		} else if (e.getMessage().contains("براي صدور حواله اينترنتي تعري�? ظر�?يت حمل مشتري الزامي است")) {
			error = "براي صدور حواله اينترنتي تعري�? ظر�?يت حمل مشتري الزامي است";
		} else if (e.getMessage().contains("شناسه س�?ارش درخواست شده در بانک اطلاعاتي وجود ندارد")) {
			error = "شناسه س�?ارش درخواست شده در بانک اطلاعاتي وجود ندارد";
		} else if (e.getMessage().contains("بسته شده است وامکان ثبت حواله جديد وجود ندارد")) {
			error = "�?روش بسته شده است وامکان ثبت حواله جديد وجود ندارد";
		} else if (e.getMessage().contains("کد مشتري اشتباه است لط�?ا تصحيح شود")) {
			error = "کد مشتري اشتباه است لط�?ا تصحيح شود";
		} else if (e.getMessage().contains("غير�?عال است")) {
			int indexStart = e.getMessage().indexOf("مشتري");
			int indexEnd = e.getMessage().indexOf("غير�?عال است")+"غير�?عال است".length();
			error = e.getMessage().substring(indexStart,indexEnd);
		} else {
			error = "unhandled";
		}
		return error;
	}

	public String agentLocationActionErrorHandle(Exception e) {
		String error = "";
		if (e.getMessage().contains("userNotFound")) {
			error = "کاربری با این کد یا�?ت نشد";
		} else {
			error = "unhandled";
		}
		return error;
	}
	
	public String bankAccountActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}
	
	private String costtypeActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}

	private String creditActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}
	
	private String ordercreditActionErrorHandle(Exception e) {
		String error = "";
		if (e.getMessage().contains("از تاريخ اعتبار مجوز درخواستي گذشته است و امکان است�?اده در اين حواله را ندارد")) {				
			error = "از تاريخ اعتبار مجوز درخواستي گذشته است و امکان است�?اده در اين حواله را ندارد";
		} else if (e.getMessage().contains("براي اطلاعات درخواستي مجوزي پيدا نشد") )  {
			error = "براي اطلاعات درخواستي مجوزي پيدا نشد";
		} else if (e.getMessage().contains("از تاريخ اعتبار مجوز درخواستي گذشته است و امکان است�?اده در اين س�?ارش را ندارد")) {
			error = "از تاريخ اعتبار مجوز درخواستي گذشته است و امکان است�?اده در اين س�?ارش را ندارد";
		} else {
			error = "unhandled";
		}
		return error;
	}
	
	private String orderficheActionErrorHandle(Exception e) {
		String error = "";
		if (e.getMessage().contains("Violation of UNIQUE KEY constraint 'U_Fiches_FicheNo_F_CustomerID'. Cannot insert duplicate key in object 'Fiches'.")) {
			error = "این شماره �?یش قبلا ثبت شده است";
		} else if (e.getMessage().contains("Violation of UNIQUE KEY constraint 'U_Fiches_FicheNo'. Cannot insert duplicate key in object 'Fiches'.")) {
			error ="این شماره �?یش قبلا ثبت شده است";
		} else if (e.getMessage().contains("مشتري با مشخصات درخواست شده وجود ندارد")) {
			error ="مشتري با مشخصات درخواست شده وجود ندارد";
		} else if (e.getMessage().contains("مشتري با مشخصات درخواست شده بيش از يک مورد پيدا شده است")) {
			error ="مشتري با مشخصات درخواست شده بيش از يک مورد پيدا شده است";
		} else if (e.getMessage().contains("اطلاعات حساب بانکي يا کد شعبه و يا شماره حساب صحيح نميباشد")) {
			error = "اطلاعات حساب بانکي يا کد شعبه و يا شماره حساب صحيح نميباشد";
		} else if (e.getMessage().contains("Violation of UNIQUE KEY constraint 'U_Fiches_FicheNo_F_CustomerID'")) {
			error = "این �?یش قبلا ثبت شده است و اطلاعات آن تکراری است";
		} else if (e.getMessage().contains("Violation of UNIQUE KEY constraint 'U_Fiches_FicheNo'")) {
			error ="این �?یش قبلا ثبت شده است";
		} else if (e.getMessage().contains("محل جاري تعري�? نشده است")) {
			error ="محل جاري تعري�? نشده است";
		} else if (e.getMessage().contains("محل جاري در منوي  کاربر تعري�? نشده است")) {
			error ="محل جاري در منوي  کاربر تعري�? نشده است";
		} else if (e.getMessage().contains("غير�?عال است")) {
			int index = e.getMessage().indexOf("Server was unable to process request. --->");
			int indexStrLenth = "Server was unable to process request. --->".length();
			if (index != 0) {
				error = e.getMessage().substring(index + indexStrLenth);
			}
		} else 	{
			error = "unhandled";
		}
		return error;
	}
	
	public String ficheActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}
	
	public String orderPursuitActionErrorHandle(Exception e) {
		String error = "";
		if (e.getMessage().contains("حواله مورد درخواست وجود ندارد")) {
			error = "حواله مورد درخواست وجود ندارد";
		} else	if (e.getMessage().contains("حواله درخواست شده به شماره")) {
			error = e.getMessage().split("--->")[1];
		} else if (e.getMessage().contains("س�?ارش مورد درخواست وجود ندارد")) {
			error = "حواله مورد درخواست وجود ندارد";
		} else if (e.getMessage().contains("کد مشتري اشتباه است")) {
			error = "کد مشتري اشتباه است";
		} else if (e.getMessage().contains("س�?ارش درخواست شده به شماره")) {
			error = e.getMessage().split("--->")[1];
		} else {
			error = "unhandled";
		}
		return error;
	}
	
	private String userActionErrorHandle(Exception e) {
		String error = "";
		if (e.getMessage().contains("Duplicate entry")) {
			error = "نام کاربری و یا کد تکراری است";
		} else if (e.getMessage().contains("handleThis")) {
			error = "عملیات ثبت با مشکل روبرو شده است";
		} else if (e.getMessage().contains("Data truncation: Data too long for column")) {
			error = "تعداد کاراکترهای ورودی بیش از حد مجاز است";
		} else if (e.getMessage().contains("notFilledFields")) {
			error = "یکی از مقادیر کد / نام / نام کاربری / کلمه عبور خالی است";
		} else {
			error = "unhandled";
		}
		return error;
	}
		
	private String changePasswordActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}
	
	private String customerTurnoverActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}

	private String customerQuotaActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}
	
	private String dailySaleActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}

	private String productSaleActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}
	
	private String sellStatisticsActionErrorHandle(Exception e) {
		String error = "";
		error = "unhandled";
		return error;
	}
	
	synchronized public static String getMellatMessage(Integer msgCode , int mode) {
		String message = "";
		switch (mode) {
		case 0:
		case 1:
		case 2:
			switch (msgCode) {
			case -2:
				message = "اشکال در برقراری ارتباط با بانک (timeout). لط�?ا مجددا سعی کنید";
				break;
			case -1:
				message = "با توجه به �?یش های است�?اده شده برای این حواله نیازی به پرداخت الکترونیکی نیست";
				break;
			case 0:
				message = "تراکنش با مو�?قیت انجام شد";
				break;
			case 1:
				message = "با بانک صادر کننده کارت تماس حاصل نمایید";
				break;
			case 12:
				message = "تراکنش نامعتبر";
				break;
			case 13:
				message = "مبلغ نامعتبر";
				break;
			case 14:
				message = "شماره کارت صحیح نمی باشد";
				break;
			case 30:
				message = "�?رمت پیام دارای اشکال می باشد";
				break;
			case 33:
				message = "تاریخ است�?اده از کارت به پایان رسیده است";
				break;
			case 38:
				message = "ورود شماره شناسایی از حد مجاز به پایان رسیده است";
				break;
			case 41:
				message = "کارت م�?قود می باشد";
				break;
			case 43:
				message = "کارت مسروقه است";
				break;
			case 51:
				message = "موجودی حساب کا�?ی نمی باشد";
				break;
			case 55:
				message = "شماره شناسایی وارده صحیح نمی باشد";
				break;
			case 57:
				message = "دارنده کارت مجاز به است�?اده از این کارت نمی باشد";
				break;
			case 58:
				message = "پذیرنده کارت مجاز به است�?اده از این کارت نمی باشد";
				break;
			case 61:
				message = "مبلغ تراکنش از حد مجاز بالاتر است";
				break;
			case 65:
				message = "تعداد د�?عات تراکنش از حد مجاز بیشتر است";
				break;
			case 76:
				message = "شماره کارت در سیستم موجود نمی باشد";
				break;
			case 80:
				message = "تراکنش مو�?ق عمل نکرده است";
				break;
			case 84:
				message = "سویچ صادر کننده �?عال نیست";
				break;
			case 88:
				message = "سیستم بانک دچار اشکال شده است";
				break;
			case 90:
				message = "سیستم صدور مجوز انجام تراکنش موقتا غیر �?عال است و یا زمان تعیین شده برای مجوز به پایان رسیده است";
				break;
			case 93:
				message = "عدم انطباق در شماره شناسایی �?ایل پیکربندی";
				break;
			case 94:
				message = "کد رزرو تکراری است";
				break;
			case 95:
				message = "ترمینال غیر �?عال است";
				break;
			case 96:
				message = "ترمینال مجاز به انجام تراکنش نیست";
				break;
			case 97:
				message = "شماره batch مطابقت ندارد";
				break;
			case 98:
				message = "شماره batch موجود نیست";
				break;
			case 101:
				message = "ارسال �?ایل های مورد نیاز";
				break;
			case 102:
				message = "شماره پیگیری صحیح نمی باشد";
				break;
			case 103:
				message = "برای این hash code تراکنشی صورت نگر�?ته است";
				break;
			case 110:
				message = "ساعت و تقویم ترمینال صحیح نمی باشد";
				break;
			default:
				message = "not yet handled";
				break;
			}
			break;
		case 3:
		case 4:
		case 5:
		case 6:
		case 8:
			switch(msgCode) {
			case -1:
				message = "اشکال در برقراری ارتباط با بانک لط�?ا مجددا سعی کنید";
				break;
			case 0:
				message = "تراکنش با مو�?قیت انجام شد";
				break;
			case 1:
				message = "خطای ناشناخته";
				break;
			case 2:
				message = "رکوردی از طر�? بانک پیدا نشد";
				break;
			case 3:
				message = "نام کاربری یا اسم رمز نامعتبر است";
				break;
			case 4:
				message = "کاربر دسترسی ندارد";
				break;
			case 5:
				message = "پارامترها بدرستی مقدار دهی نشده اند";
				break;
			case 6:
				message = "شماره پذیرنده نامعتبر است";
				break;
			case 7:
				message = "بازه تاریخی نادرست است";
				break;
			case 8:
				message = "تراکنش پیش از این اعلام مو�?قیت شده است";
				break;
			case 9:
				message = "تراکنش نامعتبر";
				break;
			}
			break;	
		case 7:
			switch(msgCode) {
			case 0:
				message = "مو�?قيت آميز بودن انجام درخواست";
				break;
			case 2:
				message = "شناسه مشتری اشتباه است";
				break;
			case 6:
				message = "خطا در انجام تراكنش";
				break;
			case 11:
				message = "شماره خارجي مشتري بايد پر شود";
				break;
			case 12:
				message = "شماره خارجي مشتري نامعتبر مي باشد";
				break;
			case 13:
				message = "سرويس براي اين مشتري غير�?عال مي باشد";
				break;
			case 21:
				message = "شماره تراكنش بايد پر شود";
				break;
			case 22:
				message = "تراكنش پس از انجام برگشت خورده است";
				break;
			case 23:
				message = "تراكنش مورد نظر در سامانه موجود نمي باشد";
				break;
			case 24:
				message = "تراكنش نامعتبر مي باشد";
				break;
			case 31:
				message = "تاريخ تراكنش اشتباه مي باشد";
				break;
			case 41:
				message = "كد محيط پرداخت بايد پر باشد";
				break;
			case 42:
				message = "كد شعبه بايد پر باشد";
				break;
			case 43:
				message = "تاريخ ارسال استعلام اشتباه مي باشد";
				break;
			case 44:
				message = "زمان ارسال استعلام اشتباه مي باشد";
				break;
			case 45:
				message = "كد محيط پرداخت اشتباه مي باشد";
				break;
			case 46:
				message = "كد شناسه قبض اشتباه مي باشد";
				break;
			case 47:
				message = "كد شناسه پرداخت اشتباه مي باشد";
				break;
			case 48:
				message = "كد شناسه قبض و پرداخت معتبر نمي باشد";
				break;
			case 51:
				message = "كد شناسه بايد پر باشد";
				break;
			case 52:
				message = "كد شناسه نامعتبر مي باشد";
				break;
			case 68:
				message = "سيستم بانک بطور موقت دچار اشكال شده است";
				break;
			}
			break;	
		}
		return message;
	}

	synchronized public static int getMellatMessage(String errorString) {
		int res = -1;
		if (errorString.contains("SUCCESS")) {
			res = 0;
		} else if (errorString.contains("ERROR")) {
			res = 1;
		} else if (errorString.contains( "RECORD_NOT_FOUND" )) {
			res = 2;
		} else if (errorString.contains("USER_NOT_FOUND")) {
			res = 3;
		} else if (errorString.contains("USER_DOES_NOT_HAVE_OPERATION")) {
			res = 4;
		} else if (errorString.contains("INVALID_ARGUMENT")) {
			res = 5;
		} else if (errorString.contains("TERMINAL_ID_COULD_NOT_BE_ZERO_OR_NULL")) {
			res = 6;
		} else if (errorString.contains("FROMTRANSACTIONDATE_OR_TOTRANSACTIONDATE_COULD_NOT_BE_ZERO_OR_NULL")) {
			res = 7;
		} else if (errorString.contains("TRANSACTION_IS_ALREADY_SETTLED")) {
			res = 8;
		} else if (errorString.contains("TRANSACTION_DATE_IS_EXPIRED")) {
			res = 9;
		} 
		return res;
	}	
		
	synchronized public static String getMelliMessage(Integer msgCode) {
		String message = "";
		switch (msgCode) {
		case -2:
			message = "اشکال در برقراری ارتباط با بانک";
			break;
		case -1:
			message = "خطای برگشتی از سایت بانک ملی: یکی از موارد مبلغ، شماره س�?ارش یا کلید اشتباه است";
			break;
		case 0:
			message = "تراکنش با مو�?قیت به انجام رسید";
			break;
		case 1:
			message = "با بانک صادر کننده تماس حاصل نمایید";
			break;
		case 3:
			message = "پذیرنده کارت �?عال نیست";
			break;
		case 12:
			message = "تراکنش معتبر نمی باشد";
			break;
		case 13:
			message = "مبلغ تراکنش معتبر نمی باشد";
			break;
		case 33:
			message = "تاریخ است�?اده کارت به پایان رسیده است";
			break;
		case 41:
			message = "کارت م�?قوده می باشد";
			break;
		case 43:
			message = "کارت مسروقه می باشد";
			break;
		case 51:
			message = "موجودی حساب کا�?ی نمی باشد";
			break;
		case 55:
			message = "رمز وارده صحیح نمی باشد";
			break;
		case 56:
			message = "شماره کارت یا CVV2  صحیح نمی باشد";
			break;
		case 57:
			message = "دارنده کارت مجاز به انجام این تراکنش نمی باشد";
			break;
		case 58:
			message = "پذیرنده کارت مجاز به انجام این تراکنش نمی باشد";
			break;
		case 61:
			message = "مبلغ تراکنش از حد مجاز بالاتر است";
			break;
		case 65:
			message = "تعداد د�?عات تراکنش از حد مجاز بیشتر است";
			break;
		case 75:
			message = "ورود رمز دوم از حد مجاز گذشته است. رمز دوم جدید در خواست نمایید";
			break;
		case 79:
			message = "شماره حساب نامعتبر است";
			break;
		case 80:
			message = "تراکنش مو�?ق عمل نکرده است";
			break;
		case 84:
			message = "سوئیچ صادر کننده کارت �?عال نیست";
			break;
		case 88:
			message = "سیستم دچار اشکال شده است";
			break;
		case 90:
			message = "ارتباط به طور موقت قطع می باشد";
			break;
		case 91:
			message = "پاسخ در زمان تعیین شده بدست سیستم نرسیده است";
			break;
		case 1003:
			message = "اطلاعات پذیرنده اشتباه است";
			break;
		case 1004:
			message = "پذیرنده موجود نیست";
			break;
		case 1006:
			message = "خطای داخلی";
			break;
		case 1012:
			message = "اطلاعات پذیرنده اشتباه است";
			break;
		case 1017:
			message = "پاسخ خطا از سمت مرکز";
			break;
		case 1018:
			message = "شماره کارت اشتباه است";
			break;
		case 1019:
			message = "مبلغ بیش از حد مجاز است";
			break;
		case 9005:
			message = "تراکنش نامو�?ق ( مبلغ به حساب دارنده کارت برگشت داده شده است)";
			break;
		case 9006:
			message = "تراکنش ناتمام ( در صورت کسرموجودی مبلغ به حساب دارنده کارت برگشت داده می شود)";
			break;
		}			
		return message;
	}

	synchronized public static int getSamanState(String errorString) {
		int res = -1;
		if (errorString.equalsIgnoreCase("OK")) {
			res = 0;
		} else if (errorString.equalsIgnoreCase("Canceled By User")) {
			res = 1;
		} else if (errorString.equalsIgnoreCase("Invalid Amount")) {
			res = 2;
		} else if (errorString.equalsIgnoreCase("Invalid Transaction")) {
			res = 3;
		} else if (errorString.equalsIgnoreCase("Invalid Card Number")) {
			res = 4;
		} else if (errorString.equalsIgnoreCase("No Such Issuer")) {
			res = 5;
		} else if (errorString.equalsIgnoreCase("Expired Card Pick Up")) {
			res = 6;
		} else if (errorString.equalsIgnoreCase("Allowable PIN Tries Exceeded Pick Up")) {
			res = 7;
		} else if (errorString.equalsIgnoreCase("Incorrect PIN")) {
			res = 8;
		} else if (errorString.equalsIgnoreCase("Exceeds Withdrawal Amount Limit")) {
			res = 9;
		} else if (errorString.equalsIgnoreCase("Transaction Cannot Be Completed")) {
			res = 10;
		} else if (errorString.equalsIgnoreCase("Response Received Too Late")) {
			res = 11;
		} else if (errorString.equalsIgnoreCase("Suspected Fraud Pick Up")) {
			res = 12;
		} else if (errorString.equalsIgnoreCase("No Sufficient Funds")) {
			res = 13;
		} else if (errorString.equalsIgnoreCase("Issuer Down Slm")) {
			res = 14;
		} else if (errorString.equalsIgnoreCase("TME Error")) {
			res = 15;
		} else if (errorString.equalsIgnoreCase("RefNum, ResNum, or Amount Does Not Match")) {
			res = 16;
		} else if (errorString.equalsIgnoreCase("Can Not Find Transaction")) {
			res = 17;
		} else if (errorString.equalsIgnoreCase("Merchant Authentication Failed")) {
			res = 18;
		} else if (errorString.equalsIgnoreCase("Bad Card Number")) {
			res = 1000;
		}
		return res;
	}	

	synchronized public static String getSamanMessage(double msgCodeDBL) {
		String message = "";
		int msgCode = (int) msgCodeDBL;
		switch (msgCode) {
		case -1:
			message = "خطاي داخلي شبکه مالي";
			break;
		case -2:
			message = "سپرده‌ها برابر نيستند. ( در حال حاضر اين شرايط به وجود نمي آيد)";
			break;
		case -3:
			message = "ورودي‌ها حاوي کارکترهاي غيرمجاز مي‌باشند";
			break;
		case -4:
			message = "Merchant Authentication Failed ( کلمه عبور يا کد �?روشنده اشتباه است)";
			break;
		case -5:
			message = "Database Exception";
			break;
		case -6:
			message = "سند قبلا برگشت کامل يا�?ته است";
			break;
		case -7:
			message = "رسيد ديجيتالي تهي است";
			break;
		case -8:
			message = "طول ورودي‌ها بيشتر از حد مجاز است";
			break;
		case -9:
			message = "وجود کارکترهاي غيرمجاز در مبلغ برگشتي";
			break;
		case -10:
			message = "رسيد ديجيتالي به صورت Base64 نيست (حاوي کارکترهاي غيرمجاز است)";
			break;
		case -11:
			message = "طول ورودي‌ها کمتر از حد مجاز است";
			break;
		case -12:
			message = "مبلغ برگشتي من�?ي است";
			break;
		case -13:
			message = "مبلغ برگشتي براي برگشت جزئي بيش از مبلغ برگشت نخورده‌ي رسيد ديجيتالي است";
			break;
		case -14:
			message = "چنين تراکنشي تعري�? نشده است";
			break;
		case -15:
			message = "مبلغ برگشتي به صورت اعشاري داده شده است";
			break;
		case -16:
			message = "خطاي داخلي سيستم";
			break;
		case -17:
			message = "برگشت زدن جزيي تراکنشي که با کارت بانکي غير از بانک سامان انجام پذير�?ته است";
			break;
		case -18:
			message = "IP Address  �?روشنده نا معتبر است";
			break;
		case 1:
			message = "تراکنش توسط خریدار کنسل شده است";
			break;
		case 2:
			message = "مبلغ سند برگشتی از مبلغ تراکنش اصلی بیشتر است";
			break;
		case 3:
			message = "درخواست برگشت یک تراکنش رسیده است در حالی که تراکنش اصلی پیدا نمی شود";
			break;
		case 4:
			message = "شماره کارت اشتباه است";
			break;
		case 5:
			message = "چنین صادر کننده کارتی وجود ندارد";
			break;
		case 6:
			message = "از تاریخ انقضای کارت گذشته است و کارت دیگر معتبر نیست";
			break;
		case 7:
			message = "رمز کارت (PIN) 3 مرتبه اشتباه وارد شده است در نتيجه کارت غير �?عال خواهد شد.";
			break;
		case 8:
			message = "خريدار رمز کارت (PIN) را اشتباه وارد کرده است.";
			break;
		case 9:
			message = "مبلغ بيش از سق�? برداشت مي باشد.";
			break;
		case 10:
			message = "تراکنش Authorize شده است ( شماره PIN و PAN درست هستند) ولي امکان سند خوردن وجود ندارد.";
			break;
		case 11:
			message = "تراکنش در شبکه بانکي Timeout خورده است.";
			break;
		case 12:
			message = "خريدار يا �?يلد CVV2 و يا �?يلد ExpDate را اشتباه زده است. ( يا اصلا وارد نکرده است)";
			break;
		case 13:
			message = "موجودي به اندازي کا�?ي در حساب وجود ندارد.";
			break;
		case 14:
			message = "سيستم کارت بانک صادر کننده در وضعيت عملياتي نيست.";
			break;
		case 15:
			message = "کليه خطاهاي ديگر بانکي باعث ايجاد چنين خطايي مي گردد.";
			break;
		case -1001:
			message = "پاسخی از بانک دریا�?ت نشد";
			break;
		}
		return message;
	}		
			
}