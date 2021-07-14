Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C23C8617
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhGNO36 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Jul 2021 10:29:58 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com ([40.107.2.108]:50045
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231977AbhGNO36 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Jul 2021 10:29:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc67lRuTKNs+bU0W53motHC/XvH/DoDW6ytUBNA6vzz+aUZOihubO4GpeDPv04IlC+s8S4nLzQhQKdjWpOajIHkaYY8aY4IiqpZeik4eLfhXLnnjxS08hbBjdZqlZ0v2exdzpcXOsZnX3rGRDA8FPaoiRKI3IBuUH+mPBbdf5/GJWcWS2nmagg4ejENd7T0m+Ye3CpjyHk43q+GgnooM63i2qk6x8HaXL9HRSVfFXtSZqN42rR4UwpT10rURPhcw98Vsa2bLLFSGGRjU2Jd5lIrElwM5VCIIcQ78agyad4/XF0447c0yIpg+VRaKnf7CxA1gnJQ2wzlghPfBq/Va7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NBBfN/FK/LFUzhQAAkc/YijpJvFM2Z5wbfDe7HpSaI=;
 b=If/Rg70fGIAJleFQHX2QbfzOnqgA3LhkxTf4eNH9cNgWvp6v+pxZEeM89rfsOrRR4SIslEh32gD3XQhRUe7tKCB1ck98ShXbdFMY5e8CME+6pRW9++ys/v/ELn6j081iuZRAauFHXBQpqmXxXI3h1/VKp7vxLX2uKum0m2QauTz+jFSk3j6/vDisfsweIM2t7l2PFCu6j8f5uQCuH4yOU8+RbwQHkQSk8Y0e4maaM9VEs1DbMa7NCCyy4FhjNarNXiOWLTPXq/8HmZ7TW6KUxmrUJn3Jvf5qnekFGzQ7oYG7eKOdhA1/7NcnrC5PD2yIbHE08hFJqsrI7CWAhBMJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NBBfN/FK/LFUzhQAAkc/YijpJvFM2Z5wbfDe7HpSaI=;
 b=vI3OyvSQroPIXA8VCUGR6ns6k/BfwM+fjkN4mWEoaD3HcHuquLnFk5fjKHw/8CBz/LUG6OT118l63GpDO99UwfkO9WP0O7khLVl2t03vDzPdm6HIOPkfHhIFP9msCdtqILI5JPY5c6HAAPEB1om/EuE80dUIifSo8Bb03FeR2sI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB4068.eurprd04.prod.outlook.com
 (2603:10a6:208:62::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 14:27:03 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 14:27:03 +0000
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
 <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
 <99abfd17-4307-0b88-32a3-c80f61da587b@redhat.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <afa5dacd-83ef-a608-46c7-1fb0f3e370b8@silicom.dk>
Date:   Wed, 14 Jul 2021 16:27:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <99abfd17-4307-0b88-32a3-c80f61da587b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::13) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.1.108] (5.179.91.58) by AS8PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:20b:312::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Wed, 14 Jul 2021 14:27:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 034312a1-7b3d-453a-74fe-08d946d3735f
X-MS-TrafficTypeDiagnostic: AM0PR04MB4068:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4068BE5BFE02420857ABF806D5139@AM0PR04MB4068.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5d8bNjGwi/9x8zKrIPL/G5hOIDwqsn5wXwmnDl8xW+qYAw7mUOEoM409m4715dDPuj4XXkRpoHeEfgg87XZG5z+31nveaBUrUs5Y/5TesQA8Ny3BRRi1FadmC8cuY3AtKE+czNBAKWQ5cznrmwDdjNf2H2KzVXw4SJLntpaIvSo0xfbEG9mgYiPrGUJJ9oy4HwjHStNPrEV7HHfXiZiI++B+eM5zPWDbUXkCKtyVvZJ7gCU/fe+rqHoEnbg+TGyiRkoGbqm/KJRcv7Yubtkvbs2ALhsIzU2vd6V443SROJ5+gp3soFRl1LXKqzn9CDl2kOYzocOgpd1noDZ5ze6zBKizT76WuuovznPx4Y5ahHvw1hnqELrp7ITIXs0pHj4JG/pNPeRxfV+m6xYpns9DvQ5oUHMHtrcsK6scW6ATtvoskfHSQ/sviqcpcRFvBay10Rdm5J54UHLY0w1Pu5hrU0Kfa+S+4SjTFurzNlyYGynsPdqX0FYHSke7R0gNlnrDf7xSVMeap8doszATPy5xoflQUzS54909DIBtn3b18haxv/M0miSU4VKysIszdZQmSFVGd5uv6uzUN4nOs/p0LMSp5QMrCdwCyM+bDNXiypL0nGGHKI6E7HpkqUWtUr+7KagDE32cKOR9sLuo6uUIg7HlhLKkA5ynxpmGLChpJomPvOaeYZ9zM9aPImCXm+GeWW8+FVpKBUl7GqT6w9D4Zh4zvmRFEpLkJsbhmEq59xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(39840400004)(346002)(478600001)(4326008)(2906002)(186003)(956004)(31686004)(38100700002)(26005)(6486002)(5660300002)(86362001)(53546011)(2616005)(36756003)(8676002)(31696002)(110136005)(316002)(66476007)(8976002)(66574015)(16576012)(8936002)(66556008)(7416002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJaTDQ1dlBncllRNmNUQXIwZEZRa3hRLzNPSG5ndUF4RFpWYVRrZDVwZDY5?=
 =?utf-8?B?K1MxUXNFSTlCVWtTR1pta01xMGFiVk8zK1BTWDA4T05HMFJsZS9CT3dhd1VV?=
 =?utf-8?B?K3BmQ080WUQyR09QQzhSVFJIYmluVnNXMXo4UlNJSjJxQXJJVGx1WFZseDk4?=
 =?utf-8?B?a0dLMWttQWJPYTVTUnRBdENsZWcwcEtJNmtRR3A5UEI0cVZXcHJiZW1HU0JY?=
 =?utf-8?B?amtoSlR3b0gxVTExVEZYcHd5ckpkSnpXL3FsUzlrK0JsUTdick83RHB6S3FL?=
 =?utf-8?B?SVFkR3pMT3pRZmltMDhiRjRBbUxscmdNdXVJTGloSmpyMGR4V1lZOE9kaTNN?=
 =?utf-8?B?YzFkSWR2eE5sdkZQY3VNL0xIMzBzT3M2enBZcUtuWTBoWkU3WlZ2MkhEblp4?=
 =?utf-8?B?cnI0SGhGcGljMURmUE82KzVDWmFzQWdESEpPZGN4N1ZYaW5SS1YvQ2hFRzFo?=
 =?utf-8?B?YW13OHNad1VuMFVaV1AyVnpRMWRucDlUcWx6OE1veUoxS2dnbVpHbGNteGs0?=
 =?utf-8?B?dzQzdWo0VDEwcHZTSUU4ZFhRUXJwUzB2cFFVcVRKRnpORU9RV1FwT05zVFQ4?=
 =?utf-8?B?TkNVUjlKU0pJU3k4YncrR2t6cTJjVlp5UUdpMWtiV3lsZDBOd0VWOXVvR0pL?=
 =?utf-8?B?V2U3RThoUklrSWNaNlR4ZkJqQjFSQlpyVkdXOEFOb2RZR0NPb1IyMml6WHFM?=
 =?utf-8?B?Y3RoSE5hUWNnc0prRnNOTHZyZzRoRVZkdjFEQlRrWng3VUQ0RWhlN3o4S0Vj?=
 =?utf-8?B?SndhZDRWTG5EdVN5aFNmSFo3aGpmWTJsNWxqRGhReU5LMC9KM1hqdk5ZaGl6?=
 =?utf-8?B?VEhtdEFJa2laRm5BQ29RTmthZW84emJxMDFWMFQ4TnRwNU8wN2hYTXpYbzR6?=
 =?utf-8?B?cnNFSnpQSkJhMVVhajRCSnRXL1Y4SWZRUHZYU3J3eVljUFZvbmN1cHRQeXVP?=
 =?utf-8?B?ZkplZWdCU3BZMEczTXJ2M3RUY1RCOXBPU2J0dE9nUGdObXhyVXRiTjlKM2xT?=
 =?utf-8?B?S3lMVkJPTzlGbWFncXc4aVNRdGIxa0ZJSUg2QzRwbUZYWWozbW5vQXQxTnI3?=
 =?utf-8?B?eHNkRlh2Y3VaaldrUGtXWTNrMVJ4WW9UZHpQempMWXk3ZlNsblhiU0Nxazg1?=
 =?utf-8?B?bWo5bW1hRThGS3NFc0RheUJaV0U3OXlWZFE5Vk1VQzUwclJWT0RuaDB5UmN1?=
 =?utf-8?B?NUxob0NuR1FpUzVtLzNYVWN0Wk84NzY0a3RsVmxCK01JVjN2VFpndWlOSVho?=
 =?utf-8?B?c0RTUllYYU9STGJadnNoM0p0UjRkam9DUHgxSlBnajVvbkJHdHRBbHJEa3lJ?=
 =?utf-8?B?dkpVeHpsOHlsWC95VC9ZV1JIaHIwRHJObTlPMGd2UUV4RFdleXpRbE1wRU1O?=
 =?utf-8?B?OUhXcFhEb1BnTWZ3U3Jzd3BpS0dlL1ZFWFdUUDJkYWlLZ0hrdGJkaDY3ZStF?=
 =?utf-8?B?d3NRb3pDZ0NDeFV5bVBHMmtjakJoN2dqSTlrYks4aCtMT3Y5ZXlCbFl2UjNL?=
 =?utf-8?B?TnlpcHZvMmZCeVBrcWppZkxKd0pKRjJzRStjRGI3amNmRU4zNGJXbTFrVkcx?=
 =?utf-8?B?bDE0L014bEhYc2JnbFZOQTlQejU0cWJDYVc5RnlqMjh2cDBCYnZWT1luU2V3?=
 =?utf-8?B?VzZmblZ4UERScVRFemptTVJTNURzZTJ0QWxXOEtVYm9BWlJyWTR2QXg0SlpO?=
 =?utf-8?B?WWIwdVR6N2x2YXJ4R1phZ2JMc1ZtdlVmNWNsR3JsL25paGxQd2VZRzh1eHR2?=
 =?utf-8?Q?BIW4ZN9hkkYHx4r9+6FVvlKzavVMVhV7I+WdsW0?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 034312a1-7b3d-453a-74fe-08d946d3735f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 14:27:03.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVsqDjyZwPSiUsISZXdymNp7rnQuWItu9ulBKshxJNCMxAfSQOnSg+zeh8DKcfvH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4068
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 14/07/2021 16.22, Tom Rix wrote:
> 
> On 7/14/21 4:33 AM, Martin Hundebøll wrote:
>>
>>
>> On 06/07/2021 16.56, Tom Rix wrote:
>>>> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
>>>> index 3e32e4fe5895..f6cf7c8d9dac 100644
>>>> --- a/drivers/spi/spi-altera-dfl.c
>>>> +++ b/drivers/spi/spi-altera-dfl.c
>>>> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>>>>       .chip_select = 0,
>>>>   };
>>>> +static struct spi_board_info m10_n5010_bmc_info = {
>>>> +    .modalias = "m10-n5010",
>>>> +    .max_speed_hz = 12500000,
>>>> +    .bus_num = 0,
>>>> +    .chip_select = 0,
>>>> +};
>>>
>>> Other then the modalias, this is exactly the same as m10_bmc_info.
>>>
>>> Why not set platform_data?
>>
>> So like this?
>>
>> +static struct spi_board_info m10_n5010_bmc_info = {
>> +    .platform_data = "m10-n5010",
>> +    .max_speed_hz = 12500000,
>> +    .bus_num = 0,
>> +    .chip_select = 0,
>> +};
>>
>> I don't see how that should improve the situation, but we might allocate
>> the board info on the stack and set modalias dynamically instead?
> 
> No, I mean that instead of have two *bmc_info's generalize the existing one.
> 
> This could be done by using the as yet unused platform_data field to hold the identity as a bit/enum in an int.

But the existing one is global/static, so it would need
to be moved to the function/stack, yes?


In which case we could as easily keep the existing approach
of modalias, and avoid changing both drivers/fpga/dfl-n3000-nios.c
and drivers/mfd/intel-m10-bmc.c ...


// Martin
