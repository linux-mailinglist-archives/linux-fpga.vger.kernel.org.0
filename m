Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5043556E
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJTVpW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 17:45:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:8388 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhJTVpW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 17:45:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="226347829"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="226347829"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 14:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="594824406"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2021 14:43:06 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 14:43:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 14:43:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 14:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deRwl19AnM5GLfUkdySj1woXj1fn/HpomPyrGZFaYjYrjUi4QmhT/gtWAY6RgvDLQbtxZ4BKfkBnVRBcx2f1NELMArNPb4G2h40mqjt6zVqq/zr88X/RXyTt7TGl905SlAF0b6oUsWXqBCOVnq0YlgzPI7sHQUuOuT2ezJ4qFKa4ZR95M6plS4GiDdcc4ZLDYBj3hkxj8SaceEqvHE0npkod0v5V9VOsbL2pyvNif591RDWvP7EXZMqYtaD1gdTgjK8Nd6Yjp4/zsiz1LZzok+xMSlPTQPA3dcsZimlbShXMcjFYCI4WUBqMAO31lsruZuptF2DIwp5bichUj5B3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/0eTOwM/znGj2PaeAxuHnfJE0cK2oL76dHNqW81jBU=;
 b=EMzT3Varr0vaPXesHqgwtV36EAzNG0EAIbt6WVj/0MmqeMhd7Rm9oEMC5x5QAvSoTBeTSWufyahSuz9WRaeIfhiyTbNbSWvFAvG673NCIWt3QO5uOcdrMTQ7yE1vNUHpKSe3T3juTnI1M1nSQhkPsp9KD7Mm3IzT3d2+ATu/MGp8l+2bvr9kzDRAuXivGPxxT0ligqmkPz8LLtattrfP05fhpr9tKr91sEaImvrsevMfyVIL2sNNUVcbl+vnooHjtGlyp+LnWSE3xKCkoREbtO/wUAZZYodcz98QLexkVtNszTf2u19yBC4Kp15befGOveVEiQGZLlWe2hStdusm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/0eTOwM/znGj2PaeAxuHnfJE0cK2oL76dHNqW81jBU=;
 b=PV3oHLsiWBd3lVzuwcFqvccf3ma+U/QGP2QWbUF8wTUABh6Qrat+54J0Y0jQZs70WecY9qbEXowFHgT7FRMmj/er9FIIQ56p6zKjYgG5z1D4xG9HbxOuyqAit7Mhva3Y2nt4RZa6dkPJOf89i7nZOMgfbL+fFJrXpkCZMKexfj4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 21:43:01 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 21:43:01 +0000
Subject: Re: [PATCH v17 4/5] fpga: image-load: add status ioctl
To:     Lizhi Hou <lizhi.hou@xilinx.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20210929230025.68961-5-russell.h.weight@intel.com>
 <97bb3fb5-3807-386d-d2c8-fec9c077a255@xilinx.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <1e94cff5-ed53-bab7-1bb1-321ba833ea1e@intel.com>
Date:   Wed, 20 Oct 2021 14:42:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <97bb3fb5-3807-386d-d2c8-fec9c077a255@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: TYBP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::31) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by TYBP286CA0019.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:ce::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 21:42:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a35379-3c6c-498e-cec1-08d9941296d8
X-MS-TrafficTypeDiagnostic: SA2PR11MB5036:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB5036998F6DF0FDC781683AD3C5BE9@SA2PR11MB5036.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWCLSC7SqnjvuI7TXsdKvCtKueqOscZhxqmLVQEe9Hn5/iWw4ldNXNqrkjfYcW6ZWnRdavIpzMf5UGyi7pDUQv/jX7WlkX0MnoXRPdQbxdGspDw3d9cs/ZnTAIRf+p5fM2akWuaKmp+LuN3e5tGGj3fAsZsHhC2WdsjYiWYaWeoAUHGmitzVRfeQpwaBuBuv9LJgP5vJpKVILBraxhfiWeKUdAvQ8WbUv/WsTsJsrCB0fI9U5EpgWATxQfVkDo6xKWrxN+c+b3ituztxgjagpKDisCADgPBlVKzLk5xA22SNudMliYJBTbkshHV39He4Fuo1gsjqnMG36rK0MdBwuvkKyQtg1xd3IzVvz6fqny23hD++jOcBJDJTbecRA5jNzA0xhGqDhpfbK5f6WBRoEn06VeuF3E1ZY+TWubxE88fFigy7jr363TQnklaa4QBZef3PVaU2JrFxBOa+t7uNbG/dlry7Sk83bvnvd58sMTLrq6pckTR/1b5phAVxQWyLG1FXNyEtUaFSBB1dd6tZp4K8xS++D0TvtUDyqNPUmzdFPJhN9/GrkB7Qj7revC4hbKjqLbL7eKSa5F7lKSKd6rYW/5C7ZdBgXb56hrUBbC7X2TjNRZZfkbn/SvK1HAqM2Bvvvdpisr66W6/DRnxNdCnjDVYSC7W60rBlQ3ZhbzGkI1oAlD9MP/PW9kdquQc8gKseXD0MQI2XXJ5dkZbt2Ab7K55t4807mqg2Wa//dxUxtdQJshizhZ8i9OBBGcqr/UkNQW/Qpy+6PBa7j9V7tQXMXskbDBbPtZbrox0tQePfSdWlBDCxNJ7ByAxQpTiA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(16576012)(82960400001)(2906002)(956004)(36756003)(508600001)(6486002)(83380400001)(31696002)(8676002)(4326008)(107886003)(66476007)(38100700002)(31686004)(8936002)(2616005)(966005)(316002)(86362001)(26005)(66946007)(186003)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFY5dHNHT1QzS2pXWEVKNWNuQU5BVnUzVi9DV2pId2w3YjlVeVBxNmRNbEts?=
 =?utf-8?B?Mkw5ajFYMUZRU3RDNXJKTFA5bHdmQWI4Q0dnbWRXVjY3Vll5VXd2RTdtbnZ4?=
 =?utf-8?B?aTZXTExnV2Z0cllNMFdpdzAwYmM0dlc3RDFFWTBZTnNKcytrR2txdnd0V0I2?=
 =?utf-8?B?cEJVeStla0lqejJwRkNlQjR3djN4UThoSTF0TG0ycHRqQTMyYnVob0Nic0Ru?=
 =?utf-8?B?Y2txWFhwMDNGMWh0VkR2YUg1U1dVUEJWN1RxZEt3bU5TZVprSU0vU3hmaEdt?=
 =?utf-8?B?aEdIV1dDTms1YXJRSnMzQW1Lbk1pTnVaVmZGZDRkZVBraE9NSmJPNHNEQzVE?=
 =?utf-8?B?TWhUeENjMzRTSTh2YS92dXAxNWtRUEJZaU53elVXeFdYaHhiKzVFclQrZUg4?=
 =?utf-8?B?Vmg0cUtURUJTSkdzKytlbWtMQzQzL01NMXM1WHFYLzkyMWpkWG5kNHQvL2ox?=
 =?utf-8?B?cE9QL05ta0ZpYlF4dDcxNTkvMzI4UGxaRWt3RHlDMWx2SXRmeHRZb3RHbEIx?=
 =?utf-8?B?TGZDN3lqamRhc2lTUmpESFdIYkp5NU83NXpJVlFiQkZHeEgzZENoTTBlT3ZV?=
 =?utf-8?B?MG1aaEhrWkVRSTNyTFl4dUZiRkZJczJ1RHRmMWZ3RUtsTVRESmNsT3p4T2FU?=
 =?utf-8?B?QnJrQThJQkFETml2QUJjVXZNd0phdUthby9zcUt1MHB5eFR2ZDBWbVptM3ZN?=
 =?utf-8?B?bDU1KzFFVi9zdHJDU1dXazVadzVRbzhUUURqZEpHbE16Y2dFdWhieUZkazVw?=
 =?utf-8?B?NGU4N0hGUmllcXA0aUZXcktHa0p6UE1iNndlTG1YVUFsbjZqVFJPaEs4NWdZ?=
 =?utf-8?B?elhaTlFpNld6S21kTGVTNXN5M3ltamZ5UmV5R3JTVlY1ZmxWa2p1UHpXVU1a?=
 =?utf-8?B?V2tYOWxncldVQmZmdlhZVlRRVUZ6QnpvbDY4NXBIUlQwRlJ2ZnlmQ25WRE5X?=
 =?utf-8?B?Y2UrSThFbGNFQm1oMzZqZnRyL1M5MndmZTJoZFM4M2U5MUJYclJPWmt0Q1B0?=
 =?utf-8?B?ckk2azZ2OU9iUEJUMG5SWW9hZDBWWHNLVldDVnZlRVhJZFMvc0xDMElGbnpM?=
 =?utf-8?B?RDlyeHM0VWwwNXE0QUlCaUZTTHNZSEFZMFM4Z0xOODlCc1RQRGp3RlhqYzlJ?=
 =?utf-8?B?d0cwYmkvYVlLSWFxZkUwZStESThkRW1TbTY2a0RHdUVGb0Z3bnZmMXQ0YWF2?=
 =?utf-8?B?YXVWVTNiWThhNzJwVThLemJ5L3NTZlphcVRtWDcvNGJ0QkROYXJhbytSWXRI?=
 =?utf-8?B?dmF5Vll0cUZmMmVWdUVuU0RubmlHUDNqT01oYkRJUXVXTWdrRWgyU2txNkdG?=
 =?utf-8?B?Z2w5RUZlYVp5bGtOSHM2cHNGa0hYMXpzeUpXQVpWUFNTT1NVV3VQZS9ZYWcz?=
 =?utf-8?B?aEFQMTRnQUpCRzdIWXN2UHlFVTFpYlRuc0tBRGJjQ2xva2VoMVZVNWJCTzJp?=
 =?utf-8?B?cjF5ZUlEWkFQbGVYamtYQUZuRjliNDJ3amtndVJ2c2tUbEtXOFZISW5hUGpu?=
 =?utf-8?B?bjhISnFzZFRJbXlSNzA1aTJRUGZ3NElUSVJnd3J4N2szY0J5M3F1dVBobVBD?=
 =?utf-8?B?VlkvZlplWDJBSlk2RGxmTzZ1RENUWmV0c3VqRG1xcGFib1hpZERxU0JWTVRC?=
 =?utf-8?B?bVU3NmwvcThmeEdjdytxc0liakIwUmlIVkVTdGFiRUJuRnpZdjhzeGlwb1Fy?=
 =?utf-8?B?ZU45ZnFBUHRhQzkvaW54QmxDTjQreUY3aGd0V2JTYnlGamtHa2Q5YkloYjYr?=
 =?utf-8?Q?PNRP/941X7M9ZEYV+k58gC7TvJ28hF7wJUcE6d8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a35379-3c6c-498e-cec1-08d9941296d8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 21:43:01.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: russell.h.weight@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/15/21 1:22 PM, Lizhi Hou wrote:
>
> On 9/29/21 4:00 PM, Russ Weight wrote:
>> Extend the FPGA Image Load framework to include an FPGA_IMAGE_LOAD_STATUS
>> IOCTL that can be used to monitor the progress of an ongoing image upload.
>> The status returned includes how much data remains to be transferred, the
>> progress of the image upload, and error information in the case of a
>> failure.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v17:
>>   - Rebased for changes to earlier patches.
>> v16:
>>   - Minor changes to adapt in changes in prevoius patches.
>> v15:
>>   - This patch is new to the patchset and provides an FPGA_IMAGE_LOAD_STATUS
>>     IOCTL to return the current values for: remaining_size, progress,
>>     err_progress, and err_code.
>>   - This patch has elements of the following three patches from the previous
>>     patch-set:
>>       [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>>       [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
>>       [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
>>   - Changed file, symbol, and config names to reflect the new driver name
>>   - There are some minor changes to locking to enable this ioctl to return
>>     coherent data.
>> ---
>>   Documentation/fpga/fpga-image-load.rst |  6 +++
>>   drivers/fpga/fpga-image-load.c         | 58 +++++++++++++++++++++-----
>>   include/linux/fpga/fpga-image-load.h   |  1 +
>>   include/uapi/linux/fpga-image-load.h   | 18 ++++++++
>>   4 files changed, 73 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>> index 487b5466f67c..f64f5ee473b8 100644
>> --- a/Documentation/fpga/fpga-image-load.rst
>> +++ b/Documentation/fpga/fpga-image-load.rst
>> @@ -33,3 +33,9 @@ being updated. This is an exclusive operation; an attempt to start
>>   concurrent image uploads for the same device will fail with EBUSY. An
>>   eventfd file descriptor parameter is provided to this IOCTL. It will be
>>   signalled at the completion of the image upload.
>> +
>> +FPGA_IMAGE_LOAD_STATUS:
>> +
>> +Collect status for an on-going image upload. The status returned includes
>> +how much data remains to be transferred, the progress of the image upload,
>> +and error information in the case of a failure.
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> index f04dfc71c190..58373b9e8c02 100644
>> --- a/drivers/fpga/fpga-image-load.c
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -22,6 +22,22 @@ static dev_t fpga_image_devt;
>>
>>   #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>>
>> +static void fpga_image_update_progress(struct fpga_image_load *imgld,
>> +                                      u32 new_progress)
>> +{
>> +       mutex_lock(&imgld->lock);
>> +       imgld->progress = new_progress;
>> +       mutex_unlock(&imgld->lock);
>> +}
>> +
>> +static void fpga_image_set_error(struct fpga_image_load *imgld, u32 err_code)
>> +{
>> +       mutex_lock(&imgld->lock);
>> +       imgld->err_progress = imgld->progress;
>> +       imgld->err_code = err_code;
>> +       mutex_unlock(&imgld->lock);
>> +}
>> +
>>   static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>>   {
>>          mutex_lock(&imgld->lock);
>> @@ -38,24 +54,24 @@ static void fpga_image_do_load(struct work_struct *work)
>>          imgld = container_of(work, struct fpga_image_load, work);
>>
>>          if (imgld->driver_unload) {
>> -               imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
>> +               fpga_image_set_error(imgld, FPGA_IMAGE_ERR_CANCELED);
>>                  goto idle_exit;
>>          }
>>
>>          get_device(&imgld->dev);
>>          if (!try_module_get(imgld->dev.parent->driver->owner)) {
>> -               imgld->err_code = FPGA_IMAGE_ERR_BUSY;
>> +               fpga_image_set_error(imgld, FPGA_IMAGE_ERR_BUSY);
>>                  goto putdev_exit;
>>          }
>>
>> -       imgld->progress = FPGA_IMAGE_PROG_PREPARING;
>> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PREPARING);
>>          ret = imgld->ops->prepare(imgld, imgld->data, imgld->remaining_size);
>>          if (ret) {
>> -               imgld->err_code = ret;
>> +               fpga_image_set_error(imgld, ret);
>>                  goto modput_exit;
>>          }
>>
>> -       imgld->progress = FPGA_IMAGE_PROG_WRITING;
>> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>>          while (imgld->remaining_size) {
>>                  ret = imgld->ops->write(imgld, imgld->data, offset,
>>                                          imgld->remaining_size);
>> @@ -65,7 +81,7 @@ static void fpga_image_do_load(struct work_struct *work)
>>                                           "write-op wrote zero data\n");
>>                                  ret = -FPGA_IMAGE_ERR_RW_ERROR;
>>                          }
>> -                       imgld->err_code = -ret;
>> +                       fpga_image_set_error(imgld, -ret);
>>                          goto done;
>>                  }
>>
>> @@ -73,10 +89,10 @@ static void fpga_image_do_load(struct work_struct *work)
>>                  offset += ret;
>>          }
>>
>> -       imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
>> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>>          ret = imgld->ops->poll_complete(imgld);
>>          if (ret)
>> -               imgld->err_code = ret;
>> +               fpga_image_set_error(imgld, ret);
>>
>>   done:
>>          if (imgld->ops->cleanup)
>> @@ -151,20 +167,42 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>          return ret;
>>   }
>>
>> +static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
>> +                                       unsigned long arg)
>> +{
>> +       struct fpga_image_status status;
>> +
>> +       memset(&status, 0, sizeof(status));
>> +       status.progress = imgld->progress;
>> +       status.remaining_size = imgld->remaining_size;
>> +       status.err_progress = imgld->err_progress;
>> +       status.err_code = imgld->err_code;
>> +
>> +       if (copy_to_user((void __user *)arg, &status, sizeof(status)))
>> +               return -EFAULT;
>> +
>> +       return 0;
>> +}
>> +
>>   static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>                                    unsigned long arg)
>>   {
>>          struct fpga_image_load *imgld = filp->private_data;
>>          int ret = -ENOTTY;
>>
>> +       mutex_lock(&imgld->lock);
>> +
>>          switch (cmd) {
>>          case FPGA_IMAGE_LOAD_WRITE:
>> -               mutex_lock(&imgld->lock);
>>                  ret = fpga_image_load_ioctl_write(imgld, arg);
>> -               mutex_unlock(&imgld->lock);
>> +               break;
>> +       case FPGA_IMAGE_LOAD_STATUS:
>> +               ret = fpga_image_load_ioctl_status(imgld, arg);
>>                  break;
>>          }
>>
>> +       mutex_unlock(&imgld->lock);
>> +
>>          return ret;
>>   }
>>
>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>> index 77b3c91ce073..366111d090fb 100644
>> --- a/include/linux/fpga/fpga-image-load.h
>> +++ b/include/linux/fpga/fpga-image-load.h
>> @@ -49,6 +49,7 @@ struct fpga_image_load {
>>          const u8 *data;                 /* pointer to update data */
>>          u32 remaining_size;             /* size remaining to transfer */
>>          u32 progress;
>> +       u32 err_progress;               /* progress at time of error */
>>          u32 err_code;                   /* image load error code */
>>          bool driver_unload;
>>          struct eventfd_ctx *finished;
>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>> index 8d2d3db92e87..1b91343961df 100644
>> --- a/include/uapi/linux/fpga-image-load.h
>> +++ b/include/uapi/linux/fpga-image-load.h
>> @@ -51,4 +51,22 @@ struct fpga_image_write {
>>
>>   #define FPGA_IMAGE_LOAD_WRITE  _IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>>
>> +/**
>> + * FPGA_IMAGE_LOAD_STATUS - _IOR(FPGA_IMAGE_LOAD_MAGIC, 1,
>> + *                              struct fpga_image_status)
>> + *
>> + * Request status information for an ongoing update.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +struct fpga_image_status {
>> +       /* Output */
>> +       __u32 remaining_size;   /* size remaining to transfer */
>> +       __u32 progress;         /* current progress of image load */
>> +       __u32 err_progress;     /* progress at time of error */
>> +       __u32 err_code;         /* error code */
>> +};
>
> Could this be extended to also collect the image detail?
>
>         Image version, name, etc been successfully written to device (flash).
>
>         Image version, name, etc is currently running on the device.
>
> Or maybe add another query command to do these?
>
> So the userland utility will be able to show what image is running and what image is going to run with next cold reboot.

This status call is intended specifically to show the progress and
status of the image load. Yilun's comments on patch 5 suggest that
some of these types of operations could be handled as part of the
fpga-region class driver

I have patches that have not been submitted yet that contain some
of these types of features, although not in the class driver (yet).
Here is a link to documentation for what I have now. Take a look
at the sysfs node descriptions that are in the control subdirectory.
These are listed at the bottom of the file.

https://github.com/OPAE/linux-dfl/blob/fpga-ofs-dev/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update

- Russ


>
>
> Thanks,
>
> Lizhi
>
>> +
>> +#define FPGA_IMAGE_LOAD_STATUS _IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>> +
>>   #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
>> -- 
>> 2.25.1
>>

