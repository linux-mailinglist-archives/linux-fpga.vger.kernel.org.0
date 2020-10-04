Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B797282C25
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgJDSBl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:01:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:49108 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgJDSBl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 4 Oct 2020 14:01:41 -0400
IronPort-SDR: tAz2xgDEJAX9Ydfw4FISevPnqmwhxBSccj4bbEvbAFPo8CzyptQSgA70nu6fq4zIs3S/K9l0FF
 4na60yDr7A/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="248035853"
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="scan'208";a="248035853"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 11:01:41 -0700
IronPort-SDR: ww/8GPGIPsP88baz4R2/7X8dbWw6Dp+VxxanYo0ZoMgBtUSRZFcwP4VvBFn//voPNA9SqdtRVM
 LC5bGEtZZC4w==
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="scan'208";a="459205023"
Received: from cmcgee-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.16.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 11:01:40 -0700
Subject: Re: [PATCH v2 2/6] fpga: m10bmc-sec: create max10 bmc security engine
To:     Randy Dunlap <rdunlap@infradead.org>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-3-russell.h.weight@intel.com>
 <6854e626-e21b-d3b6-fa31-f150edba6f66@infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <17d32b30-dab5-c8cd-9ce3-fafe847fa846@intel.com>
Date:   Sun, 4 Oct 2020 11:01:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6854e626-e21b-d3b6-fa31-f150edba6f66@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/2/20 8:15 PM, Randy Dunlap wrote:
> On 10/2/20 6:24 PM, Russ Weight wrote:
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index c534cc80f398..2380d36b08c7 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -235,4 +235,15 @@ config IFPGA_SEC_MGR
>>  	  region and for the BMC. Select this option to enable
>>  	  updates for secure FPGA devices.
>>  
>> +config IFPGA_M10_BMC_SECURE
>> +        tristate "Intel MAX10 BMC security engine"
>> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
>> +        help
>> +          Secure update support for the Intel MAX10 board management
>> +	  controller.
>> +
>> +	  This is a subdriver of the Intel MAX10 board management controller
>> +	  (BMC) and provides support for secure updates for the BMC image,
>> +	  the FPGA image, the Root Entry Hashes, etc.
>> +
>>  endif # FPGA
> Dagnabit, I need a bot to do this.
>
> Clean up the indentation in the Kconfig file.
>
> From Documentation/process/coding-style.rst, section 10:
>
> Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
>
> checkpatch should have found that issue. Did it not?
Sorry - I thought I had addressed the indentation errors after the first submission.
I'll fix it.

I am running checkpatch.pl --strict, and I did not see a warning/error for this.
>
>
> thanks.

