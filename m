Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2D282C5A
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgJDSHT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDSHT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:07:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D39C0613CE;
        Sun,  4 Oct 2020 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=e633HPyalqTmd7b+XoszZ7GvqCcOvcsQIj4oVe+ALj4=; b=neJrcFQCzU1oiMKyl9Md8oa7Cg
        kC3aWIZ8N/+ol10tDWz19MLQJ3+AsWgvpfQhBTFunUES/1LoCy7EUXR2UAON9hdlfonELxwONQKxB
        VU9PA93CaGBnHeHoQVONdL5TuvUiLayWcHfvV5yRoL4ylY03sQ3M18jjasCyx3tTR2f6Wpl8lj28E
        AIR3RwjjXoE/Bzap7BliCRti0fcf/JZfKUsRfLVoqg8sXIYZ9ybnYITfsxq6LrnSBEv56kS3AdgGT
        RLwUVtM9RgWg8KdtXWC8r6ERXSNnm43eMO4M4aW1TxR1bZF4AB2SMNpgqyprrv/4EP4GQSBRht/5i
        kWBvP8uA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kP8Ph-00044u-U5; Sun, 04 Oct 2020 18:07:14 +0000
Subject: Re: [PATCH v2 2/6] fpga: m10bmc-sec: create max10 bmc security engine
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-3-russell.h.weight@intel.com>
 <6854e626-e21b-d3b6-fa31-f150edba6f66@infradead.org>
 <17d32b30-dab5-c8cd-9ce3-fafe847fa846@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d2be9811-d7f3-552f-124a-b50f1e82f444@infradead.org>
Date:   Sun, 4 Oct 2020 11:07:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <17d32b30-dab5-c8cd-9ce3-fafe847fa846@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 10/4/20 11:01 AM, Russ Weight wrote:
> 
> 
> On 10/2/20 8:15 PM, Randy Dunlap wrote:
>> On 10/2/20 6:24 PM, Russ Weight wrote:
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>> index c534cc80f398..2380d36b08c7 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -235,4 +235,15 @@ config IFPGA_SEC_MGR
>>>  	  region and for the BMC. Select this option to enable
>>>  	  updates for secure FPGA devices.
>>>  
>>> +config IFPGA_M10_BMC_SECURE
>>> +        tristate "Intel MAX10 BMC security engine"
>>> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
>>> +        help
>>> +          Secure update support for the Intel MAX10 board management
>>> +	  controller.
>>> +
>>> +	  This is a subdriver of the Intel MAX10 board management controller
>>> +	  (BMC) and provides support for secure updates for the BMC image,
>>> +	  the FPGA image, the Root Entry Hashes, etc.
>>> +
>>>  endif # FPGA
>> Dagnabit, I need a bot to do this.
>>
>> Clean up the indentation in the Kconfig file.
>>
>> From Documentation/process/coding-style.rst, section 10:
>>
>> Lines under a ``config`` definition
>> are indented with one tab, while help text is indented an additional two
>> spaces.
>>
>> checkpatch should have found that issue. Did it not?
> Sorry - I thought I had addressed the indentation errors after the first submission.
> I'll fix it.
> 
> I am running checkpatch.pl --strict, and I did not see a warning/error for this.

OK, I looked at checkpatch.pl and I don't see any checks for that.

I'll just work on a pseudo-bot then.

thanks.

-- 
~Randy

