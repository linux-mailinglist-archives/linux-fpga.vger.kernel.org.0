Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00AB2C99E9
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLAIsK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 03:48:10 -0500
Received: from mail-eopbgr60110.outbound.protection.outlook.com ([40.107.6.110]:10659
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727058AbgLAIsK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 03:48:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI+x1YTjZnW4hRhArLK37XozT0mZCpnRvM4n7Rft8a7xxaYVmIEbRzCJvRcsw34LT/b+AN+FvwuMd6CgAJFp56+xsM3DrlAU6yzNJevrmo51FVv+uT/CyDcrzzuOAV/sl34te2KnL+E6fdQNuPlGUdoaY4rIY2k/3eMuP4Et11n3t7COg8uYMvzsFOmwTOt/RQWB2A+AX6yS8khGFeonOftB2w+QWFO9B8kICAwM97PVdx1mSH0R2wzS0xx1EigytNY0CP86kH8+BynpOCE8nBHCN6LzKcmHtQqu/On/dcJqdpU+1TiQ9tIrM6j7RbXZTb9ShsgvCNk/tOiUBTTHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC/wlcH6m2zXMpdT6yWmQ9dTXaonDNo2WVzNL+udO6Y=;
 b=Ae/tNy/z0kAWaqhs+R+VFlNKuRWuUpj3rzQEEZCSRO9Mj3tIPNi7VmmQM4tfcPWLOzCTxrA+4Yg1HTQXiRYygI6gzv0Q8MRbxWiG8jmwygu7c0QZHrfjHMA7FaWfiBfau0w6nKAXS9BdvzCRX7UzlJBiiBvLwXvGgxRfaBmKmFAFPEsYyJG7L4Lcc6L9b0fw3w8XdK/ILmdQL5oULxb/oPdchAVWQkdF1UfRWHpTCvOG2vfpR805m8Yq4jWjXh2pBceca9Awk6BOCfZ3GPAazeZGxFTvMtaMiZYLGQ+5xu1WYYTxpOJ9YtPyUv862W5/E+L54QKrMlkIQ5MTdMAJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC/wlcH6m2zXMpdT6yWmQ9dTXaonDNo2WVzNL+udO6Y=;
 b=XBGaJ4qqDVnutjcUsCU/Olv6+VdG3+1txDij/JWJypYSW9hzJ2iaxok1ZOOAQOUFBgsM2jJ+aKwNmCcRXivb14jNTZjkWb/ZbbymMKeCy7R9uEHb33ZXWS3HZVDaSKpxze7F3xfNMIqvErxBLQqTWlRgU9qjTeuGA0ZcsO3TEBg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB7026.eurprd04.prod.outlook.com
 (2603:10a6:208:192::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Tue, 1 Dec
 2020 08:47:21 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::bdca:6651:1054:423b]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::bdca:6651:1054:423b%5]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 08:47:21 +0000
Subject: Re: [PATCH v6 2/7] fpga: sec-mgr: enable secure updates
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201106010905.11935-1-russell.h.weight@intel.com>
 <20201106010905.11935-3-russell.h.weight@intel.com>
 <9dd75daf-eb73-4008-ca65-6f7ea3923e35@silicom.dk>
 <c6dc2edb-9639-9c4f-c065-18cade768fb6@intel.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <5b49ef38-2c03-02bc-6a1e-5b663180acf3@silicom.dk>
Date:   Tue, 1 Dec 2020 09:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <c6dc2edb-9639-9c4f-c065-18cade768fb6@intel.com>
Content-Type: multipart/mixed;
 boundary="------------C1B711DDA171BC4A3054BAAD"
Content-Language: en-US-large
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM6P193CA0134.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::39) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM6P193CA0134.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Tue, 1 Dec 2020 08:47:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1c1f3a6-4815-46c9-ff5e-08d895d5b78e
X-MS-TrafficTypeDiagnostic: AM0PR04MB7026:
X-Microsoft-Antispam-PRVS: <AM0PR04MB7026DFBC077C28A852E4134CD5F40@AM0PR04MB7026.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFPzgbQMHFvLDoUHImfxJ8y1odOaVIim6qMgeCZImVVlXlFqVplWBwNGO/V8HsYW5HJVfUeFqAmSzzraIZjNgsYJb2CRXPhWqvp2aNsuW6spKmTGn/qEc28JiT1dWuFYI0JjkaQDwQMtbj+5v1+y4BmYiYVn0RCrkyOE1plyLgkmhWBvA7wPbpkfCYJ/Nqw7lcM+FCkElyEz8dTFqENpmPrOzvr0Ur8uwoocPDNGvBXdmTAxwJWhrXlPH0vaWbobo3wWCQ7soVq3xkTWt5G1bd7FOtvTPi7fjHOZXfdopFXjT3YOis6+BbQ2P86X1/o7UJkyJZHNlM8ecw1IOjMSRTPOTRtXRH55OspeEiYv47xYt6pN0ozKZteFmKPhsKg+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39850400004)(235185007)(8676002)(52116002)(8936002)(316002)(66574015)(8976002)(5660300002)(16576012)(31696002)(83380400001)(26005)(31686004)(66946007)(4326008)(66556008)(86362001)(6486002)(66476007)(478600001)(2616005)(15650500001)(16526019)(956004)(2906002)(66616009)(36756003)(186003)(33964004)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z2FzaldCYU1GcU51TGt3NjQvQm9GUWM0aUVncTRVZWtLYTY5SHFiZUpoVmhr?=
 =?utf-8?B?d3lNSWZiYW15Vk5MODNLRFlOaE9uQ3V4VktoM3M1alk4aTBxR2x2MlVZMXZM?=
 =?utf-8?B?QndKWnZtOXhZcDBwZ0hrdEhHRmU2M1dWVHVZdXoveEFWZnkvOS9VR1FaalQr?=
 =?utf-8?B?R2ZCSU9sdmtvN1k5Y2R6bHRBb0ovMnZYaG4vTXRxOFh5YW1waWpUUXNtcmt0?=
 =?utf-8?B?dXRRbkxmOEVwV2pnK1JpaTc0b1h4QUZkc0V1OFlGWlU0Z2M5cUxUd2xjWVh2?=
 =?utf-8?B?ZllWY1lycGg0QXR6cWtsNHhFRjVGM05JMjdsbzd6cllXTHlBYzYxemtwNkpL?=
 =?utf-8?B?WEtpb1duWmpSSjhjNk4zUWlFaGNmUDdOTkVheGxmM3RSNE1wTGZURy9IbW80?=
 =?utf-8?B?c0dzNExRaDljUnhxZ24zeDd4a1VzaSswQ3dZMFhqUDJsZWlRek52ZXNlVzFl?=
 =?utf-8?B?dy8vM040Wm9QbWVFa2lEeWJTZmpCUTRMOW5Fayt2OERVSmdRU1ZMdjNDS2x0?=
 =?utf-8?B?a25JNmc1THNHNy9OVXJZc1hXNHBiaytKMGorNVV2NFp3T3BsV3ZxNURldk4z?=
 =?utf-8?B?NEFwVWlreEtpbVhSVzJpSzRiM2xuUnNDNnNDVEkvUW54S2tPR1A2OFBSa3p5?=
 =?utf-8?B?S0d4elpVMThxeDNqZnB0bTdkM2NiMk96cHM4MVVqd0VERnhuUWIxVzBzYWNQ?=
 =?utf-8?B?cFlCQTlmWEFFMWM4TEU3UTlrZi9EbERHaVJTMTkzc3JJeW5OMVNZOHVIVWFw?=
 =?utf-8?B?T3Fxc1UyZmhQL25zdVlKRjZ2NjZNeXNMMGlUcVpFL1pmZUkxVXdIdkR0SENw?=
 =?utf-8?B?SVNXemE5UElUUzJzUU1VVlRoY0pUQ05Kd2xEUTZEeVA1WEV2OVBNd2dQQy82?=
 =?utf-8?B?Rk51ckc2SmE1TUplUVZjZlhNOU9rdkFXUTNQejRiTnJKMmNIaVdEaTVOT2lI?=
 =?utf-8?B?eDFrMmpVZjRzNTA5d1JjMThXL2FXbGtVbVhrU2d3UXNYN0MvRjNkZ3JZZFRE?=
 =?utf-8?B?ODQzYWd3YWVsYTN3bVRnNkFVU2J2SG9WeUQyTWs1SDJIbWMzTmhwcnY5cnYv?=
 =?utf-8?B?OVRXSFdVSVAzV20vTVJJZVRZS0dPY25CbXd5djNWWE02Z0gxcE9lZzROQWJy?=
 =?utf-8?B?ektyblRjMk9CelRmSGM3djdYMEVRc3h6aVpQWDFqRXluSE9ocmptMGNMRGNu?=
 =?utf-8?B?YnQ3ZTRxMHpadE9uVlI2RXF2cWNGUW9udG03ZHkvT1F5UGZCbzA3S0djbHVM?=
 =?utf-8?B?TWZseUo3QWtZZldjYXllOHhwbGx0cXZRQlZNRklibzlsNUpSNUhmZmE5Nk1V?=
 =?utf-8?Q?nhplvf9WBaZ6q8+2ahaH6WJGkg64888Zfi?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c1f3a6-4815-46c9-ff5e-08d895d5b78e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 08:47:21.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU4o9+gWEUYafHQzHb/OXgI6WUkE7JATFAq6lmOx9TIWibgzotnYWrV5sBARf5xf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7026
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--------------C1B711DDA171BC4A3054BAAD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Russ,

On 01/12/2020 00.54, Russ Weight wrote:
> Thanks Martin. I'll work on a fix for this.

Attached is my in-house fix.

// Martin

> On 11/26/20 6:02 AM, Martin Hundebøll wrote:
>> Hi Russ,
>>
>> I found another thing while testing this...
>>
>> On 06/11/2020 02.09, Russ Weight wrote:
>>
>> <snip>
>>
>>> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>> +                  const char *buf, size_t count)
>>> +{
>>> +    struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>>> +    int ret = count;
>>> +
>>> +    if (count == 0 || count >= PATH_MAX)
>>> +        return -EINVAL;
>>> +
>>> +    mutex_lock(&smgr->lock);
>>> +    if (smgr->driver_unload || smgr->progress != FPGA_SEC_PROG_IDLE) {
>>> +        ret = -EBUSY;
>>> +        goto unlock_exit;
>>> +    }
>>> +
>>> +    smgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
>>
>> The `count - 1` is meant to remove a trailing newline, but opae-sdk writes the filename without newline, so better do it conditionally...
>>
>>> +    if (!smgr->filename) {
>>> +        ret = -ENOMEM;
>>> +        goto unlock_exit;
>>> +    }
>>> +
>>> +    smgr->err_code = FPGA_SEC_ERR_NONE;
>>> +    smgr->progress = FPGA_SEC_PROG_READING;
>>> +    reinit_completion(&smgr->update_done);
>>> +    schedule_work(&smgr->work);
>>> +
>>> +unlock_exit:
>>> +    mutex_unlock(&smgr->lock);
>>> +    return ret;
>>> +}
>>> +static DEVICE_ATTR_WO(filename);
>>> +
>>> +static struct attribute *sec_mgr_update_attrs[] = {
>>> +    &dev_attr_filename.attr,
>>> +    NULL,
>>> +};
>>
>> Thanks,
>> Martin
> 

--------------C1B711DDA171BC4A3054BAAD
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-fpga-fpga-sec-mgr-handle-trailing-newline-in-filenam.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-fpga-fpga-sec-mgr-handle-trailing-newline-in-filenam.pa";
 filename*1="tch"

From 23113231c7819b2e99854cac1ec4370b06db442c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
Date: Thu, 26 Nov 2020 14:19:51 +0100
Subject: [PATCH] fpga: fpga-sec-mgr: handle trailing newline in filename_store
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The copying of the filename written to the sysfs unconditionally remove
the last character, as (I assume) if it were a newline char. For the
most cases this is true (e.g. when using `echo` in the shell), but some
software writes the filename without a trailing newline, in which the
firmware load obviously fails.

Fix this by checking for a newline char, and replacing it with '\0' if
found.

Fixes: 1815cc58d473 ("fpga: sec-mgr: enable secure updates")
Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---
 drivers/fpga/fpga-sec-mgr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 72b61dc173db..d2ce4c682bd9 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -423,12 +423,16 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 		goto unlock_exit;
 	}
 
-	smgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
+	smgr->filename = kstrndup(buf, count, GFP_KERNEL);
 	if (!smgr->filename) {
 		ret = -ENOMEM;
 		goto unlock_exit;
 	}
 
+	/* remove trailing newline */
+	if (smgr->filename[count - 1] == '\n')
+		smgr->filename[count - 1] = '\0';
+
 	smgr->err_code = FPGA_SEC_ERR_NONE;
 	smgr->hw_errinfo = 0;
 	smgr->request_cancel = false;
-- 
2.29.2


--------------C1B711DDA171BC4A3054BAAD--
