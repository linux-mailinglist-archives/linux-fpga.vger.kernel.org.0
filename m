Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FCB4072A4
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Sep 2021 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhIJUmF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 16:42:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:63524 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhIJUmE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 16:42:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="218000337"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="218000337"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 13:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="470683307"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 10 Sep 2021 13:40:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 13:40:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 10 Sep 2021 13:40:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 10 Sep 2021 13:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt3TqcHkTBgaaCxwqXAsBswu0C+qYmJx4QYc6ycwacMuqS0MVXRbQ9g0MNJtxXaJ9E2dxPdXtqtr/DtD/xLO4nNIl3fDuS/X4/8Rk6vH/h/sBCz2bfeP7VnLFqNmSFM9xofe8p2P7hZBE1P15cdln1kMs9NvZMl3/DVARTOJHFAZ4Jx3b+PQMG+LHDuWMdnqrk0awvIB5ZJW9CiHrw6pQAGbsk4z2kqYnj+j7Y0bgrXIIRwDr+xCAT0YPdjZs6GCftVWUObMZXy8YuhKyk1NjxjmU8IdpBGrGfkr+qP9MEf/OEhaFDyuuRjhuaQcS0EHY5wCtKASZ/e1ei9Hve2FrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qhpbBJApErVZxQjlbe51p9jxOySGEIy94n2dkPyK90A=;
 b=dRt5orYw9cAGHqkL35XdWllbN3nfVroEUMYNncihKC0R82gP7q7j3Yw4yFrjJO3xVA/g0DhKH5Ep/iIU+u4D0Ngk4EIPTvL08u2eK4QpfRADm0gDOedyzQo01VUZz3NaK4mmljSVSA+Mdl2fKcEaul1qUB6Xvmp0j9xDKL3uOpC9+FH9RxvNcIaQ2nLODB+XBmn/zJzCVUgOKJbE717rQRhXHhBaHnaL4D3AVxSSyNMh/gjPQ4+9GFJylFP6XatqcoecfoN9j54VdOGfskIT5oRBPWXm5Y/cqvlGGWrQa4HB6NfG4LutWfjNrNuZKXSmj44ojlrY6pILDHAPN4pjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhpbBJApErVZxQjlbe51p9jxOySGEIy94n2dkPyK90A=;
 b=PXwjqpL22uMXtum+bNdX36cN8Dyz/FfE5Aq777fHTDCtbqjhgJntJ/LH5fpavbyxklIDtPWoe88yyGIqOuSQcX4qmLT1Z3zqzIGm21Y/ZXzla4I6EPB+4k4CWato3vF/E8UQ76j69OBrWeIIT0TsLfCkkmO/8o7GSXG36FNQ14U=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3262.namprd11.prod.outlook.com (2603:10b6:805:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 20:40:47 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 20:40:47 +0000
Subject: Re: [PATCH v14 4/4] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210909233304.5650-1-russell.h.weight@intel.com>
 <20210909233304.5650-5-russell.h.weight@intel.com>
 <20210910153347.GC757507@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <c5bc9aae-63f7-7fc2-1e41-6945e11c3f53@intel.com>
Date:   Fri, 10 Sep 2021 13:40:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210910153347.GC757507@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR2201CA0051.namprd22.prod.outlook.com
 (2603:10b6:301:16::25) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR2201CA0051.namprd22.prod.outlook.com (2603:10b6:301:16::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 20:40:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ece20a6-3ce9-49a2-7efd-08d9749b44bf
X-MS-TrafficTypeDiagnostic: SN6PR11MB3262:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB326268BF8CAEC4FCC0A35186C5D69@SN6PR11MB3262.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrq0EyrXaftXGW9zl0EBGilTRsVo1e4NOh9HXL9D+zDKP/HxdAHIzCH2wuHyYBo9Eeyle7i6sO2M1HD9HUz+qaSwSWL/CMAdKJu2DKW5zdDVLkwjc55gex/uoWJsTxVKOvsvzk0kTD9c4LRddzPezauQ0X3gkf9StAS6rl9GKBYI7YlFLFiLJEP/CiOm1kvqP5bQhlqzI8cFEmfYEiaCKjTKoFO7ECUzBb8lRuGqGEJq+rOi/lYY1ab8zidK3UEFM9GQhz/j2N7//KcvXBFrCkrbJ7zWNfNTF597uAYN5gq/vYObvaiAlUnqLGByS76JlznTLT+ecs/nIBz8MKfyWA3sAvGQCgei9RaSgE9yDSMdcghqdw9SFaWiIMTO9ePYELK+eeQEcNhMgv3p9Ei5EgfmPhlj7pjALHqT+MU6l0wLmZPMakNp5b3YO/yDU5o1aJoapNlUmnYscFwNuJXyUO0eLRTzEYK4qbbJMv7zFgcf1EH5WMgLfznk+nLZBKYJfQ3KYdFi/ULcffVygpSN5oiyEIMHIYs9RnC5c9i96Hw0UUrAd+1Sjdc/KKphgxTrFlyxgRs7rEzcx8Ll4/u2kKVQjcuii6xMvLhLE2GhIcb8k8aIy7HUl/NYFepjefUMMrjIjL97lflwhAcsXsIQLqZ0PyAs2G0XkPNdhjJuH5seCuaUdEvVmupSLdUO0A/+IoeTmB3RzYFk8sNbl1MQSqRjvgVQRrCXA2Ob+3ND3d/ujGkbDjApmqm8BcgmFqL4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(4326008)(26005)(2616005)(6636002)(66476007)(66556008)(478600001)(66946007)(53546011)(186003)(37006003)(83380400001)(15650500001)(86362001)(5660300002)(2906002)(6486002)(36756003)(31686004)(16576012)(31696002)(107886003)(6862004)(8676002)(6666004)(30864003)(956004)(38100700002)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFmRjh4SlZKdGFoZmRGVmwyTCttd3g3QUsyd2tHdTViSUk0dk9YcklveVNr?=
 =?utf-8?B?Y2JNeXZXZmNJZ0s3Y2YzeEJyUzg2ME9NMTdlMHZXU254ZHVMWlh6N2YvTjN1?=
 =?utf-8?B?azF0QXJvd0k0cTIvUFpEd1J4cXhsUUdHQ3JENjlzQjVadVQybWFadlNPckgw?=
 =?utf-8?B?SGNoQnhOTStBZmM3NXREK1U0ZFVOYTRZSDVOcURmblRCc3dLb3g4T1kyOEtj?=
 =?utf-8?B?SVkxWTdDVCtxYi9XcGlBcU9rYzZnMnRCcW5yUEJaVXVmU3h0eC9FUGgvSi9w?=
 =?utf-8?B?QzlzNWl0TEdUWmV3L1NDTndrdElORnlwVE8yUlFaeHN6dmFjMWVZNSs1RTZ0?=
 =?utf-8?B?dlhQVzFtclBLcXM2QlAxZjhNRWM1aW8yYkp0Y0ZIS1pROStaZ3E3aXQ5Tmx0?=
 =?utf-8?B?N3kzeUx6VzBPc0pqeVF2eUlabTU1eE1OTXcwRDNGcUp5VHZ3eXJaUFJxbWFs?=
 =?utf-8?B?SVRTODBIcHNDZGVSZGRrSkhxRzl6bUhaQTNQOGxEWFZFMzczL25wVUl1eTNY?=
 =?utf-8?B?ZFV3UUdWTHF4TUhtQmVEMEltOHFNNnlXcy9uNnFoUU0zaHgvV01hMGJuc21n?=
 =?utf-8?B?SjVnMnI1TUk4bFQzK0hacTh1eVFFdWdXRkVTWnpGdThOVElFMkdTMGUxdWFI?=
 =?utf-8?B?RHEvaTBhQVhIb0htc0ZQdWh1dVo1VVFiVWo1akV5Q080RlkyWDl5c1BYblBM?=
 =?utf-8?B?T04zYytmSE5yZEExbEM2bjdWMzQweXNGbk5sV2ZlTjl0Q1NzOEpUQkZnUEFt?=
 =?utf-8?B?MkE1TmhybTRFaUJMTTZlTnVNQTFxd0s4dXdlZzFFbDhMVEo1ZTVlaEhqc2Nv?=
 =?utf-8?B?d21GMkU1WUJ0RE1qaGtKdmYwNGVpaVQrSEFubUJnZC8rMm5Xb1NpcFZFdUQ2?=
 =?utf-8?B?dWkyMm1KN0hhOEhlWlBqN2RYVlNZVC96ekNGOGZHYmhTc1d3V1BENW0rSmdq?=
 =?utf-8?B?b25PY01UbjA1aDlLQXVnaUhLeVQ4SExZRE1MWHRGNEgyT2dxc3ZtblZKZGpE?=
 =?utf-8?B?TDNqeWV4eWdNZ2FBUGNFZ0oweGVIekxKZkMzRXRBalVhRmNOUHRlVmFJYzBY?=
 =?utf-8?B?cWdtOFVEa0k5K21nTC8xVEExWHN3V1VTdURCZ3YrdHd5NGlrQUR4WUZpeXNp?=
 =?utf-8?B?V295OGlvVzdHSGl3Y2FJR1hlanRoS0JnekJDMy9kS0lqNHV6L0h3OXhxbzVz?=
 =?utf-8?B?UVZGTDU1K20vSUgyNmFpejJzMnlCMkpEY21mMk9henpNTGRmNmNwNHFEL1lT?=
 =?utf-8?B?cTg5eDRISnBtcHBYc2FDaHdHK2JFb2c3dTVWK0dIQUViMVA4M1Z6RTRJTThU?=
 =?utf-8?B?bXBLVlhMSDlKemdERlQ2bmJSNTN4V29CQm1LRWhuQ3BTMHZ6VytUZFg2YUgr?=
 =?utf-8?B?dXM0OU52cGkvNjA5bVgxejBBaUZ1aUpzSlRLRzN0WUtOdVNJZTFDSUJmb3Fz?=
 =?utf-8?B?b2dQbG9GVjUrUkNlditJVEM4T3BaQjhKcCtralJVdVVsZThxdkdvOVBoTEx1?=
 =?utf-8?B?S01UbWsrRGFDendPSXBpRXNFMEhYbHVrcFVpVzRxck5KZlo0dnpoWTR5OVY3?=
 =?utf-8?B?T21FdFJNWVBRNHkwSWlRcVdxbVE2cmVzVnVBQTMrTk5aRUliUWJKOEVML1R4?=
 =?utf-8?B?NFRlakNhUjNaZVR5TmtaNzN6MTZtTTc2ZlQvNmc5aWc2RTRoTXVFd1VDbUFi?=
 =?utf-8?B?SUZQMnZ5c1c2Skw2V2pPZ1R4VE1TR0NLeDFsNnMxYkR4RU1tYytRZFQvekFs?=
 =?utf-8?Q?P2MIvhx95/Iwnx8I8E5i16dDwYTqw+oJVZhzvjO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ece20a6-3ce9-49a2-7efd-08d9749b44bf
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 20:40:47.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWd860gId1Upi03H8e1AR2+64CzSGAdhx4rw2x4CfD/wHBZwoUW5Kfi7wYhW0/CZ5PrSf14cB9GLd2XYOCwTH/U8k1QnulIoyzKXyPhFnKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3262
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/10/21 8:33 AM, Xu Yilun wrote:
> On Thu, Sep 09, 2021 at 04:33:04PM -0700, Russ Weight wrote:
>> Invoke an instance of the FPGA Image Load driver and extend the MAX10
>> BMC Secure Update driver to include the functions that enable secure
>> updates of BMC images, FPGA images, etc.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v14:
>>   - Changed symbol names to reflect the renaming of the Security Manager
>>     Class driver to FPGA Image Load.
>> v13:
>>   - No change
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>>   - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
>>     no longer has a size parameter, and the block size is determined
>>     in this (the lower-level) driver.
>> v11:
>>   - No change
>> v10:
>>   - No change
>> v9:
>>   - No change
>> v8:
>>   - Previously patch 5/6, otherwise no change
>> v7:
>>   - No change
>> v6:
>>   - Changed (size / stride) calculation to ((size + stride - 1) / stride)
>>     to ensure that the proper count is passed to regmap_bulk_write().
>>   - Removed unnecessary call to rsu_check_complete() in
>>     m10bmc_sec_poll_complete() and changed while loop to
>>     do/while loop.
>> v5:
>>   - No change
>> v4:
>>   - No change
>> v3:
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>>     driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed calling functions of functions that return "enum fpga_sec_err"
>>     to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
>> v2:
>>   - Reworked the rsu_start_done() function to make it more readable
>>   - Reworked while-loop condition/content in rsu_prog_ready()
>>   - Minor code cleanup per review comments
>>   - Added a comment to the m10bmc_sec_poll_complete() function to
>>     explain the context (could take 30+ minutes to complete).
>>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>> ---
>>  drivers/fpga/intel-m10-bmc-secure.c | 310 +++++++++++++++++++++++++++-
>>  1 file changed, 309 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> index ae1383d13bfc..025655684d00 100644
>> --- a/drivers/fpga/intel-m10-bmc-secure.c
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -181,7 +181,315 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>  	NULL,
>>  };
>>  
>> -static const struct fpga_image_load_ops m10bmc_lops = { };
>> +static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>> +{
>> +	u32 auth_result;
>> +
>> +	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
>> +
>> +	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
>> +		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>> +}
>> +
>> +static enum fpga_image_err rsu_check_idle(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
>> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_BUSY;
>> +	}
>> +
>> +	return FPGA_IMAGE_ERR_NONE;
>> +}
>> +
>> +static inline bool rsu_start_done(u32 doorbell)
>> +{
>> +	u32 status, progress;
>> +
>> +	if (doorbell & DRBL_RSU_REQUEST)
>> +		return false;
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>> +		return true;
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static enum fpga_image_err rsu_update_init(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell, status;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
>> +				 DRBL_RSU_REQUEST |
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_IDLE));
>> +	if (ret)
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_start_done(doorbell),
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +	}
>> +
>> +	status = rsu_stat(doorbell);
>> +	if (status == RSU_STAT_WEAROUT) {
>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>> +		return FPGA_IMAGE_ERR_WEAROUT;
>> +	} else if (status == RSU_STAT_ERASE_FAIL) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_IMAGE_ERR_NONE;
>> +}
>> +
>> +static enum fpga_image_err rsu_prog_ready(struct m10bmc_sec *sec)
>> +{
>> +	unsigned long poll_timeout;
>> +	u32 doorbell, progress;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
>> +	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
>> +		msleep(RSU_PREP_INTERVAL_MS);
>> +		if (time_after(jiffies, poll_timeout))
>> +			break;
>> +
>> +		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +		if (ret)
>> +			return FPGA_IMAGE_ERR_RW_ERROR;
>> +	}
>> +
>> +	progress = rsu_prog(doorbell);
>> +	if (progress == RSU_PROG_PREPARE) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>> +	} else if (progress != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_IMAGE_ERR_NONE;
>> +}
>> +
>> +static enum fpga_image_err rsu_send_data(struct m10bmc_sec *sec)
>> +{
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_WRITE_DONE));
>> +	if (ret)
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +
>> +	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
>> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				       doorbell,
>> +				       rsu_prog(doorbell) != RSU_PROG_READY,
>> +				       NIOS_HANDSHAKE_INTERVAL_US,
>> +				       NIOS_HANDSHAKE_TIMEOUT_US);
>> +
>> +	if (ret == -ETIMEDOUT) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>> +	} else if (ret) {
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +	}
>> +
>> +	switch (rsu_stat(doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +		break;
>> +	default:
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_IMAGE_ERR_NONE;
>> +}
>> +
>> +static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>> +{
>> +	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
>> +		return -EIO;
>> +
>> +	switch (rsu_stat(*doorbell)) {
>> +	case RSU_STAT_NORMAL:
>> +	case RSU_STAT_NIOS_OK:
>> +	case RSU_STAT_USER_OK:
>> +	case RSU_STAT_FACTORY_OK:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (rsu_prog(*doorbell)) {
>> +	case RSU_PROG_IDLE:
>> +	case RSU_PROG_RSU_DONE:
>> +		return 0;
>> +	case RSU_PROG_AUTHENTICATING:
>> +	case RSU_PROG_COPYING:
>> +	case RSU_PROG_UPDATE_CANCEL:
>> +	case RSU_PROG_PROGRAM_KEY_HASH:
>> +		return -EAGAIN;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static enum fpga_image_err m10bmc_sec_prepare(struct fpga_image_load *imgld)
>> +{
>> +	struct m10bmc_sec *sec = imgld->priv;
>> +	enum fpga_image_err ret;
>> +
>> +	if (imgld->remaining_size > M10BMC_STAGING_SIZE)
>> +		return FPGA_IMAGE_ERR_INVALID_SIZE;
>> +
>> +	ret = rsu_check_idle(sec);
>> +	if (ret != FPGA_IMAGE_ERR_NONE)
>> +		return ret;
>> +
>> +	ret = rsu_update_init(sec);
>> +	if (ret != FPGA_IMAGE_ERR_NONE)
>> +		return ret;
>> +
>> +	return rsu_prog_ready(sec);
>> +}
>> +
>> +#define WRITE_BLOCK_SIZE 0x4000 /* Update remaining_size every 0x4000 bytes */
>> +
>> +static enum fpga_image_err
>> +m10bmc_sec_write_blk(struct fpga_image_load *imgld, u32 offset)
>> +{
>> +	struct m10bmc_sec *sec = imgld->priv;
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	u32 doorbell, blk_size;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret) {
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>> +	}
>> +
>> +	blk_size = min_t(u32, imgld->remaining_size, WRITE_BLOCK_SIZE);
>> +	ret = regmap_bulk_write(sec->m10bmc->regmap,
>> +				M10BMC_STAGING_BASE + offset,
>> +				(void *)imgld->data + offset,
>> +				(blk_size + stride - 1) / stride);
>> +
>> +	if (ret)
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +
>> +	imgld->remaining_size -= blk_size;
>> +	return FPGA_IMAGE_ERR_NONE;
>> +}
>> +
>> +/*
>> + * m10bmc_sec_poll_complete() is called after handing things off to
>> + * the BMC firmware. Depending on the type of update, it could be
>> + * 30+ minutes before the BMC firmware completes the update. The
>> + * imgld->driver_unload check allows the driver to be unloaded,
>> + * but the BMC firmware will continue the update and no further
>> + * secure updates can be started for this device until the update
>> + * is complete.
>> + */
>> +static enum fpga_image_err m10bmc_sec_poll_complete(struct fpga_image_load *imgld)
>> +{
>> +	struct m10bmc_sec *sec = imgld->priv;
>> +	unsigned long poll_timeout;
>> +	enum fpga_image_err result;
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	result = rsu_send_data(sec);
>> +	if (result != FPGA_IMAGE_ERR_NONE)
>> +		return result;
>> +
>> +	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
>> +	do {
>> +		msleep(RSU_COMPLETE_INTERVAL_MS);
>> +		ret = rsu_check_complete(sec, &doorbell);
>> +		if (imgld->driver_unload)
>> +			return FPGA_IMAGE_ERR_CANCELED;
> Why we return CANCELED error code to user when driver unload is
> requested?
>
> Users may think the update is failed and the old image is kept,
> but in fact, the update continues and finally the old image is
> replaced by the new one.

I could return FPGA_IMAGE_ERR_NONE, and then userspace code would
think that the update completed without error, even though the
update is still in progress.

Or I could create a new FPGA_IMAGE_ERR_EXIT code to indicate that
the driver has exited while the update is still progressing.

I like the FPGA_IMAGE_ERR_EXIT option best of those two options.
Any other suggestions?

Thanks,
- Russ


>
> Thanks,
> Yilun
>
>> +	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
>> +
>> +	if (ret == -EAGAIN) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_TIMEOUT;
>> +	} else if (ret == -EIO) {
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +	} else if (ret) {
>> +		log_error_regs(sec, doorbell);
>> +		return FPGA_IMAGE_ERR_HW_ERROR;
>> +	}
>> +
>> +	return FPGA_IMAGE_ERR_NONE;
>> +}
>> +
>> +static enum fpga_image_err m10bmc_sec_cancel(struct fpga_image_load *imgld)
>> +{
>> +	struct m10bmc_sec *sec = imgld->priv;
>> +	u32 doorbell;
>> +	int ret;
>> +
>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>> +	if (ret)
>> +		return FPGA_IMAGE_ERR_RW_ERROR;
>> +
>> +	if (rsu_prog(doorbell) != RSU_PROG_READY)
>> +		return FPGA_IMAGE_ERR_BUSY;
>> +
>> +	ret = regmap_update_bits(sec->m10bmc->regmap,
>> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
>> +				 DRBL_HOST_STATUS,
>> +				 FIELD_PREP(DRBL_HOST_STATUS,
>> +					    HOST_STATUS_ABORT_RSU));
>> +
>> +	return ret ? FPGA_IMAGE_ERR_RW_ERROR : FPGA_IMAGE_ERR_NONE;
>> +}
>> +
>> +static const struct fpga_image_load_ops m10bmc_lops = {
>> +	.prepare = m10bmc_sec_prepare,
>> +	.write_blk = m10bmc_sec_write_blk,
>> +	.poll_complete = m10bmc_sec_poll_complete,
>> +	.cancel = m10bmc_sec_cancel,
>> +};
>>  
>>  static int m10bmc_secure_probe(struct platform_device *pdev)
>>  {
>> -- 
>> 2.25.1

