Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F15B4FEB
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIKQNI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 12:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIKQMz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 12:12:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD12B190;
        Sun, 11 Sep 2022 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662912773; x=1694448773;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e1njG/ms4c7Wt/dFm1QalGUQME5inUMeKY7ULkgCdQo=;
  b=hLKmH9cX0XH1p94zlx2JwUtgiy3EMOcILwmyXw15BBRL+/gmAf6t16bm
   LEEw3H9H6TnEkNf+6Xh6QY4z/2/1A2kcTbf4+x5w9x6hpqU5zDYHJIqMI
   otqUzTCHKt4SBfVfLshXdbsz6Ssfck7XYB8vo0SgjsIndYTlwd641gOAv
   w6rTRNfCtjwFQ3wGOdji3ocNx0QeLszbNUBv+6dnA5iVwy3obCe7/AXl0
   d+X4oa1/Q3vGaeWcF8VL0auClUT/8G6p8GgJ/zsB0I41rtRzpOu588C2V
   W0b6XTSU/bZbffltNPntzTkFCUzfHCS+wAIxDiozqvTAOz0v4ZjA2Uv24
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="297736409"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="297736409"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 09:12:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="566918308"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 09:12:53 -0700
Date:   Sun, 11 Sep 2022 09:13:13 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v1 2/5] fpga: dfl: Move the DFH definitions
In-Reply-To: <Yx2Wn7LR6O6ilXae@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2209110909450.142336@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-3-matthew.gerlach@linux.intel.com> <Yx2Wn7LR6O6ilXae@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sun, 11 Sep 2022, Xu Yilun wrote:

> On 2022-09-06 at 12:04:23 -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
>>
>> Moving the DFH register offset and register definitions from
>> drivers/fpga/dfl.h to include/linux/dfl.h.  These definitions
>> need to be accessed by dfl drivers that are outside of
>> drivers/fpga.
>>
>> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/fpga/dfl.h  | 22 ++--------------------
>>  include/linux/dfl.h | 23 ++++++++++++++++++++++-
>>  2 files changed, 24 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>> index 06cfcd5e84bb..d4dfc03a0b61 100644
>> --- a/drivers/fpga/dfl.h
>> +++ b/drivers/fpga/dfl.h
>> @@ -2,7 +2,7 @@
>>  /*
>>   * Driver Header File for FPGA Device Feature List (DFL) Support
>>   *
>> - * Copyright (C) 2017-2018 Intel Corporation, Inc.
>> + * Copyright (C) 2017-2022 Intel Corporation, Inc.
>>   *
>>   * Authors:
>>   *   Kang Luwei <luwei.kang@intel.com>
>> @@ -17,6 +17,7 @@
>>  #include <linux/bitfield.h>
>>  #include <linux/cdev.h>
>>  #include <linux/delay.h>
>> +#include <linux/dfl.h>
>>  #include <linux/eventfd.h>
>>  #include <linux/fs.h>
>>  #include <linux/interrupt.h>
>> @@ -53,28 +54,9 @@
>>  #define PORT_FEATURE_ID_UINT		0x12
>>  #define PORT_FEATURE_ID_STP		0x13
>>
>> -/*
>> - * Device Feature Header Register Set
>> - *
>> - * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
>> - * For AFUs, they have DFH + GUID as common header registers.
>> - * For private features, they only have DFH register as common header.
>> - */
>> -#define DFH			0x0
>> -#define GUID_L			0x8
>> -#define GUID_H			0x10
>> -#define NEXT_AFU		0x18
>> -
>> -#define DFH_SIZE		0x8
>> -
>>  /* Device Feature Header Register Bitfield */
>> -#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
>>  #define DFH_ID_FIU_FME		0
>>  #define DFH_ID_FIU_PORT		1
>> -#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
>> -#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
>> -#define DFH_EOL			BIT_ULL(40)		/* End of list */
>> -#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
>>  #define DFH_TYPE_AFU		1
>>  #define DFH_TYPE_PRIVATE	3
>>  #define DFH_TYPE_FIU		4
>> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
>> index 431636a0dc78..b5accdcfa368 100644
>> --- a/include/linux/dfl.h
>> +++ b/include/linux/dfl.h
>> @@ -2,7 +2,7 @@
>>  /*
>>   * Header file for DFL driver and device API
>>   *
>> - * Copyright (C) 2020 Intel Corporation, Inc.
>> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
>>   */
>>
>>  #ifndef __LINUX_DFL_H
>> @@ -11,6 +11,27 @@
>>  #include <linux/device.h>
>>  #include <linux/mod_devicetable.h>
>>
>> +/*
>> + * Device Feature Header Register Set
>> + *
>> + * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
>> + * For AFUs, they have DFH + GUID as common header registers.
>> + * For private features, they only have DFH register as common header.
>> + */
>> +#define DFH			0x0
>> +#define GUID_L			0x8
>> +#define GUID_H			0x10
>> +#define NEXT_AFU		0x18
>
> Now these macros are accessible in global kernel, should we add the
> DFL_ or DFH_ prefix for them?
>
> Thanks,
> Yilun

It does make sense to a DFL_ or DFH_ to these globabl macros, but I'll 
look again to see if the ones above really need to be global, where as the 
macros below definitely need to be global.  I also think a marco like 
DFL_DFH might be a little strange.

Thanks,
Matthew Gerlach

8>
>> +
>> +#define DFH_SIZE		0x8
>> +
>> +/* Device Feature Header Register Bitfield */
>> +#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
>> +#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
>> +#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
>> +#define DFH_EOL			BIT_ULL(40)		/* End of list */
>> +#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
>> +
>>  /**
>>   * enum dfl_id_type - define the DFL FIU types
>>   */
>> --
>> 2.25.1
>>
>
