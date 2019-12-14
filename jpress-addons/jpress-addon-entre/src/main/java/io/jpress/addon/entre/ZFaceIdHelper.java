package io.jpress.addon.entre;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.weixin.sdk.api.ApiResult;
import com.jfinal.weixin.sdk.utils.HttpUtils;
import com.jfinal.weixin.sdk.utils.JsonUtils;
import io.jboot.utils.HttpUtil;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

public class ZFaceIdHelper {
    //SecretId: AKID3rQ7YppX0Ho5PT81QaUEi7IFySfiobaJ
    //SecretKey:g9MOANKAk4C3f6PSTEk37wVyBJCqHSjm
    //生产环境默认24小时内同一身份证验证次数上限5次，同一设备10次
    public static String h5FaceIdCheckURL(String orderNo,String name,String idNo,String userId,String callBackURL) {
        String app_id = "IDA5oD0T";
        String secret = "N07MwpKmBoLBR6pWzXdcJ33c10E39KMl76dk85pFqHDI66kO41tBG0NNCTR4yOe1";
        String accessToken=getAccessToken(app_id,secret);
        String version="1.0.0";

        String signTicket=getSignTicket(app_id,accessToken);

        String sha1Sign=getSHA1Sign(app_id,orderNo,name,idNo,userId,version,signTicket);
        String h5faceId=getH5faceId(app_id,orderNo,name,idNo,userId,null,"1",version,sha1Sign);
        String nonceTicket=getNonceTicket(app_id,accessToken,userId);


        String  uuid=UUID.randomUUID().toString();
        uuid=uuid.replace("-","");
        String nonce=uuid;

        String h5FaceSHA1Sign=getH5FaceSHA1Sign(app_id, userId, nonce, version, h5faceId, orderNo,nonceTicket);

        String  enCodedCallBackURL="";
        try {
             enCodedCallBackURL=URLEncoder.encode(callBackURL,"utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        String url=enCodedCallBackURL;
        String resultType="2";
        String from="browser";
        String redirectType="1";
        String h5FaceIdCheckURL=getH5FaceIdCheckURL(app_id,version, nonce, orderNo, h5faceId, url, resultType, userId, h5FaceSHA1Sign, from, redirectType);
        String result=signTicket+"@"+h5FaceIdCheckURL;
        return result;
    }

    public static void main(String[] args) {


    }


    public static String getAccessToken(String  app_id,String secret){
        String accessToken="";
        ///https://idasc.webank.com/api/oauth2/access_token?app_id=xxx&secret=xxx&grant_type=client_credential&version=1.0.0
        String accessTokenURL = "https://idasc.webank.com/api/oauth2/access_token" + "?app_id={app_id}"
                + "&secret={secret}" + "&grant_type=client_credential&version=1.0.0";
        accessTokenURL = accessTokenURL.replace("{app_id}", app_id).replace("{secret}", secret);

        String jsonResult = null;
        try {
            jsonResult = HttpUtils.get(accessTokenURL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ApiResult apiResult = new ApiResult(jsonResult);
        accessToken=apiResult.getStr("access_token");
        System.out.println("accessToken:"+accessToken);
        return accessToken;
    }

    public static String getSignTicket(String app_id,String access_token){
        // https://idasc.webank.com/api/oauth2/api_ticket?app_id=xxx&access_token=xxx&type=SIGN&version=1.0.0
        String signTicket="";
        String signTicketURL = "https://idasc.webank.com/api/oauth2/api_ticket?app_id={app_id}&access_token={access_token}&type=SIGN&version=1.0.0";
        signTicketURL = signTicketURL.replace("{app_id}", app_id).replace("{access_token}", access_token);
        String jsonResult = null;
        try {
            jsonResult = HttpUtils.get(signTicketURL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ApiResult apiResult = new ApiResult(jsonResult);
        //https://cloud.tencent.com/document/product/1007/35883
        Object sign=apiResult.getList("tickets").get(0);
        String value= JSON.parseObject(sign.toString()).getString("value");
        signTicket=value;
        System.out.println("signTicket:"+signTicket);
        return signTicket;

    }

    //[1.0.0, 4300000000000, appId001, duSz9ptwyW1Xn7r6gYItxz3feMdJ8Na5x7JZuoxurE7RcI5TdwCE4KT2eEeNNDoe, orderNo19959248596551, testName, userID19959248596551]
//        webankAppId="appId001";
//        orderNo="19959248596551";
//        name="testName";
//        idNo="4300000000000";
//        userId="19959248596551";
//        version="1.0.0";
//        signTicket="duSz9ptwyW1Xn7r6gYItxz3feMdJ8Na5x7JZuoxurE7RcI5TdwCE4KT2eEeNNDoe";
    //1.0.04300000000000appId001duSz9ptwyW1Xn7r6gYItxz3feMdJ8Na5x7JZuoxurE7RcI5TdwCE4KT2eEeNNDoeorderNo19959248596551testNameuserId19959248596551
//1.0.04300000000000appId001duSz9ptwyW1Xn7r6gYItxz3feMdJ8Na5x7JZuoxurE7RcI5TdwCE4KT2eEeNNDoeorderNo19959248596551testNameuserID19959248596551
//arrStr="1.0.04300000000000appId001duSz9ptwyW1Xn7r6gYItxz3feMdJ8Na5x7JZuoxurE7RcI5TdwCE4KT2eEeNNDoeorderNo19959248596551testNameuserID19959248596551";
// 6b8601bcfd9acf30488a64c02c9409dbefc99e74
//EE57F7C1EDDE7B6BB0DFB54CD902836B8EB0575B
//EE57F7C1EDDE7B6BB0DFB54CD902836B8EB0575B
    public static String  getSHA1Sign(String webankAppId,String orderNo,String name,String idNo,String userId,String version,String signTicket){
        String[] arr=new String[7];
        arr[0]=webankAppId;
        arr[1]=orderNo;
        arr[2]=name;
        arr[3]=idNo;
        arr[4]=userId;
        arr[5]=version;
        arr[6]=signTicket;
        Arrays.sort(arr);
        String arrStr="";
        for (int i = 0; i < 7; i++) {
            arrStr+=arr[i];
        }

        String arrStrSHA1="";
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("SHA1");
            messageDigest.reset();
            messageDigest.update(arrStr.getBytes());
            arrStrSHA1=byteArrayToHexString(messageDigest.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        System.out.println(arrStr);
        System.out.println("SHA1:"+arrStrSHA1);
        return arrStrSHA1;
    }
    public static String byteArrayToHexString(final byte[] hash)
    {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }




    /**
     * {
     *   "code": "0",
     *   "msg": "请求成功",
     *   "bizSeqNo": "19082420001015300812421512766935",
     *   "result": {
     *     "bizSeqNo": "19082420001015300812421512766935",
     *     "transactionTime": "20190824124215",
     *     "orderNo": "99959248596551",
     *     "h5faceId": "430b48c53d32a4230c1e87da9e6f6516",
     *     "success": false
     *   },
     *   "transactionTime": "20190824124215"
     * }
     */
    public static String getH5faceId(String webankAppId,String orderNo,String name,String idNo,String userId,String sourcePhotoStr,String sourcePhotoType,String version,String sign){
        String h5faceId="";

        String faceIdURL="https://idasc.webank.com/api/server/h5/geth5faceid";
        Map<String, Object> jsonMap = new HashMap<String, Object>();

        jsonMap.put("webankAppId", webankAppId);
        jsonMap.put("orderNo", orderNo);
        jsonMap.put("name", name);
        jsonMap.put("idNo", idNo);
        jsonMap.put("userId", userId);
        // jsonMap.put("sourcePhotoStr", sourcePhotoStr);
        jsonMap.put("sourcePhotoType", sourcePhotoType);
        jsonMap.put("version", version);
        jsonMap.put("sign", sign);
        //webankAppId orderNo name idNo userId sourcePhotoStr sourcePhotoType version sign


        System.out.println(JsonUtils.toJson(jsonMap));
        String jsonResult = null;
        try {
            //jsonResult =  HttpUtils.post(faceIdURL,JsonUtils.toJson(jsonMap));
            Map<String, String> headers=new HashMap<>();
            headers.put("Content-Type","application/json");
            jsonResult= HttpUtil.httpPost(faceIdURL,null,headers,JsonUtils.toJson(jsonMap));
        } catch (Exception e) {
            e.printStackTrace();
        }
        ApiResult apiResult = new ApiResult(jsonResult);
        JSONObject jsonObject=(JSONObject)(apiResult.get("result"));
        //h5faceId=JSON.parseObject(apiResult.get("result").toString()).getString("h5faceId");
        h5faceId=jsonObject.getString("h5faceId");
        System.out.println(h5faceId);
        return h5faceId;
    }

    public static String getNonceTicket(String app_id,String access_token,String user_id){
        String apiTicketURL="https://idasc.webank.com/api/oauth2/api_ticket?app_id={app_id}&access_token={access_token}&type=NONCE&version=1.0.0&user_id={user_id}";
        apiTicketURL=apiTicketURL.replace("{app_id}",app_id).replace("{access_token}",access_token).replace("{user_id}",user_id);

        String nonceTicket="";
        String jsonResult = null;
        try {
            jsonResult = HttpUtils.get(apiTicketURL);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ApiResult apiResult = new ApiResult(jsonResult);
        System.out.println(apiResult);
        Object sign=apiResult.getList("tickets").get(0);
        String value=JSON.parseObject(sign.toString()).getString("value");
        nonceTicket=value;
        return nonceTicket;
    }

    //webankAppId userId nonce version h5faceId orderNo ticket
    public static String getH5FaceSHA1Sign(String webankAppId,String userId,String nonce,String version,String h5faceId,String orderNo,String ticket){
        String[] arr=new String[7];
        arr[0]=webankAppId;
        arr[1]=userId;
        arr[2]=nonce;
        arr[3]=version;
        arr[4]=h5faceId;
        arr[5]=orderNo;
        arr[6]=ticket;
        Arrays.sort(arr);
        String arrStr="";
        for (int i = 0; i < 7; i++) {
            arrStr+=arr[i];
        }

        String arrStrSHA1="";
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("SHA1");
            messageDigest.reset();
            messageDigest.update(arrStr.getBytes());
            arrStrSHA1=byteArrayToHexString(messageDigest.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        System.out.println(arrStr);
        System.out.println("H5FaceSHA1Sign:"+arrStrSHA1);
        return arrStrSHA1;
    }

    public static String getH5FaceIdCheckURL(String webankAppId,String version,String nonce,String orderNo,String h5faceId,String url,String resultType,String userId,String sign,String from,String redirectType){
        String h5FaceIdCheckURL="https://ida.webank.com/api/web/login?webankAppId={webankAppId}&version={version}&nonce={nonce}&orderNo={orderNo}&h5faceId={h5faceId}&url={url}&resultType={resultType}&userId={userId}&sign={sign}&from={from}&redirectType={redirectType}";
        h5FaceIdCheckURL=h5FaceIdCheckURL.replace("{webankAppId}",webankAppId).replace("{version}",version).replace("{nonce}",nonce)
                .replace("{orderNo}",orderNo).replace("{h5faceId}",h5faceId).replace("{url}",url).replace("{resultType}",resultType).replace("{userId}",userId).replace("{sign}",sign).replace("{from}",from).replace("{redirectType}",redirectType);
        return h5FaceIdCheckURL;
    }


    public static String  getArrSortSHA1Sign(String[] arr){
        Arrays.sort(arr);
        String arrStr="";
        for (int i = 0; i < arr.length; i++) {
            arrStr+=arr[i];
        }
        String arrStrSHA1="";
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("SHA1");
            messageDigest.reset();
            messageDigest.update(arrStr.getBytes());
            arrStrSHA1=byteArrayToHexString(messageDigest.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        System.out.println(arrStr);
        System.out.println("SHA1:"+arrStrSHA1);
        return arrStrSHA1;
    }
}
