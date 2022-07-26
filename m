Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFF581C8E
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jul 2022 01:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiGZXq7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jul 2022 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiGZXq6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Jul 2022 19:46:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7614326C9
        for <linux-fpga@vger.kernel.org>; Tue, 26 Jul 2022 16:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658879216; x=1690415216;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=n+gnjEa+EzoZmIsNmhXwInMU02YKTO0JP3eQKchW20A=;
  b=OOU0sksU3gnuD13HSEAfs74798J4fb0rJ4fmXLG9WERoqsSxk5TXzkp1
   MLx8XlfVwTJXSHT2Go5ch/7Sn3+THZG3XcSY5hDf7+C8w3CHWFSuwQJuF
   WiZ1GkeSK9YLrtoP8mUB0uhNnwiwxU/SVsS3RUweRjZCjujO4+boQnniW
   HmosUVMrKyisXoLu5oapBUavCkO2pxqUSHPQvQdFTPkdoJxw7aG+k8oCR
   3eDBZEtc1R8sXoyI5yUp6hPRuzWaBmkTGtHzbKzyiZEv76U7EOA7RtGMY
   rDRDCuFCLl31ncqtDtubJiDboF3q7l/LpQs1+nJUYWdvXYLDllXpNlpO2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="313874279"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="313874279"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="632984332"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2022 16:46:42 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 16:46:42 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 16:46:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 16:46:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 26 Jul 2022 16:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObfgNYcyGJIvhpppIdDtpZc0qYvbMfwII6nVq6t6QJn8DjP18SLyPxA4jhZLBgqmyQPMgYdQmN20JroxU4vzMhex4hFIwH4iVhjQzoq4TPlRHJ8CMo6wAcjdaWSWxJfOcawD06LgN5sSSga7Wa1tORvdOvTQT8+zOuz+aWutR7vRxdvxzIeKNlNn1d7mS9zUcH5R4Avz/4FNBasGBttwRlTaoaAB38r2b39ho93OP2abqt5LBFl+vown5DFOI050fRDQfWeQrKHpzo+Mkj6HzRBWFbcSUoQsWeYd57nlpAQg9wV/n4qnwphkzNmuBIhHOuEkz7NNUdsSaYcr/4wMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7w468EG/ezb9SvJX5S/OxIXjSvT6HAFeS7fPVCbwrY=;
 b=Vqy/UL237yhtM1VpmOGJC2G54xWBg/9cprzQQtQa+fwfaU6+91BCwlWExnY1hL1k1gem9TIwJv9s/2GCoK+qXqXc3iAKIWjO3zUvXhD70aDjQoe2xbXzFM8VVw/gh3Z6j3zXAfl5d++dXh9q1BkQDxSCZzmm8DV5thOc3OXSGfDRcPN0xdLUFrUE7XkLiu5SZQl9afR+BFNlh5kjw8hN+2OkMY04rsyYFiivNIWGrtj0wmy8IFgDMUXUvcOF97R0P+ZC30tnnRn4i/+XCNTnUarlA98CduccLGxNrlJKxagjAHeCVrXP2M09RtZPvXm+9pL1Yb3YAt0IjAyQumaSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MWHPR11MB1853.namprd11.prod.outlook.com (2603:10b6:300:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 23:46:39 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::28a7:ded2:3e14:7197]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::28a7:ded2:3e14:7197%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 23:46:39 +0000
Message-ID: <50619468-6279-e661-4a73-a1893be79c7e@intel.com>
Date:   Tue, 26 Jul 2022 16:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v3] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Content-Language: en-US
To:     "Wu, Hao" <hao.wu@intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20220527073253.306501-1-tianfei.zhang@intel.com>
 <DM6PR11MB38190615C0847C763ECF030085DD9@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <DM6PR11MB38190615C0847C763ECF030085DD9@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::23) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2deede-9e7c-4db1-5438-08da6f6115c3
X-MS-TrafficTypeDiagnostic: MWHPR11MB1853:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hmrP6JkF56FB/41HeOC+sVXIpOxFnitAoZqXTnK4P0IsSq5uYwKLneDGPn4jncBIQUkDvKt2iW8TOm6muzGsS2DHZ5b3C8/u0E3Nxbq2jKv9vVvVLl+/ERYpBZqJdVBvPhuirUGFQLMQvZrZLkhdpC4amMjP7qj6q55RCisenb10RTbHy3MPO4TY5C6bGHqQzdkRPpTCyjPJ1f8PE51zy0XMyeqklYnnbtzVbiss+50XZUHoaLo7fjXX2AJHmbnpS3DmDkyMrLgVzeFmY7mKRagOkar9udD5+77/p+SRmSMUIe9sqFVhhWljSJHdzY5DOHsdiucMk2KqjLfsFLyt9f4vx+jty1XrYFgVTlJ5QQiFgr8kw3/TSqXd4TMuaiFSanI9BYKBRy3AOQ7k8B402ANqPW/YdWOWfdNhSPJfiwZw7Alg3EG8tSHNneHwwCR7qdNuRjALLKCvTFLtGCJ9kRwMaXM5arqmg3QxOWLg/93fKzfz9ckg0XUya+J4eFrgJ37NI0C3uoX7tK5TtPTdoIRGqjUC7VvVhTbKJSCJUtXilPJxM9RLTS9EG75FU3m4wQSsIAqjRx1pmuLI/P+vhDdC5OrH3GJbIdCvIMTzP+Oo3ooynztHqHcsQUxRRl3TOX0jiFqax/Ykt0Z/XfXv20exTG9QrwY/6XZpbVH0XLu9b2AUCYCcC8VmSjaUW3n19lq4DrWUeeKZsMsHaew6fB0JW5/t37v3EksSL4yS2/3bZbbD4BGYmt9PDNgHSZhC9697v3MvlshEUT7Ail5XGioF+GfXZ8SkasSan+CR1ucIWH5wqEisS7CCokrEaGEaleXJXsW2+rCAo9S7sMJaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(366004)(376002)(136003)(6512007)(6506007)(8936002)(316002)(478600001)(2616005)(53546011)(6486002)(5660300002)(186003)(41300700001)(31686004)(86362001)(6666004)(83380400001)(31696002)(38100700002)(2906002)(82960400001)(8676002)(66556008)(66476007)(66946007)(26005)(110136005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnN6dTRWUUpWeThBOW9HOGRMalFFYXhKckJZbFNXZjJhL1hFM2VWVUdtNEQv?=
 =?utf-8?B?VUxhcjZVQ1J2WFdFQUQraGE2cHdhL2o1T3huOCsrQlZma3lKZzdnWmpkMWJr?=
 =?utf-8?B?bjQ0dTltbk54cDJUZWRuOHc1N3Vmc0RISGpoVU02S21IVldwdFlydWM0dklV?=
 =?utf-8?B?ZkpvUlVSY05SQzdjZTIzOElQRXp1aFZaL1diL2pGZlBSNnUyNFNKOGNGZktS?=
 =?utf-8?B?NXJpOGQrcEtaTStPdHRtTHJmUFNqY0lLekN0ZHY0WnB2MnZkV2tNWjd4MW8z?=
 =?utf-8?B?dXAzNENNZWd0RlEvZmE2dFp2Y2t4cWU1MmU3Y0ptZnhoSHIrRm9nZnhjaG83?=
 =?utf-8?B?QmpYR1ovc2FVQm1pQ2FXQUJDYmsrbzNEMGtpMXdyNVhsaDdNalUyWXhCT0cx?=
 =?utf-8?B?L1paeFZFcjArR2diV2p0bDE2OU5Tci9QRHRHWFJXZ2RITnUveUtvTEFaenV4?=
 =?utf-8?B?L3BDcUNvRHl5TXluRFdPeEQ3RmpSN2tCSnVJZitPK0c0T1hxdFdhaW1nenQr?=
 =?utf-8?B?Zkl3QnZYN283VGtiUXluQVJ4eVhJU2pWZG5ZRXlUd25DbWpJb051UzNXQ3Zp?=
 =?utf-8?B?dVUyMkFPYUpXVkdGbk15amQxYkJrdEpjdUE2ODFQTnFXZ2o2VW1KNVlsTnRj?=
 =?utf-8?B?SWV0UXRtbkI1dXVWUjMzRXRRZmVHYzJqRlBVOUc4Z0JsMmxMQzdFd0ZITFJM?=
 =?utf-8?B?RVRhRzdERGZqV1RUUVFpQVBlQWRzNmFXZmdIT2djSllQOFI4UDFLR095K1pG?=
 =?utf-8?B?SDBaSTRWZEowZmN6UXpwRzhybVFnZnpDaHlXOXNETzN3VHZndnhuRmdQWEdn?=
 =?utf-8?B?YXRldlhTRDNISGFVb2RkNTMwS2ViamJBY3o4M1B2Y3NCcStrbmF1cXFRZGJT?=
 =?utf-8?B?WEt2SHd6QzVLcUgvcCtodVA4SzRrQ3lsdldWZ21xcDMyVWRvZy94VGVDUStM?=
 =?utf-8?B?eU14dTduKzh6S1QwVkJCOGM5bHhJbmtFdDBYN1VXcmpDRzA0alFPQUlPVzhp?=
 =?utf-8?B?UjRrSDJSOGtFaTJWYmhlNWd3YXpLc3p4RFZjQm5wcVlheGcwalFST0x6SUk4?=
 =?utf-8?B?ZDdPWWROZFBYVU1ld0V4TUZXVHF1YnM5RmZVcEhhdmYrOWtuSWdUVjB2Tmxp?=
 =?utf-8?B?MlpKNmRhakZpWGk5aHRvVmFweEREcUVZSm1TZ2VMaEtCdU83RFE0d3dqMXg2?=
 =?utf-8?B?VlIxMkl6VWlKQnRyWWZobUVuUnpmRzZZWGFWSTJrTHFnclhTQlAxeitVOHhW?=
 =?utf-8?B?UjRDTTFRdnRab2NuSGNsYlBrdTEzNSttT002RFQ5eWRKOWVjN0NJUnU5ZXhs?=
 =?utf-8?B?bnFjYVgwZ2txSmZ2MG83SGxQcVZnaUVlZjBNakNXc3lKR2xhcmN3OE00em9D?=
 =?utf-8?B?M1UyK0M1Q0dYVjkyeGUyNGErdmNNSDQrUXhrbTlZWDlkQ2t6V0luM2l4VjdZ?=
 =?utf-8?B?ckxRbjlwbVVYQVpaNHZ5aGJCK2ZYMzhZeGhuQUQ0L3NndFdLdXJITGN5eGFy?=
 =?utf-8?B?a0xPclV6UDM4bTl3eEpxL3B3d1NWTEpXSHZmbnMxVjQzM1JLMWxPSDRMUzZ0?=
 =?utf-8?B?ZDh6T2twOHpHNzJKamx3YTVUT0hTWWdNdWVHTFYrNkJ6ay9KRkYxMFJ4YldV?=
 =?utf-8?B?R2hmTWRLYTFHTkxUdDNMWkxpd2kvU2lqSml6M2xGd093NjBWbmV1VUQ3Tmpk?=
 =?utf-8?B?OWVpS2lUNEUzaWYwWTNqRnhBa29CMEtSalNNSlM0blprZVQxWlZuYjlScHR1?=
 =?utf-8?B?NHZTNjZnTUd4d3BISXNEN1ZlQytvY09ENlVFSyt3eThWRTJxUHJrMTVUclZH?=
 =?utf-8?B?eklpcmZWdTB6QkoxWkNQb0p5bjJBekEyM2F0c0JiVHJVeTQzbzVUTHFzLzA3?=
 =?utf-8?B?ZlNncVVUSjRNZGtNR28zS1hYK3VleHpGWnZFWlRveUZRRnNIYjBhckEyMHVD?=
 =?utf-8?B?bkIxK3YrSUplS24veXNLNnQ5T3VRemdWRm10ZW9tNGlIazhBV0NxenBYMi91?=
 =?utf-8?B?bEJ2d2grYlRaMEtHZFVRRUc2Ukt1U204OVRvVjRMNVcwVUFQMlhRUm9KTG1z?=
 =?utf-8?B?M1pCc3E2YzhlRUo4MjRuWXROSzF0K0pTUzdZNUNKc3BLaUJJazNNTUpnTzBK?=
 =?utf-8?B?T0txUnlaM0hxVUFoYXJSTWdLZWg4YWdNRXo3a0N0OXBmdXVvU2o5TnN4ZDdo?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2deede-9e7c-4db1-5438-08da6f6115c3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 23:46:39.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tGmPI3EAyqBCJRVnJfXxFf/+aDPaDVRYIx5CZVIKz1RHWl+jt+wxt0BdGtM3UuEchLIVuCSxt2+vfw4ixtGNhR5Tq4O4BExG7n07Avoh2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/29/22 19:35, Wu, Hao wrote:
>> Subject: [PATCH v3] fpga: dfl: fme: adding reserved bits for revision of FME/Port
>> error
>>
>> From: Tianfei zhang <tianfei.zhang@intel.com>
>>
>> There are 2 different register layouts for FME/Port error
>> registers. The older PAC card like N3000 used the older
>> register layout, but to improve the scalability, the new
>> production like Intel PAC N6000 plans to deploy the new
>> register format.
>>
>> To distinguish the register layouts, we provide another sysfs
>> node for revision info, but it is a bad method that using one
>> sysfs node's value to determine the usage of other sysfs node.
>>
>> This patch introduces 4 reserved bits (Bit[59:56]) in error
>> register to store the revision value which readout from
>> DFH_REVISION field in DFH register, the DFH_REVSION field also
>> 4 bits width. DFL driver appends the FME/Port error
>> revision info in those bits for attribution on the readout
>> value.
> My current feeling is that the essential requirement now, is
> that userspace requires to know what the error types on the
> current FPGA card, as FPGA logic can be customized by different
> user. Ideally it should expose something like GUID to userspace,
> but now there is no such design, if GUID design could be finalized
> then we can just expose that info via GUID sysfs interface, if this
> is not possible, then I feel even revision sysfs interface is better
> than this kind of hack.

Yes - I was thinking that these registers provided a single error
value which could be augmented with the revision number to ensure
unique values across boards with different implementations. However,
embedding the revision number isn't helpful for a bitfield.

Can you elaborate on the GUID design? Wouldn't this create a situation
where you have to read the GUID to know how to interpret the error
register? If so, how is this different or better than reading a
revision number to know how to interpret the error register?

Maybe I am misunderstanding the problem or the suggestion?

Thanks,
- Russ
>
>> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
>> ---
>> v3:
>>  - no code change, just add some explanation of two register layouts in git
>> message.
>> v2:
>>  - add documentation for this change.
>>  - fix the reverse xmas tree declaration.
>> ---
>>  .../ABI/testing/sysfs-platform-dfl-fme        | 37 ++++++++++++-------
>>  drivers/fpga/dfl-fme-error.c                  | 36 +++++++++++++++---
>>  2 files changed, 54 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme
>> b/Documentation/ABI/testing/sysfs-platform-dfl-fme
>> index d6ab34e81b9b..b886568d6071 100644
>> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
>> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
>> @@ -50,46 +50,57 @@ Date:		August 2019
>>  KernelVersion:  5.4
>>  Contact:	Wu Hao <hao.wu@intel.com>
>>  Description:	Read-Write. Read this file for errors detected on pcie0 link.
>> -		Write this file to clear errors logged in pcie0_errors. Write
>> -		fails with -EINVAL if input parsing fails or input error code
>> -		doesn't match.
>> +		The readout value has embedded 4 bits revision attribution
>> +		in Bit[59:56] which reserved by hardware. Write this file to
>> +		clear errors logged in pcie0_errors. Clean Bit[59:56] before
>> +		write this file. Write fails with -EINVAL if input parsing
>> +		fails or input error code doesn't match.
>>
>>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie1_errors
>>  Date:		August 2019
>>  KernelVersion:  5.4
>>  Contact:	Wu Hao <hao.wu@intel.com>
>>  Description:	Read-Write. Read this file for errors detected on pcie1 link.
>> -		Write this file to clear errors logged in pcie1_errors. Write
>> -		fails with -EINVAL if input parsing fails or input error code
>> -		doesn't match.
>> +		The readout value has embedded 4 bits revision attribution
>> +		in Bit[59:56] which reserved by hardware. Write this file to
>> +		clear errors logged in pcie1_errors. Clean Bit[59:56] before
>> +		write this file. Write fails with -EINVAL if input parsing fails
>> +		or input error code doesn't match.
>>
>>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/nonfatal_errors
>>  Date:		August 2019
>>  KernelVersion:  5.4
>>  Contact:	Wu Hao <hao.wu@intel.com>
>> -Description:	Read-only. It returns non-fatal errors detected.
>> +Description:	Read-only. It returns non-fatal errors detected. The readout
>> +		value has embedded 4 bits revision attribution in Bit[59:56]
>> +		which reserved by hardware.
>>
>>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/catfatal_errors
>>  Date:		August 2019
>>  KernelVersion:  5.4
>>  Contact:	Wu Hao <hao.wu@intel.com>
>>  Description:	Read-only. It returns catastrophic and fatal errors detected.
>> +		The readout value has embedded 4 bits revision attribution in
>> +		Bit[59:56] which reserved by hardware.
>>
>>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/inject_errors
>>  Date:		August 2019
>>  KernelVersion:  5.4
>>  Contact:	Wu Hao <hao.wu@intel.com>
>> -Description:	Read-Write. Read this file to check errors injected. Write this
>> -		file to inject errors for testing purpose. Write fails with
>> -		-EINVAL if input parsing fails or input inject error code isn't
>> -		supported.
>> +Description:	Read-Write. Read this file to check errors injected. The readout
>> +		value has embedded 4 bits revision attribution which reserved
>> by
>> +		hardware. Write this file to inject errors for testing purpose.
>> +		Clean Bit[59:56] before write this file. Write fails with -EINVAL
>> +		if input parsing fails or input inject error code isn't supported.
>>
>>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme_errors
>>  Date:		August 2019
>>  KernelVersion:  5.4
>>  Contact:	Wu Hao <hao.wu@intel.com>
>> -Description:	Read-Write. Read this file to get errors detected on FME.
>> -		Write this file to clear errors logged in fme_errors. Write
>> +Description:	Read-Write. Read this file to get errors detected on FME. The
>> +		readout value has embedded 4 bits revision attribution which
>> +		reserved by hardware. Write this file to clear errors logged
>> +		in fme_errors. Clean Bit[59:56] before write this file. Write
>>  		fials with -EINVAL if input parsing fails or input error code
>>  		doesn't match.
>>
>> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
>> index 51c2892ec06d..a440bc09938d 100644
>> --- a/drivers/fpga/dfl-fme-error.c
>> +++ b/drivers/fpga/dfl-fme-error.c
>> @@ -39,6 +39,22 @@
>>
>>  #define ERROR_MASK		GENMASK_ULL(63, 0)
>>
>> +/* Bit[59:56] was reserved by software for error revision */
>> +#define ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
>> +
>> +static u64 set_error_revision(struct device *dev, u64 value)
>> +{
>> +	void __iomem *base;
>> +	u64 revision;
>> +	u64 dfh;
>> +
>> +	base = dfl_get_feature_ioaddr_by_id(dev,
>> FME_FEATURE_ID_GLOBAL_ERR);
>> +	dfh = readq(base);
>> +	revision = FIELD_GET(DFH_REVISION, dfh);
>> +
>> +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision);
>> +}
>> +
>>  static ssize_t pcie0_errors_show(struct device *dev,
>>  				 struct device_attribute *attr, char *buf)
>>  {
>> @@ -52,7 +68,8 @@ static ssize_t pcie0_errors_show(struct device *dev,
>>  	value = readq(base + PCIE0_ERROR);
>>  	mutex_unlock(&pdata->lock);
>>
>> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>> +	return sprintf(buf, "0x%llx\n",
>> +		       (unsigned long long)set_error_revision(dev, value));
>>  }
>>
>>  static ssize_t pcie0_errors_store(struct device *dev,
>> @@ -97,7 +114,8 @@ static ssize_t pcie1_errors_show(struct device *dev,
>>  	value = readq(base + PCIE1_ERROR);
>>  	mutex_unlock(&pdata->lock);
>>
>> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>> +	return sprintf(buf, "0x%llx\n",
>> +		       (unsigned long long)set_error_revision(dev, value));
>>  }
>>
>>  static ssize_t pcie1_errors_store(struct device *dev,
>> @@ -133,11 +151,13 @@ static ssize_t nonfatal_errors_show(struct device
>> *dev,
>>  				    struct device_attribute *attr, char *buf)
>>  {
>>  	void __iomem *base;
>> +	u64 value;
>>
>>  	base = dfl_get_feature_ioaddr_by_id(dev,
>> FME_FEATURE_ID_GLOBAL_ERR);
>> +	value = readq(base + RAS_NONFAT_ERROR);
>>
>>  	return sprintf(buf, "0x%llx\n",
>> -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
>> +		       (unsigned long long)set_error_revision(dev, value));
>>  }
>>  static DEVICE_ATTR_RO(nonfatal_errors);
>>
>> @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct device *dev,
>>  				    struct device_attribute *attr, char *buf)
>>  {
>>  	void __iomem *base;
>> +	u64 value;
>>
>>  	base = dfl_get_feature_ioaddr_by_id(dev,
>> FME_FEATURE_ID_GLOBAL_ERR);
>> +	value = readq(base + RAS_CATFAT_ERROR);
>>
>>  	return sprintf(buf, "0x%llx\n",
>> -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
>> +		       (unsigned long long)set_error_revision(dev, value));
>>  }
>>  static DEVICE_ATTR_RO(catfatal_errors);
>>
>> @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device *dev,
>>  	mutex_lock(&pdata->lock);
>>  	v = readq(base + RAS_ERROR_INJECT);
>>  	mutex_unlock(&pdata->lock);
>> +	v = FIELD_GET(INJECT_ERROR_MASK, v);
>>
>>  	return sprintf(buf, "0x%llx\n",
>> -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
>> +		       (unsigned long long)set_error_revision(dev, v));
>>  }
>>
>>  static ssize_t inject_errors_store(struct device *dev,
>> @@ -211,7 +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
>>  	value = readq(base + FME_ERROR);
>>  	mutex_unlock(&pdata->lock);
>>
>> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
>> +	return sprintf(buf, "0x%llx\n",
>> +		       (unsigned long long)set_error_revision(dev, value));
>>  }
>>
>>  static ssize_t fme_errors_store(struct device *dev,
>> --
>> 2.26.2

