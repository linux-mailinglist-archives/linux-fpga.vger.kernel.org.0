Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315152A7BC
	for <lists+linux-fpga@lfdr.de>; Tue, 17 May 2022 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiEQQRB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 May 2022 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiEQQQ7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 May 2022 12:16:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B77639BAF;
        Tue, 17 May 2022 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652804218; x=1684340218;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vy+srwUL4XHlZnfqTrKMZGcnbLAFyAwo4zj2B78pILM=;
  b=bLWObWQZadoac0BpUAFoY2FnRl4/7k7m0X2HvhjwS7fHIgXIYYd9KMCy
   2sqWj+SCrYr/jXeX6OzSqH3XLFU5gQK0Tug4zw01q5ZDckhNbZ9OXYoXm
   lW3S7fdgiFawkMEv2gVbGuMwPiCXYA/0Ms+EZ7R/V9JaEG2JH+CiQ43uS
   pNIlhg8i373R6ZEmH/IjBhhkG+xOIppBHsSSdA5GDnmkYcNPoDlojAASc
   RCe58zgDgoCPms4QMw9lJL+OiS0CM2P9TP0vk5+8I4x8GfbgySfQyVTBW
   Lidy7FfNSK5aZGHvxcgH6iezdzQO8GlfyEL3SQ+j3Q6IFwNStN7OoCEoh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270058313"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270058313"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="544975636"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2022 09:16:58 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:16:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 09:16:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 09:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdbHsUcRRCeKUkTEg9a2BgosEWMsWhukdF/78KIbOmQS8m+xfdbxrnXItSjKAsHFiOSc2s66v03z8WL3ID/CNitI4w3GhYFEPVZ47JMRGDIM1aJnQaZ1vFJGs2tmJR43Ma6RgZBp360qPLoZuDxueuHlTWuMVWH092dZJuhhNKO85KEcRwrzmi29FwriOkhmENZxUoeLulmO+G2jE+NTgL/cuvHXsuUl1YCbCb1d7yGMa7FWCvpfIHO6IJV8uTduxZWxrHKaW4uWFnnRdFwMeclBEB06rs7qrfhWqWn3xVwEi+2ZT9mTaRJrwdD/+Auq7hdDnlAKkjCJCUp6c3Cd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLaogtXdrLF83eYfx+mheyTkp79gizky86vHeDu/wYw=;
 b=VfxBc2SBRZanLN4fTf8B8iBFAtpRLLBN1FzZDWoot04fReKiRq6HFUOIj4Ktu9ph1XfFxfQ+z3QMN4GbefpHcPkxVWQ5manDzAMY5vIHhOBuSk5d5BAKbix2DOHrrwRPVNFscm6tTLxeLBp2Ncabm4+10UcPHDGFIFqOOikKgLbTvMvDlmRfWoVf9ACs0klVy63p0w4qDNSQOCeZzLKN8KJrnUpWyF2t3wsDdwjmsEJIg7MX9aItk5RMn7uYLRG/Q87jShfalic94HygS3x0avQlhpGPMLvYDSb1Pu92mKfZw8tpqJ6+yGfPyj8cBGxT2KUTQnEdLi8ypN91XqdLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 16:16:54 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:16:54 +0000
Message-ID: <8fb5dea0-9ce6-a17c-1253-64a43c86c82c@intel.com>
Date:   Tue, 17 May 2022 09:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v20 3/5] fpga: m10bmc-sec: expose max10 flash update count
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <lee.jones@linaro.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <marpagan@redhat.com>, <lgoncalv@redhat.com>,
        <matthew.gerlach@linux.intel.com>,
        <basheer.ahmed.muddebihal@intel.com>, <tianfei.zhang@intel.com>
References: <20220516234941.592886-1-russell.h.weight@intel.com>
 <20220516234941.592886-4-russell.h.weight@intel.com>
 <20220517041310.GA40711@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220517041310.GA40711@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 924fd454-e764-4fc2-5d11-08da3820a884
X-MS-TrafficTypeDiagnostic: BYAPR11MB2824:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB28246FAE5128240AE3F1C48FC5CE9@BYAPR11MB2824.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vpVf9V4Spww+BvKLJltFZ6VuolpBemZFaa87T0Yh/IL3bLhObMjQ5kyyVk0935v/ZG76/WRyrZGTi1O3WCCgUNC22EdfPjD8ItTgITe8I/oo6FLq5+IWOEVPSdrZOm+hmjQ0n4JRNlVR80q8gUHBKTk+UkqXsr71dPQDQN/GgnRl1rpm1BWT0hr5npG6N86ezovX662af2SupPBvXxXpWBvMIJlTb3aDcN7uinVreX3pCkXzHN2v9uaPNnHX7Lvq7N7MUobImXhvMYb9MByioxSczvOzD/sdskJgbSxWQT4HldztRLRvI5irmeglah0vVKbx3+pbty067i1qcS7lxI7IJQMyzY81QBvrkxiLmGpEIwy9BoSHbn+LYgznDJc+2ZUF/KkFhE/8DBaCBArT1fVObRqTFmVUPCFgqRnBIj/Rbv/JC3dJP/xWWQp0DXEfDOXcX9D5XsB4OlBR3Rhf3WQWUWgEyFssIBjT9iEVIfDWP/rNZWmXtigt0DAPozFVgrYcIi2UluuT46ZKV77i5S4IlINihQJKzNWIDUrv5Wqj20tvHV2ruo6fdKgjP+PRtjmroQi9P8v0aBzdvfiipTaALI4IW7hW6DGoKsK0+en1oGf3ue1LG5uq8QSEF+S/J3EwVdLzWGLDHUGIhVsLVxMR6DIKg0Pv/TwN140vwDIdCOZrB5t5RvwJMBi6SOAGp4OABYQYxx8hZg9A4pN4dCujc++cEHIr3zzzryH71g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(316002)(6666004)(15650500001)(6862004)(8676002)(83380400001)(6636002)(186003)(66556008)(66476007)(5660300002)(4326008)(37006003)(82960400001)(66946007)(86362001)(6506007)(36756003)(31686004)(8936002)(6486002)(2616005)(508600001)(53546011)(2906002)(26005)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnA3ek5yNWcwYklRODFnRkw1V3RnblVBd1dSd3QwVGtBTWVEMVVFYm1WWmhm?=
 =?utf-8?B?NlMxaWt3RGl1bkpoV3JQeEo1a1dRbHBJZHhOalkzS0dXYkdGbS90eHB3TGIy?=
 =?utf-8?B?eWV1aXBJbHpOMGxrMFN5YWs0WGdVZUtqVXBvZlRkNnlPK1pWUEZaZG9jaU9B?=
 =?utf-8?B?VVl5c3hhZjY2UVNSV3duRm0wTDJYTW9JRlZickUxNWNJa0lCeUMzKzBieHFC?=
 =?utf-8?B?VmFUeERML1pNdnJMRHNkNlJ1VnhsMmJnV3lMYkMyUWhERWo2M2Zrc2YrYVNF?=
 =?utf-8?B?dmI5TU1lWlZBWUhaT2VxUU0wakpvS2IxM0pjbExVWUlWekpjbHpHU1JMWTFa?=
 =?utf-8?B?Y0tlRnRkVG9FSHV4Mk4xREdyTzdEa2xtaDZtZkdXMEdweDlpK1NvZlRMUkZ2?=
 =?utf-8?B?NzNiSVU0eVlGekE1OE4wSm1lZDE4VUlPcVQybzIzUCtWWjdWTkU5eFBWSlNI?=
 =?utf-8?B?alRzZzF5NVRkMTI5bzRBb0JJOE5nd1BwMnR0d3FCNXZMeklSQ3hCcWxIVm5X?=
 =?utf-8?B?c250QnZJd1I2WUdOMVJxM1FQZ29EOEF6eHZZbjJ4T3dDOXhQY2ZtRWFCQi9S?=
 =?utf-8?B?TVVYT2xlajhTOTBYZkpwLzVMM00yYXVPZy9DR1BzdG5RYmdkc1lIeDJMRjdL?=
 =?utf-8?B?bkorSWRhYWUxbzNHb0R6VzFVemFaTWh1VVFuTkwxbzlwZ0VhV3VLYTRYS21N?=
 =?utf-8?B?OUIwL3RiVTZhWUpPdVdod0FLWUY3ZHRLWXgzM1c5bjIyK2UrRzNyeVpzM2J1?=
 =?utf-8?B?WDRucGNkWjVxRXNXV0xjbWRMOUcrNFE4dXNXSEoyRDBBbzBGOW96M3Q1TFox?=
 =?utf-8?B?UU9xVmR2K1luaVdPbldGWitnTnV4aGVZN1gvQ2QvL2hsbFhJTllLbFloK1Fw?=
 =?utf-8?B?aXcxR1NwU1BaWnZUK1JUY2cyd1RmQ3V0KzNkT1JxOWg1YkZiNWdnZ1BlZ1dK?=
 =?utf-8?B?aHdtZlRQNEhReTBlckkxK0xDaFhjZGZMTkx4RjVhNWE1MTVhVVhQdzdRdC9v?=
 =?utf-8?B?WDBBZEI4MHdtVVZFUFFxUUdMTWFtR1M1TTJOSVdycmhyQ3ZRYzl4UExHWDlL?=
 =?utf-8?B?akdoNVdRbzY3c3BaOVE3elRPOVVKY0treGVFQ0lON3NZc1pPTEsyZkNBNWN3?=
 =?utf-8?B?RU5PTHlVazJFYzQwcFhDdGRRSWIzY0NrN2s1c21nVWRoc2VpbDVuQmRrSFBR?=
 =?utf-8?B?MEhjYzVFVTBDbk42MjFkNkZuYTUwb1RhMjc5aTNlVWtFbndXcHFDY3h5MC9s?=
 =?utf-8?B?dGhrd1lIYU9ZZG04K0Q0RjBRSTZlSE9Lb3BBWXJOL2RjU250d3RGa2NpWkt2?=
 =?utf-8?B?eWN4emtxam9PTWEwQXp6bG5lWjM4dDE5ODQ5Q0w0TlJOeEdTWFhUTVBxZmxo?=
 =?utf-8?B?T0h6WWhqZlFkL3BaM2dseDJTREtOY2ZjRllwVzFqVTRqdDRxOGo0aHFGT3JS?=
 =?utf-8?B?T3VPQ2l0dXFjQkk5a3krUkh0MmNYYTlRVm1McDI0Zng4WUxLM0Qxa3pPejJO?=
 =?utf-8?B?TEdOOW9XVFQ3VGFFamtHOXUwWCt4UStFVXBMK3o4REMwcDlXMHZocHgwM3pP?=
 =?utf-8?B?cWJLai9IRXhhMTF5OHBLVk9VMVRROXJnbktIa2JCY3dZU3FrM0dNVzd0aFZM?=
 =?utf-8?B?QW5MM0JpOUpNbXBic3dPWnNCZFVESnBuc2pyeU5PZkxObWdDZU1iOEk3ckhM?=
 =?utf-8?B?NlY5WDI5eUMrWXdOMExSdC9ENmZmSitCUXZFc1hzZU1wdVJaVHVNZmJjSlhF?=
 =?utf-8?B?d0t1bjVBODZ3TmRXNncvcHJuU0YreWRBWldPK2xTelpiZEtLSzZScnlVcEpu?=
 =?utf-8?B?ZlJaLzFDOUNQeGxoM2RGRXpWejZpQXhjaEpLT2NFRlM0NUdOWEtBWnZZNmhR?=
 =?utf-8?B?MlU4Nkc2TEpKL1REbnc1dmxid0RQK1hGd0VxdW1YTFB3Zk9ZNEFIYXRGek5N?=
 =?utf-8?B?WllaYSs0Z3hHNTdXRXZBWWJlSjI1UVdJZWl1VUtTc1Q2bHpyTHc2QmJyWkFQ?=
 =?utf-8?B?TDNxd25PSjZuVk5lTWI4OWVML1VwZ2lqcjdsL0h6cFVOODVWRG00VjRybGF0?=
 =?utf-8?B?Yk1ZWjdSMjhSVmZ4Q2U1UHViQkZxOVBqRUNJMkhLYXo5MTVZL3BEZW85c2xQ?=
 =?utf-8?B?cDNCMmJncm1UTC9qdmoveVdGbVZnVE92bDF6K29zOVUzaWtPU1JoczhJM2FN?=
 =?utf-8?B?QUs3bldaNlVrS2F2UkZGdkVEWlpYcW1WZVdmcE1WNmtEenJaOEExdXd1ZFN5?=
 =?utf-8?B?RVp4WDZTOHE5Zms3MFB5TUJ5SmVzNmU2WVpUaE5rWFZ5S0xOQmFkUkJDWFlU?=
 =?utf-8?B?a0tGcDFVTXVqMlJ5SnE1STRXSnN1Z01tNnhUS1dJT2FkR0s0blpJTDVDdlpP?=
 =?utf-8?Q?yxilNO8CGwHgkKPY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 924fd454-e764-4fc2-5d11-08da3820a884
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:16:54.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kw14KzsBDNgsfOr3ZvkVGFEbai6tQIqRW9Hw3eiGk/q9Jk3ekfmWeZOuUL4AXSDgx2akb7ATsEixtGdp6Aguu4EMa/r03TUZwfJUMOAgeqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 5/16/22 21:13, Xu Yilun wrote:
> On Mon, May 16, 2022 at 04:49:39PM -0700, Russ Weight wrote:
>> Extend the MAX10 BMC Secure Update driver to provide a sysfs file to
>> expose the flash update count.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>> v20:
>>   - No change
>> v19:
>>   - Change "card bmc" naming back to "m10 bmc" naming to be consistent
>>     with the parent driver.
>> v18:
>>   - No change
>> v17:
>>   - Update the Date and KernelVersion for the ABI documentation to Jul 2022
>>     and 5.19 respectively.
>>   - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
>>     future devices will not necessarily use the MAX10.
>> v16:
>>   - No Change
>> v15:
>>   - Updated the Dates and KernelVersions in the ABI documentation
>> v14:
>>   - No change
>> v13:
>>   - Updated ABI documentation date and kernel version
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - No change
>> v10:
>>   - Changed the path expression in the sysfs documentation to
>>     replace the n3000 reference with something more generic to
>>     accomodate other devices that use the same driver.
>> v9:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - Previously patch 3/6, otherwise no change
>> v7:
>>   - Updated Date and KernelVersion in ABI documentation
>> v6:
>>   - Changed flash_count_show() parameter list to achieve
>>     reverse-christmas tree format.
>>   - Added WARN_ON() call for (FLASH_COUNT_SIZE / stride) to ensure
>>     that the proper count is passed to regmap_bulk_read().
>> v5:
>>   - Renamed sysfs node user_flash_count to flash_count and updated the
>>     sysfs documentation accordingly.
>> v4:
>>   - Moved the sysfs file for displaying the flash count from the
>>     FPGA Security Manager class driver to here. The
>>     m10bmc_user_flash_count() function is removed and the
>>     functionality is moved into a user_flash_count_show()
>>     function.
>>   - Added ABI documentation for the new sysfs entry
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>> v2:
>>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>>   - Minor code cleanup per review comments
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>> ---
>>  .../sysfs-driver-intel-m10-bmc-sec-update     |  8 +++++
>>  drivers/fpga/intel-m10-bmc-sec-update.c       | 36 +++++++++++++++++++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> index 2bb271695e14..1132e39b2125 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>> @@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
>>  		"hash not programmed".  This file is only visible if the
>>  		underlying device supports it.
>>  		Format: string.
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
>> +Date:		Jul 2022
>> +KernelVersion:	5.19
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns number of times the secure update
>> +		staging area has been flashed.
>> +		Format: "%u".
>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
>> index f9f39d2cfe5b..3f183202de3b 100644
>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>> @@ -78,7 +78,43 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>>  
>> +#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>> +
>> +static ssize_t flash_count_show(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>> +	unsigned int stride, num_bits;
>> +	u8 *flash_buf;
>> +	int cnt, ret;
>> +
>> +	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	num_bits = FLASH_COUNT_SIZE * 8;
>> +
>> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
>> +	if (!flash_buf)
>> +		return -ENOMEM;
>> +
>> +	WARN_ON(FLASH_COUNT_SIZE % stride);
> The same concern here. Stop users from getting the broken value.

Sure - I will change this.

I was using WARN_ON() because it indicates a problem in the device or
the driver itself. It is not really validating information from userspace.

As I understand it, WARN_ON() is used to log such events to the kernel
log. If this isn't an appropriate use of WARN_ON(), then when should I
consider using it?

Thanks,
- Russ
>
>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
>> +			       flash_buf, FLASH_COUNT_SIZE / stride);
>> +	if (ret) {
>> +		dev_err(sec->dev,
>> +			"failed to read flash count: %x cnt %x: %d\n",
>> +			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
>> +		goto exit_free;
>> +	}
>> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
>> +
>> +exit_free:
>> +	kfree(flash_buf);
>> +
>> +	return ret ? : sysfs_emit(buf, "%u\n", cnt);
>> +}
>> +static DEVICE_ATTR_RO(flash_count);
>> +
>>  static struct attribute *m10bmc_security_attrs[] = {
>> +	&dev_attr_flash_count.attr,
>>  	&dev_attr_bmc_root_entry_hash.attr,
>>  	&dev_attr_sr_root_entry_hash.attr,
>>  	&dev_attr_pr_root_entry_hash.attr,
>> -- 
>> 2.25.1

