Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E893C83F3
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhGNLgj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Jul 2021 07:36:39 -0400
Received: from mail-eopbgr70108.outbound.protection.outlook.com ([40.107.7.108]:1033
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239173AbhGNLgi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Jul 2021 07:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfUFEjb0zj3w5IRq5tyuIaJPz3tThBjQU6guaJUIs+/egGLOm3daDUFtlPcPGlWXN7RpOCGWW3zzy1Gnz0QSciS0HPbExnR4AF/+K9OBQKL7D3W1VaLaHoaTZVW+yyWQZI+31yEA0nKknBLk76ImZhCp1WWtmEjGi0KV+4Lc0m2wfuY0lWKJ/9VjmKf2dU53bca0cGMPFhLgY6op70Dsb8fxxCMCAfaM1kUDpGIvg+uVVnNSdKcWOyGF9lTCVuHiBa5A9wmSyNDGys/zykSksp5/GaeW/UBCb5AOcS44omF5zOfF9Dd6qQGZA8SBccsjGAVYeZx7RvxpUCaidZ7Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGBNk11TJS86+FYlxAefhxR2jbRCDT4+uDr2k+7ExBY=;
 b=d5f/crGEm2Z/8XnZOXXKgKnnMbnbcs3jwqjObfYneOIftZfBWiEX30x0hMI6BdW22a2vPxoDpMIsJUJkjvRG0r6g0CcZnNUvG5aGfDhipVDBWrPte68H8zlAYGe3mjuT+h0l9pQvuNBja99kHNTScet2mlEzvMO54SGaWi8HSDTrU3dE+LZlx7a4bWpZdAILMolyZmhqEJbM/nrq00vB1KN1c/RyjYoxMPkt91YMB2NonI/w6isvz3dYjqBfCbGAPDjgG4vJCtl0pY1FPY+iBDa8JSnbnU+ECCr4EKwIk0hrtkkIhrhFP+MlhGwkc3A4USoKBLXAmCgykMuQPTnnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGBNk11TJS86+FYlxAefhxR2jbRCDT4+uDr2k+7ExBY=;
 b=QOpBM6WGQY2r6YiHkEa2D6X3L+jGB30nJv5ll7OEwOnV7u7O8AZQ0/Y+E3Cp3MxfAQYA39XaHWntxfeTzxbdyvGCyLTsus5N025J40Y4jk4f1bgSrHBkrG3pPGOIOWtvk4Ebj03UbwmsRBpnX15tultjIUF+H4GodXXkYANABKo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB7057.eurprd04.prod.outlook.com
 (2603:10a6:208:1a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 11:33:44 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 11:33:44 +0000
Subject: Re: [PATCH v4 2/4] spi: spi-altera-dfl: support n5010 feature
 revision
To:     Tom Rix <trix@redhat.com>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210705101645.2040106-1-martin@geanix.com>
 <20210705101645.2040106-3-martin@geanix.com>
 <d6250f86-db93-bcc2-d46e-6dba30976cc4@redhat.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
Date:   Wed, 14 Jul 2021 13:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <d6250f86-db93-bcc2-d46e-6dba30976cc4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::17) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.1.108] (5.179.91.58) by AM6PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 11:33:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67259ff4-a16f-457e-00e6-08d946bb3cf7
X-MS-TrafficTypeDiagnostic: AM0PR04MB7057:
X-Microsoft-Antispam-PRVS: <AM0PR04MB70571B34FEAFCE2DE80588E7D5139@AM0PR04MB7057.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Cqof8pxM2VuAh7v/jVD6J7sHRwDXP31MZLdwea5zlZ0t7SdlfXXeHw1GURWCnLmBTD/zH/WKONLLFd/gePSMT4knCsCSin2mb/ebMYPSFpEXsoUmVPKirRjgR1pbX0hTUb4ptLGeGuCBaWX4iTBTVWKo3Ja/P2RVbMANWlmGqbM23pXDb/kRQwXsPld2J9dEtyCJ4nMQUYu8qZ2zGl9JAOY8CvuHSeCltf+mqBRiN7P9JzAJww3vI6T9155fi/J7a2GfQlPTi4sWaWgV+PJLWHKr6D5+WyZUIDzsOkyssYW6J1vxZi1+J2nMpjhPICtdDC9TrAfyy3qUl7M5Q4jowTDEy6b9OAeDkAFf6ESyeD263vMk7A3PY+mIbPjSWfWOj8PPkpAvWMRTU3kG57mMgKU02l3pArHPzcb6b4w7qd62fLtWAp38dS4fzL7mkTtZ/M8WtiHrAjMO7GuhqCx9nLwACmI7LI7slBEAErjYKBKOw4a+rFxbCRjqw5FLCNxRwx+EICY1z0Dej5AphDh43nYO0me10Eoje7UAk0yl5K+i0qGOidUc2b+eWdpkqGhgmAb0fU/0OS91r8d0RGuAX5kerH9VOnuRb0cK5TneC8iKl1IOUAbdcwq9ZnQ9RrQA2G4/tlHNOMBYuvgqs3Uow9cEuAfXDQ5Khu6NZKTah3ASr99f0FPnA9s51ceHmT/lDGbf5mym4a7LDiJYeKHU8qB1Z0exLfo+xKTkqZho/yKYCo0QVI3UVPUjlKaWmXa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(316002)(31696002)(36756003)(6486002)(66946007)(186003)(5660300002)(38100700002)(86362001)(26005)(31686004)(4326008)(2906002)(66476007)(8676002)(478600001)(2616005)(110136005)(4744005)(956004)(8936002)(7416002)(8976002)(16576012)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2tzYU9tZHhFZ01sNlZvZi9YanZsNDFBRE56eHhidGhtZmgxdlJqQ3BaUlhX?=
 =?utf-8?B?Z05VWUQwMjltbGRKWU93VHNBK3JpU1BHdUdvdGFkNjVsTG5Rc2NxQnVTamdi?=
 =?utf-8?B?WlMwVE9pWjVyam94ZVlBS21DVzN2ZUhxK2JlQkZJa2orcWZUY2tXSzl0dnBL?=
 =?utf-8?B?R01HcGVLbHBMNnZhNStSSVhDaUhZZmdXcXZBbUJwVVZtNXYrSFRub2hLSkpK?=
 =?utf-8?B?eHY2UlJQd2dQWEEwRnkwUmNZRmVzbGdxbUlka2tmOGhrSXhNMVpZRWluMFFp?=
 =?utf-8?B?aExiNFRjTk16KzdYRngxT05SaEIxYlZvWFYrdkZ4aUxDbHhISXhxcWlMRWE5?=
 =?utf-8?B?aVh2MDYxU1IvbEZpRDA2S2NlNWtVem5CUWZIcFFiRHZRdXAvaW1HWlhEZVp0?=
 =?utf-8?B?cURMV09MeUt3SG1ZS2NNS3NQaGxOUlREUW80L3g1d2dEdW01NnBJaTdMUXl6?=
 =?utf-8?B?cS80M25nVE9rY3ExalJYelQ3VFhsV2NrTjNQamJ4VGZTdmVVT2lHVXpXOURz?=
 =?utf-8?B?cW1pbitIMmJJLzZDZ1F4eGlQak90cWJIYzFQVmQwQ0FZL3FLMEdYVXdkM2NX?=
 =?utf-8?B?dGRBUFpNOVdrSjR6bGZqTXExVlhzSnV4cUx0VWdUMmIxWDJqamVXOGJYTW9j?=
 =?utf-8?B?VnFZc0ZEVkVQZzdsUm5MK0VyNVhoRnBRUkVRMCtuQ3kyK1d2KzRvZDRsdm44?=
 =?utf-8?B?WUVCaGZaTEE2OTh2ZDNuTm9jRW4zZzlKc2Z6L3AxZm1PK1NRaittWWNXM0Nh?=
 =?utf-8?B?cUdUVXVkRWJOMTcrYzBuR28vNTBLSVFocGYwdlVMYUk2ZFpmS2d1QU12Ykxo?=
 =?utf-8?B?ckxvSVRTWHdubWdiZFNNeEhqaWtrQ1dwcHV5WHhoUFVuaG93eWNkYzg4cC9J?=
 =?utf-8?B?ZzR4ei9MWmpXUEE5K2xQM3VZdm1iemEwZWVJTGQyNFF1Ti9ZRDRLMTdrd0Iv?=
 =?utf-8?B?WVVWU0JtQ2Z1OXVTSldXZ09Ed1FrVzdFNW9aR0hySFJoZG9hUG92cEJxa00w?=
 =?utf-8?B?SjdqOU1rT2RScjdXRFd4NmtTYXRYYng5ZmIwMWxCVDIxNmdHNnk4OEtFOWkr?=
 =?utf-8?B?SXJqMWY4WTZoMjV4bnNsQ2hiWGpFakFyZCttRlJ0UHhWMHNFMnVDL3B3S2Rz?=
 =?utf-8?B?cWxsU3lLcUJlV3dIOHJwUUtRYU5JM2xqZXRMOVp5M25pTDBGUnpBaHdDYy9j?=
 =?utf-8?B?eTZiVkwvVkVjdXpzM3pPc21EKzJiWkl6ZE1IMEYrR1Zld0E4UWJSUTVWWlN3?=
 =?utf-8?B?SEVyYzJlTDRSR3k3ZGZDUDM0UXpRLzNqWmp1eHZYc0ZZVkF2cTQ5UmdPRy9t?=
 =?utf-8?B?ZXBDSEo2cnRNallzWUNzTy9EQTNKLzhrSExiZGhvMVcxdFJsaUVqQjlNUTMx?=
 =?utf-8?B?YXhmQUprbDYyYmIvSHJQYTZrdG41TGVOSHhnN3BtWTVFNEtQaXBoYitWdGcz?=
 =?utf-8?B?blJ5ditpRTJ3RWRQamlYVUVoQTA0RksxSVhWSEE4V2RaWEdkY2xWZU44L0ov?=
 =?utf-8?B?dU9BeTJFczVVeHlIeGc0TDV2dWpmcE91b0tYY1NHcXBRZm5vR1V4c0orQVNo?=
 =?utf-8?B?eFk5c2VoL0RCcld4Z1F5QnVRdUhEL09hcVBVMk5SSFB0OXBqcms4N0ZyY1pj?=
 =?utf-8?B?MlpBM3dQWHZaWlJsUHJva3lkaWRLZ2F6YUN3QnBKZ3Z2ZUQxSERaMVdwR1Bw?=
 =?utf-8?B?em9aS1dZTXJjR1MxVmcyRjA1d3N6VDVvY0E4enpIYkdjMmlNQ2VZSFV1MnYy?=
 =?utf-8?Q?IsRGXxDOdELS9YYImJkpM9qJ8KSYjpyY5ntUa6/?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 67259ff4-a16f-457e-00e6-08d946bb3cf7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 11:33:44.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mbpf0uVG4Efm4b6eg4AQpOnhyOp4W+Uq7R0Jiep21/e+MBbCXp+PHBvJ+ebRWWJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7057
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 06/07/2021 16.56, Tom Rix wrote:
>> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
>> index 3e32e4fe5895..f6cf7c8d9dac 100644
>> --- a/drivers/spi/spi-altera-dfl.c
>> +++ b/drivers/spi/spi-altera-dfl.c
>> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>>       .chip_select = 0,
>>   };
>> +static struct spi_board_info m10_n5010_bmc_info = {
>> +    .modalias = "m10-n5010",
>> +    .max_speed_hz = 12500000,
>> +    .bus_num = 0,
>> +    .chip_select = 0,
>> +};
> 
> Other then the modalias, this is exactly the same as m10_bmc_info.
> 
> Why not set platform_data?

So like this?

+static struct spi_board_info m10_n5010_bmc_info = {
+    .platform_data = "m10-n5010",
+    .max_speed_hz = 12500000,
+    .bus_num = 0,
+    .chip_select = 0,
+};

I don't see how that should improve the situation, but we might allocate
the board info on the stack and set modalias dynamically instead?

// Martin
