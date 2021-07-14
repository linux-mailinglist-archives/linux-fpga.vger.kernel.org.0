Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1203C8379
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhGNLRA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Jul 2021 07:17:00 -0400
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134]:1376
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229899AbhGNLQ7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Jul 2021 07:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCUDiM3CqnODCR6DtYkIuusARXVnoBuChO7PXvnr/siFWjMPQgZV7B/jDw+amqFbIyEZhnpiofu3g6vD5jYBjT/1O7UerpYBsTWdxrl9QlUYhaBQYWkuZpqQbvDeB4ejwCPQGT0bq06GPNh393C2odrjtqXwdY9WjmfjkF3mn08Qr40SPVTdk3GTgGJeNOAZQpmBpxYBQY0T7P4mQLxqsO4gfCHPjqGsQGiL5AQztYzOVesZbqoej4qFLGX5qd22x8W73l6w+h6Z1myEGdA8eZiGH/0e1gypjphoVbo69+LPruK+j5wo/AHfRva8puQqESWp1I/X46MSkNzJVx8oMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sZECMJbFYcsSBOa1w71nGjVVxUVKpl8QFOUGWoA/uU=;
 b=Px5LS7aYQPARxkupjB8N1pyBFdv608fYIBzMp7aI8aM3ZApzsVA8lL+ydLSoyLKTZtl63BBKexcsLhPyu22sy8e5ZRziiW4GNcFQwGu65nqyZRBUCJxZguaM/RaHM46suoA3/KLbFKtgDC2ZnIUsPI4qDaI5U16kYacHLYTe0KBmjnmxaKSaBQyqi6ZyH8FvpBQ2/q/x2oCcKnzJ5kxwauGCHtAxwCfzq4dB5UczCbTiiff2ln7/ortH8ic9Q3nRMtJWjPv4WETrIKYQJESpUuz0aMSvq7i2+VDWv6lUqdnvyKiCySrssAdtj+iXhovCoR7hvsxxLOEKCWF7gRkwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sZECMJbFYcsSBOa1w71nGjVVxUVKpl8QFOUGWoA/uU=;
 b=Ax2fb+znDHoWalxI8PXfTYy1tyGFOWnQeRFmGGT4i44LoGK1biYi5WaIsDy+og1JPvd8cnD5AjbRYToMCQG9cTXO8SXr5ZJUljwzsIbBvtwq8uk0GT5VtkMHL895d0Pw/j3cik+InzyNyaPULwpNnFvAu5cSXNqB4DWSYa+VY+4=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 (2603:10a6:208:6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 11:14:06 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 11:14:06 +0000
Subject: Re: [PATCH v4 1/4] fpga: dfl: expose feature revision from struct
 dfl_device
To:     Tom Rix <trix@redhat.com>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20210705101645.2040106-1-martin@geanix.com>
 <20210705101645.2040106-2-martin@geanix.com>
 <93a8e949-ec25-d00d-4740-72d9e18ebb68@redhat.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <4ffd5153-e182-c615-0a81-2f5dad4979f5@silicom.dk>
Date:   Wed, 14 Jul 2021 13:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <93a8e949-ec25-d00d-4740-72d9e18ebb68@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P193CA0086.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::27) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.1.108] (5.179.91.58) by AM6P193CA0086.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 11:14:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93c1b2e2-f5c1-4b06-5b0d-08d946b87e67
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3747:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB37472633BD4691C6E159998CD5139@AM0PR0402MB3747.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL7NF711x3CfrW2lD6qTBsiQ6VJhOJQQbeVaj37Z+S6Ni5jjeyLnqljhxYkSf+xMhcYTsRsaKIiSUVjdrpbBi7stsqpEhR/VxjjGKXS+c1/vBu/aNmDTJ57jEAPl1OZJ1XDVvkH4C7ocQm0aey8xlGnG381MskVbyHjm7NVShJCAC7Wx/3/O5mJrDTRcF+l78Ncna+BMtLKbyCj8kINZCpxli6t6I465Mr+t6t2EtZYCJfez1Vf549e85Q2p9JdKIuMiLlZrt0vNklDBf2CBhguBB57K0pj9eDGHk+vABZ+z9VoYOCyWnE5I0yhrEjgRVWpuvsf6BB9JTctpsgWJj10pvosxHunU1fj6f2HV+pTpFdqZLrujnAMU+U2hChbOSPXHfa3dI4jeFfffxo1RBmQcBhI1RnOUbU3qC+G+bO3SzL3i2m8NvIQy7Hx6VydCO0XJpqp75BNTXQfiWElcvQqKJvC2lb5Q/Uw9a1/0dfAbcZtmZGh0nC3p66t7yk0eyPdl3iGW239byLd+61DrgL1bi0Oy5LOnNgwWCUBzhzI0D27NMeNJpAZZTlMN1Tt3/AE4YGOJjsc2QkyjT0GO3oGcNO1ESQb0ZTAQ0iduIOjBqIkDu7Tk2wCryizeKxpOSidvpLnkLds4G9rZBx64xq4kn9ASUbuwsKgTblmGJ0Qsc31mYQHry1CK/zycvtfp0dwOy2BKuOuvQeryqedS+uFS+tPehhKDFHMuiZcN5qk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39840400004)(16576012)(316002)(66946007)(2906002)(66556008)(66476007)(478600001)(31686004)(5660300002)(4744005)(6486002)(110136005)(4326008)(2616005)(956004)(36756003)(7416002)(8936002)(8976002)(8676002)(86362001)(31696002)(38100700002)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZ3QXM0b2NJL0tDQ3lTVHRUZjhVbFJSRVM4V2sydHRuRkdLeTdOTGV6NVpI?=
 =?utf-8?B?a1ROUzR2L2RRVVQ2VjFIL0YwVkhBL0I5UWZuYkU1cWlBRmM3SEx4S3YzUk5L?=
 =?utf-8?B?QXBnZWFMbGJXaWhVTWFBenNZSzJ2ekVRMzA0SnAwYjR6T29yaXl3M09FM3FE?=
 =?utf-8?B?M255d1V6bzZVaUg2Z2Q5anpuQkswS2xxZFIya3BXaStFajJhQmE3VzFJQWpB?=
 =?utf-8?B?bmgrMUhzSmgrNGhBK2NaU045VHRja2FBVjN2TFIwKzk5SGRhSW5sRE5La2Vi?=
 =?utf-8?B?Z2grNFVadk5MbEliZG9TRkpYZ0dhd1ZHZTM5MUpURkxNNVV3Z203M3kzU3k5?=
 =?utf-8?B?bjcxRkRQNUY2SFlMT1JmQjhDTHJvcDJnejJRTVFvMDkzUWI3MmFDM0FqTDJK?=
 =?utf-8?B?R2xCOXJBTXRaTEMrLytVKzBtNWMvNmRHSWszTXVsaWNxQzdyY3ZxQlFHYXBQ?=
 =?utf-8?B?R1crQzM0OTNKcUl4ejN3MC9DVDkxaFRrdE8wNUpHR1VINTdGdEhrT3pwYUd2?=
 =?utf-8?B?VDJKazd5aG14Nm9QOHo0MHo1RXI1UlJRNkN0K3F4NnB1SnpCMXhwT296SThQ?=
 =?utf-8?B?eXA4RE9YVlgxNWU1dlpHa0NucWw5SEs1ZDNnbzNKRmdqN3VUaUZLMENPSG5k?=
 =?utf-8?B?ZWdtZjdMT09paHZZUGIzS1lDQ0Y0em1WZE55aTBqSlJacHo4Qlh2cElPeVQ4?=
 =?utf-8?B?VzdvMlZaK25yckNzUVd5WEh6YlZFcHgwcE4yMlVUQ3p1c21FZEdWOXU3VjRp?=
 =?utf-8?B?Z1U0MkhyWitueU9LVnRBMExjME5ueXVGTGtLa3BVTGEyUVljenVXMkFDQ25l?=
 =?utf-8?B?N1V1a0VhZk02a2liWGRxc1lBOXhIUG1CV21IdVRmU0owaTNGbjVWeFhhalo3?=
 =?utf-8?B?eVA1MDRJeng3ODU4UHBCMDBBVHcvdHA3WHg2S3dwQWZsejNxRFo5T215R1ZK?=
 =?utf-8?B?aDVCejhRVlN4cjZnRnRMSkhHWkFOMmFITTNGd2hNV0h5YkFqWWVNL3JTK2Zx?=
 =?utf-8?B?ZzFyVllKajlkRjR2cVVtQW9VZkkzaEpSRkRIZ1dLSVl3bUVtQTVjTldBSVRn?=
 =?utf-8?B?RVBLTndTd21mMlYzc3VqNGRtUXhzV2JQeDlUbkVtQzM5NGllYi9SUDN5SUpR?=
 =?utf-8?B?WnI4YWhwcWVuU2hKZnMwNWJqVzVjYkwzNTlhdWdjZG1qNDExQ1U4R1I0Smpu?=
 =?utf-8?B?KzJUdG8wZGlnN2V3NWlNajRTWTlWUmc0VTcwMTh1UkwxZTdSTllOeXFVOUR6?=
 =?utf-8?B?dllBL1BBSXN3WUk3Y3dMQkFDQUhzREpjRTgzRURNc2I0NkRta204SkV4L0pL?=
 =?utf-8?B?ZDlKbDFGOG5HNDg2RlA4T3J1bjMxTGJqNGpUdEJOZ3phNHE4WHNuYWpkeUxr?=
 =?utf-8?B?eklkNUd0Yi9Hek5HdmN1RXZzVXZ1ZVJjRDM3TUVWbi9xakN1WVo2cG11MjNJ?=
 =?utf-8?B?dWY1QloyV09vWE9aeVhEZ1dGWmppSURERWwxZUsvSWpjQ3hvK3RIdnRyK0lp?=
 =?utf-8?B?d0xqdGJkWE5PZVErd1JWcVdueERNYXd6ZFhHN1FyRGpCMGZ3NmtPczdBYnZq?=
 =?utf-8?B?dkhvM2hacDBvWG1WdG0zazdCYTU1WncvTnMwRW1IMk1YUjJCdlloUFRiVFZJ?=
 =?utf-8?B?OFQ2MXpmTktrT0tILy9Cd2l5Qk5LYmJBQ3BqSEozRE96ZjhYSnp5ZHB5Q0ZY?=
 =?utf-8?B?NXdRNm03aHRwVFZ3RlRCUGxkUnA4ejBSbDRwREorZlQrTjhXNHlocGhTLzhs?=
 =?utf-8?Q?s0lPotSER0+6woqSdHlXWbPSS7CD5EUkoEgS2XS?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c1b2e2-f5c1-4b06-5b0d-08d946b87e67
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 11:14:05.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpfWGyD6AW0VQNktXqsG3LmvO3DgWe4dffWOw9CIrjbs/c0D6ddDMt8X5O0b+F4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3747
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 06/07/2021 16.10, Tom Rix wrote:
>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>> index 511b20ff35a3..9381c579d1cd 100644
>> --- a/drivers/fpga/dfl.c
>> +++ b/drivers/fpga/dfl.c
>> @@ -381,6 +381,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>>       ddev->type = feature_dev_id_type(pdev);
>>       ddev->feature_id = feature->id;
>> +    ddev->revision = feature->revision;
>>       ddev->cdev = pdata->dfl_cdev;
>>       /* add mmio resource */
>> @@ -717,6 +718,7 @@ struct build_feature_devs_info {
>>    */
>>   struct dfl_feature_info {
>>       u16 fid;
>> +    u8 rev;
> 
> In other places 'revision' is the element name.
> 
> For consistency, change rev to revision

So is fid vs. feature. I deliberately chose 'rev' to be consistent
with other elements in struct dfl_feature_info.

// Martin
