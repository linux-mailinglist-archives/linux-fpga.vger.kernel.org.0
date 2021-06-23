Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43DF3B1967
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFWL7W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 07:59:22 -0400
Received: from mail-eopbgr130125.outbound.protection.outlook.com ([40.107.13.125]:9188
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230019AbhFWL7V (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 07:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCCZBkAI92nf69+C46+MI+AaiqAsH0wxknJpVAGaMriXUd3WjN1RPGkcZl+DKp1RifRtS+Cc6Ju7BeI0r6ZtGbkVJbA7wEcb09c4N+myH4o81iiL0tN7dXtDKjjThk9udFWvlnhUb+RMLjjax6pNiNCanKV2/0wK6u6UuDBuPZst30LGsN1dW15HOXwaLnJxG+fT7Iy2+OzB1GdkJymnF5zWO70l/op+ctSqLO/NbHg3CLBkYj+qfAGrTkasKnaPq2ubHTVTLLDPKGUvyzy5YYwCLpjMzzD7lrItYQKcL3ePAD/ACq/4PyVZdElcWBQg+erW1y7gmWamnuqlSU0Nbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB3OXAmyzXmwFVFJcFzMbTGw+X6n766/Ym3U/BDeMeM=;
 b=llJy32c3N8qD09PlYl3dCFpEjyRfw3fedHoBWxUaVGwuhwhsl1i6yRT7EW73Sdjf7+NndEBtjVR64ZjUAeUfsgvJphUMcDqCIGr9wsl7bPd2HGpadiBJBXFbNCCx+5sR94NUZkMOO6YSYoMMIxryL+KXHGx9OVVgwWXr77PTU0iMW/ZQQDsdNYP1dOH3zdMKqmz/JV++uLWOlCeXEiw58NKU5eBTM/RXmhK36NSyAyQPBB6X/P+iP0m6F36ANHuFJZ/2ug1NH5OYCxQyzeN/lje3xLhvHperMvJeqr61U9G8gUSycrTCHZxHCM0rH1+v0mChggosGl2x64hFaVDciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB3OXAmyzXmwFVFJcFzMbTGw+X6n766/Ym3U/BDeMeM=;
 b=g48o4frpfE8/DUwY2WNP137Q6AInBxvqWMYvCUsT0ada9QtXOiiZlXMoibT9VgOUE5yMR3lmIcHXKjJn9cTPFOZkwV42W/METuqCMcj2k4fsYIMEzzll8i7IXUjx/Bb9Ia6bAgwHjRlbLT7HfYoj//NSV61ZCu8wehXksDuAI6Y=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB4067.eurprd04.prod.outlook.com
 (2603:10a6:208:64::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Wed, 23 Jun
 2021 11:57:01 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 11:57:01 +0000
Subject: Re: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
 linux/dfl.h
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@geanix.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Debarati Biswas <debaratix.biswas@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <DM6PR11MB3819FE54D2C399DDBBC38FBA850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210622052205.GB27046@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819B9B2F357B9B03F7707B685099@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <0257dcaf-348a-375d-6ed8-657974208e30@silicom.dk>
Date:   Wed, 23 Jun 2021 13:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM6PR11MB3819B9B2F357B9B03F7707B685099@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.17.218.86]
X-ClientProxiedBy: AM5PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:203:69::32) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.64.70] (185.17.218.86) by AM5PR0202CA0022.eurprd02.prod.outlook.com (2603:10a6:203:69::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 11:57:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66423611-a230-44c8-415a-08d9363e029e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4067:
X-Microsoft-Antispam-PRVS: <AM0PR04MB406757A56A9E4134793D1DF3D5089@AM0PR04MB4067.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73D9/rswL9cHaBahKs1ZlOMsMRoq7ZkOAoapRpBjf8wR1UGX3ZTNDJIlHpj0C6d5xr5aiVrrkrJK8bEeaqiVk7JSpeLitauCYxujBxC2WW7bG7VD8kDI9GVM5YIYUktQKYLIXArFuXvGTJexbXvbPWXjPHA14dKaWY0/eaOa9+HRPFKi6iIt3yHai07SNxVazWgmqKHnp9RgSKOKYfyiBhCRk8nuxFj1L1fmXfyYfvCNebFVvtLUzEhgKKZTARFjRdRQSMweeQDc67Y2ueqBOKxq1fgXScND9n+yfMfC1GgUTYGGpgvPWdlwGFKIr9Xr9uzGDosB3kVcz21jkgrKcFKEwjgJ7LjXtKuiJgGcGHAZy0/IP7pEkdQPrqyW6w57Gltgc4Fb2B8NfusMTxpvHKYm7IrQkAothhwYoPGRAfYIGmHEYAZb/oSrxJBtfCyMNKkrGy2ghk6tUzdiZL4BdMqAV+ZScyXypC31cs2a7mEazLIZOjutKV5GIcaTAhRjEk+Uo9BpYXEt9fYNzfxLhVdPcXDTHCCrWkoPO2wrISYM71Lgpr3c3GD5hf9PRLaF1cGR/K87dd9mO4QKyDKl++AinynFZoupsFAW4pd0puxqPZ0ej0WIS3uMOq4FrUVFApjTHVhvvfl2OAzZDAYcAMDMkDzGCF6T8Oiphbsh1rMn1PmYCIQ0jfx8tFxmp1oh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39850400004)(366004)(376002)(66946007)(2906002)(66556008)(66476007)(2616005)(26005)(316002)(54906003)(956004)(8676002)(16576012)(8976002)(110136005)(8936002)(478600001)(4326008)(5660300002)(7416002)(83380400001)(36756003)(6486002)(38100700002)(16526019)(31686004)(186003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmV6QjdoUENIcHFjMVMyWTUvTEk5K3pEdE9rY3cwakF1b2FjYTdoRW5GSzFL?=
 =?utf-8?B?YkZjUG9sdE1FczdNWDJaS3FxK0lzSEdsNEw0TzhmQlhnRm9UYkI2MnczN0RM?=
 =?utf-8?B?cDh3NmNUTU0xcXJOdVZoQ0VxQWRTYmZ5bmxLbW1vc2paa0FnUUxyN05xbVVN?=
 =?utf-8?B?OGxzZHdVOGIzZmk2bFA0endTamdlRDJNaWZhYnhDRWxGbEpvU05hQ0lPMWFJ?=
 =?utf-8?B?YjM4eERkcmFienFvMDFJNTM4YmVJeXM2dW5HdjZrT3VXUnV2dU1YdTBqNTJ4?=
 =?utf-8?B?b2w1eEJwRnZ5aGJrQ3B6SlFPZjJxK291RUNUeFAvT3ltbjYxYUNGeEp1SUE1?=
 =?utf-8?B?YkhaNHpMbCtNWjE1TlpsRVJCdGpkSWpoYTN5U25BeUozb1N0Vno3R2RLQUEr?=
 =?utf-8?B?a01iYmcycGNrcTlyN2V0QjFWWUF4ZUdaTXcxZXJybkpGNFBtNU15YXZvSHg3?=
 =?utf-8?B?UXFObWY0WkRRcUw1ZlBSSERSVE9mY1pvUGJpaWFQZC9zdEN1azlSUWx6MTlq?=
 =?utf-8?B?S3pCTHMwNk1iZVc2MStyZ1NrU2hhdGoyaUU4QTRWZXpwS2llbEtlczN1enpW?=
 =?utf-8?B?aXNTOEhuNkJHTnhydWs2UjdveHlSSVNuRVk1Q0o4MjN3OEdCYk5ncG1VSDBp?=
 =?utf-8?B?UGFqRHZWd3ZRVWhsYmFZQzR1ZERiaXB4aTNoVC9lSkN5ODdVSXZNc3VQMUEz?=
 =?utf-8?B?Ylo5Qy85SjlZQjljZExDT0VqNzhMNVNWUTl6em9SVmNLRDhhR1RlOG1XeE5M?=
 =?utf-8?B?VnR0dnREU0xQTlp6ZkxBNml6bDZqKzkrV0w3YmQyWm9rL3A2R3dxc2Z2QzVG?=
 =?utf-8?B?a1d3UW8zTWh3WkxuSFcvYlRDcStXaWNxRUVMWDU5a0ZVNXMxMGxXRUVDSk44?=
 =?utf-8?B?c1E2Mm03K0Jwb3NHTG9XOE8xWnFUU29wQ0VIYnRaSUFRbHY3aXpnYWEwUUFs?=
 =?utf-8?B?Zys0VWFqREdJSGpNMGNSb1k2clNLQ3R3Z0NvSitPQXVHQWsyVlhFUUo4cHo1?=
 =?utf-8?B?ZCt5U2Vkb29JdzhzSGYwQmt4TDVDZ0VocmptSWsxYmVBOXA3U01jN2hjM0x4?=
 =?utf-8?B?TnYwcHdFUlI3b0NUeHBjNFp1bGRmYUIrRVd4c3ZEZW1McG1jUGcrbDBGc3pl?=
 =?utf-8?B?RkoyYXhoaHZFaHBwNVp6LzNtMFdLZWw5UFdHS0d5V3NjeGZFM0E5cmRVcGda?=
 =?utf-8?B?clp4MDI1dFpEK2NIaDhIaS9iNE9WMjBLRmJpUEx5c2YzYlRFQnlQMUpLUDF4?=
 =?utf-8?B?cjZPL2d6azlpUlQvYlREMjlrTHRXdGxpeW8zRTN0aFI2aTEvcG5Sc2UrNjBz?=
 =?utf-8?B?eXh6alRqTEpFRUxCaU5taUZiSllGR0U5RHllUS9IYS9MbWVRRllJUDg0RzlM?=
 =?utf-8?B?MW1sS1BzMHB6REFqZlp6amI3eUovUlRRSzRjMFJXdDU4R01uNUo0N1BFMWx3?=
 =?utf-8?B?Y3dyeE1uYnp1Z2J1OTNXTHdmM28wT2pPV1o5bzhISFpWRnR2QkJ0SlFpT2NP?=
 =?utf-8?B?TUVFdFVXZ3Qxdk5MdzlxaUNkaWJVa0FhclZ4aC8velNRR1V0U2l3UVhUbGlS?=
 =?utf-8?B?TlFob2xWNzJ5cHplUkhuVFBFRk4zT3MyQnFybXFFWm5HVzVYTVYvRGR1VG9W?=
 =?utf-8?B?SllvdzNDVjVmanRtWFNnYU5STGNQblM4cXJQYVMwZFdBK1BPZUR2QWdUZXZ6?=
 =?utf-8?B?YVNveG9uVmJKSnlLY3NoaThCaDlTMmppUTBXcXZYK2d5anNodkROTHJzbWZX?=
 =?utf-8?Q?gLi+EpZSc0QUz4kQql3TZaGa2O3WybIIYpwzN9q?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 66423611-a230-44c8-415a-08d9363e029e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 11:57:01.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHW1J40Mfj31T0hQcw+Uf30dXLC7yTDjmmGrXrUxdnKundW+eUNRy01FSkf1h1s7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4067
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 22/06/2021 09.39, Wu, Hao wrote:
>> On Mon, Jun 21, 2021 at 06:19:15PM +0800, Wu, Hao wrote:
>>>> Subject: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
>> linux/dfl.h
>>>>
>>>> From: Debarati Biswas <debaratix.biswas@intel.com>
>>>>
>>>> Device Feature List (DFL) drivers may be defined in subdirectories other
>>>> than drivers/fpga, and each DFL driver should have access to the Device
>>>> Feature Header (DFH) register, which contains revision and type
>>>> information. This change moves the macros specific to the DFH register
>>>> from drivers/fpga/dfl.h to include/linux/dfl.h.
>>>
>>> Looks like it requires to access the revision info in the next patch, because
>>> current dfl_device doesn't expose related information.
>>>
>>> @Yilun, do you have any concern to expose those info via dfl_device?
>>
>> Exposing these header register definitions are good to me. These registers
>> are in DFL device's MMIO region, so it is good to share these info with
>> all DFL drivers.
> 
> I mean expose revision via dfl_device, as dfl core already reads the DFL
> header, it sounds duplicate read in each dfl device driver. And if we
> consider this as a common need from dfl device driver, then the code
> can be moved to a common place as well.
> 
> I hope from dfl device driver side, it doesn't need to know details of
> how DFH register is defined, only simple way from dfl device data
> structure or some simple helper function, then dfl device driver could
> know all common information from DFH.
> 
> How do you think?

struct dfl_device {} already has "u16 type" and "u16 feature_id", so it would make sense to add "u8 feature_rev" as well?

// Martin
