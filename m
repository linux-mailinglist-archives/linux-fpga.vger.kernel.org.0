Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4EF698120
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Feb 2023 17:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBOQnu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Feb 2023 11:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBOQnt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 15 Feb 2023 11:43:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1791F4B2;
        Wed, 15 Feb 2023 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676479428; x=1708015428;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q4flZDBD/JlR3YbZX4lsavg7V/kt6yWMp1TRvj4mkqw=;
  b=GBvX1j9DuWHMiupj7jS2H5hsSb92+frNJqhe0eI4FtaI9mv9oWtHq2UR
   2fhY7FDdc5TLb1a8iSkvKS8+igToUjdBGn2yIBnmW0BoY2FaBjGEHhmcm
   tq2clKDAxXsuIxH0Gg750gapf6jddZ158PwM4mBYvdm7GFoJn6ajF8LZL
   f+9vcbIq3+bAv1wpdSv6vjQstAgr/vEnOVQJS6g0j0c+MNCXZ2UQ/mOIL
   E1IA3/6jP4MoMrI9oj1r5vvV8zCCHDaKYeivPGs/EVYJQ8qkyYUfjmnYz
   K2XeLIt2W/BpPoXeqzGPvj5bisHLxe1LCnLJsn2Us8P1/IJ9GYm5zWF2+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311840253"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="311840253"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="663025033"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="663025033"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 15 Feb 2023 08:43:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 08:43:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 08:43:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 08:43:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 08:43:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coZqLJt2Go+XppHB9Y5z6VHHIYXtu7WU0VuUCOVBKzcWlpwgMtLUQrtgDdHF4cCGHMvC9h8Id8dW3xZCOZfpnsm92ySWl53H7comlZkZ/tB2RpqStFWFGMnAQku2rezaYqDEQvIDXHQ1iq7stNHoF2SavJS7mTA75ZjPb1K/JgkVoQMu5Vdczorwx8eckhUO+MCTnRnTWwz8N2xHFGDkVWOX/uXFzhoNwyTs77r77WyWUq/ccSTPG2cK87QtNkVHrN0XdmCYuzQDfMQZrUOsMU0jVNCZv8OCVm0HvHrbQlSYnMDnuYZV5FBxq9oOJHU2J+doe9dLgQ82/aDG2G6XEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4flZDBD/JlR3YbZX4lsavg7V/kt6yWMp1TRvj4mkqw=;
 b=POlG9iHYLqTklK1Eu2U9F7QpjVCVRRgIefNthGTpLa8HgAQlyfJ57BEBjkvPGDYGqj2rXezKS2s3igXskDRfs+Z0xITifDjRqdNYTTuJj50DtFLcNxPC1cbAScGhHyADI78hQQd9xNa+g+xXGcVl8CL0imCealzsfbRYs/hC2IHGB8xbyYsp6zTKpq5hhkL3gWG69Eip+RBsLQ+kYuWDA9hlyvwFak5J/eefppnWDVTBANODmiyhcNGPzivWikihOC4a9uhNXTmvaWoSd5QWEoldoVSUh4wjW5iAPM1c6oG5GcfZtW5MJuRg97Z8fuPiEkopYbK5c3PnqwY0i1gpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 16:43:44 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::d151:74c0:20d6:d5fc%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 16:43:44 +0000
Message-ID: <516993be-f33e-64cf-811b-cb8272b1d844@intel.com>
Date:   Wed, 15 Feb 2023 08:43:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 0/4] fpga: add initial KUnit test suite for the
 subsystem
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>
CC:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230203170653.414990-1-marpagan@redhat.com>
 <05f6238e-4ad8-f30c-38da-74c343e6abb5@intel.com>
 <01fd3850-af54-c0f0-ec2f-ae672420ce17@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <01fd3850-af54-c0f0-ec2f-ae672420ce17@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|SN7PR11MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 483411cd-a0db-438f-abad-08db0f73cc89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUq+nWL+5v5EbHkZbOYFDnRK3gWQ+xpUEg6SPqeeoNpJILA0pl0rRO6SlOlI34g1FyLiJEaOka/lq3/ZWQwP0feF+5sg2X4Bq+zHdFvhIrv98e+fehcu73wK60aLA9ltNRhx9PGojlOiKvG9dpuuIvI1LS7PSa7Z//PzjEC8m8MznY4kEpXp8fDzLADAq3LhnzSUY+1agycTWUUU6aE4At+RvxvpxB7n1at3w/f8hq//lw+rGd5tMZCawFLQcbP0E79ppOOIZNqMV+a84f4/6joifDJWYwSAiLhG4q4GsK538aAlHUCyk+DePOjbclovcQB5fwzjeFRjfibsc8l1diqf8sKsjF7fnkxmk96A2tUGKcoQvviIT8nQ+F3A+fExc4HO2gZSL2qjmZ+S0C7wfKK/6PEyTEFiz9BQ6FMWAU4rZH/f+5qIs7c61JHh7IoQaHZVWmCm7eKNpRaASB4ygGMLQiIhz1q6h52hWPDYDu6rSxbr6jpHWOrQ53/ZGRGZBHe3jr4EWIAk92lnYB6AsOZ7NINNmoB6bQNvAZSDDQ/Zl1reuYK2hD/LNEGp4Vk9LJEM2WuWJqvXVWXaN3FIq3EmtGuf3aOgXbhnnGKaiOX46J3mKor5mVxvrnOkYBAjIrTg0Z/2YPc1efWuTpre6rEg656QvYYimQc5P3MjZYnIwh/SRugXlEVDDl72A2w7jIw9Tt7PCeiO9y9hRoG1HSCWhz0ltdzQaDEWheVKXvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199018)(31686004)(186003)(83380400001)(5660300002)(26005)(2906002)(36756003)(2616005)(86362001)(6506007)(6666004)(41300700001)(478600001)(6486002)(53546011)(31696002)(8936002)(6512007)(66946007)(66556008)(8676002)(66476007)(316002)(4326008)(82960400001)(54906003)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJEMVVueWJFVWdjQmt4S0dnT2RDYks0U0oyVlRMbnFRN1VMSm04K3E4RE5Q?=
 =?utf-8?B?TThTR0RYa05IVWxmVE9NL2hqUWlodlpmNGFrWnZ0bHhlelU3bGROeVJGVVpN?=
 =?utf-8?B?MFhmNjNraGJtZjRFcm1IVi90QkJzNXdlczZwcE1zZ1dodWYzSUdEL2ZJRDVF?=
 =?utf-8?B?NnVkQldzUTUrNytjK2IreThUSnNJeVd3clVBMjc2TmRSZHhLVGw1N0hFbEFi?=
 =?utf-8?B?ZlN0UXFKZkJhRUdHRWFFUDU4bk1HQkxycW91blgxek1hMzYzK0p5RDVNakFZ?=
 =?utf-8?B?dGRaUGNtb21NV1FkNWRXMURJSkFZeDZpUFFETW1iSXNhSEJqSVZWSk1Fc0NW?=
 =?utf-8?B?ekhTZ1FpT3o4R1E2Q3dtM3lIb3c5b2NSV2hWenU0MTFxWkwxV1VLK1dGZ3RO?=
 =?utf-8?B?S2YxaU5DemZiQ1NpZ1pBTVcvWjNjVEhYNElHMHI0WTg1eXk3MExZYUpaNFB0?=
 =?utf-8?B?NHFNK3JVa3lSK1FEVStVSm1HVUNaak91dGpMeU4zK1ZzM1ZIWjZ6UVJ0MllQ?=
 =?utf-8?B?OWVDVEVOVFZuUGhZeFdqR1FDc3ZGWUgxVXJSQXI4QjZaTjROUTNXNnRMcjUr?=
 =?utf-8?B?MzFzNGc0ODlXK0tkUnV4N0h4NU5IZnpzMFE3USsrcTY0Z2tmdDlNRm80TTV0?=
 =?utf-8?B?cmh5U0RpTWFBcWx1TlZiY1BuOWpncEg0cFk3Y2J4NzIzVEtnenhTNVhWVkli?=
 =?utf-8?B?RUx6bFZHVzBhWEgxb3hlQ2p0Q1RjcndSZTF5QlpHNi93SWs0KzVSd3p1bjl0?=
 =?utf-8?B?UWxTMzd3YjBMU1dYZUFydEZsVHJlRktTYVF6ZXBBUGdXOTVlc3lQOU53RHov?=
 =?utf-8?B?eWg5N21xMTQ1dDNqKzlrY1hhOExtaSt1UnVHZXNyQVVZL1czOEpDK0tWUWpD?=
 =?utf-8?B?UE1hMmRVQ29YM1JMMkZ5bXdpN3NJRW5LZXhWYU9obGc2Wng5WWxqRGkxckg4?=
 =?utf-8?B?ZkZ0SVRrb2xsK3FqRFBieVJPUWFKVlRwR2VnQUpoeHhTbzQ3cmdmTmtEYVQ5?=
 =?utf-8?B?a2locGRCb0ZGdllsVlZIUzZXMzRGY3BQL29LUU85T2RCN0FENWQrYi8yOEVS?=
 =?utf-8?B?YTNzZmMxQ293WFdOUmdIalMrZHhyQitpK1BzdXE1elVXYU1QMW80cmVKVjd4?=
 =?utf-8?B?TFI5cHFHamdkZ1NZL3g2UEM5YUlUb1VXWERGQUxwVVM4bnR1N2plZFNyVlpB?=
 =?utf-8?B?d1dCRS9CeGFZaXYybGE2Um5MVlFsR2tiTUVYUFVBQ3JFY0NPMlMzNGJRaXkv?=
 =?utf-8?B?dk8xTFdEbFQxUUx5UEVzRlpUOGNNWFZnVTJzNFlUTEtCNThFczUwVmVWTElB?=
 =?utf-8?B?bnhWSytUNE5kMG1QMVQxU3djR3NqUmZyTmU5S3BqVzBpeFJabXhVdFlMQ25Z?=
 =?utf-8?B?ZzZxaHI4ZXdoUFNGZFYwNkhoWHdNTHpWODgrMGtyY0dyRTFMbjBKK1gySWpY?=
 =?utf-8?B?MWc5MXhtOWM2dnczMlhvNS9LcThjWm9oaytKUkVXSko1OE5xR29zVGsrM1BM?=
 =?utf-8?B?bVgrMDh6WHd6OUk2OVNQanRSZWNmSEc3TEg3anl0a2plbXNsc1hDVi9iZElL?=
 =?utf-8?B?NkhhMjAwN2R1SnZrdDNSZHMwUFAwQXNlbXFXTzlBUHhFVjlYSWdDVkY1WXo2?=
 =?utf-8?B?RFdMMEo3WDRIM1dBenB2M09LY1hKejVwZUV2T1h2ZEFDUzVkOWxrR2VHOXFT?=
 =?utf-8?B?amFHZWZiNS9RVzJUcW1EMWJhS1Y5MUIrY1RYRkx4SUZxcXF6TXJKa0o2SkhX?=
 =?utf-8?B?NDE3ZWJiNlgvZXNidmVzcjEwMzFkY0d2YnBKNE5nUGFCMGxSVmRVVzRyZUVK?=
 =?utf-8?B?R1JjWWpGOVMyL01GWnRVVmVhTlNvdXZoNkQrOFhST2pwL09VTzMzMDRZcWIx?=
 =?utf-8?B?bDZzdmp6VkF1SXNwdktjNGswR01PMTF4Snozck9XVmJpMk1wYjFYUGlvS25S?=
 =?utf-8?B?elVxQ2JWcm5YbEFGSzNESmVFbHRSdFpQeGxaWXlNRnJFaXlCVUNuMDhWTWtk?=
 =?utf-8?B?VlQxS2hhUTdWa1NDNHA4dTlzaitGZWVFR29JMEdUeFY4Sm5ZbDk5VnJ1bVRm?=
 =?utf-8?B?S3owRzhkTkt2MnkvWkc0bE9aaGNFRm1FMEo2OG04anlsR21PSnc4RFFhZTln?=
 =?utf-8?B?ZWlWcVdzR25RWmt3czB3ZG5EaGNpRlVacDA3ZHpQNHVHKy81c29zNnZWZjVO?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 483411cd-a0db-438f-abad-08db0f73cc89
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 16:43:44.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcUTG5L3IBWOUbbf1yGPfvWeCyy5RPPuk32qez/36EnKqrjs2v83NaXZli2SFIzJXIwR4DQllCAVVKYyK+G1iG0ebwpE8MSOA1Vqt8xH4yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/15/23 03:19, Marco Pagani wrote:
>> When I tried running these tests, I got an error until I created this file:
>>
>> drivers/fpga/tests/.kunitconfig:
>> CONFIG_KUNIT=y
>> CONFIG_FPGA=y
>> CONFIG_FPGA_REGION=y
>> CONFIG_FPGA_BRIDGE=y
>> CONFIG_FPGA_KUNIT_TESTS=y
>>
>> I think this file needs to be included in your patchset?
>>
>> - Russ
>>
> Patch 1/4 includes a .kunitconfig file with these configs set =y
>
>> diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
>> new file mode 100644
>> index 000000000000..a1c2a2974c39
>> --- /dev/null
>> +++ b/drivers/fpga/tests/.kunitconfig
>> @@ -0,0 +1,5 @@
>> +CONFIG_KUNIT=y
>> +CONFIG_FPGA=y
>> +CONFIG_FPGA_REGION=y
>> +CONFIG_FPGA_BRIDGE=y
>> +CONFIG_FPGA_KUNIT_TESTS=y
> To double-check for any patch format errors, I downloaded the patch set
> from lore.kernel.org and applied it on a fresh tree with Git (version
> 2.39.1) using git am. In my case, Git created the .kunitconfig file and
> I was able to run the tests.
>
>
I can see the .kunitconfig file in the emailed patch. I had to resolve
some conflicts when I applied patch #1 - I must have missed this file
when I committed the changes.

Thanks,
- Russ
