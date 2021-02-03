Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC37E30E6C5
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 00:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhBCXID (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 18:08:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:57540 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhBCXHs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 18:07:48 -0500
IronPort-SDR: +yDlhbc5KBOGBe+u/pYF913N6n5SJ8K8kHC5/gkh0ntoIHQ2ZReedsv95LzgXfs9FBgKEVmEvB
 dpWUFhivaXww==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="181207547"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="181207547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 15:06:52 -0800
IronPort-SDR: qQAPGiFMeJNym3pvMrqM1aqmddz4pgJC8vBaQgBuHjmX/nRG06wbDwyUFq8JXwcmOgAGoKgawt
 ieT53Z/xdWug==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="396844148"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.187.111])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 15:06:52 -0800
Subject: Re: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210202230631.198950-1-russell.h.weight@intel.com>
 <15f90871-170c-3487-0f99-47cf54163bb7@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <9e53d35b-b1b5-5f21-f771-63ce689dd67e@intel.com>
Date:   Wed, 3 Feb 2021 15:06:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <15f90871-170c-3487-0f99-47cf54163bb7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/3/21 7:25 AM, Tom Rix wrote:
> ..snip..
>
> On 2/2/21 3:06 PM, Russ Weight wrote:
>> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
>> index 576e94960086..e5020e2b1f3d 100644
>> --- a/drivers/fpga/dfl-afu.h
>> +++ b/drivers/fpga/dfl-afu.h
>> @@ -80,7 +80,7 @@ struct dfl_afu {
>>  };
>>  
>>  /* hold pdata->lock when call __afu_port_enable/disable */
>> -void __afu_port_enable(struct platform_device *pdev);
>> +int __afu_port_enable(struct platform_device *pdev);
>>  int __afu_port_disable(struct platform_device *pdev);
>>  
> Should the '__' prefix be removed from __afu_port* ?
>
> This would make the function names consistent with the other decls

The '__' prefix is used here to help highlight the fact that these functions go not manage
the locking themselves and must be called while holding the port mutex. There are additional
functions, such as__port_reset(), that are following this same convention. I think these
are OK as they are.

- Russ

>
> Tom
>
>>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);

