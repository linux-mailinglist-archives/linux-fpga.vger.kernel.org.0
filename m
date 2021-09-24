Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28942417D31
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Sep 2021 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhIXVrt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Sep 2021 17:47:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:38258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhIXVrs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 24 Sep 2021 17:47:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="285186016"
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="285186016"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 14:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="475318926"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2021 14:46:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 14:46:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 14:46:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 24 Sep 2021 14:46:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 24 Sep 2021 14:46:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muwmcz+OwamJ3/GIxVZySt0Tdn/6VTtrJAuKO4ClsTQqKnlXCWBnMDD9ZH+S8W3mN74eQZH5KmE/WpgUYacQEAsQarhOIHpZCtS9JvzTmrA25Ws3b8/wxaYhOEFSj2YMYjVgb0SkSk7qM/S52av08vGMkLQSB6AFUH7VL/v67n91Gey9+74zPe8cpoaIRNqVegANR0jfardsidpQKOTQV23gPYx6hKVWqvCNAPrMhwRhywMDcErk3yy/VkasVdLsb2b8+y7v3Bq0vLS1/PWL52nhDI4WgL9CpyeJm5UPezOaQ5UoacgRVYinIyMomaWYB+HV+Gnpg6qsaHYUf5Craw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3ilYLLZUckXDyMsa7q1Wb1P5EXYXfFgaEalOQh4Xdhw=;
 b=Oe0vF6ycSwJ8N4uVSmbFaZYGbbAsVtLN4WUW04TWgVE6yICC3oOEXeejsSgRZNmmb1hwfvjdGbmyC9DF1aHcadl/y7iewqUz2S2nUzvztFhqF0U2n6z6XiV3b8d665QyX0wDkL2ga+zkfnjT4/w2kdzepT2Apf0Mv5C3S6psTUN4FBfz/Tp5zHrz+9T1XY0lt9GxuUGNBTx8QSopn871RJu23QvpbhWNafCKSMVgiKy8v18a6CNhX7Mf72+6rou0X+HOLwbAKJxiXImaAlLEK6YW/SudpDIljKvu8JqwlMVqi8ssfvP3Q8bA7yA/jDAmmZ71xbiISscMuo7evakVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ilYLLZUckXDyMsa7q1Wb1P5EXYXfFgaEalOQh4Xdhw=;
 b=jIBcUi/nE6kemUF8mNR7XIdLQgQywkUnWn3sNtHdVQ/QhL8e8ws92gJ/cPRrLxVrzmjx7kNw7hJLiEikjQzcB06kLfABw8+xdjkQ7fzY9VovNouSRHZ4txWTj28I/aZscSGA80CTxPg9BqclPQhM/jc8KOpd9WUYNAes7BHnh18=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 21:46:09 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%5]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 21:46:09 +0000
Subject: Re: [PATCH v16 3/5] fpga: image-load: signal eventfd when complete
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
 <20210923001056.282790-4-russell.h.weight@intel.com>
 <20210924084947.GC806603@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <2c63282d-504c-e428-5048-d0743d8523fa@intel.com>
Date:   Fri, 24 Sep 2021 14:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210924084947.GC806603@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:300:16::18) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR13CA0008.namprd13.prod.outlook.com (2603:10b6:300:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Fri, 24 Sep 2021 21:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8839fc5f-e3d6-4f80-bdac-08d97fa4b835
X-MS-TrafficTypeDiagnostic: SA0PR11MB4541:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR11MB45418771BE4F91283A9E155CC5A49@SA0PR11MB4541.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrYWxPAKsOCeyZqQ8/Fu9C+Xe/L9+vRz/g6IYJcY+s2pn7yvLJzPusRvhI87uIF9XJZ/s4vBiwhGtllG/VpyQB+O5GyB9RRUmiMr+R0t8fVqhZP/1CbH21K59RCtNUuX7RRXUAVPvjbvPRqe8xb+p2NPNvoIyk+Wuy9gJUt7bw52gdTk3Yw/gSAsmTAWgGF5J8NNJa7Jdp4B8WrdSq1s+f5E3b1yvkDyNRhKTrJ5oDxMtJx61prZkLcPiR/fML/3vKb2XPUqWulLoPilE4axT8/rbIGv+VFci3F9W6pVLhL3IT1ul+mpDPkK5ItuiV8NuYEnVQE+EBLdq+as3WFgVlRZpHzpTpH7ki2rRpyJLWTUe+QUDLteaE6FjhbqkAbn3Be0JLdOSC6QG4qZChNJBxjsrIuqnVUbNaO/o1V1MlQYf7RNZEM2vtuJKJKsillWPpnV3nInhvWO/43fdvSCpfoUFP6MWYniXatuWeGHGzgEZHbSNXoj+T287gCgu2zMZnHqDYOvjb3SV3VL0cFs2J1mqMw2Q8YBXcI2qx349MC5DfWKRQAgzVoa4sn2q8nPx/FnlpxJ5IyqhLZUF5Vug9fMlo61M8ySURPQA/ND4QMIhE0ihHuJVpL50gGqT2U6Xilli7PniUoW+6KKeXnayCGCeNGb9hN1Ypi8ZuwYcUMuUnUpeHuqTIMLsLgwnyfVQXz6BaQuteimedWv1e4HCV5zpJwURcZF5+EE+JspRfp7QjyFGCeidKC+ZtDXWwKe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8676002)(186003)(5660300002)(6636002)(31696002)(83380400001)(53546011)(26005)(31686004)(36756003)(16576012)(6486002)(37006003)(316002)(2906002)(4326008)(86362001)(107886003)(6862004)(8936002)(66476007)(66556008)(66946007)(38100700002)(6666004)(2616005)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZYT1ZjVTRFME9yaXFkVU5FcWVLQ1F1Vmk5ZE1zMlZoNnVDRGN5dGlRdHVz?=
 =?utf-8?B?UUdVZGVDTnBUQnd3YWc2Ui92a0RTMitQdXBQVXQ1ZzFvbEdXdmdzNjRYbCty?=
 =?utf-8?B?TG9DR1JOVkMyM1RRbnE3VTBMK3NIQjVadC9FcUNyWkQreVlTdlpERG4xcldq?=
 =?utf-8?B?djFsRVhyZm0vS21NZm9KL29iWkQrOFpWUzNMZStpZ1JiZmwyTlJ3ejhXUjNt?=
 =?utf-8?B?WS94amM0ZERIL0tYYnVnRjliUVZoempJNEplcDk0bEFWR2hKY1piZjd5Qkpw?=
 =?utf-8?B?RzVzQmhzeTdIY0dFMnpEc1pkaVZGTmNoOGpzRjJuMnhTMFpPZWJ4RDFkWmJM?=
 =?utf-8?B?cG5yZnNHRXp1cHo1eVlZTWdqaFBhck5qWFhZKzFWWjBoTHJPMGFNVGtwdERJ?=
 =?utf-8?B?TllRaVlDMTNpR2lrS0s5WmFOVkxrVnhDOWZ6NE9uME5uOXJSTHBBK3IvR3Ji?=
 =?utf-8?B?L085TTZNUHRDR2JHSmhGMHEvSG9JZGNWQytTTGF4UkhPeVVrWm9aUHg2bVI4?=
 =?utf-8?B?LzNBS08vQ0IwbjBlNlpUUXV1djBGY1JxeWlXTytGUWhRWjZWaUxiTlZJcUNZ?=
 =?utf-8?B?L2hkQ2V3M1E5VHhYNlNPYmN2YlRneGt0VnJRN0k2dzRvQ1BwUFVSUGFMa3Mv?=
 =?utf-8?B?Zm5OaUpVUlZPQjJWR1RFYW1lUGVSQU5jY1NrSEFPMloxYUMxRkhhZFJEZkxQ?=
 =?utf-8?B?TlFaVmlOSnpFUFpvZ2FyenQxbE9TckVLM3IvclB5WktDVy9kelVRRENoMEFD?=
 =?utf-8?B?czdSREViL0k3YUlPZFJkUVVaN2g3RDU1ZTVOeTJBZ1NOcjl6VDNFZTU0OUFp?=
 =?utf-8?B?U1pBa2JaaGtWZzZ4UHpHQVNZekNzZXNVSFhzTmZURkZVaEVDenN5aGlOS09S?=
 =?utf-8?B?bFNWa0JqNWdlTDJEQklqdHNNRm5xSDA0UWJRVzhTcG41MTJjdzk1V2lqanRL?=
 =?utf-8?B?ZkJ3OWhMeGk4QUZrWGg4UUpjS3hRVVkwUTRCME1ONExjTGVUcWliOUNmU3cz?=
 =?utf-8?B?UFpKNXBMSW9OYTNhM0diQTFqNE0wR29oaElMcjNCRXF5Yld6TXFONERDSGJk?=
 =?utf-8?B?ZlV5SlpMQWVnUkNpTWw4T3JGaTU1dTZpTHNDYmdoc0JGaUJOWlluamV5c1NF?=
 =?utf-8?B?M2hqMTFlYmc5Rk8xc0ZCWDMxS28rVHZnUjlEekdvb0JxdndXdkxGTDIxTGJy?=
 =?utf-8?B?Wjl4UWNvdzVDR3pSQ2JLWjB4dzdiR0dqYUExMGgyOEhLTmlOdUhiUmlTMkVy?=
 =?utf-8?B?NkR3ZVdOSHM1SVVBNUd4MEpCRmNIdU8zVlJrY0NrUTl6cEVEbEpUalV6Yytv?=
 =?utf-8?B?cjR1QUFBbmh1V1dEUHhrWW84aXlmNG0rN291VTg4cm5Uc1huS2NMNCt6ODJN?=
 =?utf-8?B?RFkxUHQ0aGNMUWFGTHZYQWJ1SUowS21rdVZTbFFDYUs4SjkxbDRRVXBnajdl?=
 =?utf-8?B?eVQvQUg4VVkzMHJWdG1lb0p4emQ0Q3ZCR0RHbW5EcFo3OFF0Ri9LR0xzSjdF?=
 =?utf-8?B?MmNoY282clNiRkY4cXBuRVd3UkREYnI0dTVLc2ZZV1dVNkpRM3JYS1M4bmMw?=
 =?utf-8?B?OE9OeVZWUW9HdmRvRUI0M3dKc2ZTaXRpazR5cGhLVGZOZDNNeDdWNlhvODZC?=
 =?utf-8?B?NEtESTV0Y1d6bHZvY1NHdjBGUE1mWk9hZ2FReDFET0lET2ZmRExzSUNyaWZz?=
 =?utf-8?B?c1R2a1dvY0RZazhSYVVoM2VaSS9EM0t0Vy90ZVRlOVJPNHdZTUcvdm1CTlAx?=
 =?utf-8?Q?eEANS2iT6t4XDSOdOlETHmlDNMOiExyfkvVX6H+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8839fc5f-e3d6-4f80-bdac-08d97fa4b835
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 21:46:09.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNdDVioSFPbja+ic5lPk/Qq2QXfKIDav1E9fyhuQ10GCE4N4gaRsG90zL5iHzsA2k7WMYDGcn8yWhzC9QHKj0phbK3B+qnX4IHCaDZcyQK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/24/21 1:49 AM, Xu Yilun wrote:
> On Wed, Sep 22, 2021 at 05:10:54PM -0700, Russ Weight wrote:
>> Amend the FPGA_IMAGE_LOAD_WRITE IOCTL implementation to include an
>> eventfd file descriptor as a parameter. The eventfd will be triggered
>> when the image upload completes.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v16:
>>  - Some cleanup of documentation for the FPGA_IMAGE_LOAD_WRITE IOCTL.
>> v15:
>>  - This patch is new to the patch-set, and adds an eventfd to the
>>    FPGA_IMAGE_LOAD_WRITE IOCTL. The eventfd is signalled upon completion
>>    of an update.
>> ---
>>  Documentation/fpga/fpga-image-load.rst | 12 +++++++-----
>>  drivers/fpga/fpga-image-load.c         | 22 ++++++++++++++++++++--
>>  include/linux/fpga/fpga-image-load.h   |  2 ++
>>  include/uapi/linux/fpga-image-load.h   |  3 ++-
>>  4 files changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>> index ba371c7c0ca0..22a455421bb4 100644
>> --- a/Documentation/fpga/fpga-image-load.rst
>> +++ b/Documentation/fpga/fpga-image-load.rst
>> @@ -27,8 +27,10 @@ ioctl
>>  
>>  FPGA_IMAGE_LOAD_WRITE:
>>  
>> -Start an image upload with the provided image buffer. This IOCTL returns
>> -immediately after starting a kernel worker thread to process the image
>> -upload which could take as long a 40 minutes depending on the actual device
>> -being updated. This is an exclusive operation; an attempt to start
>> -concurrent image uploads for the same device will fail with EBUSY.
>> +Start an image upload with the provided image buffer. This IOCTL returns
>> +immediately after starting a kernel worker thread to process the image
>> +upload which could take as long a 40 minutes depending on the actual device
>> +being updated. This is an exclusive operation; an attempt to start
> Just curious, there are marks here but seems no change.
Hmmm - sometimes when fixing up patches, I find it easier to edit
the patch files (e.g. changing file and symbol names). The patches
applied cleanly, but I must have forgotten to regenerate them
before sending them for review.

>
>> +concurrent image loads for the same device will fail with EBUSY. An eventfd
> You want to fix "uploads" to "loads"? But there are many other "upload(s)".
My preference is upload, because load implies more than transferring
the data but the data transfer is all that this driver really does.
I preferred fpga_image_load to fpga_image_upload for the device name,
just because it was a couple of characters less. I'll change "loads"
to "uploads" here.

Do you think I should rename the driver to fpga_image_upload? Or do
you think the name is OK if it is probably documented?

- Russ
>
> Others look good to me.
>
>> +file descriptor parameter is provided to this IOCTL. It will be signalled
>> +at the completion of the image upload.
>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>> index 65f553b59011..09164a0258a5 100644
>> --- a/drivers/fpga/fpga-image-load.c
>> +++ b/drivers/fpga/fpga-image-load.c
>> @@ -34,6 +34,7 @@ static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>>  {
>>  	mutex_lock(&imgld->lock);
>>  	imgld->progress = FPGA_IMAGE_PROG_IDLE;
>> +	eventfd_signal(imgld->finished, 1);
>>  	mutex_unlock(&imgld->lock);
>>  }
>>  
>> @@ -112,6 +113,8 @@ static void fpga_image_do_load(struct work_struct *work)
>>  	vfree(imgld->data);
>>  	imgld->data = NULL;
>>  	fpga_image_prog_complete(imgld);
>> +	eventfd_ctx_put(imgld->finished);
>> +	imgld->finished = NULL;
>>  }
>>  
>>  static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>> @@ -119,6 +122,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>  {
>>  	struct fpga_image_write wb;
>>  	unsigned long minsz;
>> +	int ret;
>>  	u8 *buf;
>>  
>>  	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
>> @@ -135,13 +139,23 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>  	if (wb.size & 0x3)
>>  		return -EINVAL;
>>  
>> +	if (wb.evtfd < 0)
>> +		return -EINVAL;
>> +
>>  	buf = vzalloc(wb.size);
>>  	if (!buf)
>>  		return -ENOMEM;
>>  
>>  	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
>> -		vfree(buf);
>> -		return -EFAULT;
>> +		ret = -EFAULT;
>> +		goto exit_free;
>> +	}
>> +
>> +	imgld->finished = eventfd_ctx_fdget(wb.evtfd);
>> +	if (IS_ERR(imgld->finished)) {
>> +		ret = PTR_ERR(imgld->finished);
>> +		imgld->finished = NULL;
>> +		goto exit_free;
>>  	}
>>  
>>  	imgld->data = buf;
>> @@ -151,6 +165,10 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>  	queue_work(system_unbound_wq, &imgld->work);
>>  
>>  	return 0;
>> +
>> +exit_free:
>> +	vfree(buf);
>> +	return ret;
>>  }
>>  
>>  static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>> index 41ab63cf7b20..7d39daa4d921 100644
>> --- a/include/linux/fpga/fpga-image-load.h
>> +++ b/include/linux/fpga/fpga-image-load.h
>> @@ -9,6 +9,7 @@
>>  
>>  #include <linux/cdev.h>
>>  #include <linux/device.h>
>> +#include <linux/eventfd.h>
>>  #include <linux/mutex.h>
>>  #include <linux/types.h>
>>  #include <uapi/linux/fpga-image-load.h>
>> @@ -52,6 +53,7 @@ struct fpga_image_load {
>>  	u32 progress;
>>  	u32 err_code;			/* image load error code */
>>  	bool driver_unload;
>> +	struct eventfd_ctx *finished;
>>  	void *priv;
>>  };
>>  
>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>> index 0382078c5a6c..152a8e1c031f 100644
>> --- a/include/uapi/linux/fpga-image-load.h
>> +++ b/include/uapi/linux/fpga-image-load.h
>> @@ -38,7 +38,7 @@
>>   *				struct fpga_image_write)
>>   *
>>   * Upload a data buffer to the target device. The user must provide the
>> - * data buffer and size.
>> + * data buffer, size, and an eventfd file descriptor.
>>   *
>>   * Return: 0 on success, -errno on failure.
>>   */
>> @@ -46,6 +46,7 @@ struct fpga_image_write {
>>  	/* Input */
>>  	__u32 flags;		/* Zero for now */
>>  	__u32 size;		/* Data size (in bytes) to be written */
>> +	__s32 evtfd;		/* File descriptor for completion signal */
>>  	__u64 buf;		/* User space address of source data */
>>  };
>>  
>> -- 
>> 2.25.1

