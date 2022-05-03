Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F318519272
	for <lists+linux-fpga@lfdr.de>; Wed,  4 May 2022 01:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiECXv2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 May 2022 19:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiECXv1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 May 2022 19:51:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F7B42ECD;
        Tue,  3 May 2022 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651621672; x=1683157672;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZZvASo2PdgbUTVU2zmPNhbt02LsTec4wb1cyK4VTls=;
  b=MCb09OOFYuS6XVhW86TL8lUo06L5i5nmGwh4d5g6oCGof/9dCct92nUE
   KZZt6/eLEVGjiwzxu4X4w78Akorh9WQ1/LjMpdeIk3arenmQM0dybRqea
   43ytV5AM+paJQ5P09rzkGbCrZTBc3gSQjimW0WdU1aAfoDS8vK3AcVeLD
   kAl9umDMsSrflimK1XoN85r24LinumDNd/xZeLv2OAuVq+ZTunBX/B7XA
   gISNSDhVczFse7Zqbnbxf7+VNDlNoSVUakElcxgj+ZP9ah2eKkrs2bUAF
   LSf9IQ4p53RFvZsnNtDFauRvICsam6cUAg8UBvMrAlwj8NaXbgIa3rQmJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="328163479"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="328163479"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 16:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="692766648"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2022 16:47:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 16:47:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 3 May 2022 16:47:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 3 May 2022 16:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUUoSYC0xXBhmXBtCyIlKXYuGLmJui4gmDRoDgP7z2EMWusqhn4Ta8lJV93sBJcmEZaM3F56BE3dlV6SkFrAzr7cYVKp1O5Dlm8e7HaC8WJYRG/snrUDVFO7FitUaEU0sWCUrhhFA2tEPI4TsroxRBBLpSPOcVmD1U3BFtup0YzWvjO0vnkVVELQuEe1EXqv+E3aKuXy273mLAj/IA6eWH1PxqDo28pYYQjBDcTjsPkS77drr2NtapIrwwZiaeIh3y+iRsQVUAeuRj05GDvPU0j4SO35FMFBTJsopodgS3TbZFeTIBub+ZdSzsV+jCA8nn851AIUuTjalknQ1xjjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKHZcrPawKkYtUe86yhpmAhFSGyrAnrZ4YB8LOZQE+0=;
 b=JsVL6nv74vT29aLlI8OLpcITUDmoKlCdC1lWAkJlAgQjstyGZy67yk92uKx6+yvcgNK38F6hW/TqbP6bB/BoWKMGf4sy5vnH2x0pmPjB1a21aoHVezSWfiJ6+G7M2r4y/Qa4Mnx8kkTMnB0YRtunVUpvTFlzNAVz3fXLCG6vCYOYCCOOdDBpwbKONjJhwWYuKE34CnIcdfTo5HbRmJaZM5wPrYKt1t2BHnnNHDAG6cPCJ/f5eIJSzslEEOdALgnhMHvjuJKJxQ/Wk6VvLUmD61DLqq5D04yAvUBBwW5OPfT8mgRBcIN8/ej2set/EAToSy526rygjdjJzUuJJz4dAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 3 May
 2022 23:47:47 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5186.028; Tue, 3 May 2022
 23:47:47 +0000
Message-ID: <f17267a1-f503-366b-9b58-bce2e9d0c908@intel.com>
Date:   Tue, 3 May 2022 16:47:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
From:   Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v17 2/5] fpga: cardbmc-sec: create bmc secure update
 driver
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220428233732.189425-1-russell.h.weight@intel.com>
 <20220428233732.189425-3-russell.h.weight@intel.com>
 <20220430165137.GC398931@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <20220430165137.GC398931@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30f695f-7cf5-4714-0ca3-08da2d5f5384
X-MS-TrafficTypeDiagnostic: MN0PR11MB6301:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN0PR11MB63010CCE85864EAF7B42F578C5C09@MN0PR11MB6301.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuFNDiMEESJ68axtErYYuQwabfmuoZ5N3DJBW2qQ5Pt6j4CYsxl5MOC8d4uXDnWA5jGgsVTTELsuyncBZUAY9i0YxpjGlF/MGf8Vp+DqRV60YFl67RwhXsWE8c9nKr/qLQmCXV/fmXa0csMAvS0NSBYjaZNOTys1NsUxRjZdcSCctStO+EhsB3Scot+UGK9T9wZPtcuqrIvqlPRIm7S6dNUWhGxNb2RTck3qw4WhulA6oxMDaPFNzj/mRS9PMaliBThl75BnD0f5fUqdFPfQnQfjN6w9D0IAf9akEXm7PGsjfsNIqjjFkd5+cDSejhI7M9YSwO5TSBrZ6IVcl1BpZGZocrV5IQ0eo4JLcdV0IJdnGe3sYrGSBp/qOR0KDMSA6J43a9IxUFU8sq094hD5ZZKAdDb7R+bgTzBizv15MvJwYu+b/ShnplZ2E42uEyOj274ribAhQNDP96rINLVe+rEa55r/IJ73lIacQ4/iuKB9mL8Y+7Bw16gO3ptyAwsrqOjhvClOzCPvCMpE/8WzUUNOORj8zN5yTzcqv4EkbiUVSPwJ1u4JaffltJNnUef1NO0xiSo68C9j1AYN0phmhWO/5ZHu/SlDwpTDVNw42HNftZg0UsTntJpdM0/1cWY+yZCNNNrtlswwX+7qF2Gm6/1DuTlKL5WQC0swTWD9AWaIq2F1+08hYKdDOvKdgZe6AebDQgL9m2+CEjODiN3au8j3LcfWpFHDc/04iS2BMJfXZHliyD+MUyyAVJBSmgHn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(86362001)(66476007)(66556008)(66946007)(6862004)(31696002)(15650500001)(2906002)(36756003)(4326008)(8676002)(6636002)(82960400001)(6666004)(316002)(8936002)(30864003)(5660300002)(38100700002)(2616005)(508600001)(37006003)(26005)(83380400001)(186003)(6506007)(6486002)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1hWDQvbE4zdXpWUmMycUlsenk0SVNvVXRMSG45SmpuTW80OGI3L1MrNkhV?=
 =?utf-8?B?L2xMQ0phQ0xWdVlNZWJhcFkwOU84YjJwSXF1VEJkQ0VQYVVtVE1DeE1BTENQ?=
 =?utf-8?B?d1d1dzNkVnZzWDh3T2JBWHFxNis0anFSL1YyL2txeVl0d1ZGbnd6amVNMitj?=
 =?utf-8?B?aTBCUDROc2RsWXNiWVcrY2NaRng1SmtEVW54UVJ1eDBtNHlBZENRQkh1eUVz?=
 =?utf-8?B?T0RNTmt5SURHaWVMZzgzNVI5aW9kNDczTjZHUFdORStOL1JVWGkybG1EYytU?=
 =?utf-8?B?SkFlUUxDTnJiYmZBc2pvQzJJTVc3SS9kMXB5WUJIellQU05TUVYxWXVwR1NW?=
 =?utf-8?B?d2NoRi9BVHAzTTR6V0RWR1phOGhuaEhCRU9QdTN0c3FHQVg3M05USlM4K2tG?=
 =?utf-8?B?RVFjRHpPOUtXSFBBUG93MVJxUFd1SXkyN1NrZWl0WDdtZWpOVGVBTEZJYUNw?=
 =?utf-8?B?alNRUk9rVlJIa1dZNWt3QUIvTGNnOHBmQnZlclptbzdOOFVjTklqeS9xNm56?=
 =?utf-8?B?VlZ3Uk85cUN3ZFR1QlFqNy9UWEJNdHNpczVVRDhnSW5NaHUrZmFHQXpvZGtL?=
 =?utf-8?B?ZFJ2T2dYM1FaK3ZKSU1vdHduOXVkT2JsUE1iaHZoU01Nb2lpb2NMajZIM0ZT?=
 =?utf-8?B?Y1FmcEFTWXA0OEVvV2JKbTB0eUhHS3hrUXhhcUtpWEw3L1NUSUFhWkppTHJO?=
 =?utf-8?B?OVRxbW9sV1pDTXp4RXh4dTh6eWVUMUVJYUJVYUVyRzNFY2lra0gvMDNCaGl4?=
 =?utf-8?B?VE8yL2I5eXkramNiWDNBek9PN0owRk11STJXWFdYZU1TY3k3b1lDd3J1emZ1?=
 =?utf-8?B?aG1Cc1FhUldQSkhHT2VBRWlkOWk4bkRMRVMyZCtnNXN4Y2NkSWNIU2tpejQ1?=
 =?utf-8?B?ODVESnVkQTRPVXUzNm9GekthS1MxbUNuUFdKUFpURGpxN0tRdFFjVzNOSXRy?=
 =?utf-8?B?NThFYXZJdTBienM2SkJqL1pDVXFUM2pxcmh0dnpZMk05YzdXR3YxOTQrL3ht?=
 =?utf-8?B?Ykoybk1JV0dPc01IYmxlQ2ovc3BLUFljaSszRnZjL3laTTViOVZpZmE2RUQr?=
 =?utf-8?B?THpuU3lxWmJocTM4YjJiQ2RSUGtXejl0MXI3dmJ1K2RnSlg4cmNvbUoyL2dn?=
 =?utf-8?B?V2RYdDRRazY4K0plYjk5UmdLT3FjTEpVUXVZaWlQblorcjVsZEhlUkRWSEhO?=
 =?utf-8?B?amtNMVBJbVFPcnI5NlhlUHNHd3ZtNFRjTkh0SEt4cXJwK29uR1EwVnBPL24y?=
 =?utf-8?B?OU1kTE9qclpqQzN1MHZnaHJ4THNNQVlMZGduYnVKK0tOMlliZFBaMTNsSVN0?=
 =?utf-8?B?MTdIdmF4NnAwTXRnSWVta3YyRHV0SnVMYjNvbEJuMjNnYmJaOVhXZHR2SlJS?=
 =?utf-8?B?SnZ1cUJlSWVqZ2hqTlMxeWZLaUpTNmJuWUhVdy9IMU80dHhncFhWYlkwT3BX?=
 =?utf-8?B?ZEwwR012dkVJVzBxTXRlTm5pcGM2S2NNVloxR3paRGllVlVZMi9QOG5CS1Uy?=
 =?utf-8?B?ZStqdEp2MHNiUTNJZmhjaElWbWtjbUxONlQ5ZC9wbzkycEJvSHEzRjB3dUp6?=
 =?utf-8?B?bHVHMU5Ma1JtazEwZE8zSEJDTTFJL3lidlpUUXBHd3M0dnl2VUlDazk3VFhl?=
 =?utf-8?B?eGdtWlRLSGdTUjRkSEJLVzNGNEFneFU2K3VDZVExd1B6MEtmKzhMLzF6bnYz?=
 =?utf-8?B?cW91MlllRU5VT3FBYUJZWWJSOVQzSXQ0RXhQK3JkaUsySTFQYXFXbGhoak9r?=
 =?utf-8?B?NUdFbmVpNDRNUGNpSDVYUmRFYkNEK2NvZmU2Y3dpZWlPcGFQZ2ZaSUN3b0JO?=
 =?utf-8?B?Q0VsSGVyOGRTa3h3TFRSMStNWkZKYk01NTVLd21NY0REMzNVUHppK290eEFK?=
 =?utf-8?B?Q043b0NVY1ZldUNNaU5LNkNVblNVbnB3RDd2UkMzVG5ibHdMZUxiU2ExTEx0?=
 =?utf-8?B?ckhOVUJFcisxeXlPc0pHUHdxSFZHcllHNG14Z0J0c09PMzhhWHQ5SytEVzdT?=
 =?utf-8?B?RDNSSkZ5ZUtWWU5BRGV4OFlCR3lONzZSN1BmZHNiOEJZZDdXRE50TFErUnBO?=
 =?utf-8?B?VzFHMndEaGtNSWhrSUpZdnMxSFBnYytKRU1FUkorMlFkUkFMRHNWSUZkYU5M?=
 =?utf-8?B?a3prWE9vYmw2ZmtsVTNjR3hwRjhqcnl0djFrTWRjUGp3Q0ZaVWJVL1VFVlFl?=
 =?utf-8?B?U1VBa0tTVVpiZk1Nb09LazhpYTVuWFRldHVZM0JjbDlwZ0hrQkdKK0tycEND?=
 =?utf-8?B?aGUwenVHUjdGa3ZvbDdhdStGY1kvcDRJbnZhL0FXc3FvVkQrb3k2bmdZRXA5?=
 =?utf-8?B?R3lFekw5YlkvUWREcTlkTkhDaG83c1c1Vm1oZGVKR3NKb1FzS25kSTA3NFM5?=
 =?utf-8?Q?IEAndoulnph1u9wg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d30f695f-7cf5-4714-0ca3-08da2d5f5384
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 23:47:47.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn/Pi7S7aCROXBlhzpbcTYSneKQ7c3vmqcB1E5ow+SRKv+lfioxBGgsx2qVVdQ8h9f547XsJm2y1l2NJCj8whfhRS/qZR6pvTtrIBJMGDAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 4/30/22 09:51, Xu Yilun wrote:
> On Thu, Apr 28, 2022 at 04:37:29PM -0700, Russ Weight wrote:
>> Create a sub driver for the FPGA Card BMC in order to support secure
>> updates.  This sub-driver uses the Firmware Upload support of the
>> Firmware Loader subsystem to transfer the image data to the device.
>>
>> This patch creates the FPGA Card BMC Secure Update driver and provides
>> sysfs files for displaying the current root entry hashes for the FPGA
>> static region, the FPGA PR region, and the card BMC.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>> v17:
>>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>>     and 5.19 respectively.
>>   - Updated the copyright end-date to 2022 for the secure update driver.
>>   - Change m10bmc to cardbmc to reflect the fact that the future devices
>>     will not necessarily use the MAX10. This affects filenames, configs, and
>>     symbol names.
>>   - Removed references to the FPGA Image Load class driver and replaced
>>     them with the new firmware-upload service from the firmware loader.
>>   - Firmware upload requires a unique name for the firmware device. Use
>>     xarray_alloc to generate a unique number to append to the name.
>>   - Changed the license from GPL to GPLv2 per commit bf7fbeeae6db: 'module:
>>     Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity'
>> v16:
>>   - No Change
>> v15:
>>   - Updated the Dates and KernelVersions in the ABI documentation
>>   - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
>>   - Change CONFIG_FPGA_M10_BMC_SECURE to CONFIG_FPGA_M10_BMC_SEC_UPDATE.
>>   - Change instances of *bmc-secure to *bmc-sec-update in file name
>>     and symbol names.
>>   - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
>>     names.
>>   - Change instances of *lops* to *ops* in symbol names.
>> v14:
>>   - Changed symbol and text references to reflect the renaming of the
>>     Security Manager Class driver to FPGA Image Load.
>> v13:
>>   - Updated copyright to 2021
>>   - Updated ABI documentation date and kernel version
>>   - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>>     functions instead of devm_fpga_sec_mgr_create() and
>>     devm_fpga_sec_mgr_register().
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - Added Reviewed-by tag
>> v10:
>>   - Changed the path expressions in the sysfs documentation to
>>     replace the n3000 reference with something more generic to
>>     accomodate other devices that use the same driver.
>> v9:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - Previously patch 2/6, otherwise no change
>> v7:
>>   - Updated Date and KernelVersion in ABI documentation
>> v6:
>>   - Added WARN_ON() call for (sha_num_bytes / stride) to assert
>>     that the proper count is passed to regmap_bulk_read().
>> v5:
>>   - No change
>> v4:
>>   - Moved sysfs files for displaying the root entry hashes (REH)
>>     from the FPGA Security Manager class driver to here. The
>>     m10bmc_reh() and m10bmc_reh_size() functions are removed and
>>     the functionality from these functions is moved into a
>>     show_root_entry_hash() function for displaying the REHs.
>>   - Added ABI documentation for the new sysfs entries:
>>     sysfs-driver-intel-m10-bmc-secure
>>   - Updated the MAINTAINERS file to add the new ABI documentation
>>     file: sysfs-driver-intel-m10-bmc-secure
>>   - Removed unnecessary ret variable from m10bmc_secure_probe()
>>   - Incorporated new devm_fpga_sec_mgr_register() function into
>>     m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>>     function.
>> v3:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>>     Update driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed "_root_entry_hash" to "_reh", with a comment explaining
>>     what reh is.
>> v2:
>>   - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>>   - Switched to GENMASK(31, 16) for a couple of mask definitions.
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>>   - Replaced small function-creation macros with explicit function
>>     declarations.
>>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>>     the single call to ifpga_sec_mgr_register() into two function
>>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
>> ---
>>  .../sysfs-driver-intel-cardbmc-sec-update     |  29 +++
>>  MAINTAINERS                                   |   7 +
>>  drivers/fpga/Kconfig                          |  12 ++
>>  drivers/fpga/Makefile                         |   3 +
>>  drivers/fpga/intel-cardbmc-sec-update.c       | 167 ++++++++++++++++++
>>  5 files changed, 218 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
>>  create mode 100644 drivers/fpga/intel-cardbmc-sec-update.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
>> new file mode 100644
>> index 000000000000..c032fbe59614
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
>> @@ -0,0 +1,29 @@
>> +What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/sr_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the static
>> +		region if one is programmed, else it returns the
>> +		string: "hash not programmed".  This file is only
>> +		visible if the underlying device supports it.
>> +		Format: "0x%x".
> Should the format be "string'? I always see the hash value is a hexadecimal
> string without "0x" prefix. So why you want to output it like a large
> hex number?

Yes - string makes more sense, especially since we sometimes return "hash not
programmed. I'll remove the '0x' and specify a string output.

>> +
>> +What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/pr_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the partial
>> +		reconfiguration region if one is programmed, else it
>> +		returns the string: "hash not programmed".  This file
>> +		is only visible if the underlying device supports it.
>> +		Format: "0x%x".
> Same concern.
>
>> +
>> +What:		/sys/bus/platform/drivers/intel-cardbmc-sec-update/.../security/bmc_root_entry_hash
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the BMC image
>> +		if one is programmed, else it returns the string:
>> +		"hash not programmed".  This file is only visible if the
>> +		underlying device supports it.
>> +		Format: "0x%x".
> Same.
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 61d9f114c37f..43feaaa25352 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7725,6 +7725,13 @@ F:	Documentation/fpga/
>>  F:	drivers/fpga/
>>  F:	include/linux/fpga/
>>  
>> +FPGA BMC INTEL SECURE UPDATES
>> +M:	Russ Weight <russell.h.weight@intel.com>
>> +L:	linux-fpga@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-driver-intel-cardbmc-sec-update
>> +F:	drivers/fpga/intel-cardbmc-sec-update.c
>> +
>>  FPU EMULATOR
>>  M:	Bill Metzenthen <billm@melbpc.org.au>
>>  S:	Maintained
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 991b3f361ec9..346889e3096a 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -243,4 +243,16 @@ config FPGA_MGR_VERSAL_FPGA
>>  	  configure the programmable logic(PL).
>>  
>>  	  To compile this as a module, choose M here.
>> +
>> +config FPGA_CARDBMC_SEC_UPDATE
> INTEL_FPGA_CARDBMC_SEC_UPDATE ?
Yes - I can make this change.
>
>> +	tristate "Intel FPGA Card BMC Secure Update driver"
>> +	depends on MFD_INTEL_M10_BMC && FW_UPLOAD
> You mentioned that the driver supports devices which may not use max10,
> so is it possible to remove the depends on MFD_INTEL_M10_BMC?
At this point, the only driver that will use this sub-driver is the
MAX10 BMC driver, so we can't remove this dependency. It was not my
intention to completely eliminate the "MAX10 BMC" terminology from
the upstream kernel at this time - I am just trying not to perpetuate
the naming.

The basic issue is that the current MAX10 BMC driver also works for the
Cyclone10 implementation of the BMC, so including "MAX10" in the name is
not strictly correct. Do you recommend that we change the MAX10 BMC
driver and config names now? Or is it sufficient to avoid adding new
unnecessary references to max10?

>
> Some more stuff related to max10 in this patch.
>
>> +	help
>> +	  Secure update support for the Intel FPGA board management
>> +	  controller.
>> +
>> +	  This is a subdriver of the Intel MAX10 board management controller
> And the same concern here.
Unless we rename the upstream MAX10 driver, this description is still accurate.

>
>> +	  (BMC) and provides support for secure updates for the BMC image,
>> +	  the FPGA image, the Root Entry Hashes, etc.
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 0bff783d1b61..daf427393ba9 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>  
>> +# FPGA Secure Update Drivers
>> +obj-$(CONFIG_FPGA_CARDBMC_SEC_UPDATE)	+= intel-cardbmc-sec-update.o
> CONFIG_INTEL_FPGA_CARDBMC_SEC_UPDATE ?
yes
>
>> +
>>  # FPGA Bridge Drivers
>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>> diff --git a/drivers/fpga/intel-cardbmc-sec-update.c b/drivers/fpga/intel-cardbmc-sec-update.c
>> new file mode 100644
>> index 000000000000..ba3559f3335d
>> --- /dev/null
>> +++ b/drivers/fpga/intel-cardbmc-sec-update.c
>> @@ -0,0 +1,167 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel Max10 Board Management Controller Secure Update Driver
> Maybe replace Max10 with other description?
Yes - I'll go through the file more carefully and eliminate unnecessary
MAX10 references.
>
>> + *
>> + * Copyright (C) 2019-2022 Intel Corporation. All rights reserved.
>> + *
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/firmware.h>
>> +#include <linux/mfd/intel-m10-bmc.h>
> Try to remove this head file if you want to support devices not on max10
Please see my comments above. We depend on the MAX10 BMC driver. We can
rename it now if you think it is necessary - or we can continue to
reference it as is.

>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +struct bmc_sec {
>> +	struct device *dev;
>> +	struct intel_m10bmc *m10bmc;
> The same concern.
We can't change this structure name without changing the upstream MAX10 driver.

>
>> +	struct fw_upload *fwl;
>> +	char *fw_name;
>> +	u32 fw_name_id;
>> +};
>> +
>> +static DEFINE_XARRAY_ALLOC(fw_upload_xa);
>> +
>> +/* Root Entry Hash (REH) support */
>> +#define REH_SHA256_SIZE		32
>> +#define REH_SHA384_SIZE		48
>> +#define REH_MAGIC		GENMASK(15, 0)
>> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
>> +
>> +static ssize_t
>> +show_root_entry_hash(struct device *dev, u32 exp_magic,
>> +		     u32 prog_addr, u32 reh_addr, char *buf)
>> +{
>> +	struct bmc_sec *sec = dev_get_drvdata(dev);
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	int sha_num_bytes, i, cnt, ret;
>> +	u8 hash[REH_SHA384_SIZE];
>> +	u32 magic;
>> +
>> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(dev, "%s magic 0x%08x\n", __func__, magic);
> Remove the dev_dbg.
Yes - I'll remove it
>
>> +
>> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
>> +		return sysfs_emit(buf, "hash not programmed\n");
>> +
>> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
>> +	if (sha_num_bytes != REH_SHA256_SIZE &&
>> +	    sha_num_bytes != REH_SHA384_SIZE)   {
>> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>> +			sha_num_bytes);
>> +		return -EINVAL;
>> +	}
>> +
>> +	WARN_ON(sha_num_bytes % stride);
> Why warn on this condition? I assume with this warning user cannot get
> enough sha data, so is the output still useful?
The sha_num_bytes() variable is expected to be a multiple of stride. The
WARN_ON is intended to enforce that.
>
>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
>> +			       hash, sha_num_bytes / stride);
>> +	if (ret) {
>> +		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
>> +			reh_addr, sha_num_bytes / stride, ret);
>> +		return ret;
>> +	}
>> +
>> +	cnt = sprintf(buf, "0x");
> Why add the 0x prefix on hash value output?
I have eliminated it.
>
>> +	for (i = 0; i < sha_num_bytes; i++)
>> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
>> +	cnt += sprintf(buf + cnt, "\n");
>> +
>> +	return cnt;
>> +}
>> +
>> +#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
>> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
>> +					    struct device_attribute *attr, \
>> +					    char *buf) \
>> +{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
>> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
>> +
>> +DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>> +
>> +static struct attribute *bmc_security_attrs[] = {
>> +	&dev_attr_bmc_root_entry_hash.attr,
>> +	&dev_attr_sr_root_entry_hash.attr,
>> +	&dev_attr_pr_root_entry_hash.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group bmc_security_attr_group = {
>> +	.name = "security",
>> +	.attrs = bmc_security_attrs,
>> +};
>> +
>> +static const struct attribute_group *bmc_sec_attr_groups[] = {
>> +	&bmc_security_attr_group,
>> +	NULL,
>> +};
>> +
>> +static const struct fw_upload_ops cardbmc_ops = { };
> I think if you are not ready to introduce fw upload functionality in
> this patch, don't add any related stuff here.
Sure - I'll defer this until a later patch.
>
>> +
>> +#define SEC_UPDATE_LEN_MAX 32
>> +static int bmc_sec_probe(struct platform_device *pdev)
>> +{
>> +	char buf[SEC_UPDATE_LEN_MAX];
>> +	struct bmc_sec *sec;
>> +	struct fw_upload *fwl;
>> +	unsigned int len, ret;
>> +
>> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>> +	if (!sec)
>> +		return -ENOMEM;
>> +
>> +	sec->dev = &pdev->dev;
>> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>> +	dev_set_drvdata(&pdev->dev, sec);
>> +
>> +	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
>> +		       xa_limit_32b, GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>> +			sec->fw_name_id);
>> +	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
>> +
>> +	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>> +				       &cardbmc_ops, sec);
>> +	if (IS_ERR(fwl)) {
>> +		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
>> +		kfree(sec->fw_name);
>> +		xa_erase(&fw_upload_xa, sec->fw_name_id);
>> +		return PTR_ERR(fwl);
>> +	}
>> +
>> +	sec->fwl = fwl;
>> +	return 0;
>> +}
>> +
>> +static int bmc_sec_remove(struct platform_device *pdev)
>> +{
>> +	struct bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>> +
>> +	firmware_upload_unregister(sec->fwl);
>> +	kfree(sec->fw_name);
>> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver intel_cardbmc_sec_driver = {
>> +	.probe = bmc_sec_probe,
>> +	.remove = bmc_sec_remove,
>> +	.driver = {
>> +		.name = "n3000bmc-sec-update",
> If you expect the driver to support devices not just on n3000 max10 bmc,
> using .id_table is better.
Later patches which add support for new devices will add the .id_table.
At your recommendation, I change this patch to use .id_table now.
>
>> +		.dev_groups = bmc_sec_attr_groups,
>> +	},
>> +};
>> +module_platform_driver(intel_cardbmc_sec_driver);
>> +
>> +MODULE_ALIAS("platform:n3000bmc-sec-update");
> using MODULE_DEVICE_TABLE is better?
OK
>
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
> Please keep the naming consistent.
Yes - I'll go back through the MAX10 references

Thanks,
- Russ
>
> Thanks,
> Yilun
>
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1

