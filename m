Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6450600F
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 01:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiDRXDt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Apr 2022 19:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiDRXDs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Apr 2022 19:03:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31255E0E9
        for <linux-fpga@vger.kernel.org>; Mon, 18 Apr 2022 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650322868; x=1681858868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aRb16JP+Z0emRhND9kwWhZmVNwrKLihir+ULr5sITjU=;
  b=dBEHmwYTalQzC2r1nIf6pC2zCPw6DsCq6Y9MsUJzQSJuL0GCFWS5Z3+i
   tVdBiMRUBugSfump745zImIxsZ6O2hcsCR+ZE68pGZb0Y1m7tEcZn0nxI
   5zk+aGqQwA8s6ywaS3XCGfOoMxAvKgF0TvAsj2ocQDMk9qf1WqRhdh5DN
   40bkoTC60FDuUttaA3wpczEA2RwBic1vQZpDWrkG4p/pFHaqzrxzlQdKJ
   9JUQ046RJnJVm4W5mDMriqA0I4bxPuSOPxorEwEfwGs7b1WyoN9iBvKer
   nxfi/EHdkzGFQSTv2brbX+hfPkqKsPilA6XKemr/PUG6L9ht/p5Kz4Fu0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288722597"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="288722597"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 16:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="625447133"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 18 Apr 2022 16:01:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 16:01:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 16:01:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 16:01:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 16:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQFj6IJ/fML3RwtO+6pRg08lbWEqU/dnATBJ594p9TY5TxYHx7rMxX8ltxSEaJt55KJJua37bWfntImSjBH7INcC0BPEQ0QwRNQFJs4VGRFSyEYxVaCcefxBRwt4uyGavOmiebCnFCujUen+Q+BvqAKPy4A4U34K52vrkHCZ8Ax1vZyPoV7lKZ8M8CIsEKFKa4lcWq9K6ayU2LzFYwn6d3/q7uOhxXEt13mjijWEV2EnEAa1SqkDV/HJTppD6C5gqz1tb1uoSPY++v9NISogy72PSmDmlthKcMcVoPh9AGtPVGQcHMw6iPTLx49WvFLmeBWBkga2+fcy4PN9LekOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yTt5LLiP5mgB8xqAH4i94Sdw/vN38BkepqI7nr4Tbc=;
 b=ZprjqXGACJD+kY4Kotnc2eI7lm2TM2uaTG9wKGfIr0hmelPp2OEYDqig5D2eUQGDpseTh6iqAO/KYxrVDWG/Blgfg6LfpiPK7uOF8kaHpiqRhjziv7/VX5ApPsjZPKQ550Fa4J6612pGffc1LYpFkDotYv+DBpW/PYQEtAE5e5sBgkDVQMmIVVAzQVM1raSp4ARqfTV4q5VfI9qNdZB6fTJrVde7dG4Q4roJ3AHzb3gKBAGSH/CT92oeVmWakpcdar9zBYcKkOoJm6SbP0Eg+iiD4asH6uICt5Kq/9rrYjrMW8ARW2iGQ38VddBCJDthaHgA7EQMdFlXVbPw0W6XTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MWHPR11MB1887.namprd11.prod.outlook.com (2603:10b6:300:109::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 23:01:04 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 23:01:04 +0000
Message-ID: <3aa28e32-bcb5-9141-66ec-df0fa55daf50@intel.com>
Date:   Mon, 18 Apr 2022 16:00:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/8] Extend FW framework for user FW uploads
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <rafael@kernel.org>, <trix@redhat.com>, <lgoncalv@redhat.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20220308214932.24477-1-russell.h.weight@intel.com>
 <20220316033206.GA123354@yilunxu-OptiPlex-7050>
 <3840315e-9f78-91a4-cdcd-9bd103c1d144@intel.com>
 <20220317015556.GA133444@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220317015556.GA133444@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::12) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3384f8ea-c271-4bed-37ad-08da218f505c
X-MS-TrafficTypeDiagnostic: MWHPR11MB1887:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1887AC4CE14AA47FD95CEE23C5F39@MWHPR11MB1887.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQ0y7Xnm94DDQP3w/7crHRL0nxZ+dirWIcO2U75aQ4I9rTMtgoAE/Jwavo3Bz6SxxJ9usC74WjVgmqkxwF9kLOACa1vxp6GPf7Lh6DY0N0JM7YTqArcaGI+o+BUL3xiKCoaKFmNR7uVQHzkwzTnYy4WeMOTsuWnqhM5PNucnkBEIKjg+G5L+nXXG+ENTtJJKULxxpxE3E3Bn4eUbRpFxkE3l+VrtngMafUHzeyHljez7SJO/yQX5jkbFMrd4cEdofqIId2oGOzk6xlrZ+1UJybl5NXU1CfZhI8U8qi0L/21Qsc3U3lkP/+dnk+gKZNxLq9ap1FlWmuMotipjbI+TgSlKdBQIyBMVFJVN+jjE2lDxMMxCkeWgmHEyziZwqsLZc72lr+O/tUaWEtWh2hD4Qm5Rix+2WwT4wlLb5x5Z5YGPc8W5MBLlglvkVEy2VLdkHc1dlnr5XHzpJqrQgGdXgJF7nDsJ86VTPG5bXgZL2ORrnrv7HZEs8CSWW8PXXrsrsEyW/IiMe/36hW+znrSp5gCXf0X5qP1nmI6a7dupoFJtlO5ogDFUfebX/tywaQj29yFQilrV09fz+d7UXy81zf8vOiNZfoqupZafiGOgxlBVKbWXJrH9xsODEQH00UCllD+D2ylitfG76/wSG5955EMBVyfSb0EkaxYAQ9eKCG9kzMKAxIgIFcAXnJSrL0J6vqRJjk2Sf06vatfVeYZBCRT/QKZvbfvCYoaO6EwtoZ8wZeR+J9jKQx7H6WKZAdDO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(4326008)(26005)(2616005)(8676002)(2906002)(82960400001)(83380400001)(8936002)(31686004)(36756003)(53546011)(6666004)(508600001)(6512007)(6506007)(186003)(66556008)(66476007)(31696002)(316002)(6862004)(86362001)(6486002)(6636002)(37006003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFrcGozU1lmNWlwMmFzTVNxeXNnaUZFSGQ2cDNuL09uNjA2UWRrZGYrVE84?=
 =?utf-8?B?YWVLTDQ3dlhKMU1VRVErbmZXd0tGMGFXME0xQm5yNFRiYURBZk4zTmpzRWx1?=
 =?utf-8?B?a3A2NkxUQkhCOVVwb0E4NXk0akRNNnlXYlJLaG9Ca0NDM2ZoZmVvK2VtNWxZ?=
 =?utf-8?B?YmxLWEpPdVBUY1g2QVZMR3pKY1lmdnBGN1d2YW50ckZ5RStFMnp6UldoYzZ0?=
 =?utf-8?B?OHJLYlBCWHY5WjQ1K1NZZXVVeWRFWE95OEVnQTg2Rzl5OFFvM3lyZjgrN1Av?=
 =?utf-8?B?b3ZucUpQS1J5RHZvZ1hEemFlMnFKR25CRlN0Q24yTStNY2hkbzN4b1dRUDZY?=
 =?utf-8?B?cHhhdVc4c1NCbmlBaUZ0S2JkMFRZcEZjNS9CZTFkaVdXMFpEd3VCcUhxYkpR?=
 =?utf-8?B?WWJvNThTYmttNmliU0pETGo4ajlTdkZhQjd2bDVaYUZkMkwwc3VUMkVORmZI?=
 =?utf-8?B?Z0ZEVXBPMVN2Y2pMRjJoUVFmQ21hMkxycVdLOHRITnRBV2hCK2VWbUNzT3ND?=
 =?utf-8?B?alc1Nk9CSG5Dd2lUSnJhUWF2TVdsaUh0UzlZcEFDbzh6dWxCYlZjSE1weEJo?=
 =?utf-8?B?NWlzK0t3Ymxyc25aRnYxMlhXUXBmQkc3QVBwamlEdXJpNGZScW1JVjM2ckpa?=
 =?utf-8?B?ejZDOURkUmVHNlJmbWtnTTc0YWxhckpGMFpTS25LNUphOGYwbWk5OWViL21k?=
 =?utf-8?B?WnRycGdPQnJaUFpnWVZsZjhFN21CMGptN09oZEZDWStLK3ViNzhzNFVxTUF2?=
 =?utf-8?B?N2ppaW9mWkoxSXZJZ0NGcmJrVitvay9FSFkreGE1RDlTNmp4WUZSMVQ2RHk0?=
 =?utf-8?B?TU9kS2ZGdzQ2QTlqc2VpSHBhQ05EcXc5aTZPdkR4ckYwZk1wMVkyTER6NGtW?=
 =?utf-8?B?Wmh5ZjVrR25ENGZaSEZKS1lEQ1JMSVRsYW1FaG96RloyOUl6NXhDeHI5RlBO?=
 =?utf-8?B?S1Y0K3dPN2tiOEI1SmRUQ0ErUnZJQ2kxeERvM3FLMlNMYzZPWStyUmFDb1VF?=
 =?utf-8?B?S1B3Qzh1clJUdUJMa1hKL0U4b1oyUWR6eFljbnhHcldOKyt4aHVwSitoRHZC?=
 =?utf-8?B?a2ZxVWNKNzhDUjNQNlAxeUVYcXZRTVNlanNWVFNPSVBEVHN2TUNNc20wSzIw?=
 =?utf-8?B?bmxWelg1ZzYwZVhQZ3pZbEpQUFZCZ1Z2ZE53elFvbkJiRE03NFJwVXdWbmdK?=
 =?utf-8?B?Y3RnUnV2Tk54N0xFV3dXeWdKdk9DQnZ1azQyRTNReGZ6VmVCK3pSZ1NyMmJj?=
 =?utf-8?B?MXlxSFJwVXlBWS95Ri83cEhEejJNcEh2K1V1MlpqR2NCNzdRNkh1L1NhNDVv?=
 =?utf-8?B?U21PWENka1g5NSttb2hXSkN3TEpLUUZRNVZXL2lyQkNSRW1hQ0xLZWt5UlJm?=
 =?utf-8?B?N1JUQ21yaUF2aVluUVc4WjU5RytmVDhFeG43bGphdUNvMUk5c0tpNGNkWGY0?=
 =?utf-8?B?bDh6Y3d5U05xWm1naFJWSXpBdlBraGFZeHh1NHQ4OWVVaUY1eWxET3VGWUJC?=
 =?utf-8?B?ckNVSFN5SklUaU5JdE1NOHAyYkd2TE9jV3A2U3hGMHgxb0dKdW9YdDgvQW8w?=
 =?utf-8?B?SFpwd1dLS0JEMncyekNZb3hCZkZOR0V4WEgxNlhZMFpHZ1R1cGFzeTE4Nllj?=
 =?utf-8?B?VVhKRlFESjlCcnlVNTZ6Zk9QZW9hNHc1b1g5THhlRCtXcVZqa3hPV3FHVElS?=
 =?utf-8?B?SVFya0MrTEFMZHcvV3RRSW5GK0hEbFlpaWpWa1ZFT3FnOGl5ZWdHNkhoMm9C?=
 =?utf-8?B?OXgxcTZzbU5sWCtIK1VITjVxcFNHcVE1eWcyUDNjWUJ5RXBOM01oSjdMZCtY?=
 =?utf-8?B?Qmt5REg0VXdxWXJFaGFZWHovUFhmMDFKTGpwU3lZT1NTNmlobmlmcHd0dkI2?=
 =?utf-8?B?YklpeGVvZWhmZG4vZk9jaUtvZ0VyN0Jza3R4UUhocVBmK0QwTUt1REdRRFcz?=
 =?utf-8?B?Uzk3VlgwbGFWdzJLNFFrZzNTZHpzN2FXRG5VdGZpU0tCc3A1aXhkNjMrSlE5?=
 =?utf-8?B?d2l4alRhbXpRTm1sWmZmOTVhL2Qxam1tSTM2citDT2ZhRDQ0RlhvT3RrZ0ZB?=
 =?utf-8?B?SUJxaG5TUW03anZYeVlxSFBQNmNhSTh4aGszZmVtd2Vremg3aGVyMHpyTXMv?=
 =?utf-8?B?ZS9GRGpYeWgxWXVUbG9BYUwrcXFWcEI4dXhndS9YM0N1ZjJJUjg2Uy8zaCs0?=
 =?utf-8?B?b0hKaDAwZE5adkRXbXFHUlhYVGZsNzFSajhHUDVMK0VZelJmM1drVGRtb1FC?=
 =?utf-8?B?ZkQybFIxNnZlMG1ENzJqVlV2b2lWYklPcjlZcklVT0VrUnFiSVlTQXJ0elFJ?=
 =?utf-8?B?T2Fod1hmTlRXcUZRbGIrK2ROTlo0bkhVWENxV0E4aXBpblkwdm0vTnl6Tkx4?=
 =?utf-8?Q?8JkY5ySLEO/c2Efw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3384f8ea-c271-4bed-37ad-08da218f505c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 23:01:04.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyQOStpaxqj0fKEKBknit51plupKBv55zB+WHIEKY0HJ04DqLyTsw9rrj2O5Dj3FBR8zRCRZH+EJwaisoru/TjDh7ZwWXRTQudGRs+Boe/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1887
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

Since this discussion is specific to FPGA, I have reduced the distribution list and
have added the linux-fpga mailing list. Please see inline comments below.

On 3/16/22 18:55, Xu Yilun wrote:
> On Wed, Mar 16, 2022 at 10:39:39AM -0700, Russ Weight wrote:
>>
>> On 3/15/22 20:32, Xu Yilun wrote:
>>> On Tue, Mar 08, 2022 at 01:49:24PM -0800, Russ Weight wrote:
>>>> Extend the firmware loader subsystem to support a persistent sysfs
>>>> interface that userspace may use to initiate a firmware update. For
>>>> example, FPGA based PCIe cards automatically load firmware and FPGA images
>>>> from local FLASH when the card boots. The images in FLASH may be updated
>>>> with new images that are uploaded by the user.
>>>>
>>>> A device driver may call firmware_upload_register() to expose persistent
>>>> "loading" and "data" sysfs files at /sys/class/firmare/<NAME>/*. These
>>>> files are used in the same way as the fallback sysfs "loading" and "data"
>>>> files. However, when 0 is written to "loading" to complete the write of
>>>> firmware data, the data is also transferred to the lower-level driver
>>>> using pre-registered call-back functions. The data transfer is done in
>>>> the context of a kernel worker thread.
>>>>
>>>> Additional sysfs nodes are added in the same location as "loading" and
>>>> "data" to monitor the transfer of the image data to the device using
>>>> callback functions provided by the lower-level device driver and to allow
>>>> the data transfer to be cancelled.
>>>>
>>>> Example usage:
>>>>
>>>> $ pwd
>>>> /sys/class/firmware/n3000bmc-sec-update.8
>>> I'm good with the firmware update API, but have concern about the
>>> example.
>>>
>>> The n3000 bmc secure update engine is the sub device on N3000 PCIe based
>>> FPGA card, it could be a data xfer engine which helps to update the
>>> firmware of the N3000. The N3000 PCI driver knows how the firmware
>>> uploading affects the card.
>>>
>>> So maybe the N3000 PCI driver should register the firmware upload. But
>>> of course it could interact with the n3000bmc-sec-update driver for
>>> specific firmware upload ops.
>> Until now, these interfaces (for the firmware-loader) have been created
>> (i.e. registered) at a granularity of one interface per firmware file (e.g.
>> /sys/class/firmware/my-firmware-file.bin/). For secure updates, the files
>> are self describing, so a single interface is sufficient for various
>> payloads. It sounds like you are suggesting a coarser granularity that
>> would allow other firmware files (separate from the secure update driver)
>> to share a single interface for a PCI card?
> The granularity is specific to the HW. If we could independently update
> firmware for one sub device and not impact the other component on the card,
> an interface could be registered by the sub device driver. If there is a
> firmware updating that impacts the whole card, an interface could be
> registered by the parent card driver. Alternatively, we could have a single
> interface for parent card which serves all different types of updates
> inside the card, the parent card driver handles each update request
> internally.
>
> My main concern is we should be clear about the scope of the update,
> then find the right device driver to create the interface. To avoid that
> the device is impacted by an update but its driver is unaware of it.
>
> I think registering the firmware update interface in a data transfer engine
> driver is general not a good idea. The update is not to change the data
> transfer engine itself.

Today I was looking at how to register the firmware update interface at
the PCI device level. As you know, the callbacks that perform the actual
update are part of the BMC secure-update sub-driver. I have been looking
at how to make the connection between to the two drivers.

The card interface will not always be PCI, so we can't assume that in
placing the firmware node. The only workable solution I have come up with
is to pass a register-function pointer and device handle from the card/bus
interface driver through multiple driver layers to the secure update driver.
The secure update driver would then call the function and pass back the
device handle and the secure update call-back functions.

This seems pretty messy to me. Is there another approach that is more
standard and/or less messy?

Do you think it is critical to place the firmware node at the card interface?
I understand your argument about scope, but it is the BMC driver that manages
the card. It seems acceptable to me that the firmware interface be attached
to the BMC driver.

- Russ

> Thanks, Yilun
>> - Russ
>>> Thanks,
>>> Yilun
>>>
>>>> $ ls
>>>> cancel  device  loading  remaining_size  subsystem
>>>> data    error   power    status          uevent
>>>> $ echo 1 > loading
>>>> $ cat /tmp/firmware.bin > data
>>>> $ echo 0 > loading
>>>> $ while :; do cat status; cat remaining_size ; sleep 3; done
>>>> preparing
>>>> 44590080
>>>> <--snip-->
>>>> transferring
>>>> 44459008
>>>> transferring
>>>> 44311552
>>>> <--snip-->
>>>> transferring
>>>> 173056
>>>> <--snip-->
>>>> programming
>>>> 0
>>>> <--snip-->
>>>> idle
>>>> 0
>>>> ^C
>>>> $ cat error
>>>>
>>>> The first two patches in this set make minor changes to enable the
>>>> fw_priv data structure and the sysfs interfaces to be used multiple times
>>>> during the existence of the device driver instance. The third patch is
>>>> mostly a reorganization of existing code in preparation for sharing common
>>>> code with the firmware-upload support. The fourth and fifth patches provide
>>>> the code for user-initiated firmware uploads. The final 3 patches extend
>>>> selftest support to test firmware-upload functionality.
>>>>
>>>>
>>>> Changelog RFC -> v1:
>>>>   - Renamed files fw_sysfs.c and fw_sysfs.h to sysfs.c and sysfs.h
>>>>   - Moved "MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);" from sysfs.c to
>>>>     sysfs.h to address an error identified by the kernel test robot
>>>>     <lkp@intel.com>
>>>>   - renamed fw_upload_register() and fw_upload_unregister() to
>>>>     firmware_upload_register() and fw_upload_unregister().
>>>>   - Moved ifdef'd section of code out of firmware_loading_store() in sysfs.c
>>>>     into a new function, fw_upload_start(), in sysfs_upload.c.
>>>>   - Changed #defines to enums for error codes and progress states
>>>>   - Added additional kernel-doc supported symbols into the documentation.
>>>>     Some rewording in documentation as well.
>>>>   - Added module reference counting for the parent module in the
>>>>     firmware_upload_register() and firmware_upload_unregister() functions
>>>>     to fix problems found when testing with test_firmware module.
>>>>   - Removed unnecessary module reference counting for THIS_MODULE.
>>>>   - Added a new patch to modify the test_firmware module to support
>>>>     testing of the firmware upload mechanism.
>>>>   - Added a new patch to modify the test_firmware module to support
>>>>     error injection for firmware upload.
>>>>   - Added a new patch to extend the existing firmware selftests to cover
>>>>     firmware upload.
>>>>
>>>> Russ Weight (8):
>>>>   firmware_loader: Clear data and size in fw_free_paged_buf
>>>>   firmware_loader: Check fw_state_is_done in loading_store
>>>>   firmware_loader: Split sysfs support from fallback
>>>>   firmware_loader: Add firmware-upload support
>>>>   firmware_loader: Add sysfs nodes to monitor fw_upload
>>>>   test_firmware: Add test support for firmware upload
>>>>   test_firmware: Error injection for firmware upload
>>>>   selftests: firmware: Add firmware upload selftests
>>>>
>>>>  .../ABI/testing/sysfs-class-firmware          |  77 ++++
>>>>  .../driver-api/firmware/fw_upload.rst         | 117 +++++
>>>>  Documentation/driver-api/firmware/index.rst   |   1 +
>>>>  drivers/base/firmware_loader/Kconfig          |  18 +
>>>>  drivers/base/firmware_loader/Makefile         |   2 +
>>>>  drivers/base/firmware_loader/fallback.c       | 430 -----------------
>>>>  drivers/base/firmware_loader/fallback.h       |  46 +-
>>>>  drivers/base/firmware_loader/firmware.h       |  11 +
>>>>  drivers/base/firmware_loader/main.c           |  18 +-
>>>>  drivers/base/firmware_loader/sysfs.c          | 435 ++++++++++++++++++
>>>>  drivers/base/firmware_loader/sysfs.h          | 100 ++++
>>>>  drivers/base/firmware_loader/sysfs_upload.c   | 396 ++++++++++++++++
>>>>  drivers/base/firmware_loader/sysfs_upload.h   |  47 ++
>>>>  include/linux/firmware.h                      |  82 ++++
>>>>  lib/test_firmware.c                           | 378 +++++++++++++++
>>>>  tools/testing/selftests/firmware/Makefile     |   2 +-
>>>>  tools/testing/selftests/firmware/config       |   1 +
>>>>  tools/testing/selftests/firmware/fw_lib.sh    |   7 +
>>>>  .../selftests/firmware/fw_run_tests.sh        |   4 +
>>>>  tools/testing/selftests/firmware/fw_upload.sh | 214 +++++++++
>>>>  20 files changed, 1900 insertions(+), 486 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
>>>>  create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
>>>>  create mode 100644 drivers/base/firmware_loader/sysfs.c
>>>>  create mode 100644 drivers/base/firmware_loader/sysfs.h
>>>>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.c
>>>>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.h
>>>>  create mode 100755 tools/testing/selftests/firmware/fw_upload.sh
>>>>
>>>> -- 
>>>> 2.25.1

