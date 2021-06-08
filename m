Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8739EEA3
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 08:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFHGY7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 02:24:59 -0400
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:48384
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229797AbhFHGY6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Jun 2021 02:24:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVKsvJFBrwJ5kwcjona9xSD2KsBIiZF8pUZbFTzEAciLjQPWAc77vqOB8gLW82k18fTRSMcjjKsw9IaT/mt6lUq8bctpcahZgzQMF5F2HYrrL+XKUoiQ6qRh0V0H3ObgdQD0+aZtDssNf11vkZRYcPyLxXwCO4o2f/s8EzoOoYmSwzcrd2t6VXBdo+vKaJAwWuto/c1d9vkOnZauyumqD6tk7HgN8T2rP+MYi4pWKzZa+OU2pH1yTXQxreQenJcn2VOoTVjqEjJ4VQML6iaUsMQNkUZ9b9lCISl5KDyCOw5Ypm2Woa3tLSrT5HkoFVzy5V0T8fYijMSyuESaI1vo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eKC+bwIB69XTQEKa1mywTRxsXvB2q2Ewmqt2REvXtI=;
 b=aK03f+zUuJ7ogAQ7lkNKK8HHtHeX42rEY1xTRBxQiHFlfqsHLqLylOFjD08w1LjP17uYiJ9hNxNzNQtzGCPkXW4PNtdel6Rx9ZmAuc4hVqFFCBtm1IH8p231tHID5loKENcxmQhn93AcF0Z2WuhULqA99TS2Z896gHRG7ZsTTLfov/buJnMDQrwCiMGODjwhgdJ9UP/BFfGys5oJpr4wFZS76zT36k15aT9zMI++uNXcDV/YuNLspROefxPOVDi1LuUoKW6RA5JMRJFyNDC5EcdG7sknWfZ4BHaAgjlgLqNEY6neohZePMXe/F0u5sICXX1KuvGl3IBYfvdoc5LetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eKC+bwIB69XTQEKa1mywTRxsXvB2q2Ewmqt2REvXtI=;
 b=M4kruOeuSqbMm5Q10jGFkY3WULDjOh6xLuXvxOiFik9kKO7Ocz0XtrbMoisRpN/lJCne7unbn9/sq6d9OXVyS1HkFPIw3LvS1FbLKjvOx5neKb4Jd6d004sNSlQm04o5S8gdFywV2RcbA2b8xBsi9CcjUFeUAK1gVhk/wjzyJXU=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM4PR0401MB2338.eurprd04.prod.outlook.com
 (2603:10a6:200:50::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Tue, 8 Jun
 2021 06:23:04 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4173.029; Tue, 8 Jun 2021
 06:23:04 +0000
Subject: Re: [PATCH 1/7] fpga: wrap the write_init() op
To:     Moritz Fischer <mdf@kernel.org>, trix@redhat.com
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210607172402.2938697-1-trix@redhat.com>
 <20210607172402.2938697-2-trix@redhat.com> <YL6fUSD0KLP0l80g@epycbox.lan>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <2faf6ccb-005b-063a-a2a3-e177082c4b3c@silicom.dk>
Date:   Tue, 8 Jun 2021 08:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YL6fUSD0KLP0l80g@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM5PR0701CA0051.eurprd07.prod.outlook.com
 (2603:10a6:203:2::13) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM5PR0701CA0051.eurprd07.prod.outlook.com (2603:10a6:203:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Tue, 8 Jun 2021 06:23:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e42fed0-2ff2-4c90-46d3-08d92a45df46
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2338:
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2338DE6D880595001DAA55FFD5379@AM4PR0401MB2338.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRP0Cfne3cZbwhrf8VKu2ocxTVmQqQ6gGY61Vb8mK9R8KbX6xCcDt8bjZ1Q1+3GJCNMmn/MuwGKsDo7SZQdfkcbuUwQnEd9AOkm6VK4J4OksfuotoCog5CiQBeidJ3Gf9vmxROSSJe8HcdyvqWaZPb8lQi7QmhUBAEXzJVKEyhzSFTubQWWv4/Ve6zdBDmrszITjaQ0ExFa/q13jyhWiU9rhyVYNFwLwPF/IypKWLAZjnj2176taaG0ULD92utmYngidUbqrd7CPBjUefME+PR5fOJPrI+GLy9E9/Apxpkal+uJEgeKuO4dtmmfRUHyG0rdqg75rN4qX9pwxn4s3onqRwokCTzqiRC8+jw1tKNG9HefswoUqcmUxP5iPzYbD9pYrIKqZ/6qGI7QBnuwhviM2dJk1cIKlGjpWYxswXVzjpXTv6+XXPqESHRiRKIRqDWU2SVc9PkijQCYBodMBiKVjanhr1g581jB+buQtgNdGowMIsxzcgDxIPeaqY9zsnGvnwwfUl8Y71SEloao8b8lu+MR3gJvxigYgeh/6fL3yLkoletgvzZT/Uvno38WN2O5ssx7SnBLeO5bydutSr0iZ1EBy963iYmEbzB4B+WQa6SyT86DQBemY/VExntVVGI/8UKhq0PMC2vlkZYdpNiZjl1zm/TrwDPP7tdHXhOmRSp3NWlWRbHWEQWvMCHkf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(366004)(396003)(376002)(136003)(16576012)(86362001)(2906002)(31686004)(5660300002)(66946007)(16526019)(38100700002)(316002)(186003)(31696002)(8936002)(4326008)(8976002)(2616005)(956004)(8676002)(478600001)(66476007)(26005)(36756003)(66556008)(83380400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0FkMEE1MHdsNlhoSXBWQ3ZXVXNzWmIzNHVVNVZ2RWVpZmROM3kwSU9xRGFC?=
 =?utf-8?B?ZS83NlREa1FRTG9YQW52TENwWHM5ejJoaXR5ZlVoMVhnSk15bTdVUCtnT2g4?=
 =?utf-8?B?Zit6aHd3S1IxdXVQeFhNSzFIcWdRZnM5c0w0ckhvVjcwSnRNZ2cxQmw1RWox?=
 =?utf-8?B?RW9oVVAvSWh3ZWNaTGY2bEpjZ1Bvek9ZZUZxMmlSbTlEOGJHV00yMUZJR3p4?=
 =?utf-8?B?ZEVEWnplRU9ha3VEYXY1eDdsMVA1Q3JUUENWbmVLQXQ0NUIzUDRFQ0ZpUmtH?=
 =?utf-8?B?TG1pTEtmOExHQ29CTlRvd056ekVjaDZSNE9xWGRldmlENVJVV0EzVnpJQUwy?=
 =?utf-8?B?dnV3UVo0emNSanlid3VKNFBXQXhUSHB6YVlxVmVGSTZrSG1aWlQyV1VDVEVw?=
 =?utf-8?B?d1VRa0YyTWM5VHJyMmpXUmsrMjVVV1BOSzRUa1NMam5tMUZRMnN5SFBCbENP?=
 =?utf-8?B?RzIzRHlocGduV1VSSmdFQlVFN3AyY2xsajF6YUdmaWVKWUNENjBWdkVHaG92?=
 =?utf-8?B?MVJMamovL2hDN1NTZGM5TmVnbHMyVmtLKytBUVhmdGRwWmpRakUvVm1BeEZS?=
 =?utf-8?B?STZla3BJNWNqNXFBaUxnU1ZmekRBT21DU1UwRWpzRXVVczQzV28ySFQ3TTZW?=
 =?utf-8?B?TGt4cHd5NWZJckg3ZWZKa3NhU3NoQUdVSWNWNGUwSlVEUENOdUNEMlF5VVFE?=
 =?utf-8?B?TitkWUxvcFZPMFBwVjRkL2wyTGZQWmFJQ2JaU0hlVFI4Ni9mbVpQQUx4SHgr?=
 =?utf-8?B?dnhDMFByUkdQY2cvVERSbHliRkF6aHg0TjU4MGxDWWgyTy83Vmk1aGxDQVFo?=
 =?utf-8?B?UmRHdFJPaXdtdS8vM21TSWJXUnpOWFlIYmE5YTJNVmo0QWx6T2pCS1pJODNG?=
 =?utf-8?B?bVFDeWdkUnZKL2MxVUVqelBvVFFsS1FoN0loTFI5UTRYK0MzQ1JZSWdaSTRN?=
 =?utf-8?B?czNsc1RqSVVVYmRHUFJiSzFxNER4VnJMNWQzSmVSOXNPZ1R3dXEvY0NUb0Jq?=
 =?utf-8?B?Ty82bUF6bGFUQ2ppa0wvcFFiMFJFSFRxNTM5UmZodXdNSk9xTzJoZ3lOWHBT?=
 =?utf-8?B?dFYvak80U2JQMU5GSEs2UmdMNUtRNDdDNk45Vm45SW51dnp1Wk9WM1Z5S0ps?=
 =?utf-8?B?QlVtdWxsTjFrWWdPeGNESDdEcjJBelhNSlVQSnE3L3hBSVdRdXFJaTY3QjJH?=
 =?utf-8?B?VHkrYW5TTFp3a09aZ21ScC9WMm9GUkhYbngvekthbVpINm1oNXZLcWcrbVFq?=
 =?utf-8?B?ZjlEeGU2TGFDYzVBNm0zS2UrN2lsNnp1YVVOdGlFZktocXVMUnNBVHkyYUxm?=
 =?utf-8?B?SDNweVRhN1BYMjdBcmU2cmdtSDVDRzIwT3FDazN6Y2xsanpQQ011RXpWcTNT?=
 =?utf-8?B?ZjJqSWJtNE5TK1FnNnM4SFJadUVhNTNKeExneEVqL0NpYWRtMWxwaldYdXRJ?=
 =?utf-8?B?ZE1jT1ZpVjRyQ2V3eTBoSUNFT0wyQ1ZqODdJN2F3OFFlZ2hNcStYMEpINGhB?=
 =?utf-8?B?aTFYbW9FemQ4aHZQS3dsdldpMDREeEFiNVRteS8zTlBVM1dkbXZ6cWIwWHBN?=
 =?utf-8?B?ZnRGSTFVWjk3OHNSano4V0hDYXhDc0xvOEhhTksvUk9wd1RyS0pVSDI5SlRF?=
 =?utf-8?B?MXNneUk0aXc3Tmo1WGdtRjgvcENvY3k4czNxVGNGbnZmYUFpbGNkQTJOWS9D?=
 =?utf-8?B?azhISzNqNWxlVW1VN2Q5WEJ4VFA0SU80dkNvbjN3aWtFR01zT0ZMOWd3OUhG?=
 =?utf-8?Q?h7+FGU2MFrkgvdcDIZ73i0OHDcV/m+QHwESDpNZ?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e42fed0-2ff2-4c90-46d3-08d92a45df46
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 06:23:03.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vg2nPPuInyAeha6kiMhMSFmCvPdNnFjNvVuMIGVJ61ssGt/a6fdKH16TLdqewx/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2338
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 08/06/2021 00.36, Moritz Fischer wrote:
> On Mon, Jun 07, 2021 at 10:23:56AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The board should not be required to provide a
> Nit: Can you turn these into for whole series:
> A FPGA Manager should not be ...

Nit nit: should be:
An FPGA Manager should not be ...

// Martin

> 
>> write_init() op if there is nothing for it do.
>> So add a wrapper and move the op checking.
>> Default to success.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/fpga-mgr.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index b85bc47c91a9..24547e36a56d 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info *info)
>>   }
>>   EXPORT_SYMBOL_GPL(fpga_image_info_free);
>>   
>> +static int fpga_mgr_write_init(struct fpga_manager *mgr,
>> +			       struct fpga_image_info *info,
>> +			       const char *buf, size_t count)
>> +{
>> +	if (mgr->mops && mgr->mops->write_init)
>> +		return  mgr->mops->write_init(mgr, info, buf, count);
>> +	return 0;
>> +}
>>   /*
>>    * Call the low level driver's write_init function.  This will do the
>>    * device-specific things to get the FPGA into the state where it is ready to
>> @@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>>   
>>   	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>>   	if (!mgr->mops->initial_header_size)
>> -		ret = mgr->mops->write_init(mgr, info, NULL, 0);
>> +		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>>   	else
>> -		ret = mgr->mops->write_init(
>> +		ret = fpga_mgr_write_init(
>>   		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
>>   
>>   	if (ret) {
>> @@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>   	int id, ret;
>>   
>>   	if (!mops || !mops->write_complete || !mops->state ||
>> -	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>> +	    (!mops->write && !mops->write_sg) ||
>>   	    (mops->write && mops->write_sg)) {
>>   		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
>>   		return NULL;
>> -- 
>> 2.26.3
>>
> 
> Can you change the subjects to "fpga: fpga-mgr: ..."
> 
> Otherwise series looks good.
> 
> - Moritz
> 
