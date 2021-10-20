Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B779D434F9F
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJTQGG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 12:06:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:1633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhJTQF6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 12:05:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="215982065"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="215982065"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="527126027"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2021 09:02:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 09:02:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 09:02:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 09:02:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFv3p+3LHNEHtOh6y5rL9rG2JDKQpnXJEtN4LFTJ1orF36jFwZiUo5yUtgRUarJENzCBKKfgZO9JpwoSR311NtZiEXVtnxWuExdfn8TJ0AYDp4OniOB+466tVrCJRcn9NwBLYFNQLHXI8QiCDK6Sd3yxAb03fS9nCFBmbDaO5PeIZ0v9mqucyquDqSIWuEwcN0CYxspcBSPISWblm52+1ZENomFwmpoZgdDR+lD1yp+g6AbiyasjwLnJKZHPEAeHls/a8r2HOMDeTMnRruh32vkZUWpTYzlz/Pb6TShpkpuvhdlhOuwdH3BQ7F/aAiL82OXzkGZH3KOkLnfQ9V3tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuFDFR7RMceDD6URuK/a4/ynL7yCYR90hgWd45jrY9c=;
 b=NzoHBxwR2vr3kH5AISI+kjasgfq+GjK0js/TuLHdbz5aOOgqpoJiwZZ/QJEiO3eXUSkjvJUZ7E1jcIFN6RH8yUlDcgeo201CLWmGu3nxt1XzR5HP6sy6E1FvOUMzceL/Y8HYZ8X/RqyDAVYWqoFg/SFjqmugZW3Wo67NJhuTu9dzYobh2phmOo/Qq+D9TtnjFTJTH1U4LdwriMKm4Z1yx4mMj4fTiOrmnxOzkGgmLOHsvSbxjgVH7VNFbYHPLKtjlr0uNM3yxUQowjPeCHrETFwMsguu30lG3Kpt5n7X5bOfsVB1v0Hk6zaX24GY1kS0SRWsgaQvir8E5adsvL/2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuFDFR7RMceDD6URuK/a4/ynL7yCYR90hgWd45jrY9c=;
 b=IzkYgdX/5B34gw48ZytrsozqTGj3S3gW604PwczQkut8inkLVXr5tPqKrpoWx9w2HvhNGO/PlJJEOTdVlqu4DqVzYj8lEnP+IRtNuFPm04p2Wctqlw73kC8ELIimAvFOVl5WRy8K6wI5wDgIoMmyJ/Qb/jG9HLfYgWUVPx5w6SI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3501.namprd11.prod.outlook.com (2603:10b6:805:d4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 16:02:19 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 16:02:19 +0000
Subject: Re: [PATCH v1 1/2] fpga: dfl: afu: Clear port errors in afu init
To:     Tom Rix <trix@redhat.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20211019231545.47118-1-russell.h.weight@intel.com>
 <20211019231545.47118-2-russell.h.weight@intel.com>
 <e03a0a0a-74c3-9791-2603-523c2796a71d@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <cfcd0e62-aa51-3fdf-a6ce-75d8dad76b3f@intel.com>
Date:   Wed, 20 Oct 2021 09:02:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <e03a0a0a-74c3-9791-2603-523c2796a71d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:300:13d::25) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR20CA0015.namprd20.prod.outlook.com (2603:10b6:300:13d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 16:02:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4376b66-53c8-4f52-c00d-08d993e2fe6e
X-MS-TrafficTypeDiagnostic: SN6PR11MB3501:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB3501A5789914C658DCC1AAC5C5BE9@SN6PR11MB3501.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9A5lFClf5c72T6DKCTYvZ92W1JZYx7LSrh91i43OANp74MyrhFErA2ytpG6dhh9JiG3SI5/Kr8+tLIo+4WUmfT8Q8MLHkY13BO0v5UPf70ETOytW5hiwn/X59mkY5wHblhbh7IrJAoketgZkETboZSnqdDXCWH9l6zfOmpLho0TCm2LzC0Zq3WbtoMYWSnddkb5mpyC9jkNxP4h7TKLYJ3jY4MS8C6q8eo269PA8VsuIHlYIXwzs3tCjqiUlPme1+KnSBkEmiAcjMdCIQxtNVlLnlBcv0MEIMFkQgGe8g7vEMzZrrpkZ/6TuotBDEeP6+QIGSn5iTHuMyGmdtlj3nFQz+H8vzMt8aFaKDYDKGlMcWMbKf6KCYjKh/EdsrRhKcb0qAtAq7CCoPFkwZIKGoNS4CXCTPjEof3OOlcVF8g+khGKvmXo8kcxAh4Ue6b/ke2EYiUIKY50WkB7qA4KVbk52Y96uK1UY+pjlNuDCtfXQar68kRNbqP2BD7ZS5P+aJGE3aUp9SCMiJ8RUPHjCcb81JYZxa2N9GxapJxnDDHmHoj2H4HIZfb1Ak6fB2/qKkxYLiFQyV35b0pKa675ppj2JGG2G8vBBQ0u567G6wZKTzy+KN3FKikHvj0lL5lZjAioRaXGgn7qcFNgiZ2feNiFvVG9UJEhWNABTMGBRWgoZTTPBlzOthBJ+znoexGCi77DivHHl+EGlybTmFUvM5BUeYC+24EDp/4ZZ7bLD8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(83380400001)(2906002)(5660300002)(316002)(16576012)(6666004)(8676002)(4326008)(53546011)(8936002)(31686004)(508600001)(86362001)(107886003)(36756003)(956004)(6486002)(66946007)(31696002)(2616005)(38100700002)(66556008)(66476007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZTVWUyMmtmU1ZCYXkvQjJRazBGU3JqZGRqTUxWamhucDd4ZDBwSmxTKzBs?=
 =?utf-8?B?NjRhN2pndWdnYTlHYzcrb1RINGFzRVhmZXB1d0hWMnY3NlI5MXdmbXdiM2JI?=
 =?utf-8?B?WWN4dG5RZUthZ3BlRkdFVE1qd3hlbFRqRXVjYStIZWVRMlUwZFZkenJIZWd0?=
 =?utf-8?B?TDRZOGtTek8zQnd3VDZsRi9zVXNrbVJpa20zSTdQalBhZHZwMVVHMmM5OUZ2?=
 =?utf-8?B?alpocUtOMDhVZGxoekFkaUR3aUlqUnNhQlIvd0c2dnk5ZzNzV045dVE0RG5Y?=
 =?utf-8?B?cDEzbmFwMDM1UWJONE5TT3czSm5Jdjh5citkdlhtU2VCeHdvZDRtSFdpRml5?=
 =?utf-8?B?R2thdzlqQkdPTjZlQnBqV1UvTnJJZzN5M0pZaXhsQldxT2hjb2Nnbi9lQllR?=
 =?utf-8?B?MGJxdVhJQWFmN1RnYmhPYmwzb2dVWGxZMmcvQUxBNEE5ODB0b0hOdTdzY0Qv?=
 =?utf-8?B?SktQTmdIZHZVbG4rUzl4NFNjckx0ZkwvV3hVUHB5Qndwak0ydm1yOU1SVWRk?=
 =?utf-8?B?Qkc3cHZiY2FOTE8xVnB6YW8vd1UvWVZ3S2grZXI1cDU3eTVKVUNoQzlXTDEx?=
 =?utf-8?B?VjdWUWdha2lJblVEMmJSekF1aVNCWkQ3dFNvUHBZRFU0V29sS3hEeUFnTmoz?=
 =?utf-8?B?TXBYUWhZNExLOW1BeU1NcDgwOUJzMDZWeUpYNHo0UFpubEtVZjNkV09adTlE?=
 =?utf-8?B?b0ZtMkdlTmMySGpncTloK1RGais1c3JjVkN1UnJMOHYyeHloczBKL0duM0sw?=
 =?utf-8?B?VDQwSit6bDlGV3plczh2VlNtTCtEQTFTdXBuVnArNmdvYnBxZ3czSEtCVkNh?=
 =?utf-8?B?bWU3SG0vU3Urd3lWSTZCaEhGbzUrS3BYZVZRUjkzYW9VTFhJN2U1cW9FNDFG?=
 =?utf-8?B?QlJCODhUWGJoNzN5cExGR25WdTd0dkcvTVZCZXc0clRkSDFjTjlBazIxakkz?=
 =?utf-8?B?QzlXR25USHhHMXFuMkxmM1BKVGRvMGtLMkxIdnBIK0ZqT2k0Rk84bER4SGoy?=
 =?utf-8?B?WnhJQTA4VFF6a2hxdFEyN1Y4d1A3SE1KaVlIRWZ0bnVlVjJzY2VLUm93T1hD?=
 =?utf-8?B?VENFenVqejRnTDdMem9MOTlOU3ZBN1M0WVI4L2hONHMrY2duSkxVQW1GQkJa?=
 =?utf-8?B?Y3lFZERMbitpa1h5VWIzY3RDbTRLY0lROFg3ZWVxN1l6MUh0UTJHeTUxdG1k?=
 =?utf-8?B?SFpuRHZyemg3b1VWakxiaGs3Q1ZleUhpQ28zb3BhWEFnSWp0c2lJdmU5aFlF?=
 =?utf-8?B?QWFUSFRKbUZjSVdHU2NiNFEvZllxeXFZL3FYNlFBMDZobUFQQzFOMzlmMnlZ?=
 =?utf-8?B?b2h1VjNiUXczOFQyZWR3dG9sRGtoQjhmUUxRcE5EUkFhd1RxejZjeHNoSEtU?=
 =?utf-8?B?dFNrUXFPTHJrbDNJWVVuZVhXcmpZc08rTW1CQmx6V3hMTk1KdFJobVJKWk5h?=
 =?utf-8?B?aGtJV3VsTkg4Qlp2K3pLQThFTHNydy9RRHkxN1VPU3IrazFvUHFVclFQajZZ?=
 =?utf-8?B?dEJZOWQ1U3IvS3Y5b3VDQnZzREZHQkwzb3VqcGluR29PRUhxd2pLZ1REZ1JP?=
 =?utf-8?B?MjRON0Fma00wOTlSK0xwTjBTN2lITGpld1ZVMnJYcW00RFNwM2txZnZmWGNI?=
 =?utf-8?B?cnVPakIxZE5jQ014dnAwYkxLdUFibzVBQ1dQRHp0NGphdkt4dksvT1hOd2Uv?=
 =?utf-8?B?UnR4eEY5Y3FGM0s0WUJUTVplTFZSSDZDWkJwbGRUV0lwKzUwWi8rYWVqTjEv?=
 =?utf-8?Q?yV0SUDnmn2pJH0LXaVYIBwt13AdBFdcoKdexDeR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4376b66-53c8-4f52-c00d-08d993e2fe6e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:02:19.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: russell.h.weight@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3501
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/20/21 5:18 AM, Tom Rix wrote:
>
> On 10/19/21 4:15 PM, Russ Weight wrote:
>> When the AFU driver initializes, log any pre-existing errors and clear them.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>>   drivers/fpga/dfl-afu-error.c | 26 ++++++++++++++++----------
>>   1 file changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
>> index ab7be6217368..0dc60bf49902 100644
>> --- a/drivers/fpga/dfl-afu-error.c
>> +++ b/drivers/fpga/dfl-afu-error.c
>> @@ -47,13 +47,13 @@ static void afu_port_err_mask(struct device *dev, bool mask)
>>   }
>>     /* clear port errors. */
>> -static int afu_port_err_clear(struct device *dev, u64 err)
>> +static int afu_port_err_clear(struct device *dev, u64 err, bool clear_all)
>>   {
>>       struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>>       struct platform_device *pdev = to_platform_device(dev);
>> +    u64 v, port_error, port_first_error;
> v is only used now by the read of PORT_HDR_STS, could v be changed to a more descriptive variable like hdr_sts ?
>>       void __iomem *base_err, *base_hdr;
>>       int enable_ret = 0, ret = -EBUSY;
>> -    u64 v;
>>         base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
>>       base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
>> @@ -88,16 +88,21 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>>       __afu_port_err_mask(dev, true);
>>         /* Clear errors if err input matches with current port errors.*/
>> -    v = readq(base_err + PORT_ERROR);
>> +    port_error = readq(base_err + PORT_ERROR);
>>   -    if (v == err) {
>> -        writeq(v, base_err + PORT_ERROR);
>> +    if (clear_all || port_error == err) {
>> +        port_first_error = readq(base_err + PORT_FIRST_ERROR);
>>   -        v = readq(base_err + PORT_FIRST_ERROR);
>> -        writeq(v, base_err + PORT_FIRST_ERROR);
>> +        if (clear_all && (port_error || port_first_error))
>
> likely with clear_all that this dev_warn will over report.
>
> how about removing clear_all && from if-check ?
I think that would make it report more often? clear_all is only set
at the time that the driver initializes. With the current condition,
errors will only be logged when the driver loads, if and only if
there are actually errors to report.


>
>> +            dev_warn(dev,
>> +                 "Port Error: 0x%llx, First Error 0x%llx\n",
>> +                 port_error, port_first_error);
>> +
>> +        writeq(port_error, base_err + PORT_ERROR);
>> +        writeq(port_first_error, base_err + PORT_FIRST_ERROR);
>>       } else {
>>           dev_warn(dev, "%s: received 0x%llx, expected 0x%llx\n",
>> -             __func__, v, err);
>> +             __func__, port_error, err);
>>           ret = -EINVAL;
>>       }
>>   @@ -137,7 +142,7 @@ static ssize_t errors_store(struct device *dev, struct device_attribute *attr,
>>       if (kstrtou64(buff, 0, &value))
>>           return -EINVAL;
>>   -    ret = afu_port_err_clear(dev, value);
>> +    ret = afu_port_err_clear(dev, value, false);
>>         return ret ? ret : count;
>>   }
>> @@ -211,7 +216,8 @@ const struct attribute_group port_err_group = {
>>   static int port_err_init(struct platform_device *pdev,
>>                struct dfl_feature *feature)
>>   {
>> -    afu_port_err_mask(&pdev->dev, false);
>> +    if (afu_port_err_clear(&pdev->dev, 0, true))
>> +        afu_port_err_mask(&pdev->dev, false);
>
> There is a __afu_port_err_mask at the end of afu_port_err_clear so this call isn't needed.

The condition statements says to only clear the mask explicitly if afu_port_err_clear()
fails. If it succeeds, then the explicit call will not happen, because as you have
pointed out, afu_port_err_clear() clear the mask.

Thanks,
- Russ

>
> Tom
>
>>         return 0;
>>   }
>

