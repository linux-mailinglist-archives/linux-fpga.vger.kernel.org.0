Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF53B3D09
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhFYHOY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 03:14:24 -0400
Received: from mail-eopbgr140107.outbound.protection.outlook.com ([40.107.14.107]:37349
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229437AbhFYHOX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 03:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa3Uwch4k/HCj0R2Yo0Weaw+zS45pDDcZQJovUAJO6YKFJmo4QGJnnH5VXNtV+1WsPf8NM/KISQQgyHxZr+OTNNYBXJYTsFJ3iFXi61oilCWw9noPPn/35uIFIcGsci3yLSs8GaS7zJx9Kzw4BL6fbZ2p4715GJ8N24NbBzbNZ5j6P5HR+hsQi/rX0d0e0TCuZ/nK4T3KV3xJOOBBue6QsxcTbnUXatKUtS7acSsAhtM33rWd+Lb4YfkkGIeMYtoZqObNBCknvsrDz1kk1q3g6oc7p6ItMjgwpM1chngEvGBMMzRAE9c/waHG6rpLNSGPxwTovQ4OJTXJva8pK3ygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIP2tlR8+uGiubpTNefYfrnLQZQAmFeDUegixDfiJ5I=;
 b=NIuyWGfaJgQDjSuUc1mzThdPucMuHummfVNi7uCuroWQyUgauVYp8ilFrSnvIUhoP6+89WAa0ou8kCgnSeQDyv8d55LYYSeIC3yNeV5EAJxWpkdppQAUf6PmaZnGfRqeVyarnGHz21thm6nVIFs0phgRScpOPvQzhRNCOCy0GTFEfjZwuRSn8oYU8uUTp/ny8LvtcIatSw7TvVTMlLi/L8AH51S8mzt3gtgrNMQ+GmYFW/xpyLKN/u/o5/GwKbs0oQlSIdnHa8IZchmOc5zYtLRXzR3zYL3HbofpxE2sha0Kv0j2E8U+eBxYkiPel6Z7EATVFYXORDi83oENxSlNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIP2tlR8+uGiubpTNefYfrnLQZQAmFeDUegixDfiJ5I=;
 b=ZjV+01rt9AZkSrGJxCcmBuyJ94zzn6EgH36j3Rsvr2jr2fBgYt6JaQzI7eUXLnxM7S646mLXOkW8ZhbSfpheMMqhdJqdB3k/YEpJh1vu8LhEEREyDSP+oFCruo5Zuutx5hPGt0uk+V6HuhoVSFF9My2y1y6uv0PA4XAEskecfns=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB7028.eurprd04.prod.outlook.com
 (2603:10a6:208:19a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.22; Fri, 25 Jun
 2021 07:11:59 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4242.025; Fri, 25 Jun 2021
 07:11:59 +0000
Subject: Re: [PATCH 0/4] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621083856.GA24178@yilunxu-OptiPlex-7050>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <fad06784-45b1-e139-4f93-b7d2777c3e07@silicom.dk>
Date:   Fri, 25 Jun 2021 09:11:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210621083856.GA24178@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM6PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::43) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM6PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:20b:2e::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 07:11:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bad1540-43a3-4524-8165-08d937a88630
X-MS-TrafficTypeDiagnostic: AM0PR04MB7028:
X-Microsoft-Antispam-PRVS: <AM0PR04MB7028E49F09D78CA312A61FFBD5069@AM0PR04MB7028.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbiJi6Va6VLNqKNVG52asmWbOhbAEqEXQGk20wUs/LrS29qlW8mDJbC2d3d9QWfin4WxXzS5b4Ull5lwln1tjnPQByzK1ztHRo2sSKF6y+GZIxfMFRbOnZ30Nf4ey83qWHJL1Y1zybJvzPuEJNZrsLhmwhw4m7VabWLvUjDEnrntNowwbgnUXmvWMFuU38IlAfrO4scsYgt1oCnzkdPHDhTJU15geHKXsJtcDvxQaX9YjAlN4dtxW1ZDKUN9PcO7i6P85YWsCvyeMIg9G6OTWs8Pgnb/cKq/wNssNtmLHwUUXYbEIWKENzIkMeMSJIpAUfwLHlqGEf49snAdWiK5scULX9UChc8tQthhKqEouHGfHGautDLU2F1dkdqkivNAIcrvLsizBnYH/sfGdL6kAHJVuXAx8LJEzwzJSaJ/ncSqlnWppzNW4BAdNjdBt6wpIwakLfO8tfD580D9dBJpnFMfWOzw4QtiAZcCcIFYP8kodAoO4wzlRBNPFRXqYXW9RDilwITFh7ONWjaC7zDGLw7X/HTFJ4SU4dGpJB0OCAhoI9GQSkT9+OrXYomzlEf8+40vc+hZtniPdKkQXQ6dEuos+QuOCS9lJiIy1Pe7xq7DGq5RAYoHDxaRc5ES/dRi7O+IozSleof3H0GXLf6qnrOT0vVIzxtRifUJ0rIXAAdeAevzxooZFs7HBavMUVZDkSFjqT2lmUFr7Oo7z+WjuJrMnbO/1n1pjy4ypH6tubA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39840400004)(346002)(6916009)(26005)(38100700002)(31696002)(7416002)(66574015)(86362001)(8976002)(83380400001)(8936002)(2906002)(5660300002)(66946007)(8676002)(66476007)(66556008)(16526019)(186003)(6486002)(316002)(36756003)(478600001)(54906003)(2616005)(4326008)(16576012)(31686004)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3p0UmNCTUVUL0hLeFpjS1UyTUFxTjg3aXJGOWdIR2owRWxrRDRoQThEamRJ?=
 =?utf-8?B?dTI1NkQ2RHo5c1VUMllSZzBaT3VXWWhIbTJaTzc3RHc3bVl1RlBUKzJiM1E3?=
 =?utf-8?B?clZSL0pEQWxlU0ZzbDJWWERNQmt3cnlKOWlPUERoa2x0NFpGVmUwUlM1azRj?=
 =?utf-8?B?U1d6VnFNdDlkT2JDaW1JdjA3TExsVDhHUFFack5XbnpBNnRDMkxjamdpdDJD?=
 =?utf-8?B?alNBL2wrMElKV0lxd0YwWDdQVUsvN2E5ZVQvR0tZdXFDSGFFKzlKMlR0amVs?=
 =?utf-8?B?cmFwNTFINndvbFkzYksraHZYMWF2TzF0SW9WbXcxbTZ5VnlKRzRMUTYxdVVT?=
 =?utf-8?B?UVRWZWtWTnFPazQrWXRUcVgybVQxamtqS3JCbjM3Zzg0N1lXWXo2amR6dlND?=
 =?utf-8?B?aVNPWTN5Q1Y3SHFOUFM0dnhveDhVeFJkRXNmaCt2ZlBKRVk2YnBHRFNKeXNJ?=
 =?utf-8?B?c2gveWhFVWNaQ1ZJaFNKQWZCdmxqVDBtN0NwK0tQcXM5OVZ1VFN5S0xNeDJH?=
 =?utf-8?B?dmtTamhiQjVOaXp5WkRzWUFMbVJ1eXdJYkVqQXdWSmZkWFlTSENBaVJxUHdj?=
 =?utf-8?B?YzBWeVg4QVpjeEcwR2crY1U4KzJHSzRoaml3YzBvZ3dSQlhzdm5NV2hhdDFr?=
 =?utf-8?B?bnBKNGZCanZHYTFVd21QaDFFanBWNDczS0cxYk1hZFo3TXJqVkdaOW1jRVBI?=
 =?utf-8?B?U3pFRGtEYkNBQmhGOTc2VTA2Q0VCVTB2Y1JnUDhJZ3hVRXZQNE04aGpPSXlo?=
 =?utf-8?B?WWo5ZXh4ajltZDRZY1VXOW1FU0pEVlRWUmxqUTF2L2t1YmNUYU5vTk1LWGVy?=
 =?utf-8?B?ZVYrVFdkTEhONnZXQjlSQ0F0RHdEa24rRHJvMFJHUmFSWlY5VGx5U1NMaFlV?=
 =?utf-8?B?bjVubHM0dEJ4YjR1RDc0bUw3R0h2ckhQSU43aHJFbDlHbFk0TUgvNXdxSnZy?=
 =?utf-8?B?b2FuU1E0UlQ5NVBPVGFZL0dUQWN4dzhmK3dWVHFieklMV0Ztem9zeStWRkxJ?=
 =?utf-8?B?RUhuQ1dUa1BRZ3VWS2tSUVh1R0ErNEhBdno4cWQwcHk1S0t0dExuN2p2ZFMx?=
 =?utf-8?B?QkdWS1pSV2VSWEN3RjRsR0dqUUdVdzNEQWdNMjdIL3dEaHFJZ01OdnJvZ3pD?=
 =?utf-8?B?V3lZNDJNckhnZ0lJc3ZuWElUZjR2Vy96Mk1XeWJ6MTNXVWd3ai9HZy95alpl?=
 =?utf-8?B?cnBKUzJZQjZwT29GU1ZJeGw3ZU9EVW1BUkFzMWtOQWJtazVBQUZpc0FwYUFR?=
 =?utf-8?B?ZDlDY1RYdnJoQytkbEhKbm1hSjkyQzYxMjM1SUU2S01OQUZDUnFJTUxQeW5N?=
 =?utf-8?B?SWdFWE90dVNqaVFuR09IdDlHV0dISld0eGh2M1NOWTE4Q3AzOWxnT0dJWk90?=
 =?utf-8?B?cnJ0d2huenAvS01pcnpIbUxsTGZTdHR6MVFjamh6ajFLa0d2cmFPMzVZeXlh?=
 =?utf-8?B?Z0ozdmwvK2NxWGppY3l0NVV4S0g5SEFsMEx6RXQwTEQvb3FGY2lPMldJR3M5?=
 =?utf-8?B?YkgvakNiMm42NjdiTmorWjRLbGxnTDVOcDFTakNmSWczR2tMMFp6VFFJUmli?=
 =?utf-8?B?Qk1pQjI3N3dFUThpQVZtbVNzZWdwUjNzd1dEWC9wVGdRSWVReXo1TTFsOThI?=
 =?utf-8?B?MGlzM3ZVUTRMUG5FTm16enFwYzAxNEY2MzA3V3NVcmtXdnNvVytnbjNMTG5h?=
 =?utf-8?B?TlBUeSs4Z1BtanhDSFJNTFEwNTNNQzlBOWl2bGd5R3hYdFJHMXNWNHNYMjdh?=
 =?utf-8?Q?MhVY10nilllANJO0Et7dkIri/7TmgDJ1iYfahlq?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bad1540-43a3-4524-8165-08d937a88630
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 07:11:59.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TmLoyHAIJpTUlGNc8mUAgVPGQrtUtQbuC8cZDFEtYl7+BVMIDi/41ya+kZkSFax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

On 21/06/2021 10.38, Xu Yilun wrote:
> On Mon, Jun 21, 2021 at 09:06:17AM +0200, Martin Hundebøll wrote:
>> From: Martin Hundebøll <mhu@geanix.com>
>>
>> This is an initial set of patches for the Silciom N5010 programmable
>> accelerated card adding support for reading out sensors.
> 
> Seems the card is a variant of d5005, just changes the layout of the
> sensors in BMC. It may not worth a dedicated PCI DID, and pass
> down the info all the way from
>    pcie -> dfl -> spi-altera -> m10bmc -> m10bmc-hwmon
> 
> Is it possible we just have some version check in m10bmc?

I think not.

The n501x is a Silicom card, and d5005 is from Intel. The Max10 based BMC
is quite similar, which is why we use a feature revision to differentiate,
but the main FPGA register layout is a different story.

// Martin

>>
>> I'm not really sure if these should be taken through each of the
>> affected trees separately, or just by fpga collectively?
>>
>> Based on current master.
>>
>> // Martin
>>
>> Debarati Biswas (1):
>>    fpga: dfl: Move DFH header register macros to linux/dfl.h
>>
>> Martin Hundebøll (3):
>>    fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
>>    spi: spi-altera-dfl: support n5010 feature revision
>>    hwmon: intel-m10-bmc: add sensor support for Silicom N5010 card
>>
>>   drivers/fpga/dfl-pci.c              |   5 ++
>>   drivers/fpga/dfl.h                  |  48 +-----------
>>   drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
>>   drivers/mfd/intel-m10-bmc.c         |  12 ++-
>>   drivers/spi/spi-altera-dfl.c        |  15 +++-
>>   include/linux/dfl.h                 |  52 +++++++++++++
>>   6 files changed, 198 insertions(+), 50 deletions(-)
>>
>> -- 
>> 2.31.0
