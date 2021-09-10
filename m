Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD14073D2
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 01:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhIJXY7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 19:24:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:50701 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234787AbhIJXY5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 19:24:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="306763816"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="306763816"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 16:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="467507118"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2021 16:23:45 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 16:23:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 10 Sep 2021 16:23:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 10 Sep 2021 16:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1oBbE50Vuv/mDLZzyrgemJZ4smG0WMo4LFQQFEaQ4qnGEubFV8Oh2rSXX/Qg3xH+huLDE46W2glp2jW6VPyEEatqXDkVklDOwkejsZcB0hAGyvXAJzo0FUHiZThEf9aiZq5zR6iz4LE3tPmbSDrAr0Sw315UV+UI1RyMBZIq0vNxEti8vmCqAsVPTvFz0/pAVOdIPW3gqDDJ/vwBWQGP7y2Nszi6YCW/So+R6oEAh8lFjfuNOSjzIJcFHjDTB2H1hPsrFXC71TaXf+zhPfeILh2i/Xr24+uaE6Ob1wY4YVHzv22/us3neLw+p/GTzIj5kO1p/nkTknj6AhDjaU9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PTSm5cv+g2rkC3NkREOZos65XQwAEd5KStLCsdnhinc=;
 b=gFqIahr18t7/sGtR79hnfatVeTI8V8pL3F+YTbtpz4Mu3HMYiD+N9QYBcaR+NDjHTNpQJR313xevWPMrjT8MRO+dWmpFHX7dH/8TPnyjYpvDG/ekjEfQPjZm2Zym5c4FF/j8QsQRgNbo6q908XEaFianxqjvZ+daU43/BnsY0wQm7a/rftPsQTU1DTJ31Jpy/ySTFh6Sisc96RwfFk85C6bmiDG6EthLbflm4MAXTezIxk1w0rKletfISqareBr4p1Z4yaQ7sZCzD1V5Wr1y5zERO93D850ZwYPv1EyBC0NwZaX8cmFvaP/jJetPr5OxHBszC6OZFdkg9wMOuow0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTSm5cv+g2rkC3NkREOZos65XQwAEd5KStLCsdnhinc=;
 b=mI8LRCApksheUyyIa/YTtlCZg/cl98XRPOL0sSCEekyG4SU0tFxgIsbRyjAol+WcTzW1qHapXmDykbZS8156e3mgt5MvAnrHOgVB5jSpYy1DBH3cusk2fdibXqPtwiiPTLeSIOoBrSOnaKCye+XgPqytKVTUzoklbYd/+gMHo8s=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 23:23:29 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 23:23:29 +0000
Subject: Re: [PATCH v15 4/6] fpga: image-load: add status ioctl
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-5-russell.h.weight@intel.com>
 <20210910085005.GC754505@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <4ea07b83-f592-749e-80c3-27ed144171bc@intel.com>
Date:   Fri, 10 Sep 2021 16:23:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210910085005.GC754505@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: CY4PR18CA0066.namprd18.prod.outlook.com
 (2603:10b6:903:13f::28) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by CY4PR18CA0066.namprd18.prod.outlook.com (2603:10b6:903:13f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 23:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4768383-1f53-46db-28cb-08d974b1ffa0
X-MS-TrafficTypeDiagnostic: SA2PR11MB5129:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5129A98653CFFF5861FE74B1C5D69@SA2PR11MB5129.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FO6EZJndgUpjFWFGz7kL46WYNQipOrSi+14zyuTibXtWFNuST10r3AAknXEQGDWgxqijqPK5FnFYENgn6ep6Et1pzv0CKsZpcU3XVE4hU+bgC3zsGX9lbCz/oC3exR7F0P35lBoVEhMRBXe/vv7TjSCOWZ/jGSGwRUcQW/eEmRYSBtOM+C66Ek1d4vjP8BtWOqj+yEJ4a17akyx6zqRwozw6/PndjtYrytAr7dSdkCzTWnUpYCMnc38hir6ibacR/b1J9t2mt+G4QRfzKE6F7TrHLI9UU7q4lkie468Q060sdtU6r5jmiysoN+nCS6eRsg/WVs1b8tYBVLU/mDCxh0T6mDdTkEn9sMZ3Axhl+AQS/ejdKKC8M7I6Trita4Iregwbabc/FRqTLmCKiWXyfrpDophjbGa6H2yYrDvn0tKHRwwbCIz3mqc0zW+me9lcycp0FmkUry6QDuL1l7Ac+OZ4TcFLQtj0Ipa+cNB1Oeu40mIOAi/Myguf2yAPKYP1XDA6lKrY+3KMEKtS3/S9KxIhV2fCgaECTZyUvmzIE3pZ4OzFki0MUy+qJ/8eGXu6/2MDTp8dPBkLaWtI03+2Q2f1RBlP2pqNneA66ist42sIiMDKtzd3cp01iLg9jmdNYqUX5/fXbz+kdq+pf5/ponC9f6R4dtEe6acvegWT7P3lSJFBRpTn2CxmvUjV0x+xAP09iauRyGCRrPfQDfBWfsURtZVT0DUQxECk+C+RHag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(36756003)(478600001)(5660300002)(186003)(6486002)(38100700002)(83380400001)(8936002)(26005)(107886003)(6666004)(31686004)(16576012)(66556008)(31696002)(2906002)(66946007)(86362001)(956004)(53546011)(8676002)(6862004)(4326008)(37006003)(316002)(2616005)(6636002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGlERldzU1lTMEN3djhNMWtpU0pBYS9IeE9xMjlMdHRUdDlFV1pvSitObVRR?=
 =?utf-8?B?VUg2UEpyUkUvK2lycXo5Yk50RFBzejcvRzZsMG1uNXVsZEpiSXMzSU1PYU1I?=
 =?utf-8?B?RlJMeko0YTdib0w4K3p1NDVpa3VBMFhRQUowUFU1OFVDVXgwWXRIQXVnNDN1?=
 =?utf-8?B?dVdOY2RzcUo4QThlQUpMUjByWjFtNnNtanhLT3kzYklOejVKZ3gvNGNTVU4v?=
 =?utf-8?B?dVYrVXZ5MnNKcWpWYlA0eGhxOWNuRFhYdVFkNkV0eDVBQzljWTUwVEZ5cDIx?=
 =?utf-8?B?R25sRWdBdVdRSWxrU2RrOWFTQkU2OEgrMjhHTGFlZFhrc3pCUmN1dFhzcEtQ?=
 =?utf-8?B?WWMrUEx5SldESC9kTFRGbTU3K1c0YzhFN25nZmZXQU9WL1Y0cElzTkgxQUpz?=
 =?utf-8?B?TnpadnR4Q1llY3RvVVFKeDdxbEhSZmZUMlFnT010SjJudDdLam1aMmlWNFBh?=
 =?utf-8?B?VG5vT2Nwc1dBang0d0g5bFNxdHFHUCszN1ZPYTZuWGl6d0JNSUlGbjJMYUd3?=
 =?utf-8?B?TnJtOU1lbytOS0JoMXFtZ0pmaU9ZbEREdlZMaER5R1NZdnJ6aW13azVjMUcz?=
 =?utf-8?B?bk00R0lMVW9haWlhQ2NBY2puNVhrMDJBaStDL2RhNUxkNk0vbE4yalRZbHZJ?=
 =?utf-8?B?aVNUQlNKRFhNUklkRkd2ZWNKa1o5RWNSWW1nTW9wemg1Z2QvUnVqelFSbVhC?=
 =?utf-8?B?ZGRwKzljMUwrME82RlAvL0pWWWVwSUZSMTJONjI3ZW9rOHpLZFg3dlk5R1hs?=
 =?utf-8?B?NEh2anZZWFJ3dHJyVkJsVTBQeXlFRHdJZXRQeXpWdndsWExFbnFtd3pMT0VZ?=
 =?utf-8?B?NGUyc3VxNU82bUtBYlMrZUZLdlZZQVBJUnpzWnQ0Qm9wSjl5VkRKOG1iMnNK?=
 =?utf-8?B?TFBUS2loZ0JkRllXc1NNZllDSndoY1ZYam5IL3hrbkwzaXFWRGhXTVNWa0lr?=
 =?utf-8?B?UFVlcGVMRmYvQ0ptM1QrYktZZVhneFhZbWVHL3BpbC9PUkhvZHF3SFBIVnVP?=
 =?utf-8?B?c1c2cWthelhPUkdUOUQ1N0pBVmZVbEhwS1dOZzBTTE4wbFptdmRadGxTTjlQ?=
 =?utf-8?B?YW5WeG1vN2VTSFg5Z0NVaDNFaDNNTlBlMFdNNHRoTmx3S1hLRjRlNHFMMDlW?=
 =?utf-8?B?SVdRT0FOamVLdTdxSzdOekNvRTZJSmpBZEVHZzNUeUNUdVBnVU9kMHpod09a?=
 =?utf-8?B?Mi9hSE50aEh5Kyszb3JHYlFtcUJhcjBpbWhjUjM5V1FPZWZPNHhWM2N0OFVj?=
 =?utf-8?B?R2RHRHVyZ2ZwbVU5WkVKcUpnV3RmWmR5OXZIbzFSY0R6QmNHVlRMY0NVV1Aw?=
 =?utf-8?B?WVlFU3lMcmdXTlFEVmk3TE5kZHFxZFg0K3JCakpuR3lDTEJ6TFVKRkhnUUky?=
 =?utf-8?B?M29sT1ZESnlEQ3dRY3hXd0JiT0RYb0UySEZsaC8rckZTWEcvaGRFbDA2YUNT?=
 =?utf-8?B?U0tlQmtQdjROWHowRHRFcXdPV3pHWjA1eGdicExNTUxKY2tnMlhIS1ZkSjBs?=
 =?utf-8?B?T3BlQVVvNCtadkJmREE2NHFHbnIzd1NDcy9acUVzb2FwdXNQQndtTHdieWFr?=
 =?utf-8?B?ajFQdG1jdGQzYVBCOXpoZTNPdGRmcG85cHYvcXJxTGlFQ2tKZUJPd3cyei9T?=
 =?utf-8?B?TnVwMmhEZktlampFMWhHcU5QQjdEMVZlYzRldUFUc0psRkNaK0dCcUVaS1V2?=
 =?utf-8?B?R3Zrdld1TDlXYVRJa0IrTVVaazBVank1cFFscWdhU0E1MlAxZDcydmdWRWgy?=
 =?utf-8?Q?eH2w8kZhQlr7JW+L1rf4L2TX5kFXkPqMtxh5pKq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4768383-1f53-46db-28cb-08d974b1ffa0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 23:23:29.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6FrdH9/MgMgkKGlWaNB/H5WnKdaNHBzVY/N25lE1Aqir4IKQPU6FZsspe6RJF3oMT5Gqe3k0avd7U2zdonm5HSDu52JBCfzpXK5Bpv9wN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/10/21 1:50 AM, Xu Yilun wrote:
> On Wed, Sep 08, 2021 at 07:18:44PM -0700, Russ Weight wrote:
>> Extend the FPGA Image Load class driver to include an
>> FPGA_IMAGE_LOAD_STATUS IOCTL that can be used to monitor the progress
>> of an ongoing image load.  The status returned includes how much data
>> remains to be transferred, the progress of the image load, and error
>> information in the case of a failure.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> V15:
>>  - This patch is new to the patchset and provides an FPGA_IMAGE_LOAD_STATUS
>>    IOCTL to return the current values for: remaining_size, progress,
>>    err_progress, and err_code.
>>  - This patch has elements of the following three patches from the previous
>>    patch-set:
>>      [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>>      [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
>>      [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
>>  - Changed file, symbol, and config names to reflect the new driver name
>>  - There are some minor changes to locking to enable this ioctl to return
>>    coherent data.
>> ---
>>  Documentation/fpga/fpga-image-load.rst |  6 +++
>>  drivers/fpga/fpga-image-load.c         | 53 ++++++++++++++++++++++----
>>  include/uapi/linux/fpga-image-load.h   | 18 +++++++++
>>  3 files changed, 70 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>> index 739d735592a5..3d5eb51223e3 100644
>> --- a/Documentation/fpga/fpga-image-load.rst
>> +++ b/Documentation/fpga/fpga-image-load.rst
>> @@ -31,3 +31,9 @@ updated. This is an exclusive operation; an attempt to start concurrent image
>>  load for the same device will fail with EBUSY. An eventfd file descriptor
>>  parameter is provided to this IOCTL, and it will be signalled at the
>>  completion of the image load.
>> +
>> +FPGA_IMAGE_LOAD_STATUS:
>> +
>> +Collect status for an on-going image upload. The status returned includes
>> +how much data remains to be transferred, the progress of the image load,
>> +and error information in the case of a failure.
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> index b784456765b0..99a47b21c995 100644
>> --- a/drivers/fpga/fpga-image-load.c
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -22,10 +22,27 @@ static dev_t fpga_image_devt;
>>  
>>  #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>>  
>> -static void fpga_image_dev_error(struct fpga_image_load *imgld,
>> +static void fpga_image_update_progress(struct fpga_image_load *imgld,
>> +				       enum fpga_image_prog new_progress)
>> +{
>> +	mutex_lock(&imgld->lock);
>> +	imgld->progress = new_progress;
>> +	mutex_unlock(&imgld->lock);
>> +}
>> +
>> +static void fpga_image_set_error(struct fpga_image_load *imgld,
>>  				 enum fpga_image_err err_code)
>>  {
>> +	mutex_lock(&imgld->lock);
>> +	imgld->err_progress = imgld->progress;
>>  	imgld->err_code = err_code;
>> +	mutex_unlock(&imgld->lock);
>> +}
>> +
>> +static void fpga_image_dev_error(struct fpga_image_load *imgld,
>> +				 enum fpga_image_err err_code)
>> +{
>> +	fpga_image_set_error(imgld, err_code);
>>  	imgld->lops->cancel(imgld);
>>  }
>>  
>> @@ -49,18 +66,18 @@ static void fpga_image_do_load(struct work_struct *work)
>>  
>>  	get_device(&imgld->dev);
>>  	if (!try_module_get(imgld->dev.parent->driver->owner)) {
>> -		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
>> +		fpga_image_set_error(imgld, FPGA_IMAGE_ERR_BUSY);
>>  		goto idle_exit;
>>  	}
>>  
>> -	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
>> +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PREPARING);
>>  	ret = imgld->lops->prepare(imgld);
>>  	if (ret != FPGA_IMAGE_ERR_NONE) {
>>  		fpga_image_dev_error(imgld, ret);
>>  		goto modput_exit;
>>  	}
>>  
>> -	imgld->progress = FPGA_IMAGE_PROG_WRITING;
>> +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>>  	while (imgld->remaining_size) {
>>  		ret = imgld->lops->write_blk(imgld, offset);
>>  		if (ret != FPGA_IMAGE_ERR_NONE) {
>> @@ -71,7 +88,7 @@ static void fpga_image_do_load(struct work_struct *work)
>>  		offset = size - imgld->remaining_size;
>>  	}
>>  
>> -	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
>> +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>>  	ret = imgld->lops->poll_complete(imgld);
>>  	if (ret != FPGA_IMAGE_ERR_NONE)
>>  		fpga_image_dev_error(imgld, ret);
>> @@ -151,20 +168,42 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>  	return ret;
>>  }
>>  
>> +static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
>> +					unsigned long arg)
>> +{
>> +	struct fpga_image_status status;
>> +
>> +	memset(&status, 0, sizeof(status));
>> +	status.progress = imgld->progress;
>> +	status.remaining_size = imgld->remaining_size;
>> +	status.err_progress = imgld->err_progress;
>> +	status.err_code = imgld->err_code;
>> +
>> +	if (copy_to_user((void __user *)arg, &status, sizeof(status)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>  static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>  				  unsigned long arg)
>>  {
>>  	struct fpga_image_load *imgld = filp->private_data;
>>  	int ret = -ENOTTY;
>>  
>> +	mutex_lock(&imgld->lock);
>> +
>>  	switch (cmd) {
>>  	case FPGA_IMAGE_LOAD_WRITE:
>> -		mutex_lock(&imgld->lock);
>>  		ret = fpga_image_load_ioctl_write(imgld, arg);
>> -		mutex_unlock(&imgld->lock);
>> +		break;
>> +	case FPGA_IMAGE_LOAD_STATUS:
>> +		ret = fpga_image_load_ioctl_status(imgld, arg);
>>  		break;
>>  	}
>>  
>> +	mutex_unlock(&imgld->lock);
>> +
>>  	return ret;
>>  }
>>  
>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>> index a60da115adf5..6a995bcc0fb7 100644
>> --- a/include/uapi/linux/fpga-image-load.h
>> +++ b/include/uapi/linux/fpga-image-load.h
>> @@ -38,6 +38,7 @@ enum fpga_image_err {
>>  };
>>  
>>  #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>> +#define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>>  
>>  /**
>>   * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
>> @@ -56,4 +57,21 @@ struct fpga_image_write {
>>  	__u64 buf;		/* User space address of source data */
>>  };
>>  
>> +/**
>> + * FPGA_IMAGE_LOAD_STATUS - _IOR(FPGA_IMAGE_LOAD_MAGIC, 1,
>> + *				 struct fpga_image_status)
>> + *
>> + * Request status information for an ongoing update.
>> + * data buffer, size, and an eventfd file descriptor.
> This line is a typo.
Thanks - I'll fix it.
>
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +struct fpga_image_status {
>> +	/* Output */
>> +	__u32 remaining_size;			/* size remaining to transfer */
>> +	enum fpga_image_prog progress;		/* current progress of image load */
>> +	enum fpga_image_prog err_progress;	/* progress at time of error */
>> +	enum fpga_image_err err_code;		/* error code */
> Should we use __u32 for these enumeration types?
We could, but I did see a lot of uapi header file examples that use
enum for IOCTL structures. Is there a reason to prefer __u32? If I change
these to __u32, then I suppose I need to change from enum declarations to
#define macros?

- Russ

>
> Thanks,
> Yilun
>
>> +};
>> +
>>  #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
>> -- 
>> 2.25.1

